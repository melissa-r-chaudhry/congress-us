-- Exhaustive PAC classification, pass 16. All FEC-verified live via CONGRESS_GOV_API_KEY.

UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_note='Stripe Inc. Political Action Committee — Lobbyist/Registrant PAC for Stripe, a major payment-processing/fintech company; classified with payment networks (Visa/Mastercard precedent), not big tech.',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00883116/'
  WHERE fec_committee_id='C00883116';

UPDATE pac_committees SET classification_status='classified', industry_code='oil_gas',
  classification_note='US Energy PAC — the PAC of American Exploration & Production Council, Inc., a trade association for oil & gas exploration/production companies.',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00755454/'
  WHERE fec_committee_id='C00755454';

UPDATE pac_committees SET classification_status='classified', industry_code='big_tech_crypto',
  classification_note='Intel Corporation PAC — confirmed Corporation via FEC, major semiconductor/tech manufacturer.',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00125641/'
  WHERE fec_committee_id='C00125641';

UPDATE pac_committees SET classification_status='classified', industry_code='oil_gas',
  classification_note='Ovintiv USA Inc. PAC — confirmed Corporation via FEC, real oil & gas exploration/production company (formerly Encana).',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00431932/'
  WHERE fec_committee_id='C00431932';

UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_note='Alnylam Pharmaceuticals PAC — confirmed Corporation via FEC, real pharmaceutical company.',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00670331/'
  WHERE fec_committee_id='C00670331';

UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_note='Biotechnology Innovation Organization PAC (BIO PAC) — confirmed Trade Association via FEC, the biotech industry''s primary trade group, same fit as already-classified PhRMA.',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00355677/'
  WHERE fec_committee_id='C00355677';

UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_note='America''s Health Insurance Plans PAC (AHIP PAC) — confirmed Trade Association via FEC, the health insurance industry''s primary national trade group.',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00106740/'
  WHERE fec_committee_id='C00106740';

UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_note='Delta Dental Plans Association PAC — confirmed Trade Association via FEC, dental insurance industry; same treatment as already-classified VSP (vision insurance).',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00213819/'
  WHERE fec_committee_id='C00213819';

UPDATE pac_committees SET classification_status='classified', industry_code='labor_union',
  classification_note='International Longshoremen''s Association Committee on Political Education — confirmed Labor Organization via FEC.',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00158576/'
  WHERE fec_committee_id='C00158576';

-- reviewed_no_fit: confirmed Leadership PACs via live FEC lookup (leadership_pac flag = X)
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Confirmed Leadership PAC via live FEC lookup (leadership_pac flag set) — not industry money.',
  classification_source_url='https://api.open.fec.gov/v1/committee/' || fec_committee_id || '/'
  WHERE fec_committee_id IN ('C00524314','C00914028','C00573709','C00583153','C00799809','C00631051','C00377143','C00707232','C00390674','C00654475');

-- reviewed_no_fit: trade associations / law firms / providers / no fitting category, confirmed via FEC record
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='The ESOP Association PAC — confirmed Trade Association via FEC (employee stock ownership plan advocacy) — no fitting category among current 9.',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00196089/'
  WHERE fec_committee_id='C00196089';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Maynard Nexsen PAC — confirmed Corporation via FEC; Maynard Nexsen is a law firm — no fitting category.',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00272724/'
  WHERE fec_committee_id='C00272724';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='National Fisheries Institute (FISHPAC) — confirmed Trade Association via FEC, fishing industry — no fitting category.',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00101204/'
  WHERE fec_committee_id='C00101204';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='American Society for Radiation Oncology PAC (ASTRO-PAC) — healthcare-provider professional association, part of the recurring provider cluster with no fitting category (distinct from health-insurance payers).'
  WHERE fec_committee_id='C00384602';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Agricultural Retailers Association PAC — agriculture trade association, no fitting category.'
  WHERE fec_committee_id='C00264770';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='FAA Managers Association PAC — professional association for FAA managers, no fitting category.'
  WHERE fec_committee_id='C00366070';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='National Business Aviation Association PAC (NBAA-PAC) — aviation trade association, no fitting category.'
  WHERE fec_committee_id='C00319723';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='LifePoint Health PAC — hospital operator, part of the recurring healthcare-provider cluster (distinct from pharma/health-insurance payers), no fitting category.'
  WHERE fec_committee_id='C00347955';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='IHG (InterContinental Hotels Group) PAC — hospitality company, no fitting category.'
  WHERE fec_committee_id='C00836692';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='American Urological Association PAC — healthcare-provider professional association, no fitting category.'
  WHERE fec_committee_id='C00691741';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='American Society of Plastic Surgeons PAC — healthcare-provider professional association, no fitting category.'
  WHERE fec_committee_id='C00249342';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Alliant Energy Corporation Employee''s PAC — electric utility, part of the recurring utilities cluster flagged to Melissa, no current fitting category.'
  WHERE fec_committee_id='C00132092';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Guardian Life Insurance Company of America PAC — general/life insurance, part of the recurring insurance cluster flagged to Melissa (broader than current health-specific scope), no current fitting category.'
  WHERE fec_committee_id='C00173393';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='American Society of Interventional Pain Physicians PAC — healthcare-provider professional association, no fitting category.'
  WHERE fec_committee_id='C00351197';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Ambulatory Surgery Center Association PAC (ASCAPAC) — healthcare-provider association, no fitting category.'
  WHERE fec_committee_id='C00424788';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Mondelez International PAC — diversified food/snack company (Oreo, Cadbury, etc.), no fitting category.'
  WHERE fec_committee_id='C00529073';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Management & Training Corp PAC — private corrections/workforce-training company, no fitting category among current 9.'
  WHERE fec_committee_id='C00208322';
