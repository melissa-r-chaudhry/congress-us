-- Exhaustive PAC classification pass 21

UPDATE pac_committees SET classification_status='classified', industry_code='surveillance_weapons',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00783423/', last_reviewed_date=CURRENT_DATE,
  classification_note='CACI International Inc — confirmed via live FEC lookup (Corporation, Qualified PAC). Well-known major US defense/intelligence IT services contractor, core business is government/defense IT and intelligence solutions.'
WHERE fec_committee_id='C00783423';

UPDATE pac_committees SET classification_status='classified', industry_code='surveillance_weapons',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00782532/', last_reviewed_date=CURRENT_DATE,
  classification_note='Shield AI — confirmed via live FEC lookup (Corporation, Qualified PAC). Defense AI/autonomous-systems company (military drones/autonomy software), core business is defense technology.'
WHERE fec_committee_id='C00782532';

UPDATE pac_committees SET classification_status='classified', industry_code='surveillance_weapons',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00431114/', last_reviewed_date=CURRENT_DATE,
  classification_note='KBR, Inc. — confirmed via live FEC lookup (Corporation, Lobbyist/Registrant PAC). Moderate confidence: Government Solutions (defense/government services) is KBR''s dominant business segment (formerly Kellogg Brown & Root, spun off from Halliburton), less diversified than AECOM/Jacobs precedent that was left uncategorized, but revenue mix not independently verified beyond public reputation.'
WHERE fec_committee_id='C00431114';

UPDATE pac_committees SET classification_status='classified', industry_code='vice_guns_gambling_alcohol',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00034470/', last_reviewed_date=CURRENT_DATE,
  classification_note='Diageo North America — confirmed via live FEC lookup (Corporation, Lobbyist/Registrant PAC). Major global spirits/alcohol company (Johnnie Walker, Smirnoff, Guinness, etc.).'
WHERE fec_committee_id='C00034470';

UPDATE pac_committees SET classification_status='classified', industry_code='oil_gas',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00381954/', last_reviewed_date=CURRENT_DATE,
  classification_note='Atmos Energy Corporation — confirmed via live FEC lookup (Corporation, Unauthorized). Natural gas distribution utility, same category treatment as already-classified American Gas Association (gas distribution fits oil_gas).'
WHERE fec_committee_id='C00381954';

UPDATE pac_committees SET classification_status='classified', industry_code='labor_union',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00219568/', last_reviewed_date=CURRENT_DATE,
  classification_note='International Union of Operating Engineers Local No. 12 — confirmed "Labor Organization" via live FEC lookup.'
WHERE fec_committee_id='C00219568';

-- Confirmed real Leadership PACs (leadership_pac flag = X on live FEC lookup), not industry money
UPDATE pac_committees SET classification_status='reviewed_no_fit', last_reviewed_date=CURRENT_DATE,
  classification_note='Confirmed real Leadership PAC via live FEC lookup (leadership_pac flag set) — not industry-affiliated money.'
WHERE fec_committee_id IN ('C00832147','C00767871','C00564187','C00832568','C00833574','C00423079','C00563429','C00818542');

-- Recurring uncategorized clusters (food/agriculture, healthcare-provider, HR/staffing) — no fitting category among current 9
UPDATE pac_committees SET classification_status='reviewed_no_fit', last_reviewed_date=CURRENT_DATE,
  classification_note='Food/agriculture/food-processing industry — no fitting category among current 9.'
WHERE fec_committee_id IN ('C00394650','C00128231','C00492363','C00412098','C00508770');

UPDATE pac_committees SET classification_status='reviewed_no_fit', last_reviewed_date=CURRENT_DATE,
  classification_note='Healthcare-provider/clinical-services association — distinct from pharma/health-insurance payers, no fitting category among current 9.'
WHERE fec_committee_id IN ('C00410084','C00529909','C00544957');

UPDATE pac_committees SET classification_status='reviewed_no_fit', last_reviewed_date=CURRENT_DATE,
  classification_note='HR/staffing-services trade association — no fitting category among current 9.'
WHERE fec_committee_id='C00447284';

-- Candidate committees — not industry money at all
UPDATE pac_committees SET classification_status='reviewed_no_fit', last_reviewed_date=CURRENT_DATE,
  classification_note='Sitting member''s own candidate committee, not industry-affiliated PAC money.'
WHERE fec_committee_id IN ('C00501643','C00653816');
