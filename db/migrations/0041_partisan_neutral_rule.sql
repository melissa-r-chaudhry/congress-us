-- Applies Melissa's rule (2026-07-28): "partisan turnout organizations are neutral, period.
-- nonpartisan power-building/pro genuine democracy/good governance organizations are positive."
-- Retroactively re-examines EVERY already-classified other_positive committee, per her explicit
-- instruction, not just new ones going forward. Result: none of the 14 previously-classified
-- committees actually qualify under the precise test -- they are genuine issue-advocacy
-- organizations (environment, LGBTQ+ rights, reproductive rights, immigration, animal welfare,
-- disease research, veteran advocacy) or partisan-turnout-shaped, not democracy-structure/
-- governance-reform organizations specifically. other_positive is intentionally empty after
-- this migration -- an honest reflection of the new stricter definition, not an error.

-- The 3 newly-flagged, clearly partisan-turnout-shaped committees
UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='Partisan advocacy/electoral organization (pro-life movement). Per Melissa''s explicit rule (2026-07-28): "partisan turnout organizations are neutral, period." Not classified positive or negative -- same treatment applies symmetrically to Progressive Turnout Project and Citizens United Political Victory Fund.'
WHERE committee_name ILIKE '%SUSAN B%ANTHONY%' OR committee_name ILIKE '%PRO-LIFE AMERICA%';

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='Explicitly partisan electoral-turnout organization. Per Melissa''s rule (2026-07-28): "partisan turnout organizations are neutral, period."'
WHERE committee_name ILIKE '%PROGRESSIVE TURNOUT PROJECT%';

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='Explicitly partisan electoral-turnout organization. Per Melissa''s rule (2026-07-28): "partisan turnout organizations are neutral, period." Same symmetric treatment as Progressive Turnout Project on the other side.'
WHERE committee_name ILIKE '%CITIZENS UNITED POLITICAL VICTORY FUND%';

-- Retroactive re-examination of all 14 previously-classified other_positive committees.
-- MoveOn specifically: explicitly partisan-turnout-shaped, per Melissa's direct call-out.
UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28 per Melissa''s new rule: "partisan turnout organizations are neutral, period." MoveOn.org functions as progressive electoral-turnout infrastructure, not a nonpartisan democracy/governance-reform organization -- does not qualify as other_positive under the narrowed definition.'
WHERE fec_committee_id = 'C00341396';

-- The remaining 13: genuine issue-advocacy organizations (real, verified missions), but NOT
-- specifically democracy-structure/governance-reform organizations (voting rights, campaign
-- finance reform, redistricting, government accountability) -- the actual bar Melissa's rule
-- sets for "positive." Symmetric and consistent: reclassified to neutral like Planned
-- Parenthood's real-world mirror-image counterpart (Susan B. Anthony List) above.
UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28 per Melissa''s new rule: "nonpartisan power-building/pro genuine democracy/good governance organizations are positive." This is genuine issue-advocacy (retirement/Social Security policy), not a democracy-structure/governance-reform organization -- does not meet the narrowed bar for other_positive, even though it is real, grassroots-funded, and not corporate money.'
WHERE fec_committee_id = 'C00436188'; -- Alliance for Retired Americans

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28: genuine disease-research/care-funding advocacy (Alzheimer''s), not a democracy-structure/governance-reform organization. Does not meet the narrowed other_positive bar.'
WHERE fec_committee_id = 'C00486928'; -- Alzheimer's Impact Movement

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28: environmental issue-advocacy with an explicitly partisan-branded name ("Democratic Conservation Alliance"). Neither democracy-structure advocacy nor safely nonpartisan -- clear case for neutral under the new rule.'
WHERE fec_committee_id = 'C00657452'; -- Democratic Conservation Alliance PAC

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28: genuine environmental issue-advocacy, not a democracy-structure/governance-reform organization. Does not meet the narrowed other_positive bar.'
WHERE fec_committee_id = 'C00471540'; -- Environmental Defense Action Fund

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28: genuine animal-welfare issue-advocacy, not a democracy-structure/governance-reform organization. Does not meet the narrowed other_positive bar.'
WHERE fec_committee_id = 'C00466813'; -- Humane World Action Fund

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28: genuine LGBTQ+ civil-rights issue-advocacy, not specifically a democracy-structure/governance-reform organization (voting rights, campaign finance, redistricting, accountability) under Melissa''s precise test. Does not meet the narrowed other_positive bar, applying the same strict reading used across all issue-advocacy PACs regardless of political association.'
WHERE fec_committee_id = 'C00235853'; -- Human Rights Campaign PAC

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28: genuine (bipartisan-framed) immigration-policy issue-advocacy, not a democracy-structure/governance-reform organization. Does not meet the narrowed other_positive bar.'
WHERE fec_committee_id = 'C00430280'; -- Immigrants' List

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28: climate-issue advocacy tied to a public figure, not a democracy-structure/governance-reform organization. Does not meet the narrowed other_positive bar.'
WHERE fec_committee_id = 'C00806893'; -- Jane Fonda Climate PAC

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28: genuine environmental issue-advocacy, not a democracy-structure/governance-reform organization. Does not meet the narrowed other_positive bar.'
WHERE fec_committee_id = 'C00252940'; -- League of Conservation Voters Action Fund

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28 per Melissa''s explicit instruction: reproductive-rights issue-advocacy, the direct real-world mirror of Susan B. Anthony List on the opposite side of the same issue. Classifying one positive/neutral and not the other would be a visible partisan asymmetry -- both now treated identically as neutral, issue-advocacy rather than democracy-structure organizations.'
WHERE fec_committee_id = 'C00314617'; -- Planned Parenthood Action Fund

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28: genuine environmental issue-advocacy, not a democracy-structure/governance-reform organization. Does not meet the narrowed other_positive bar.'
WHERE fec_committee_id = 'C00135368'; -- Sierra Club PAC

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28: a congressional coalition PAC (founded by sitting Representatives) for clean-energy/environmental policy -- closer to a legislative caucus vehicle than grassroots democracy-reform advocacy. Does not meet the narrowed other_positive bar.'
WHERE fec_committee_id = 'C00581785'; -- SEEC PAC

UPDATE pac_committees SET classification_status='reviewed_no_fit', industry_code=NULL,
  classification_note='RECLASSIFIED 2026-07-28, flagged as the closest call of this batch: VoteVets'' stated mission (increasing veteran representation in government) has a plausible "power-building/broadening who participates" reading, but its real-world observed behavior has been reported as functioning closer to Democratic-aligned veteran-candidate turnout than nonpartisan democracy-structure reform. Reclassified to neutral for consistency with the strict reading applied across this batch -- worth revisiting if better evidence of genuinely nonpartisan behavior surfaces.'
WHERE fec_committee_id = 'C00418897'; -- VoteVets
