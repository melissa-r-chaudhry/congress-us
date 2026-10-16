-- Adds a percentile rank next to composite scores, so a raw number like "39.1" has
-- context ("better than X% of scored members") without requiring the full methodology
-- page. Computed only among members who actually have a composite_score — members
-- still awaiting funding data are excluded from the ranking universe entirely (not
-- given a fake low percentile).

ALTER TABLE member_scores ADD COLUMN percentile_rank NUMERIC;

CREATE OR REPLACE FUNCTION refresh_member_scores() RETURNS void AS $$
DECLARE
  v_G NUMERIC;
  v_conf_direct NUMERIC;
  v_conf_inferred NUMERIC;
  v_pos_weight NUMERIC;
  v_cycle_window INT;
  v_congress_window INT;
  v_avg_ratio NUMERIC;
BEGIN
  SELECT value::numeric INTO v_G FROM scoring_config WHERE key = 'grassroots_avg_gift_G';
  SELECT value::numeric INTO v_conf_direct FROM scoring_config WHERE key = 'confidence_direct';
  SELECT value::numeric INTO v_conf_inferred FROM scoring_config WHERE key = 'confidence_inferred';
  SELECT value::numeric INTO v_pos_weight FROM scoring_config WHERE key = 'positive_pac_weight';
  SELECT value::int INTO v_cycle_window FROM scoring_config WHERE key = 'funding_cycle_window';
  SELECT value::int INTO v_congress_window FROM scoring_config WHERE key = 'alignment_congress_window';

  CREATE TEMP TABLE _ranked_cycles ON COMMIT DROP AS
  SELECT DISTINCT cycle_year FROM individual_contribution_summary
  ORDER BY cycle_year DESC LIMIT v_cycle_window;

  CREATE TEMP TABLE _neg_by_industry ON COMMIT DROP AS
  SELECT pc.bioguide_id, pi.code AS industry_code, SUM(pc.amount) AS amount
  FROM pac_contributions pc
  JOIN pac_committees cm ON cm.fec_committee_id = pc.fec_committee_id
  JOIN pac_industries pi ON pi.code = cm.industry_code AND pi.polarity = 'negative'
  WHERE pc.cycle_year IN (SELECT cycle_year FROM _ranked_cycles)
  GROUP BY pc.bioguide_id, pi.code;

  CREATE TEMP TABLE _neg_max ON COMMIT DROP AS
  SELECT bioguide_id, MAX(amount) AS max_amount FROM _neg_by_industry GROUP BY bioguide_id;

  CREATE TEMP TABLE _top_neg_all ON COMMIT DROP AS
  SELECT t.bioguide_id, t.industry_code, t.amount
  FROM _neg_by_industry t
  JOIN _neg_max nm ON nm.bioguide_id = t.bioguide_id AND t.amount = nm.max_amount;

  DELETE FROM member_top_negative_industries;
  INSERT INTO member_top_negative_industries (bioguide_id, industry_code, amount)
  SELECT bioguide_id, industry_code, amount FROM _top_neg_all;

  CREATE TEMP TABLE _funding_raw ON COMMIT DROP AS
  WITH ics AS (
    SELECT bioguide_id,
           SUM(verified_itemized_count_under200) AS count_under200,
           SUM(estimated_unitemized_count) AS est_unitemized_count,
           SUM(unitemized_total_amount) AS grassroots_total_amount,
           COUNT(*) AS cycles_present
    FROM individual_contribution_summary
    WHERE cycle_year IN (SELECT cycle_year FROM _ranked_cycles)
    GROUP BY bioguide_id
  ),
  pac AS (
    SELECT pc.bioguide_id,
           SUM(pc.amount) FILTER (WHERE pi.polarity = 'negative') AS negative_pac_total,
           SUM(pc.amount) FILTER (WHERE pi.polarity = 'positive') AS positive_pac_total,
           SUM(pc.amount) AS pac_total_amount
    FROM pac_contributions pc
    LEFT JOIN pac_committees cm ON cm.fec_committee_id = pc.fec_committee_id
    LEFT JOIN pac_industries pi ON pi.code = cm.industry_code
    WHERE pc.cycle_year IN (SELECT cycle_year FROM _ranked_cycles)
    GROUP BY pc.bioguide_id
  ),
  aipac_signal AS (
    SELECT bioguide_id, SUM(amount) AS traced_total
    FROM external_funding_signals
    WHERE cycle_year IN (SELECT cycle_year FROM _ranked_cycles)
    GROUP BY bioguide_id
  ),
  top_neg AS (
    SELECT DISTINCT ON (bioguide_id) bioguide_id, industry_code AS top_industry
    FROM _top_neg_all
    ORDER BY bioguide_id, industry_code ASC
  )
  SELECT
    m.bioguide_id,
    COALESCE(ics.count_under200, 0) + COALESCE(ics.est_unitemized_count, 0) AS count_under200,
    COALESCE(pac.positive_pac_total, 0) AS positive_pac_total,
    COALESCE(pac.negative_pac_total, 0) AS negative_pac_total,
    COALESCE(aipac.traced_total, 0) AS aipac_traced_total,
    COALESCE(ics.grassroots_total_amount, 0) AS grassroots_total_amount,
    COALESCE(pac.pac_total_amount, 0) AS pac_total_amount,
    (ics.cycles_present IS NOT NULL AND ics.cycles_present > 0) OR (pac.bioguide_id IS NOT NULL) AS funding_ready,
    tn.top_industry
  FROM members m
  LEFT JOIN ics ON ics.bioguide_id = m.bioguide_id
  LEFT JOIN pac ON pac.bioguide_id = m.bioguide_id
  LEFT JOIN aipac_signal aipac ON aipac.bioguide_id = m.bioguide_id
  LEFT JOIN top_neg tn ON tn.bioguide_id = m.bioguide_id;

  CREATE TEMP TABLE _funding_scored ON COMMIT DROP AS
  SELECT
    bioguide_id,
    funding_ready,
    top_industry,
    grassroots_total_amount,
    pac_total_amount,
    CASE WHEN pac_total_amount > 0 THEN grassroots_total_amount / pac_total_amount ELSE NULL END AS people_pac_ratio,
    (count_under200 * 1.0)
      + ((positive_pac_total / NULLIF(v_G,0)) * v_pos_weight)
      - ((negative_pac_total / NULLIF(v_G,0)) * v_conf_direct)
      - ((aipac_traced_total / NULLIF(v_G,0)) * v_conf_inferred)
      AS funding_raw
  FROM _funding_raw;

  SELECT SUM(grassroots_total_amount) / NULLIF(SUM(pac_total_amount), 0)
    INTO v_avg_ratio FROM _funding_scored WHERE funding_ready;

  UPDATE scoring_config SET value = COALESCE(v_avg_ratio, 0)::text, updated_at = now()
  WHERE key = 'dataset_avg_people_pac_ratio';

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

  CREATE TEMP TABLE _funding_bounds ON COMMIT DROP AS
  SELECT MIN(funding_raw) AS lo, MAX(funding_raw) AS hi
  FROM _funding_scored WHERE funding_ready;

  INSERT INTO member_scores (bioguide_id, congress_number, funding_raw_score, funding_display_score,
    alignment_raw_score, alignment_display_score, composite_score, top_negative_industry_code,
    grassroots_total_amount, pac_total_amount, people_pac_ratio,
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
    fs.grassroots_total_amount,
    fs.pac_total_amount,
    fs.people_pac_ratio,
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
    grassroots_total_amount = EXCLUDED.grassroots_total_amount,
    pac_total_amount = EXCLUDED.pac_total_amount,
    people_pac_ratio = EXCLUDED.people_pac_ratio,
    funding_data_status = EXCLUDED.funding_data_status,
    alignment_data_status = EXCLUDED.alignment_data_status,
    computed_at = EXCLUDED.computed_at;

  -- Percentile rank, 0-100, ONLY among members with a real composite_score — a high
  -- percentile means a HIGH score (100=best), matching Melissa's stated scale.
  -- PERCENT_RANK gives the bottom scorer 0 and the top scorer 1; scaled to 0-100 and
  -- rounded for display ("80th percentile" reads as "better than 80% of scored members").
  UPDATE member_scores ms
  SET percentile_rank = sub.pct
  FROM (
    SELECT bioguide_id, ROUND((PERCENT_RANK() OVER (ORDER BY composite_score))::numeric * 100, 0) AS pct
    FROM member_scores
    WHERE composite_score IS NOT NULL
  ) sub
  WHERE ms.bioguide_id = sub.bioguide_id;

  UPDATE member_scores SET percentile_rank = NULL WHERE composite_score IS NULL;
END;
$$ LANGUAGE plpgsql;
