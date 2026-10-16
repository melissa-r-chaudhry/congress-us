-- Exhaustive PAC classification pass 13. All classifications FEC-verified live
-- via CONGRESS_GOV_API_KEY (avoids the shared FEC_API_KEY rate limit fixed in pass 11).

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://www.fec.gov/data/committee/C00525055/',
  classification_note = 'TransCanada USA Services Inc PAC (TC PAC) — TC Energy, major North American oil/gas pipeline operator. Confirmed Corporation via live FEC lookup.'
  WHERE fec_committee_id = 'C00525055';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'big_tech_crypto',
  classification_source_url = 'https://www.fec.gov/data/committee/C00367375/',
  classification_note = 'SAP America Inc PAC — major enterprise software company, same tier as already-classified Oracle. Confirmed Corporation via live FEC lookup.'
  WHERE fec_committee_id = 'C00367375';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00340364/',
  classification_note = 'Blue Shield of California PAC (SHIELD PAC) — major health insurer. Confirmed Corporation via live FEC lookup.'
  WHERE fec_committee_id = 'C00340364';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00517052/',
  classification_note = 'RBC USA Holdco Corporation Federal PAC — Royal Bank of Canada US arm. Confirmed Corporation via live FEC lookup.'
  WHERE fec_committee_id = 'C00517052';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00161901/',
  classification_note = 'Equitable Holdings Inc PAC — insurance/financial services holding company (life insurance, annuities, asset management). Classified consistent with prior passes'' treatment of Prudential Financial, Lincoln Financial, and TransAmerica.'
  WHERE fec_committee_id = 'C00161901';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_source_url = 'https://www.fec.gov/data/committee/C00007898/',
  classification_note = 'OPEIU (Office and Professional Employees International Union) JB Moss VOTE — confirmed Labor Organization via live FEC lookup.'
  WHERE fec_committee_id = 'C00007898';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_source_url = 'https://www.fec.gov/data/committee/C00461418/',
  classification_note = 'National Union of Healthcare Workers Federal COPE — confirmed Labor Organization via live FEC lookup.'
  WHERE fec_committee_id = 'C00461418';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'other_positive',
  classification_source_url = 'https://www.fec.gov/data/committee/C00341396/',
  classification_note = 'MoveOn.org Political Action — genuine progressive advocacy organization, same treatment as already-classified Sierra Club, League of Conservation Voters, and Human Rights Campaign PACs.'
  WHERE fec_committee_id = 'C00341396';

-- reviewed_no_fit: confirmed real Leadership PACs via live FEC lookup (designation_full = 'Leadership PAC')
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00416743/',
  classification_note = 'Victory Now PAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00416743';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00629311/',
  classification_note = 'Granite Values PAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00629311';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00497073/',
  classification_note = 'Lobo PAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00497073';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00892752/',
  classification_note = 'Juntos PAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00892752';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00808717/',
  classification_note = 'Keep Texas Texas PAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00808717';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00571000/',
  classification_note = 'True North PAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00571000';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00493700/',
  classification_note = 'Blue Hen Federal PAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00493700';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00818328/',
  classification_note = 'PAC for New Leadership — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00818328';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00493361/',
  classification_note = 'Razor PAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00493361';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00719971/',
  classification_note = 'Senate Eagle PAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00719971';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00403592/',
  classification_note = 'Narragansett Bay PAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00403592';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00885319/',
  classification_note = 'Colorado Western Political Action Committee — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00885319';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00825430/',
  classification_note = 'Double L PAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00825430';

-- reviewed_no_fit: recurring uncategorized clusters already flagged to Melissa (electric utilities,
-- telecom/media, general/life insurance, healthcare-provider/medical-device, real estate)
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00330647/',
  classification_note = 'EchoStar Corporation and DISH Network Corporation PAC — satellite/telecom media distribution. Telecom/media, not "big tech" in the classic sense; part of the recurring telecom cluster already flagged, no fitting category exists.'
  WHERE fec_committee_id = 'C00330647';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00034884/',
  classification_note = 'Alticor Inc PAC (ALTIPAC) — Amway parent company, consumer products/direct selling. No fitting category among current 9.'
  WHERE fec_committee_id = 'C00034884';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00300426/',
  classification_note = 'Southeast Cotton Committee (SECC) — agriculture trade group, no fitting category.'
  WHERE fec_committee_id = 'C00300426';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00214148/',
  classification_note = 'American Peanut Shellers Association PAC — agriculture trade group, no fitting category.'
  WHERE fec_committee_id = 'C00214148';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00139071/',
  classification_note = 'ArchiPAC (American Institute of Architects) — professional association, no fitting category.'
  WHERE fec_committee_id = 'C00139071';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00040725/',
  classification_note = 'International Fresh Produce Association PAC — agriculture trade group, no fitting category.'
  WHERE fec_committee_id = 'C00040725';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00089086/',
  classification_note = 'American Occupational Therapy Association PAC (AOTPAC) — confirmed Membership Organization via live FEC lookup; healthcare-provider/professional-association cluster, no fitting category.'
  WHERE fec_committee_id = 'C00089086';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00128678/',
  classification_note = 'Southeastern Lumber Manufacturers Association PAC — trade group, no fitting category.'
  WHERE fec_committee_id = 'C00128678';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00824425/',
  classification_note = 'Taft Stettinius & Hollister LLP PAC — law firm, no fitting category, same treatment as prior law-firm classifications.'
  WHERE fec_committee_id = 'C00824425';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00279828/',
  classification_note = 'Textile Rental Services Association of America PAC — trade group, no fitting category.'
  WHERE fec_committee_id = 'C00279828';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00691972/',
  classification_note = 'Allison Transmission Inc PAC — diversified transmission manufacturer (commercial + some defense-vehicle applications). Defense revenue not confirmed dominant; same non-dominant-industry treatment as prior AECOM/Dow/Textron/SpaceX precedent.'
  WHERE fec_committee_id = 'C00691972';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00699439/',
  classification_note = 'Zillow Group Inc PAC (ZG PAC) — real estate cluster, already flagged as a recurring pattern with no fitting category.'
  WHERE fec_committee_id = 'C00699439';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00519371/',
  classification_note = 'Society for Cardiovascular Angiography and Interventions PAC (SCAI) — medical professional association, healthcare-provider cluster, no fitting category.'
  WHERE fec_committee_id = 'C00519371';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00564377/',
  classification_note = 'Chugach Alaska Corporation PAC (CAC PAC) — diversified Alaska Native corporation (government services, construction, and more), too diversified to classify into a single industry.'
  WHERE fec_committee_id = 'C00564377';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00562546/',
  classification_note = 'Novocure Inc PAC — medical device company (cancer treatment devices). Healthcare-provider/medical-device cluster, same treatment as prior Medtronic/Boston Scientific/Smith & Nephew precedent, distinct from pharma_health_insurance.'
  WHERE fec_committee_id = 'C00562546';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00268904/',
  classification_note = 'Trinity Industries Employee PAC (TIEPAC) — diversified industrial/rail equipment manufacturer, no fitting category.'
  WHERE fec_committee_id = 'C00268904';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00402107/',
  classification_note = 'CUNA Mutual Holding Company PAC / TruStage PAC — general/life insurance company, recurring uncategorized cluster (broader than current health-specific pharma_health_insurance scope), no fitting category.'
  WHERE fec_committee_id = 'C00402107';

-- Note: Keystone America PAC (C00439992) left in needs_review — confirmed 'Unauthorized' designation
-- via live FEC lookup but no organization_type or other identifying data available; insufficient
-- evidence to classify either as a Leadership PAC or an industry committee, not guessed either way.
