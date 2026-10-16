-- Exhaustive PAC classification, pass 17. All via live FEC lookup (CONGRESS_GOV_API_KEY).

-- Classified (4)
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00443168/', classification_note='IntercontinentalExchange Inc PAC — ICE operates NYSE and major financial exchanges/clearing/data services, confirmed Corporation via live FEC lookup.'
  WHERE fec_committee_id='C00443168';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00689091/', classification_note='The Carlyle Group Inc PAC — major global private equity/investment firm, confirmed Corporation via live FEC lookup.'
  WHERE fec_committee_id='C00689091';
UPDATE pac_committees SET classification_status='classified', industry_code='labor_union',
  classification_source_url='https://www.fec.gov/data/committee/C00455394/', classification_note='Writers Guild of America West Inc PAC — confirmed "Labor Organization" via live FEC lookup.'
  WHERE fec_committee_id='C00455394';
UPDATE pac_committees SET classification_status='classified', industry_code='labor_union',
  classification_source_url='https://www.fec.gov/data/committee/C00590471/', classification_note='Local 881 United Food and Commercial Workers Political Action Fund — confirmed "Labor Organization" via live FEC lookup.'
  WHERE fec_committee_id='C00590471';

-- Reviewed, no fit (real documented reasoning each)
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Rolls-Royce North America Holdings Inc PAC — confirmed real corporation, but civil aerospace revenue dominates over the real-but-secondary defense segment; same non-forced treatment as Dow/BASF/Textron/SpaceX precedent.'
  WHERE fec_committee_id='C00296822';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='TTM Technologies Inc PAC — printed circuit board manufacturer serving many industries (telecom, automotive, industrial, defense); too diversified a component supplier to confidently classify as defense-specific.'
  WHERE fec_committee_id='C00752766';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Confirmed Leadership PAC via live FEC lookup (leadership_pac flag set), not industry money.'
  WHERE fec_committee_id IN ('C00439521','C00826297','C00391797','C00772434','C00572271','C00495887','C00563601','C00764761','C00603134');
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='General Aviation Manufacturers Association PAC — civilian general-aviation trade group, no fitting category among current 9.'
  WHERE fec_committee_id='C00014878';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='American Water Works Company PAC — water utility, distinct from the electric-utilities cluster already flagged, no fitting category.'
  WHERE fec_committee_id='C00354548';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Owner Operator Independent Drivers Association PAC — trucking industry trade group, no fitting category.'
  WHERE fec_committee_id='C00236778';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Office of the Commissioner of Major League Baseball PAC — professional sports league, not gambling/vice, no fitting category.'
  WHERE fec_committee_id='C00368142';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Alaska Air Group PAC — airline, same treatment as Southwest/American/Atlas Air precedent (not an industry category).'
  WHERE fec_committee_id='C00024349';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Agricultural trade/cooperative PAC — no fitting category among current 9.'
  WHERE fec_committee_id IN ('C00009423','C00234120','C00002238','C00405555','C00349373');
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='National Independent Automobile Dealers Association PAC — auto dealers trade group, no fitting category.'
  WHERE fec_committee_id='C00507699';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='United States Cellular Corporation PAC — telecom, part of the recurring telecom/media cluster already flagged to Melissa as a possible future category.'
  WHERE fec_committee_id='C00336057';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Outdoor Amusement Business Association PAC — carnival/fair industry, not gambling; no fitting category.'
  WHERE fec_committee_id='C00163212';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='JM Family Enterprises Inc PAC — diversified auto distribution, no fitting category.'
  WHERE fec_committee_id='C00240911';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Law firm PAC — no fitting category, same treatment as prior law-firm classifications this session.'
  WHERE fec_committee_id IN ('C00462630','C00395723','C00216127');
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Fraternity & Sorority Political Action Committee — Greek-life advocacy organization, no fitting category among current 9.'
  WHERE fec_committee_id='C00410068';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Mark Kelly for Senate — a sitting member''s own candidate committee, not industry money, same treatment as Pete Aguilar/Scalise precedent.'
  WHERE fec_committee_id='C00696526';
