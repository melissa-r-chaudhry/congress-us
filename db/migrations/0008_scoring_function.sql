-- refresh_member_scores(): the scoring function, single source of truth for the formula.
-- Full rationale: /Users/macuser/.claude/plans/mutable-spinning-acorn.md and
-- businessventures/project_congress_us.md memory. Reads confidence weights, G, and window
-- sizes live from scoring_config — never hardcode them here, always reference the config.

CREATE OR REPLACE FUNCTION refresh_member_scores() RETURNS void AS $$
DECLARE
  v_G NUMERIC;
  v_conf_direct NUMERIC;
  v_conf_inferred NUMERIC;
  v_pos_weight NUMERIC;
  v_cycle_window INT;
  v_congress_window INT;
BEGIN
  SELECT value::numeric INTO v_G FROM scoring_config WHERE key = 'grassroots_avg_gift_G';
  SELECT value::numeric INTO v_conf_direct FROM scoring_config WHERE key = 'confidence_direct';
  SELECT value::numeric INTO v_conf_inferred FROM scoring_config WHERE key = 'confidence_inferred';
  SELECT value::numeric INTO v_pos_weight FROM scoring_config WHERE key = 'positive_pac_weight';
  SELECT value::int INTO v_cycle_window FROM scoring_config WHERE key = 'funding_cycle_window';
  SELECT value::int INTO v_congress_window FROM scoring_config WHERE key = 'alignment_congress_window';

  -- Working table: raw funding inputs per member, aggregated equally across the last
  -- v_cycle_window available cycles (not just the latest) — this IS the 3-cycle anti-
  -- shapeshifting rule, not an approximation of it.
  CREATE TEMP TABLE _funding_raw ON COMMIT DROP AS
  WITH ranked_cycles AS (
    SELECT DISTINCT cycle_year FROM individual_contribution_summary
    ORDER BY cycle_year DESC LIMIT v_cycle_window
  ),
  ics AS (
    SELECT bioguide_id,
           SUM(verified_itemized_count_under200) AS count_under200,
           SUM(estimated_unitemized_count) AS est_unitemized_count,
           COUNT(*) AS cycles_present
    FROM individual_contribution_summary
    WHERE cycle_year IN (SELECT cycle_year FROM ranked_cycles)
    GROUP BY bioguide_id
  ),
  pac AS (
    SELECT pc.bioguide_id,
           SUM(pc.amount) FILTER (WHERE pi.polarity = 'negative') AS negative_pac_total,
           SUM(pc.amount) FILTER (WHERE pi.polarity = 'positive') AS positive_pac_total
    FROM pac_contributions pc
    LEFT JOIN pac_committees cm ON cm.fec_committee_id = pc.fec_committee_id
    LEFT JOIN pac_industries pi ON pi.code = cm.industry_code
    WHERE pc.cycle_year IN (SELECT cycle_year FROM ranked_cycles)
    GROUP BY pc.bioguide_id
  ),
  aipac_signal AS (
    SELECT bioguide_id, SUM(amount) AS traced_total
    FROM external_funding_signals
    WHERE cycle_year IN (SELECT cycle_year FROM ranked_cycles)
    GROUP BY bioguide_id
  ),
  top_neg AS (
    -- top negative industry by points-weighted total (direct PAC only, for now)
    SELECT DISTINCT ON (pc.bioguide_id) pc.bioguide_id, pi.code AS top_industry
    FROM pac_contributions pc
    JOIN pac_committees cm ON cm.fec_committee_id = pc.fec_committee_id
    JOIN pac_industries pi ON pi.code = cm.industry_code AND pi.polarity = 'negative'
    WHERE pc.cycle_year IN (SELECT cycle_year FROM ranked_cycles)
    GROUP BY pc.bioguide_id, pi.code
    ORDER BY pc.bioguide_id, SUM(pc.amount) DESC
  )
  SELECT
    m.bioguide_id,
    COALESCE(ics.count_under200, 0) + COALESCE(ics.est_unitemized_count, 0) AS count_under200,
    COALESCE(pac.positive_pac_total, 0) AS positive_pac_total,
    COALESCE(pac.negative_pac_total, 0) AS negative_pac_total,
    COALESCE(aipac.traced_total, 0) AS aipac_traced_total,
    (ics.cycles_present IS NOT NULL AND ics.cycles_present > 0) OR (pac.bioguide_id IS NOT NULL) AS funding_ready,
    tn.top_industry
  FROM members m
  LEFT JOIN ics ON ics.bioguide_id = m.bioguide_id
  LEFT JOIN pac ON pac.bioguide_id = m.bioguide_id
  LEFT JOIN aipac_signal aipac ON aipac.bioguide_id = m.bioguide_id
  LEFT JOIN top_neg tn ON tn.bioguide_id = m.bioguide_id;

  -- funding_raw formula: points(x) = x / G. Direct PAC signals at confidence_direct,
  -- AIPAC-traced signals at confidence_inferred (lower certainty, deliberately).
  CREATE TEMP TABLE _funding_scored ON COMMIT DROP AS
  SELECT
    bioguide_id,
    funding_ready,
    top_industry,
    (count_under200 * 1.0)
      + ((positive_pac_total / NULLIF(v_G,0)) * v_pos_weight)
      - ((negative_pac_total / NULLIF(v_G,0)) * v_conf_direct)
      - ((aipac_traced_total / NULLIF(v_G,0)) * v_conf_inferred)
      AS funding_raw
  FROM _funding_raw;

  -- Alignment: applicable tracked_item_bills = chamber-matched AND within the last
  -- v_congress_window Congresses AND the member held office during that specific Congress.
  CREATE TEMP TABLE _alignment_raw ON COMMIT DROP AS
  WITH recent_congresses AS (
    SELECT congress_number FROM congresses ORDER BY congress_number DESC LIMIT v_congress_window
  ),
  applicable AS (
    SELECT mt.bioguide_id, tib.id AS tracked_item_bill_id
    FROM member_terms mt
    JOIN tracked_item_bills tib
      ON tib.congress_number = mt.congress_number
     AND ((tib.bill_type IN ('hr','hjres') AND mt.chamber = 'house')
          OR (tib.bill_type = 's' AND mt.chamber = 'senate'))
    WHERE mt.congress_number IN (SELECT congress_number FROM recent_congresses)
      AND tib.is_active = true
  ),
  scored AS (
    SELECT a.bioguide_id,
           CASE mbp.position_type
             WHEN 'sponsor' THEN 1 WHEN 'cosponsor' THEN 1
             WHEN 'voted_yea' THEN 1 WHEN 'voted_nay' THEN -1
             ELSE 0
           END AS credit
    FROM applicable a
    LEFT JOIN member_bill_positions mbp
      ON mbp.bioguide_id = a.bioguide_id AND mbp.tracked_item_bill_id = a.tracked_item_bill_id
  )
  SELECT bioguide_id, AVG(credit) AS alignment_raw, COUNT(*) AS applicable_count
  FROM scored GROUP BY bioguide_id;

  -- min-max normalize funding_raw to 0-100 across members with real funding data
  CREATE TEMP TABLE _funding_bounds ON COMMIT DROP AS
  SELECT MIN(funding_raw) AS lo, MAX(funding_raw) AS hi
  FROM _funding_scored WHERE funding_ready;

  INSERT INTO member_scores (bioguide_id, congress_number, funding_raw_score, funding_display_score,
    alignment_raw_score, alignment_display_score, composite_score, top_negative_industry_code,
    funding_data_status, alignment_data_status, computed_at)
  SELECT
    m.bioguide_id,
    119,
    fs.funding_raw,
    CASE WHEN fs.funding_ready AND fb.hi > fb.lo
         THEN ROUND(((fs.funding_raw - fb.lo) / (fb.hi - fb.lo)) * 100, 1)
         WHEN fs.funding_ready THEN 50.0
         ELSE NULL END,
    ar.alignment_raw,
    CASE WHEN ar.applicable_count > 0 THEN ROUND(((ar.alignment_raw + 1) / 2) * 100, 1) ELSE NULL END,
    CASE WHEN fs.funding_ready AND ar.applicable_count > 0
         THEN ROUND(
           (COALESCE(CASE WHEN fb.hi > fb.lo THEN ((fs.funding_raw - fb.lo) / (fb.hi - fb.lo)) * 100 ELSE 50.0 END, 50.0)
            + ((ar.alignment_raw + 1) / 2) * 100) / 2, 1)
         ELSE NULL END,
    fs.top_industry,
    CASE WHEN fs.funding_ready THEN 'ready' ELSE 'insufficient_data' END,
    CASE WHEN ar.applicable_count > 0 THEN 'ready' ELSE 'insufficient_data' END,
    now()
  FROM members m
  LEFT JOIN _funding_scored fs ON fs.bioguide_id = m.bioguide_id
  LEFT JOIN _alignment_raw ar ON ar.bioguide_id = m.bioguide_id
  CROSS JOIN _funding_bounds fb
  ON CONFLICT (bioguide_id) DO UPDATE SET
    congress_number = EXCLUDED.congress_number,
    funding_raw_score = EXCLUDED.funding_raw_score,
    funding_display_score = EXCLUDED.funding_display_score,
    alignment_raw_score = EXCLUDED.alignment_raw_score,
    alignment_display_score = EXCLUDED.alignment_display_score,
    composite_score = EXCLUDED.composite_score,
    top_negative_industry_code = EXCLUDED.top_negative_industry_code,
    funding_data_status = EXCLUDED.funding_data_status,
    alignment_data_status = EXCLUDED.alignment_data_status,
    computed_at = EXCLUDED.computed_at;
END;
$$ LANGUAGE plpgsql;
