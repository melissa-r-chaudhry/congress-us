-- Exhaustive PAC classification pass 15. All via live FEC lookup (CONGRESS_GOV_API_KEY)
-- plus web-search secondary verification for two ambiguous "nice-sounding name" cases.

-- Classified (7)
UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_source_url='https://www.fec.gov/data/committee/C00199703/',
  classification_note='GlaxoSmithKline (GSK) — major global pharmaceutical company.'
  WHERE fec_committee_id='C00199703';

UPDATE pac_committees SET classification_status='classified', industry_code='surveillance_weapons',
  classification_source_url='https://www.fec.gov/data/committee/C00743435/',
  classification_note='Fairbanks Morse Defense — manufactures engines for US Navy submarines/surface ships, confirmed defense contractor relationship.'
  WHERE fec_committee_id='C00743435';

UPDATE pac_committees SET classification_status='classified', industry_code='big_tech_crypto',
  classification_source_url='https://www.fec.gov/data/committee/C00828830/',
  classification_note='Applied Intuition, Inc. — AI/autonomous-systems simulation software company. Confirmed Corporation via FEC. Note: has some defense-sector customers; classified as big_tech_crypto given core business is software/AI, not primarily a defense manufacturer.'
  WHERE fec_committee_id='C00828830';

UPDATE pac_committees SET classification_status='classified', industry_code='other_positive',
  classification_source_url='https://seecpac.org/about/',
  classification_note='Sustainable Energy and Environment Coalition PAC — confirmed real congressional coalition (60+ members) for clean energy/environmental policy, founded 2009 by Reps. Jay Inslee and Steve Israel. Genuine advocacy, verified via web search, not name-pattern alone.'
  WHERE fec_committee_id='C00581785';

UPDATE pac_committees SET classification_status='classified', industry_code='other_positive',
  classification_source_url='https://en.wikipedia.org/wiki/Immigrants%27_List',
  classification_note='Immigrants'' List — confirmed real bipartisan single-issue PAC founded 2006 by immigration attorneys, advocates for immigration reform. Verified via web search (Wikipedia, OpenSecrets), not name-pattern alone.'
  WHERE fec_committee_id='C00430280';

UPDATE pac_committees SET classification_status='classified', industry_code='other_positive',
  classification_source_url='https://www.fec.gov/data/committee/C00806893/',
  classification_note='Jane Fonda Climate PAC — well-documented public figure''s climate-advocacy PAC, funds climate-focused candidates.'
  WHERE fec_committee_id='C00806893';

UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00409714/',
  classification_note='Financial Services Institute — trade association for independent financial advisors/broker-dealers. Confirmed Lobbyist/Registrant PAC (real industry-representation designation).'
  WHERE fec_committee_id='C00409714';

-- reviewed_no_fit (28), all with documented real reasoning
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_source_url='https://www.opensecrets.org/political-action-committees-pacs/conquering-cancer-pac/C00785014/summary/2022',
  classification_note='Conquering Cancer PAC — confirmed real via OpenSecrets/press coverage, but is a physician-practice-interest PAC (donations tied to one medical practice, connected to a specific candidate''s own campaign treasurer, real political controversy per Daily Beast reporting) advocating on cancer-care-delivery policy — not patient advocacy, not pharma/insurance industry. Healthcare-provider cluster, no fitting category.'
  WHERE fec_committee_id='C00785014';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Argentum — confirmed Trade Association (senior living/assisted living industry). Healthcare-provider-adjacent cluster, no fitting category.'
  WHERE fec_committee_id='C00338020';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Holland America Line — cruise line (Carnival subsidiary). Transportation/leisure industry, no fitting category.'
  WHERE fec_committee_id='C00287714';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Asurion — device insurance/warranty company. General insurance cluster (non-health), no fitting category.'
  WHERE fec_committee_id='C00450916';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id IN ('C00544254','C00635367','C00540054','C00536540','C00458570','C00570945','C00818740','C00655423','C00569871','C00883413','C00545137');
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Law firm PAC, same treatment as prior-classified law firms (Sidley Austin, Barnes & Thornburg, etc.) — no fitting category.'
  WHERE fec_committee_id IN ('C00431072','C00695254');
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='National Tank Truck Carriers — trucking industry trade group, no fitting category.'
  WHERE fec_committee_id='C00188011';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Genworth/Enact — mortgage/general insurance, non-health. No fitting category (recurring general-insurance cluster).'
  WHERE fec_committee_id='C00404194';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='FirstEnergy — electric utility. No fitting category (recurring electric-utilities cluster, flagged to Melissa as a possible future category).'
  WHERE fec_committee_id='C00140855';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='The Hartford — general property/casualty insurance, non-health. No fitting category.'
  WHERE fec_committee_id='C00511444';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='BAPS Public Affairs — confirmed Membership Organization (Hindu religious/cultural community organization''s civic-engagement arm). No fitting category.'
  WHERE fec_committee_id='C00753475';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Society for Vascular Surgery — medical specialty association. Healthcare-provider cluster, no fitting category.'
  WHERE fec_committee_id='C00381459';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='3M — diversified industrial conglomerate (adhesives, healthcare products, safety equipment, electronics). Same non-forced treatment as Dow/BASF — no single dominant category.'
  WHERE fec_committee_id='C00084475';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Associated Equipment Distributors — construction equipment trade group, no fitting category.'
  WHERE fec_committee_id='C00010124';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Congressional Black Caucus PAC — caucus PAC, not industry money, same treatment as Congressional Hispanic Caucus precedent.'
  WHERE fec_committee_id='C00147512';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='FGS Global — public relations/communications firm, no fitting category.'
  WHERE fec_committee_id='C00466094';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Sugar Cane Growers Cooperative of Florida — agriculture, no fitting category.'
  WHERE fec_committee_id='C00254656';
