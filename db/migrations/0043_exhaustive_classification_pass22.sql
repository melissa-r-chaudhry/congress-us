-- Pass 22 part 2: main dollar-ranked sweep, real FEC-verified classifications.

UPDATE pac_committees SET classification_status='classified', industry_code='big_tech_crypto',
  classification_note='Cognizant Technology Solutions Corporation PAC — confirmed real IT/technology services corporation via live FEC lookup (PAC - Qualified, Lobbyist/Registrant).'
WHERE fec_committee_id='C00485979';

UPDATE pac_committees SET classification_status='classified', industry_code='oil_gas',
  classification_note='National Propane Gas Association PAC — confirmed real trade association for the propane (fossil-fuel derived) industry via live FEC lookup.'
WHERE fec_committee_id='C00079681';

UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_note='Nelnet Inc PAC — confirmed real student-loan servicing/financial-services corporation via live FEC lookup.'
WHERE fec_committee_id='C00370015';

UPDATE pac_committees SET classification_status='classified', industry_code='vice_guns_gambling_alcohol',
  classification_note='Swedish Match North America LLC PAC — confirmed real tobacco/nicotine products manufacturer (snus, etc.) via live FEC lookup.'
WHERE fec_committee_id='C00215053';

UPDATE pac_committees SET classification_status='classified', industry_code='surveillance_weapons',
  classification_note='Vantor Parent Inc. PAC (formerly Maxar Technologies) — confirmed real defense/government geospatial-intelligence and satellite-imagery corporation via live FEC lookup (Lobbyist/Registrant PAC). Maxar''s government/defense geospatial business was rebranded to Vantor.'
WHERE fec_committee_id='C00370585';

UPDATE pac_committees SET classification_status='classified', industry_code='general_life_insurance',
  classification_note='Mortgage Guaranty Insurance Corporation PAC (MGIC) — confirmed real mortgage insurance corporation via live FEC lookup.'
WHERE fec_committee_id='C00586859';

UPDATE pac_committees SET classification_status='classified', industry_code='electric_utilities',
  classification_note='Clearway Energy Inc PAC — confirmed real power-generation (renewable energy) corporation via live FEC lookup.'
WHERE fec_committee_id='C00847764';

UPDATE pac_committees SET classification_status='classified', industry_code='labor_union',
  classification_note='International Association of Heat and Frost Insulators and Allied Workers PAC — confirmed "Labor Organization" via live FEC lookup.'
WHERE fec_committee_id='C00115527';

UPDATE pac_committees SET classification_status='classified', industry_code='real_estate',
  classification_note='Affordable Housing Tax Credit Coalition PAC — confirmed real Trade Association for affordable-housing tax-credit finance/development via live FEC lookup.'
WHERE fec_committee_id='C00842583';

-- reviewed_no_fit: real committees, verified, don't fit any current category
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Everytown for Gun Safety Action Fund PAC — confirmed real gun-VIOLENCE-PREVENTION advocacy organization via live FEC lookup, i.e. opposed to the gun industry, not aligned with it. Does not fit vice_guns_gambling_alcohol (that category is for pro-industry PAC money). Also does not meet the new strict other_positive bar (2026-07-28 rule: only genuine democracy-structure/governance-reform orgs qualify as positive; single-issue advocacy, however sympathetic, is neutral) — issue-advocacy, not a democracy/governance-reform organization. Neutral.'
WHERE fec_committee_id='C00640086';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Duane Morris Government Committee — confirmed law firm (Duane Morris LLP) PAC via live FEC lookup, no fitting industry category.'
WHERE fec_committee_id='C00364133';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Baker & Hostetler Political Action Committee — confirmed law firm PAC via live FEC lookup, no fitting industry category.'
WHERE fec_committee_id='C00174227';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='HOPE PAC — confirmed real Leadership PAC via live FEC lookup (leadership_pac flag set), not industry money.'
WHERE fec_committee_id='C00701680';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Alabama First PAC — confirmed real Leadership PAC via live FEC lookup (leadership_pac flag set), not industry money.'
WHERE fec_committee_id='C00821058';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Space Coast Leadership PAC — confirmed real Leadership PAC via live FEC lookup (leadership_pac flag set), not industry money.'
WHERE fec_committee_id='C00877506';
