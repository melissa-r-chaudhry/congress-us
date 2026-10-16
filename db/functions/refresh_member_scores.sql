-- refresh_member_scores(): the scoring function, single source of truth for the formula.
-- Full rationale: /Users/macuser/.claude/plans/mutable-spinning-acorn.md and
-- businessventures/project_congress_us.md memory. Reads confidence weights, G, and window
-- sizes live from scoring_config — never hardcode them here, always reference the config.
--
-- 2026-07-28: negative_pac_total now applies pac_industries.severity_weight per row before
-- summing (5 half-weight industries added per Melissa's decision) -- NOT applied to
-- top-negative-industry display (member_top_negative_industries), which stays raw-dollar
-- for factual transparency, only to the SCORE calculation.
-- 2026-07-27: added percentile_rank (0-100, among members with a real composite_score
-- only) — a high percentile means a high score, matching the 100=best/0=worst scale.

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
           SUM(pc.amount * COALESCE(pi.severity_weight, 1.0)) FILTER (WHERE pi.polarity = 'negative') AS negative_pac_total,
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
    -- BUG FIX 2026-08-25: tracked_items.contributes_to_score existed since the original schema
    -- but was never actually joined/filtered here -- every tracked item counted toward the 80%
    -- Bill score regardless of the flag. Caught while adding the Foreign Lobby Independence
    -- items (Antisemitism Awareness Act, Israel Anti-Boycott Act), which are deliberately
    -- contributes_to_score=false -- without this fix they'd have silently polluted the general
    -- alignment score the moment they were added.
    SELECT mt.bioguide_id, tib.id AS tracked_item_bill_id
    FROM member_terms mt
    JOIN tracked_item_bills tib
      ON tib.congress_number = mt.congress_number
     AND ((tib.bill_type IN ('hr','hjres') AND mt.chamber = 'house')
          OR (tib.bill_type = 's' AND mt.chamber = 'senate'))
    JOIN tracked_items ti ON ti.id = tib.tracked_item_id AND ti.contributes_to_score = true
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

  -- 2026-08-25: "PAC Funding Partisanship" -- factor 2 of Melissa's 3-way funding split. Computed
  -- directly from pac_contributions x member_terms.party (data we already have), NOT a manual
  -- PAC-by-PAC classification pass -- deliberately different approach than the industry
  -- classification. Measures how ONE-SIDED the PACs funding a member are (hyper-partisan-giving
  -- vs. evenly-bipartisan-giving), independent of the member's own party -- direction (which
  -- party those PACs favor) is stored separately as context, no polarity/value-judgment attached
  -- to R vs D, only to how one-sided the giving pattern is. See migration 0082 for full rationale.
  CREATE TEMP TABLE _committee_lean ON COMMIT DROP AS
  SELECT pc.fec_committee_id,
         SUM(CASE WHEN mt.party = 'Republican' THEN pc.amount ELSE 0 END) AS r_amount,
         SUM(CASE WHEN mt.party = 'Democrat' THEN pc.amount ELSE 0 END) AS d_amount
  FROM pac_contributions pc
  JOIN member_terms mt ON mt.bioguide_id = pc.bioguide_id AND mt.is_current = true
  JOIN pac_committees pcm ON pcm.fec_committee_id = pc.fec_committee_id
  WHERE pc.cycle_year IN (SELECT cycle_year FROM _ranked_cycles)
    AND COALESCE(pcm.is_conduit, false) = false
  GROUP BY pc.fec_committee_id
  HAVING SUM(CASE WHEN mt.party = 'Republican' THEN pc.amount ELSE 0 END)
       + SUM(CASE WHEN mt.party = 'Democrat' THEN pc.amount ELSE 0 END) > 0;

  CREATE TEMP TABLE _committee_lean_score ON COMMIT DROP AS
  SELECT fec_committee_id,
         r_amount / (r_amount + d_amount) AS lean_direction,          -- 0 = all-D-giving, 1 = all-R-giving
         ABS(r_amount / (r_amount + d_amount) - 0.5) * 2 AS lean_intensity -- 0 = evenly split, 1 = fully one-sided
  FROM _committee_lean;

  -- 2026-08-25: persist committee-level lean (migration 0086) so the per-member "PAC Lean" tab
  -- can show each of a member's top PACs with its own indicator, not just the member rollup.
  UPDATE pac_committees pcm
  SET lean_direction = ROUND(cls.lean_direction, 3), lean_intensity = ROUND(cls.lean_intensity * 100, 1)
  FROM _committee_lean_score cls
  WHERE pcm.fec_committee_id = cls.fec_committee_id;

  CREATE TEMP TABLE _member_lean ON COMMIT DROP AS
  SELECT pc.bioguide_id,
         SUM(pc.amount * cls.lean_intensity) / NULLIF(SUM(pc.amount), 0) AS intensity_raw,
         SUM(pc.amount * cls.lean_direction) / NULLIF(SUM(pc.amount), 0) AS direction_raw
  FROM pac_contributions pc
  JOIN _committee_lean_score cls ON cls.fec_committee_id = pc.fec_committee_id
  WHERE pc.cycle_year IN (SELECT cycle_year FROM _ranked_cycles)
  GROUP BY pc.bioguide_id;

  UPDATE member_scores ms
  SET funding_lean_intensity = ROUND(ml.intensity_raw * 100, 1),
      funding_lean_direction = ROUND(ml.direction_raw, 3)
  FROM _member_lean ml
  WHERE ms.bioguide_id = ml.bioguide_id;

  UPDATE member_scores SET funding_lean_intensity = NULL, funding_lean_direction = NULL
  WHERE bioguide_id NOT IN (SELECT bioguide_id FROM _member_lean);

  -- 2026-08-25: "Foreign Lobby Independence" -- factor 4. Two real signals only: AIPAC-aligned
  -- PAC money (the already-classified pac_industries.code='aipac_aligned' committees -- NOT
  -- aipac_traced_total, which sources from the still-empty external_funding_signals V3.0
  -- donor-tracing table, deferred separately) and whether the member signed the PEACE Pledge.
  -- Deliberately percentile-only, no G-point blending -- AIPAC dollar amounts and a rare binary
  -- pledge signal live on wildly different scales, and percentile rank sidesteps that cleanly.
  -- Pledge signers get an explicit 100th-percentile floor: signing away AIPAC-money eligibility
  -- entirely is a small (3 members, as of 2026-08-25 research), real, costly, verifiable
  -- commitment that a raw dollar-based percentile alone likely wouldn't surface strongly enough.
  CREATE TEMP TABLE _foreign_lobby_raw ON COMMIT DROP AS
  SELECT m.bioguide_id,
         -COALESCE(aipac.amount, 0) AS raw_score,
         (pps.bioguide_id IS NOT NULL) AS pledge_signed,
         fs.funding_ready
  FROM members m
  LEFT JOIN (SELECT bioguide_id, amount FROM _neg_by_industry WHERE industry_code = 'aipac_aligned') aipac
    ON aipac.bioguide_id = m.bioguide_id
  LEFT JOIN peace_pledge_signatures pps ON pps.bioguide_id = m.bioguide_id
  LEFT JOIN _funding_scored fs ON fs.bioguide_id = m.bioguide_id;

  UPDATE member_scores ms
  SET foreign_lobby_percentile_rank = LEAST(
        100,
        GREATEST(
          COALESCE(sub.pct, 0),
          CASE WHEN flr.pledge_signed THEN 100 ELSE 0 END
        )
      )
  FROM _foreign_lobby_raw flr
  LEFT JOIN (
    SELECT bioguide_id, ROUND((CUME_DIST() OVER (ORDER BY raw_score))::numeric * 100, 0) AS pct
    FROM _foreign_lobby_raw WHERE funding_ready
  ) sub ON sub.bioguide_id = flr.bioguide_id
  WHERE ms.bioguide_id = flr.bioguide_id AND flr.funding_ready;

  UPDATE member_scores SET foreign_lobby_percentile_rank = NULL
  WHERE bioguide_id NOT IN (SELECT bioguide_id FROM _foreign_lobby_raw WHERE funding_ready);

  -- Percentile rank, 0-100, ONLY among members with a real composite_score — a high
  -- percentile means a HIGH score (100=best), matching Melissa's stated scale.
  -- BUG FIX 2026-08-25: was PERCENT_RANK, which anchors a tied block to the START of its
  -- sorted position -- for a field where hundreds of members are genuinely tied at the single
  -- BEST possible value (e.g. $0 AIPAC money), PERCENT_RANK gave that whole top-tier group a
  -- misleadingly low percentile (~33 instead of 100), since it measures "strictly worse than
  -- you," not "at or better than you." CUME_DIST measures the latter -- ties at the max
  -- correctly show 100, ties at the min correctly show a value reflecting the true share below.
  UPDATE member_scores ms
  SET percentile_rank = sub.pct
  FROM (
    SELECT bioguide_id, ROUND((CUME_DIST() OVER (ORDER BY composite_score))::numeric * 100, 0) AS pct
    FROM member_scores
    WHERE composite_score IS NOT NULL
  ) sub
  WHERE ms.bioguide_id = sub.bioguide_id;

  UPDATE member_scores SET percentile_rank = NULL WHERE composite_score IS NULL;

  -- 2026-08-25: same percentile treatment, computed separately per component. The min-max
  -- *_display_score columns stay (useful as an exact reference number on the profile page,
  -- and `refresh_member_scores`'s own math is checkable against them), but percentile rank is
  -- what the app now shows as the PRIMARY number, since it's spread uniformly 0-100 across
  -- whatever members exist by construction -- immune to a handful of outliers compressing
  -- everyone else into a narrow band, which is exactly what min-max display scores were doing.
  UPDATE member_scores ms
  SET funding_percentile_rank = sub.pct
  FROM (
    SELECT bioguide_id, ROUND((CUME_DIST() OVER (ORDER BY funding_display_score))::numeric * 100, 0) AS pct
    FROM member_scores
    WHERE funding_display_score IS NOT NULL
  ) sub
  WHERE ms.bioguide_id = sub.bioguide_id;
  UPDATE member_scores SET funding_percentile_rank = NULL WHERE funding_display_score IS NULL;

  UPDATE member_scores ms
  SET alignment_percentile_rank = sub.pct
  FROM (
    SELECT bioguide_id, ROUND((CUME_DIST() OVER (ORDER BY alignment_display_score))::numeric * 100, 0) AS pct
    FROM member_scores
    WHERE alignment_display_score IS NOT NULL
  ) sub
  WHERE ms.bioguide_id = sub.bioguide_id;
  UPDATE member_scores SET alignment_percentile_rank = NULL WHERE alignment_display_score IS NULL;

  -- funding_lean_intensity percentile: NOTE this is intentionally NOT "higher = better" like the
  -- other three -- it's a neutral fact (how one-sided is this member's PAC funding), not a value
  -- judgment, so the app layer must not color/label it good/bad the way it does for the others.
  UPDATE member_scores ms
  SET funding_lean_percentile_rank = sub.pct
  FROM (
    SELECT bioguide_id, ROUND((CUME_DIST() OVER (ORDER BY funding_lean_intensity))::numeric * 100, 0) AS pct
    FROM member_scores
    WHERE funding_lean_intensity IS NOT NULL
  ) sub
  WHERE ms.bioguide_id = sub.bioguide_id;
  UPDATE member_scores SET funding_lean_percentile_rank = NULL WHERE funding_lean_intensity IS NULL;
END;
$$ LANGUAGE plpgsql;
