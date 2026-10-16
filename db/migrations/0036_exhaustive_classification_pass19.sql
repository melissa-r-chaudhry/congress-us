-- Exhaustive PAC classification pass 19. All via live FEC lookup (CONGRESS_GOV_API_KEY)
-- plus 2 web-search corroborations (FS PAC, Democratic Conservation Alliance PAC).

UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00553834/', classification_note='Otsuka America Pharmaceutical Inc — Corporation, pharmaceutical manufacturer.'
WHERE fec_committee_id='C00553834';

UPDATE pac_committees SET classification_status='classified', industry_code='surveillance_weapons',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00828905/', classification_note='Thales USA Inc — Corporation, US subsidiary of Thales Group, major defense/aerospace/security electronics multinational.'
WHERE fec_committee_id='C00828905';

UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00364455/', classification_note='Fidelity National Financial Inc PAC — Corporation, title insurance and financial services.'
WHERE fec_committee_id='C00364455';

UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00366013/', classification_note='NASDAQ Inc PAC — Corporation, stock exchange operator.'
WHERE fec_committee_id='C00366013';

UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00491118/', classification_note='Lundbeck LLC Employee PAC — Corporation, pharmaceutical manufacturer.'
WHERE fec_committee_id='C00491118';

UPDATE pac_committees SET classification_status='classified', industry_code='labor_union',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00446237/', classification_note='National Nurses United PAC — confirmed Labor Organization via live FEC lookup.'
WHERE fec_committee_id='C00446237';

UPDATE pac_committees SET classification_status='classified', industry_code='labor_union',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00459800/', classification_note='Professional Engineers in California Government Federal PAC — confirmed Labor Organization via live FEC lookup.'
WHERE fec_committee_id='C00459800';

UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00717900/', classification_note='PTC Therapeutics Inc PAC — Corporation, pharmaceutical manufacturer.'
WHERE fec_committee_id='C00717900';

UPDATE pac_committees SET classification_status='classified', industry_code='big_tech_crypto',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00750026/', classification_note='C3.ai Inc PAC — Corporation, enterprise AI software company, same tier as Applied Intuition precedent.'
WHERE fec_committee_id='C00750026';

UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00161141/', classification_note='GuideWell Mutual Holding Corporation PAC — Corporation, parent of Florida Blue/BCBS Florida, consistent with existing Blue Cross Blue Shield precedent.'
WHERE fec_committee_id='C00161141';

UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_source_url='https://api.open.fec.gov/v1/committee/C00444885/', classification_note='Astellas US LLC PAC — Corporation, pharmaceutical manufacturer.'
WHERE fec_committee_id='C00444885';

UPDATE pac_committees SET classification_status='classified', industry_code='other_positive',
  classification_source_url='https://www.fec.gov/data/committee/C00657452/', classification_note='Democratic Conservation Alliance PAC — web-search-confirmed genuine grassroots conservation/environmental advocacy PAC electing pro-conservation candidates, same treatment as Sierra Club/LCV/MoveOn precedent. Not name-guessed.'
WHERE fec_committee_id='C00657452';

UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.opensecrets.org/political-action-committees-pacs/fs-investments/C00559302/', classification_note='FS PAC = FS Investments PAC, Philadelphia-based financial services/asset management firm. Confirmed via OpenSecrets cross-reference, not name-guessed (FEC record alone lacked org_type data).'
WHERE fec_committee_id='C00559302';

-- reviewed_no_fit, real documented reasoning each
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Transportation Intermediaries Association PAC — freight brokerage/logistics trade association, no fitting category among current 9.' WHERE fec_committee_id='C00335091';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Sunrun Inc PAC — residential solar energy company; no renewable-energy category exists among current 9.' WHERE fec_committee_id='C00489302';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='S.C. Johnson & Son PAC — consumer packaged goods (household cleaning products), no fitting category.' WHERE fec_committee_id='C00342246';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='JetBlue Airways Crewmember Good Government Fund — airline, no fitting category (consistent with other airline PACs already reviewed).' WHERE fec_committee_id='C00484584';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Arkansas Farm Bureau Federal Ag PAC — agriculture trade association, no fitting category.' WHERE fec_committee_id='C00866202';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Rocket Lab Corporation PAC — Corporation confirmed via live FEC lookup; commercial-primary space launch provider, held to the same "not dominant defense revenue" precedent already applied to SpaceX and Blue Origin.' WHERE fec_committee_id='C00811034';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Encompass Health Corporation PAC — rehabilitation hospital operator, healthcare-provider cluster, no fitting category among current 9.' WHERE fec_committee_id='C00414649';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Pitney Bowes Inc PAC — mailing/shipping technology company, no fitting category.' WHERE fec_committee_id='C00339499';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='ASCAP Legislative Fund for the Arts — music performing-rights licensing organization, no fitting category.' WHERE fec_committee_id='C00228296';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='PPL Corporation People for Good Government — electric utility, part of the recurring electric-utilities cluster with no fitting category among current 9.' WHERE fec_committee_id='C00228106';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Jersey Values PAC — confirmed Leadership PAC via live FEC lookup (leadership_pac flag set), not industry money.' WHERE fec_committee_id='C00652164';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='DTE Energy Company PAC — electric/gas utility, electric-utilities cluster, no fitting category.' WHERE fec_committee_id='C00081547';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='America''s Essential Hospitals PAC — healthcare-provider association, no fitting category among current 9.' WHERE fec_committee_id='C00602805';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Sam Graves Victory Fund — a sitting member''s own leadership/victory fund, not industry money.' WHERE fec_committee_id='C00588822';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='NetJets Inc PAC — private aviation company, no fitting category.' WHERE fec_committee_id='C00481309';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='ITC Holdings Corp PAC — electric transmission utility, electric-utilities cluster, no fitting category.' WHERE fec_committee_id='C00388462';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='American Mosaic PAC — confirmed Leadership PAC via live FEC lookup (leadership_pac flag set), not industry money.' WHERE fec_committee_id='C00694471';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Conservatives Harvesting Success PAC — confirmed Leadership PAC via live FEC lookup (leadership_pac flag set), not industry money.' WHERE fec_committee_id='C00678813';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Sock It To ''Em PAC — confirmed Leadership PAC via live FEC lookup (leadership_pac flag set), not industry money.' WHERE fec_committee_id='C00654186';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Hall Render Killian Heath & Lyman Employee PAC — law firm (healthcare law specialty), no fitting category.' WHERE fec_committee_id='C00552083';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Paramount Global PAC — media/entertainment conglomerate, telecom/media cluster, no fitting category among current 9.' WHERE fec_committee_id='C00167759';

SELECT refresh_member_scores();
