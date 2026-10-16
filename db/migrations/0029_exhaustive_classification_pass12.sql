-- Exhaustive PAC classification pass 12. All classifications FEC-verified
-- (live lookup via CONGRESS_GOV_API_KEY for ambiguous names, public-record
-- identity for unambiguous major companies).

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://www.fec.gov/data/committee/C00430157/',
  classification_note = 'Cheniere Energy Inc PAC — major US LNG (liquefied natural gas) exporter.'
  WHERE fec_committee_id = 'C00430157';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00488882/',
  classification_note = 'U.S. Bancorp Federal PAC — U.S. Bank, major national bank.'
  WHERE fec_committee_id = 'C00488882';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00313700/',
  classification_note = 'TransUnion PAC — major credit reporting/financial data services company.'
  WHERE fec_committee_id = 'C00313700';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00186064/',
  classification_note = 'PNC Financial Services Group PAC — major national bank.'
  WHERE fec_committee_id = 'C00186064';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'vice_guns_gambling_alcohol',
  classification_source_url = 'https://www.fec.gov/data/committee/C00042002/',
  classification_note = 'Reynolds American Inc PAC (RAI PAC) — major US tobacco company.'
  WHERE fec_committee_id = 'C00042002';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'vice_guns_gambling_alcohol',
  classification_source_url = 'https://www.fec.gov/data/committee/C00639138/',
  classification_note = 'Sazerac Company Inc PAC — major spirits/alcohol producer.'
  WHERE fec_committee_id = 'C00639138';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'surveillance_weapons',
  classification_source_url = 'https://www.fec.gov/data/committee/C00432856/',
  classification_note = 'AM General PAC — manufacturer of Humvee/military tactical vehicles.'
  WHERE fec_committee_id = 'C00432856';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'other_positive',
  classification_source_url = 'https://www.fec.gov/data/committee/C00235853/',
  classification_note = 'Human Rights Campaign PAC — genuine LGBTQ+ civil rights advocacy organization, not corporate/industry money, same treatment as Sierra Club/League of Conservation Voters precedent.'
  WHERE fec_committee_id = 'C00235853';

-- reviewed_no_fit: confirmed Leadership PACs / Unauthorized (candidate-adjacent), via live FEC lookup
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/' || fec_committee_id || '/',
  classification_note = 'Confirmed via live FEC lookup: Leadership PAC, not industry money.'
  WHERE fec_committee_id IN ('C00669929','C00844720','C00656777','C00366781','C00410092','C00460972','C00771238','C00459925','C00507574','C00832576','C00819854');

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/' || fec_committee_id || '/',
  classification_note = 'Confirmed via live FEC lookup: Unauthorized (candidate-adjacent) committee, not industry money.'
  WHERE fec_committee_id IN ('C00696591','C00880062','C00829119');

-- reviewed_no_fit: healthcare-provider / medical-device cluster (no fitting category, per prior passes)
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/' || fec_committee_id || '/',
  classification_note = 'Healthcare-provider/professional-association PAC — distinct from health-insurance payers, no fitting category among current 9 (recurring cluster flagged to Melissa).'
  WHERE fec_committee_id IN ('C00122499','C00383976','C00365965','C00485896','C00340356','C00210666');

-- reviewed_no_fit: real estate cluster
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00567792/',
  classification_note = 'National Association of Residential Property Managers PAC — real estate industry, no fitting category (recurring cluster flagged to Melissa).'
  WHERE fec_committee_id = 'C00567792';

-- reviewed_no_fit: electric utilities cluster
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00507962/',
  classification_note = 'AES Corporation PAC — electric power generation utility, no fitting category (recurring cluster flagged to Melissa).'
  WHERE fec_committee_id = 'C00507962';

-- reviewed_no_fit: law firms
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/' || fec_committee_id || '/',
  classification_note = 'Law firm PAC — no fitting industry category.'
  WHERE fec_committee_id IN ('C00351270','C00395947','C00204453');

-- reviewed_no_fit: agriculture
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/' || fec_committee_id || '/',
  classification_note = 'Agricultural trade group PAC — no fitting industry category.'
  WHERE fec_committee_id IN ('C00599084','C00015552');

-- reviewed_no_fit: misc, individually justified
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00340075/',
  classification_note = 'BASF Corporation Employees PAC — diversified chemicals conglomerate, not oil/gas-primary; same treatment as Dow Inc precedent from pass 8.'
  WHERE fec_committee_id = 'C00340075';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00097865/',
  classification_note = 'NATSO Inc PAC — represents truck stops/travel centers trade association, no fitting category.'
  WHERE fec_committee_id = 'C00097865';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00411694/',
  classification_note = 'Saltchuk Resources Inc PAC — confirmed real Corporation (Lobbyist/Registrant PAC) via live FEC lookup; diversified transportation/logistics/maritime holding company (owns TOTE Maritime, Foss Maritime), no fitting industry category.'
  WHERE fec_committee_id = 'C00411694';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00394957/',
  classification_note = 'Scalise for Congress — a sitting member''s own candidate committee, not industry money at all.'
  WHERE fec_committee_id = 'C00394957';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://www.fec.gov/data/committee/C00034405/',
  classification_note = 'International Paper PAC — paper/packaging manufacturer, no fitting industry category.'
  WHERE fec_committee_id = 'C00034405';
