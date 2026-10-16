-- Exhaustive PAC classification pass 18
-- Resumed from pass 17's ~78.07%. All lookups via CONGRESS_GOV_API_KEY.

-- Classified: 4 committees, real evidence
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://www.fec.gov/data/committee/C00083857/',
  classification_note = 'Occidental Petroleum Corporation PAC — major US oil & gas producer, confirmed via live FEC lookup (Corporation, Lobbyist/Registrant PAC).'
WHERE fec_committee_id = 'C00083857';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'vice_guns_gambling_alcohol',
  classification_source_url = 'https://www.fec.gov/data/committee/C00908699/',
  classification_note = 'DraftKings Inc. PAC — major US sports-betting/gambling company, confirmed via live FEC lookup (Corporation, Lobbyist/Registrant PAC).'
WHERE fec_committee_id = 'C00908699';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00589119/',
  classification_note = 'Synchrony Financial Employees PAC — major US consumer financial services/credit company, confirmed via live FEC lookup (Corporation, Lobbyist/Registrant PAC).'
WHERE fec_committee_id = 'C00589119';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://www.fec.gov/data/committee/C00479998/',
  classification_note = 'Tenaska Inc Employees PAC — natural gas asset development/trading and gas-fired power generation company; core business is natural gas, distinct from the regulated-electric-utility cluster left uncategorized elsewhere. Confirmed via live FEC lookup (Corporation).'
WHERE fec_committee_id = 'C00479998';

-- Reviewed, no fit: confirmed Leadership PACs via live FEC leadership_pac flag (11)
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Confirmed real Leadership PAC via live FEC lookup (leadership_pac flag set), not industry money.'
WHERE fec_committee_id IN (
  'C00368696', -- RESPONSIBILITY AND FREEDOM WORK PAC
  'C00388934', -- FUND FOR AMERICA'S FUTURE
  'C00851998', -- PENNSYLVANIA HONOR
  'C00567693', -- HAWAII PAC
  'C00492983', -- NUTMEG PAC
  'C00664318', -- DEMOCRACY SUMMER LEADERSHIP PAC
  'C00760397', -- NO NONSENSE PAC
  'C00378695', -- VICTORY IN NOVEMBER ELECTION PAC
  'C00412791', -- FORWARD TOGETHER PAC
  'C00481531', -- TEXAS REPUBLICANS UNITED PAC
  'C00577288'  -- DECIDING CRITICAL RACES PAC
);

-- Reviewed, no fit: well-known public identity, no fitting category among current 9
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Verizon Communications PAC — telecom carrier, part of the recurring telecom/media cluster with no current fitting category (flagged to Melissa, not yet decided).'
WHERE fec_committee_id = 'C00025163';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Jackson National Life Insurance — life insurance/annuity company, part of the recurring general/life insurance cluster (broader than current health-specific pharma_health_insurance scope), no current fitting category.'
WHERE fec_committee_id IN ('C00254953', 'C00686055');

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Rain and Hail Insurance Society PAC — crop/agricultural insurance, general insurance cluster, no fitting category.'
WHERE fec_committee_id = 'C00279505';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Food Marketing Institute PAC — grocery industry trade association, no fitting category.'
WHERE fec_committee_id = 'C00014555';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Chiropractic Association PAC — healthcare-provider association, distinct from health-insurance payers, recurring uncategorized cluster.'
WHERE fec_committee_id = 'C00102764';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Global Medical Response Inc. PAC — ambulance/EMS transport provider, healthcare-provider (not payer/manufacturer) cluster, no fitting category.'
WHERE fec_committee_id = 'C00389585';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Conagra Brands — packaged food company, no fitting category.'
WHERE fec_committee_id = 'C00087874';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'The Hershey Company PAC — confectionery/food company, no fitting category.'
WHERE fec_committee_id = 'C00200139';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'BMI (Broadcast Music Inc.) PAC — music-licensing/media organization, telecom/media cluster, no fitting category.'
WHERE fec_committee_id = 'C00653188';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Aircraft Owners and Pilots Association PAC — aviation advocacy/trade group, no fitting category.'
WHERE fec_committee_id = 'C00131185';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Glaukos IPAC — ophthalmology medical device company, healthcare-provider/medical-device cluster, same treatment as Medtronic/Boston Scientific precedent.'
WHERE fec_committee_id = 'C00825364';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Quanta Services — diversified infrastructure/construction contractor (electric power + pipeline construction), not dominant enough in one category to classify, same treatment as Dow/BASF precedent.'
WHERE fec_committee_id = 'C00720920';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Wayne Farms LLC PAC — poultry/agriculture company, no fitting category.'
WHERE fec_committee_id = 'C00412445';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Hy-Vee Inc Employees PAC — grocery chain, no fitting category.'
WHERE fec_committee_id = 'C00243659';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Fareway Stores Inc PAC — grocery chain, no fitting category.'
WHERE fec_committee_id = 'C00331686';
