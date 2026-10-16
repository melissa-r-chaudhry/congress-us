-- 2026-08-25: min-max normalized display scores (funding_display_score, alignment_display_score,
-- composite_score) are sensitive to outlier compression -- a handful of extreme members stretch
-- the scale so the bulk of "normal" members cluster in a narrow middle band. Percentile rank
-- already existed for the composite (spread uniformly 0-100 across whatever members exist, by
-- construction) but wasn't computed per-component, and wasn't the PRIMARY number shown on cards --
-- the clustered raw display score was. Adding the missing per-component percentiles here;
-- refresh_member_scores.sql and the app layer switch to using these as primary in a follow-up step.

ALTER TABLE member_scores
  ADD COLUMN IF NOT EXISTS funding_percentile_rank NUMERIC,
  ADD COLUMN IF NOT EXISTS alignment_percentile_rank NUMERIC;
