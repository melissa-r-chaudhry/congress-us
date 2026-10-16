-- 2026-08-25: "PAC Funding Partisanship" factor -- Melissa's ask #2 of the 3-way funding split.
-- Computed directly from data we already have (pac_contributions x member_terms.party), NOT a
-- new manual PAC-by-PAC classification sweep -- deliberately different approach than the
-- industry classification, and confirmed as the chosen approach in this session.
--
-- What it measures: not "which party is this member," but "how one-sided are the PACs funding
-- them" -- a member funded heavily by PACs that pour ~all their money into one party (hyper-
-- partisan machine PACs) scores differently than one funded by PACs that split more evenly
-- across both parties, independent of the member's own party. Direction (R-leaning vs D-leaning)
-- is stored separately as context, not baked into the score's polarity -- no value judgment is
-- attached to which party a PAC favors, only to how one-sided its giving pattern is, consistent
-- with the site's nonpartisan design.
ALTER TABLE member_scores
  ADD COLUMN IF NOT EXISTS funding_lean_intensity NUMERIC,  -- 0 = funded by evenly-bipartisan-giving PACs, 100 = funded by hyper-partisan-giving PACs
  ADD COLUMN IF NOT EXISTS funding_lean_direction NUMERIC,  -- 0-1, >0.5 = those PACs skew Republican on average, <0.5 = skew Democrat; context only, not scored
  ADD COLUMN IF NOT EXISTS funding_lean_percentile_rank NUMERIC;
