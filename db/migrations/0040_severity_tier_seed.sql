-- Seed real committees into the 5 new half-weight industries, using committees already
-- identified (with FEC-confirmed real-company identity) across prior classification passes'
-- reviewed_no_fit notes -- these were correctly held pending a category existing for them.

UPDATE pac_committees SET classification_status='classified', industry_code='electric_utilities',
  classification_source_url='https://www.fec.gov/data/committee/'||fec_committee_id||'/',
  classification_note='Regulated electric utility PAC, confirmed via FEC record. Held reviewed_no_fit across multiple prior passes pending this category''s creation (2026-07-28).'
WHERE fec_committee_id IN ('C00206136','C00075473','C00108209','C00083535','C00064774','C00095869','C00848820','C00144774','C00107771');

UPDATE pac_committees SET classification_status='classified', industry_code='healthcare_providers_medical_devices',
  classification_source_url='https://www.fec.gov/data/committee/'||fec_committee_id||'/',
  classification_note='Medical device manufacturer / healthcare provider PAC, confirmed via FEC record. Held reviewed_no_fit across multiple prior passes pending this category''s creation (2026-07-28).'
WHERE fec_committee_id IN ('C00357863','C00411900','C00311878','C00895706');

UPDATE pac_committees SET classification_status='classified', industry_code='real_estate',
  classification_source_url='https://www.fec.gov/data/committee/'||fec_committee_id||'/',
  classification_note='Real estate industry PAC, confirmed via FEC record. Held reviewed_no_fit across multiple prior passes pending this category''s creation (2026-07-28).'
WHERE fec_committee_id IN ('C00830083','C00699439');

UPDATE pac_committees SET classification_status='classified', industry_code='general_life_insurance',
  classification_source_url='https://www.fec.gov/data/committee/'||fec_committee_id||'/',
  classification_note='General property/casualty or life insurance PAC (distinct from health-insurance payers), confirmed via FEC record. Held reviewed_no_fit across multiple prior passes pending this category''s creation (2026-07-28).'
WHERE fec_committee_id IN ('C00457234','C00406215','C00128918','C00544817','C00376376');

UPDATE pac_committees SET classification_status='classified', industry_code='telecom_media',
  classification_source_url='https://www.fec.gov/data/committee/'||fec_committee_id||'/',
  classification_note='Telecom carrier or media company PAC, confirmed via FEC record. Held reviewed_no_fit across multiple prior passes pending this category''s creation (2026-07-28).'
WHERE fec_committee_id IN ('C00279216','C00025163','C00186288');
