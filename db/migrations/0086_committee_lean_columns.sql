-- 2026-08-25: persist committee-level partisan lean (previously computed transiently inside
-- refresh_member_scores.sql's _committee_lean_score temp table, never stored) so the new
-- per-member "PAC Lean" tab can show each of a member's top PACs with its own lean indicator,
-- not just the member-level rollup.
ALTER TABLE pac_committees
  ADD COLUMN IF NOT EXISTS lean_direction NUMERIC,  -- 0=all-D-giving, 1=all-R-giving, same scale as member_scores.funding_lean_direction
  ADD COLUMN IF NOT EXISTS lean_intensity NUMERIC;  -- 0-100, 0=evenly bipartisan-giving, 100=fully one-sided
