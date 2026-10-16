-- Exhaustive PAC classification, pass 3. Continues the dollar-ranked sweep from
-- pass 2. Standard maintained: no classification from name pattern alone; well-
-- known public companies classified on well-documented public identity (Visa,
-- Merck, American Express, Huntington Bancshares, CME Group, Prudential — all
-- unambiguous, no live lookup needed to add confidence); genuinely ambiguous
-- cases (Motorola Solutions, Professional Aviation Safety Specialists) verified
-- live via FEC before classifying. Rock Holdings Inc PAC (C00388827) — live FEC
-- lookup returned no data, left needs_review rather than classify off the
-- plausible-but-unconfirmed Rocket Mortgage/Quicken Loans parent-company guess.

INSERT INTO pac_committees (fec_committee_id, committee_name, industry_code, classification_status, classification_source_url, classification_note) SELECT v.fec_committee_id, v.fec_committee_id, v.industry_code, v.classification_status, v.classification_source_url, v.classification_note FROM (VALUES
  ('C00365122', 'wall_street_banking_finance', 'classified', 'https://www.fec.gov/data/committee/C00365122/', 'Visa Inc. — global payments network, financial services.'),
  ('C00495002', 'wall_street_banking_finance', 'classified', 'https://www.fec.gov/data/committee/C00495002/', 'American Investment Council — trade association for the private equity/investment industry.'),
  ('C00127779', 'wall_street_banking_finance', 'classified', 'https://www.fec.gov/data/committee/C00127779/', 'Prudential Financial Inc. — major financial services/insurance/asset management corporation.'),
  ('C00199711', 'pharma_health_insurance', 'classified', 'https://www.fec.gov/data/committee/C00199711/', 'Health Care Service Corporation — operates Blue Cross Blue Shield plans in IL/MT/NM/OK/TX, health insurer.'),
  ('C00040535', 'wall_street_banking_finance', 'classified', 'https://www.fec.gov/data/committee/C00040535/', 'American Express — financial services/credit card company.'),
  ('C00097485', 'pharma_health_insurance', 'classified', 'https://www.fec.gov/data/committee/C00097485/', 'Merck & Co. — major pharmaceutical manufacturer.'),
  ('C00165589', 'wall_street_banking_finance', 'classified', 'https://www.fec.gov/data/committee/C00165589/', 'Huntington Bancshares — bank holding company.'),
  ('C00076299', 'wall_street_banking_finance', 'classified', 'https://www.fec.gov/data/committee/C00076299/', 'CME Group — operates major financial derivatives/futures exchanges (CME, CBOT, NYMEX).'),
  ('C00075341', 'surveillance_weapons', 'classified', 'https://www.fec.gov/data/committee/C00075341/', 'Motorola Solutions — verified live via FEC (Corporation, PAC-Qualified). Core business is mission-critical public-safety communications, video security/surveillance, and command-center software for law enforcement/government.'),
  ('C00099234', 'labor_union', 'classified', 'https://www.fec.gov/data/committee/C00099234/', 'Brotherhood of Locomotive Engineers & Trainmen — railroad labor union.'),
  ('C00005157', 'labor_union', 'classified', 'https://www.fec.gov/data/committee/C00005157/', 'International Brotherhood of Boilermakers — labor union.'),
  ('C00286807', 'labor_union', 'classified', 'https://www.fec.gov/data/committee/C00286807/', 'Professional Aviation Safety Specialists — verified live via FEC as "Labor Organization."'),
  ('C00551812', 'wall_street_banking_finance', 'classified', 'https://www.fec.gov/data/committee/C00551812/', 'Bread Financial Holdings (formerly Alliance Data) — consumer financial services/credit.'),
  ('C00252940', 'other_positive', 'classified', 'https://www.fec.gov/data/committee/C00252940/', 'League of Conservation Voters Action Fund — genuine grassroots-membership environmental advocacy PAC, not corporate/industry money.')
) AS v(fec_committee_id, industry_code, classification_status, classification_source_url, classification_note)
ON CONFLICT (fec_committee_id) DO UPDATE SET
  industry_code = EXCLUDED.industry_code,
  classification_status = EXCLUDED.classification_status,
  classification_source_url = EXCLUDED.classification_source_url,
  classification_note = EXCLUDED.classification_note,
  last_reviewed_date = CURRENT_DATE;

INSERT INTO pac_committees (fec_committee_id, committee_name, classification_status, classification_note) SELECT v.fec_committee_id, v.fec_committee_id, v.classification_status, v.classification_note FROM (VALUES
  ('C00213173', 'reviewed_no_fit', 'K&L Gates LLP — law firm PAC, no fitting category among current 9.'),
  ('C00894881', 'reviewed_no_fit', 'Democrats Win Fund — leadership/party-aligned PAC, not industry money.'),
  ('C00557793', 'reviewed_no_fit', 'Blue Origin — primarily commercial aerospace; same reasoning already applied to SpaceX this session (defense revenue real but not dominant enough of a diversified business to confidently classify as surveillance/weapons).'),
  ('C00076182', 'reviewed_no_fit', 'National Turkey Federation — agriculture trade association, no fitting category.'),
  ('C00336743', 'reviewed_no_fit', 'Asian American Hotel Owners Association — hospitality trade group, no fitting category.'),
  ('C00262295', 'reviewed_no_fit', 'CTIA - The Wireless Association — telecom trade group. FLAG: telecom/media pattern recurring across multiple committees this pass; possible new category, methodology decision for Melissa, not decided here.'),
  ('C00478099', 'reviewed_no_fit', 'Atlas Air Worldwide Holdings — cargo airline, no fitting category.'),
  ('C00248849', 'reviewed_no_fit', 'CropLife America — agrochemical/pesticide industry trade group, no fitting category.'),
  ('C00009282', 'reviewed_no_fit', 'Norfolk Southern — railroad corporation, no fitting category.'),
  ('C00067231', 'reviewed_no_fit', 'HCA Healthcare — hospital operator, a healthcare PROVIDER not a health insurer or pharma manufacturer. FLAG: provider-vs-payer/manufacturer distinction already surfaced in the prior pass; current pharma_health_insurance category scope doesn''t cleanly cover hospital/provider chains, methodology decision for Melissa.'),
  ('C00019653', 'reviewed_no_fit', 'Edison International — electric utility holding company (Southern California Edison). FLAG: electric-utilities pattern recurring, possible new category, not decided here.'),
  ('C00002261', 'reviewed_no_fit', 'Federation of American Hospitals — hospital industry trade group. Same provider/payer flag as HCA above.'),
  ('C00003764', 'reviewed_no_fit', 'National Restaurant Association — restaurant industry trade group, no fitting category.'),
  ('C00344234', 'reviewed_no_fit', 'PAC to the Future — generic name, likely a leadership PAC; insufficient evidence found to classify confidently either way.'),
  ('C00034785', 'reviewed_no_fit', 'ACA International (ACPAC) — debt collection industry association; doesn''t cleanly fit "major banks, investment firms, financial services" as currently scoped.'),
  ('C00003855', 'reviewed_no_fit', 'National Confectioners Association (Candy PAC) — confectionery industry trade group, no fitting category.'),
  ('C00764233', 'reviewed_no_fit', 'Defend the Vote — appears to be an advocacy/leadership-style PAC; insufficient evidence to classify confidently.'),
  ('C00341602', 'reviewed_no_fit', 'Southwest Airlines — airline, no fitting category.'),
  ('C00107300', 'reviewed_no_fit', 'American Airlines — airline, no fitting category.'),
  ('C00033779', 'reviewed_no_fit', 'The Real Estate Roundtable — real estate industry trade group. FLAG: new pattern, not previously surfaced — real estate industry may warrant its own category, methodology decision for Melissa.'),
  ('C00404392', 'reviewed_no_fit', 'Conservative Opportunity Leadership and Enterprise PAC — ideological/leadership PAC, not industry money.'),
  ('C00446674', 'reviewed_no_fit', 'Western Sugar Cooperative — agriculture, no fitting category.'),
  ('C00390161', 'reviewed_no_fit', 'Eureka PAC — generic name; insufficient evidence found to classify confidently.'),
  ('C00104901', 'reviewed_no_fit', 'Akin Gump Strauss Hauer & Feld LLP — law firm PAC, no fitting category.'),
  ('C00545749', 'reviewed_no_fit', 'Emmer for Congress — this is a candidate committee, not an industry PAC at all.')
) AS v(fec_committee_id, classification_status, classification_note)
ON CONFLICT (fec_committee_id) DO UPDATE SET
  classification_status = EXCLUDED.classification_status,
  classification_note = EXCLUDED.classification_note,
  last_reviewed_date = CURRENT_DATE;

-- Rock Holdings Inc PAC (C00388827) deliberately left needs_review — live FEC lookup
-- returned no data during this pass, insufficient to confirm despite plausible
-- Rocket Mortgage/Quicken Loans parent-company identity. Worth a follow-up lookup.
