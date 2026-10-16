-- Exhaustive PAC classification, pass 6. Real FEC-verified evidence for every row.

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'surveillance_weapons',
  classification_source_url = 'https://www.fec.gov/data/committee/C00275123/', classification_note = 'Leonardo DRS PAC — corporate PAC of Leonardo DRS, major US defense electronics/sensors manufacturer.'
  WHERE fec_committee_id = 'C00275123';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'vice_guns_gambling_alcohol',
  classification_source_url = 'https://www.fec.gov/data/committee/C00122101/', classification_note = 'Safari Club International PAC — hunting/firearms-rights membership organization, same category logic already applied to NRA in this project (advocacy org, not a manufacturer).'
  WHERE fec_committee_id = 'C00122101';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00494534/', classification_note = 'Bank of New York Mellon Corporation Federal PAC — major US bank/custodian.'
  WHERE fec_committee_id = 'C00494534';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://www.fec.gov/data/committee/C00342766/', classification_note = 'HF Sinclair PAC (DINO PAC) — major US oil refining company.'
  WHERE fec_committee_id = 'C00342766';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://www.fec.gov/data/committee/C00145037/', classification_note = 'Southern Company Gas Employees PAC — natural gas utility subsidiary of Southern Company.'
  WHERE fec_committee_id = 'C00145037';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00468660/', classification_note = 'Vertex Pharmaceuticals Inc PAC — major biotech/pharmaceutical manufacturer.'
  WHERE fec_committee_id = 'C00468660';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00424143/', classification_note = 'Alliance for Pharmacy Compounding PAC (COMP PAC) — pharmacy/pharmaceutical compounding industry trade association.'
  WHERE fec_committee_id = 'C00424143';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'other_positive',
  classification_source_url = 'https://www.fec.gov/data/committee/C00466813/', classification_note = 'Humane World Action Fund PAC — genuine animal-welfare advocacy nonprofit (formerly Humane Society Legislative Fund), not corporate money — same category logic already applied to League of Conservation Voters Action Fund.'
  WHERE fec_committee_id = 'C00466813';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'other_positive',
  classification_source_url = 'https://www.fec.gov/data/committee/C00471540/', classification_note = 'Environmental Defense Action Fund PAC (EDAF) — genuine environmental advocacy nonprofit, not corporate money — same category logic as League of Conservation Voters Action Fund.'
  WHERE fec_committee_id = 'C00471540';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'surveillance_weapons',
  classification_source_url = 'https://www.fec.gov/data/committee/C00762427/', classification_note = 'Applied Research Associates Inc PAC (ARAPAC) — defense-focused applied research/testing contractor (blast/munitions effects, DOD research). Moderate confidence: company is diversified engineering services, but defense/DOD work is its primary known specialization, unlike SpaceX/Blue Origin/Serco which were left uncategorized for being commercial-primary.'
  WHERE fec_committee_id = 'C00762427';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://www.fec.gov/data/committee/C00035204/', classification_note = 'Energy Marketers of America Small Business Committee PAC — trade association representing fuel marketers/distributors (heating oil, motor fuel retail) — downstream oil & gas industry segment.'
  WHERE fec_committee_id = 'C00035204';

-- reviewed_no_fit, real documented reasoning per row

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Huck PAC for America — Mike Huckabee''s personal political organization, not industry money. FEC designation: Unauthorized.'
  WHERE fec_committee_id = 'C00448373';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Forever Youth Organization Utilizing a New Generation PAC — confirmed via live FEC lookup as a Leadership PAC (a sitting member of Congress''s own PAC), not industry money. Resolves the item pass 5 left unconfirmed due to a rate limit.'
  WHERE fec_committee_id = 'C00683508';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Lasting Investments Strengthening America PAC — confirmed Leadership PAC, not industry money.'
  WHERE fec_committee_id = 'C00764886';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Primerica Inc PAC — primarily a life insurance/financial-services company; part of the recurring general/life insurance cluster flagged to Melissa as a potential new category, no fitting category among the current 9.'
  WHERE fec_committee_id = 'C00521914';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Giddy Up PAC — confirmed Leadership PAC, not industry money.'
  WHERE fec_committee_id = 'C00687582';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Baker PAC — confirmed Leadership PAC, not industry money.'
  WHERE fec_committee_id = 'C00770297';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'First In Freedom PAC — confirmed Leadership PAC, not industry money.'
  WHERE fec_committee_id = 'C00540146';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Oceans PAC — confirmed via live FEC lookup to be a Leadership PAC, NOT an environmental/ocean-conservation advocacy organization despite the name — verified rather than assumed from the name.'
  WHERE fec_committee_id = 'C00431601';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Tractor Supply Company PAC — farm/ranch retail company, no fitting category among the current 9.'
  WHERE fec_committee_id = 'C00763664';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Zurich Holding Company of America Z-PAC — general insurance, not health-specific; part of the recurring general/life insurance cluster flagged as a potential new category.'
  WHERE fec_committee_id = 'C00235036';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'National Chicken Council PAC — agriculture/poultry industry trade association, no fitting category.'
  WHERE fec_committee_id = 'C00034272';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Venable PAC — major law firm, no fitting category (consistent with law firms excluded in prior passes).'
  WHERE fec_committee_id = 'C00369660';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'TeamHealth Holding Inc PAC — physician staffing/healthcare provider services, not a payer or pharma manufacturer; part of the recurring healthcare-provider cluster flagged as a potential new category.'
  WHERE fec_committee_id = 'C00895706';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Society of Pension Professionals and Actuaries PAC — professional association for retirement-plan administrators, not itself a bank or financial institution.'
  WHERE fec_committee_id = 'C00333104';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Wholesale & Specialty Insurance Association PAC — general insurance trade association, part of the recurring insurance cluster flagged as a potential new category.'
  WHERE fec_committee_id = 'C00417634';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Dairy Farmers of America Inc PAC — agriculture, no fitting category.'
  WHERE fec_committee_id = 'C00001388';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Committee Organized for the Trading of Cotton PAC (American Cotton Shippers Association) — agriculture, no fitting category.'
  WHERE fec_committee_id = 'C00014019';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Fresenius Medical Care Holdings PAC — dialysis/renal care provider, not a payer or pharma manufacturer; part of the recurring healthcare-provider cluster.'
  WHERE fec_committee_id = 'C00401299';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'PowerPAC of the Edison Electric Institute — electric utility trade association, part of the recurring electric-utilities cluster flagged as a potential new category.'
  WHERE fec_committee_id = 'C00095869';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'DCCC (Democratic Congressional Campaign Committee) — national party committee, not industry money.'
  WHERE fec_committee_id = 'C00000935';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Academy of Rail Labor Attorneys PAC — attorneys representing rail labor unions, not itself a labor union; distinct from labor_union category.'
  WHERE fec_committee_id = 'C00636753';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'House Conservatives Fund — ideological/leadership-adjacent fund, not industry money.'
  WHERE fec_committee_id = 'C00326439';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Osteopathic Information Association - Osteopathic PAC — physician professional association; part of the recurring healthcare-provider cluster.'
  WHERE fec_committee_id = 'C00113803';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American College of Rheumatology PAC (RHEUMPAC) — physician specialty professional association; part of the recurring healthcare-provider cluster.'
  WHERE fec_committee_id = 'C00432823';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Congress of OB-GYNs PAC — physician specialty professional association; part of the recurring healthcare-provider cluster.'
  WHERE fec_committee_id = 'C00364158';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'The Schwan Company PAC — frozen food company, no fitting category.'
  WHERE fec_committee_id = 'C00360362';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Dow Inc PAC (DOWPAC) — diversified chemicals/materials manufacturer, not primarily oil/gas extraction or refining; no fitting category among the current 9.'
  WHERE fec_committee_id = 'C00074096';

-- Flagged, deliberately left needs_review (not classified either way)
-- C00468314 DEMOCRACY ENGINE, INC., PAC — name and high transaction count (797) suggest a
-- possible donation-processing/conduit platform similar to ActBlue/WinRed. Not confirmed via
-- FEC record alone (shows as Corporation/Unauthorized, which doesn't rule it in or out).
-- Flagging for conduit investigation with more research time/tools rather than guessing.
