-- Exhaustive PAC classification pass 20. Resumed from pass 19's ~79.98% resolved.
-- Standard: no name-pattern-only classification; real FEC verification via live
-- lookup (CONGRESS_GOV_API_KEY, avoids FEC_API_KEY's rate-limit contention with
-- the concurrent individual-contribution resync); honest reviewed_no_fit over
-- forced/unsubstantiated classification.

-- Classified (8), all FEC-verified live:
UPDATE pac_committees SET classification_status='classified', industry_code='oil_gas', classification_source_url='https://www.fec.gov/data/committee/C00060103/', classification_note='BP Corporation North America Employee PAC — BP is a major integrated oil & gas company. Confirmed via live FEC lookup.' WHERE fec_committee_id='C00060103';
UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance', classification_source_url='https://www.fec.gov/data/committee/C00789370/', classification_note='Coherus BioSciences PAC — biopharmaceutical company (biosimilars). Confirmed corporation via live FEC lookup.' WHERE fec_committee_id='C00789370';
UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance', classification_source_url='https://www.fec.gov/data/committee/C00721811/', classification_note='Jazz Pharmaceuticals PAC — biopharmaceutical company. Confirmed corporation via live FEC lookup.' WHERE fec_committee_id='C00721811';
UPDATE pac_committees SET classification_status='classified', industry_code='labor_union', classification_source_url='https://www.fec.gov/data/committee/C00280909/', classification_note='Transportation Trades Department AFL-CIO PAC — confirmed org_type Labor Organization via live FEC lookup.' WHERE fec_committee_id='C00280909';
UPDATE pac_committees SET classification_status='classified', industry_code='big_tech_crypto', classification_source_url='https://www.fec.gov/data/committee/C00342394/', classification_note='eBay Inc PAC — major e-commerce/tech platform, same treatment as Amazon precedent. Confirmed corporation via live FEC lookup.' WHERE fec_committee_id='C00342394';
UPDATE pac_committees SET classification_status='classified', industry_code='vice_guns_gambling_alcohol', classification_source_url='https://www.fec.gov/data/committee/C00312785/', classification_note='Swisher International PAC — major cigar/tobacco manufacturer, same treatment as Altria/Reynolds American precedent. Confirmed corporation via live FEC lookup.' WHERE fec_committee_id='C00312785';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_source_url='https://www.fec.gov/data/committee/C00792127/', classification_note='Fair Isaac Corporation (FICO) PAC — core business is financial risk/credit-scoring analytics infrastructure for the banking and lending industry. Confirmed corporation via live FEC lookup.' WHERE fec_committee_id='C00792127';
UPDATE pac_committees SET classification_status='classified', industry_code='big_tech_crypto', classification_source_url='https://www.fec.gov/data/committee/C00408138/', classification_note='Bentley Systems — major infrastructure engineering software company, same enterprise-software treatment as SAP/C3.ai precedent.' WHERE fec_committee_id='C00408138';

-- Reviewed, deliberately no fit (documented reasoning each):
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Confirmed Leadership PAC via live FEC lookup (leadership_pac flag set) — not industry money.' WHERE fec_committee_id IN ('C00686816','C00576249','C00691501','C00455717');
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Diversified engineering/industrial/defense-adjacent firm — real defense-sector business exists but not dominant enough of a diversified portfolio to classify, same treatment as AECOM/Textron/Rolls-Royce NA precedent.' WHERE fec_committee_id IN ('C00341271','C00142299');
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Paper/pulp manufacturing — no fitting category among current 9.' WHERE fec_committee_id='C00789602';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Industrial bearings/precision manufacturing — no fitting category among current 9.' WHERE fec_committee_id='C00311308';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Law firm — no fitting category among current 9.' WHERE fec_committee_id='C00111534';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Healthcare-provider/medical-device cluster (medical device manufacturer) — no fitting category among current 9, same treatment as Medtronic/Boston Scientific precedent.' WHERE fec_committee_id IN ('C00411900','C00574103','C00409516');
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Electric-utilities cluster (utility holding company / power equipment manufacturer) — no fitting category among current 9.' WHERE fec_committee_id IN ('C00075473','C00848820');
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Real estate cluster (single-family rental REIT) — no fitting category among current 9.' WHERE fec_committee_id='C00830083';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Agriculture trade association — no fitting category among current 9.' WHERE fec_committee_id IN ('C00167684','C00828806','C00376590','C00503847','C00455766');
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='General construction/manufacturing/diversified holding company — no fitting category among current 9.' WHERE fec_committee_id IN ('C00337394','C00388777');
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Investment-visa industry advocacy association — not a fit for any current industry category.' WHERE fec_committee_id='C00829671';

-- Left needs_review (genuinely ambiguous, insufficient FEC data, not forced either direction):
-- National Victory Action Fund, Thoroughbred PAC, Maryland Association for Concerned
-- Citizens PAC, Citizens Organized Political Action Committee — no leadership_pac flag,
-- Unauthorized/Lobbyist-Registrant designation, no org_type data.
