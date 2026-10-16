-- Exhaustive PAC classification, pass 14. Verified via live FEC lookup
-- (api.open.fec.gov, CONGRESS_GOV_API_KEY to avoid the shared FEC_API_KEY
-- rate limit) unless noted as well-known public identity.

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'big_tech_crypto',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00362707/', classification_note = 'Cisco Systems, Inc. Federal PAC -- confirmed Corporation via live FEC lookup, major networking/tech company.'
  WHERE fec_committee_id = 'C00362707';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'vice_guns_gambling_alcohol',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00142315/', classification_note = 'Boyd Gaming Corporation PAC -- confirmed Corporation via live FEC lookup, major casino/gaming operator.'
  WHERE fec_committee_id = 'C00142315';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'vice_guns_gambling_alcohol',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00059733/', classification_note = 'Brown-Forman Corporation PAC -- confirmed Corporation via live FEC lookup, spirits/alcohol producer (Jack Daniel''s).'
  WHERE fec_committee_id = 'C00059733';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'surveillance_weapons',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00890590/', classification_note = 'Axon Enterprise Inc PAC -- confirmed Corporation via live FEC lookup; maker of Tasers and law-enforcement body-camera/surveillance tech.'
  WHERE fec_committee_id = 'C00890590';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00279380/', classification_note = 'Marine Engineers'' Beneficial Association PAF -- confirmed "Labor Organization" via live FEC lookup.'
  WHERE fec_committee_id = 'C00279380';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00142851/', classification_note = 'International Union of Operating Engineers Local 150 PAC -- confirmed "Labor Organization" via live FEC lookup.'
  WHERE fec_committee_id = 'C00142851';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00011262/', classification_note = 'Brotherhood of Railroad Signalmen PAC -- confirmed "Labor Organization" via live FEC lookup.'
  WHERE fec_committee_id = 'C00011262';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'other_positive',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00314617/', classification_note = 'Planned Parenthood Federal PAC -- confirmed "Membership Organization" via live FEC lookup; genuine advocacy org, same treatment as Sierra Club/LCV/HRC/MoveOn precedent, not corporate money.'
  WHERE fec_committee_id = 'C00314617';

-- reviewed_no_fit, documented reasoning
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Nutrien Ag Solutions Employee Citizenship Fund PAC -- confirmed Corporation via live FEC lookup; agriculture/fertilizer, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00385039';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'NiSource Inc PAC -- confirmed Corporation via live FEC lookup; mixed natural-gas-and-electric utility holding company (parent of NIPSCO), not a pure gas-distribution entity like the already-classified American Gas Association -- treated consistently with the recurring electric-utilities cluster, not force-fit into oil_gas.'
  WHERE fec_committee_id = 'C00051979';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Bayer US LLC Employee PAC (BAYERPAC) -- confirmed Corporation via live FEC lookup; genuinely diversified across pharmaceuticals, consumer health, and crop science (post-Monsanto acquisition) -- neither pharma nor agriculture clearly dominant, same non-forced treatment as Dow/BASF/Siemens.'
  WHERE fec_committee_id = 'C00281162';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Husch Blackwell PAC -- law firm, same treatment as Sidley Austin/Barnes & Thornburg/King & Spalding/Squire Patton Boggs/Nelson Mullins/Foley & Lardner/Balch & Bingham/McGuireWoods/Kelley Drye/Venable/K&L Gates/Akin Gump precedent.'
  WHERE fec_committee_id = 'C00424382';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Nike Inc Federal PAC -- well-known public company, consumer apparel/footwear, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00142786';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Cargill Incorporated PAC -- well-known public company, agriculture/commodities, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00067884';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Siemens Corporation PAC -- diversified industrial conglomerate (energy, healthcare tech, infrastructure), same non-dominant-industry treatment as Dow/BASF precedent.'
  WHERE fec_committee_id = 'C00353797';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Corning Incorporated Employees PAC -- well-known public company, materials/glass manufacturer, no fitting category.'
  WHERE fec_committee_id = 'C00033589';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Motion Picture Association PAC -- media/entertainment trade association, part of the recurring telecom/media cluster already flagged, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00139519';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'MetLife Inc Employees'' Political Participation Fund A -- life/general insurance, part of the recurring general/life-insurance cluster already flagged, distinct from the current health-specific pharma_health_insurance scope.'
  WHERE fec_committee_id = 'C00040923';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Syngenta Corporation PAC -- well-known public company, agrochemicals/seeds, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00363945';

-- Keystone America PAC (C00439992) left in needs_review deliberately: FEC record shows
-- org_type "None" with no other identifying data, insufficient to classify either way.
