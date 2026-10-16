ALTER TABLE member_scores
  ADD COLUMN IF NOT EXISTS foreign_lobby_percentile_rank NUMERIC;
