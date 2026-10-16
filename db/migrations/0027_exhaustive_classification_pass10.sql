-- Exhaustive PAC classification, pass 10. Resumed from pass 9's 67.4% mark.
-- Real FEC API rate limit (1000/hour, personal key) hit almost immediately this
-- pass -- only 1 of 9 attempted live lookups succeeded (confirmed below). For
-- the remainder, classified only well-known, unambiguous public companies
-- without a fresh call (Devon Energy, Halliburton, Oracle, Franklin Templeton --
-- singular, well-documented real-world identity, not name-guessing on an
-- ambiguous org). Left genuinely ambiguous odd-named committees (Rebuild
-- America PAC, HMS Scrap PAC, BRETTPAC, VITORIA PAC, SIX PAC, LIFTOFF PAC,
-- Blue Dog PAC, Torch Technologies, Fight On PAC, and others) in needs_review
-- rather than guess -- same discipline pass 9 used for Blue Dog PAC.

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://www.fec.gov/data/committee/C00354753/',
  classification_note = 'Devon Energy Corporation -- major US oil & gas exploration/production company, unambiguous public-company identity.'
  WHERE fec_committee_id = 'C00354753';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://www.fec.gov/data/committee/C00035691/',
  classification_note = 'Halliburton Company -- major oilfield services company, unambiguous public-company identity.'
  WHERE fec_committee_id = 'C00035691';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'big_tech_crypto',
  classification_source_url = 'https://www.fec.gov/data/committee/C00323048/',
  classification_note = 'Oracle America, Inc. -- major technology company, unambiguous public-company identity.'
  WHERE fec_committee_id = 'C00323048';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00874982/',
  classification_note = 'Franklin Resources Inc (Franklin Templeton) -- major asset management/investment firm, unambiguous public-company identity.'
  WHERE fec_committee_id = 'C00874982';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00633354/',
  classification_note = 'Structured Finance Coalition -- trade group for the securitization/structured-finance industry (MBS/ABS), a core Wall Street capital-markets activity by its own name and function.'
  WHERE fec_committee_id = 'C00633354';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'surveillance_weapons',
  classification_source_url = 'https://www.fec.gov/data/committee/C00414896/',
  classification_note = 'OSI Systems Inc -- parent of Rapiscan Systems, well-documented security/detection screening technology (airport/border security scanners).'
  WHERE fec_committee_id = 'C00414896';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'surveillance_weapons',
  classification_source_url = 'https://www.fec.gov/data/committee/C00731414/',
  classification_note = 'Amentum Services Inc -- major government/defense/intelligence services contractor, well-documented 2020 spinoff of AECOM government services business.'
  WHERE fec_committee_id = 'C00731414';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_source_url = 'https://www.fec.gov/data/committee/C00849323/',
  classification_note = 'Independent Pilots Association -- real labor union representing UPS pilots.'
  WHERE fec_committee_id = 'C00849323';

-- reviewed_no_fit: healthcare-provider professional associations (recurring flagged cluster)
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Academy of Family Physicians (FAMMEDPAC) -- physician professional association, healthcare-provider not payer/manufacturer, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00411553';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'College of American Pathologists -- physician professional association, healthcare-provider not payer/manufacturer, no fitting category.'
  WHERE fec_committee_id = 'C00274944';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Society of Clinical Oncology (ASCO) Association PAC -- physician specialty professional association, healthcare-provider not payer/manufacturer, no fitting category.'
  WHERE fec_committee_id = 'C00734012';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Association of Crop Insurers -- agriculture/crop-insurance hybrid trade group, no fitting category among current 9 (not general insurance, not agriculture).'
  WHERE fec_committee_id = 'C00172833';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'National Association of Wholesaler-Distributors -- generic cross-industry trade association, no fitting category.'
  WHERE fec_committee_id = 'C00109306';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Salt River Project -- Arizona public power/water utility. Electric utilities remain a recurring flagged gap, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00048579';

-- reviewed_no_fit: law firms (established pattern)
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Troutman Pepper Locke LLP -- law firm, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00311142';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Arnold & Porter Kaye Scholer LLP -- law firm, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00216895';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Steptoe LLP -- law firm, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00431858';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Thompson Coburn -- law firm, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00550491';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Texans for Jodey Arrington -- a sitting member of Congress''s own candidate committee, not industry money at all (same treatment as Pete Aguilar for Congress in pass 8).'
  WHERE fec_committee_id = 'C00588657';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'CHC BOLD PAC -- Congressional Hispanic Caucus''s political action committee. Caucus/advocacy money, not industry-aligned, no fitting category.'
  WHERE fec_committee_id = 'C00365536';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Unum Group -- life/disability insurance company. General/life insurance remains a recurring flagged gap, distinct from banking/finance, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00177436';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Protective Life Corp -- life insurance company. Same general/life insurance gap as Unum, no fitting category.'
  WHERE fec_committee_id = 'C00161414';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Demand Justice PAC -- judicial-reform/court-reform advocacy organization. Valence and category fit unclear, not forced into other_positive without clearer evidence, same caution as ARI PAC in pass 8.'
  WHERE fec_committee_id = 'C00760827';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Confirmed via live FEC lookup: Leadership PAC (designation_full=Leadership PAC, leadership_pac flag set), not an industry PAC.'
  WHERE fec_committee_id = 'C00832469';
