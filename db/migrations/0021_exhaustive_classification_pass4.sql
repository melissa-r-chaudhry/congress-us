-- Exhaustive PAC classification, pass 4. Continues from pass 3's stopping point.
-- Real FEC lookups performed for genuinely ambiguous committees (Rocket/Rock Holdings,
-- Abundance PAC, Serco, JEFF PAC, On Wisconsin PAC, Republican Mainstream Partnership).
-- Well-known, unambiguous public companies (BWX Technologies, AstraZeneca/Zeneca,
-- Genentech, TransDigm, Anduril, McKesson, Cencora/AmerisourceBergen, major electric
-- utilities, major insurers) classified on real public-record corporate identity, not
-- name-pattern guessing -- distinct from the AIPAC-episode problem, which was inferring
-- industry from suggestive-sounding names on genuinely ambiguous/obscure committees.

-- Classified: 13 committees, real evidence
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_note = 'Rocket Companies (Rocket Mortgage) corporate PAC -- confirmed via live FEC lookup, official name "ROCKET LIMITED PARTNERSHIP PAC (ROCKET PAC)", Lobbyist/Registrant PAC, org_type Corporation. Mortgage lending/financial services.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00388827/'
  WHERE fec_committee_id = 'C00388827';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_note = 'Lincoln Financial Group (Lincoln National Corp) -- life insurance and financial services/asset management. Same category placement as Prudential Financial (pass 2 precedent) given comparable diversified insurance+financial-services business.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00110577/'
  WHERE fec_committee_id = 'C00110577';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_note = 'National Venture Capital Association -- venture capital/investment industry trade group.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00150367/'
  WHERE fec_committee_id = 'C00150367';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_note = 'BMO Financial Corp (Bank of Montreal US operations) -- major bank.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00611871/'
  WHERE fec_committee_id = 'C00611871';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'surveillance_weapons',
  classification_note = 'BWX Technologies -- manufactures naval nuclear reactors and nuclear components for the US Navy/DoD; core business is defense/nuclear manufacturing.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00365502/'
  WHERE fec_committee_id = 'C00365502';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'surveillance_weapons',
  classification_note = 'TransDigm Group -- major specialized aerospace/defense component manufacturer, substantial DoD supplier.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00714329/'
  WHERE fec_committee_id = 'C00714329';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'surveillance_weapons',
  classification_note = 'Anduril Industries -- defense technology company (autonomous systems, AI-enabled defense products); core business is defense, unambiguous.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00763623/'
  WHERE fec_committee_id = 'C00763623';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_note = 'Zeneca Inc (AZPAC) -- AstraZeneca, major global pharmaceutical manufacturer.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00279455/'
  WHERE fec_committee_id = 'C00279455';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_note = 'Genentech (GENENPAC) -- major biotechnology/pharmaceutical company (Roche subsidiary).',
  classification_source_url = 'https://www.fec.gov/data/committee/C00199257/'
  WHERE fec_committee_id = 'C00199257';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_note = 'McKesson Corporation -- one of the "big three" pharmaceutical distributors. Same category placement as Cardinal Health (prior pass precedent), a direct industry peer.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00108035/'
  WHERE fec_committee_id = 'C00108035';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_note = 'Cencora Inc (formerly AmerisourceBergen) -- one of the "big three" pharmaceutical distributors, direct peer of already-classified Cardinal Health and McKesson.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00400929/'
  WHERE fec_committee_id = 'C00400929';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_note = 'International Alliance of Theatrical Stage Employees (IATSE) -- entertainment industry labor union.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00344325/'
  WHERE fec_committee_id = 'C00344325';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'other_positive',
  classification_note = 'VoteVets -- veteran advocacy PAC, not corporate/industry money. Same reasoning as League of Conservation Voters Action Fund (pass 2 precedent): genuine issue-advocacy organization, people-aligned.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00418897/'
  WHERE fec_committee_id = 'C00418897';

-- Reviewed, no fitting category among current 9: 25 committees, real documented reasoning
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Southern Company Employees PAC -- electric utility. Part of the recurring electric-utilities cluster with no current fitting category (flagged to Melissa as a possible new category, not yet decided).'
  WHERE fec_committee_id = 'C00144774';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Duke Energy Corporation PAC -- electric utility. Electric-utilities cluster.'
  WHERE fec_committee_id = 'C00083535';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'NextEra Energy PAC -- electric utility. Electric-utilities cluster.'
  WHERE fec_committee_id = 'C00064774';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Abundance PAC -- confirmed via live FEC lookup (Unauthorized designation, no corporate org_type). Political/ideological movement PAC (the "abundance" policy movement), not an industry PAC.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00903880/'
  WHERE fec_committee_id = 'C00903880';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Serco Inc PAC -- confirmed via live FEC lookup as a real corporate PAC. Serco is a diversified government-services contractor (citizen services, transportation, defense/intelligence); defense revenue not confirmed dominant enough of a diversified business to classify as surveillance_weapons, same standard applied to SpaceX/Textron/Blue Origin in prior passes.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00402669/'
  WHERE fec_committee_id = 'C00402669';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Southern Minnesota Beet Sugar Cooperative PAC -- agriculture. Agriculture/trade-group cluster with no fitting category.'
  WHERE fec_committee_id = 'C00166348';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'CHS Inc PAC -- major agricultural cooperative. Agriculture cluster.'
  WHERE fec_committee_id = 'C00149104';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'LabCorp (Laboratory Corporation of America) PAC -- clinical diagnostics/lab testing company. Healthcare-provider cluster, distinct from pharma manufacturing or health insurance -- current category scope does not cover healthcare service/provider companies.'
  WHERE fec_committee_id = 'C00314997';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'GE Healthcare Technologies PAC -- medical imaging/diagnostic equipment manufacturer. Medical device/technology, distinct from the pharma-manufacturer/health-insurer scope of the current pharma_health_insurance category.'
  WHERE fec_committee_id = 'C00830208';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Chemistry Council PAC -- chemical manufacturing industry trade association, distinct from oil & gas extraction/production. No fitting category among current 9.'
  WHERE fec_committee_id = 'C00252338';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Kelley Drye & Warren LLP PAC -- law firm. Law-firm cluster, no fitting category (consistent with prior passes leaving other law firms uncategorized).'
  WHERE fec_committee_id = 'C00301929';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Pistachio Growers PAC -- agriculture. Agriculture cluster.'
  WHERE fec_committee_id = 'C00197715';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'National Alliance of Forest Owners PAC -- forestry/timber industry. No fitting category among current 9.'
  WHERE fec_committee_id = 'C00469080';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Academy of Ophthalmology PAC (OPHTHPAC) -- physician specialty association. Healthcare-provider/professional-association cluster, distinct from pharma/insurance scope.'
  WHERE fec_committee_id = 'C00196246';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Podiatric Medical Association PAC -- physician specialty association. Healthcare-provider/professional-association cluster.'
  WHERE fec_committee_id = 'C00008839';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'JEFF PAC (Jobs, Education & Families First) -- confirmed via live FEC lookup as a Leadership PAC (a member''s personal political committee), not industry money.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00617803/'
  WHERE fec_committee_id = 'C00617803';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'On Wisconsin PAC -- confirmed via live FEC lookup as a Leadership PAC, not industry money.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00697326/'
  WHERE fec_committee_id = 'C00697326';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Republican Mainstream Partnership PAC -- confirmed via live FEC lookup (Unauthorized, no corporate org_type). Political faction/caucus-aligned PAC, not industry money.',
  classification_source_url = 'https://www.fec.gov/data/committee/C00165159/'
  WHERE fec_committee_id = 'C00165159';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Elect Democratic Women -- political/ideological PAC (candidate-recruitment focused), not industry money.'
  WHERE fec_committee_id = 'C00685297';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'SEMA & PRI PAC (Specialty Equipment Market Association / Performance Racing) -- auto aftermarket and racing industry trade group. No fitting category among current 9.'
  WHERE fec_committee_id = 'C00389403';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Ball Corporation PAC -- packaging/aluminum can manufacturer. General manufacturing, no fitting category.'
  WHERE fec_committee_id = 'C00039461';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'U.S. Travel Association PAC -- travel/tourism industry trade group. No fitting category among current 9.'
  WHERE fec_committee_id = 'C00457754';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Nationwide Mutual Insurance PAC -- general/property-casualty insurance, not health-specific. Part of the recurring general/life-insurance cluster with no current fitting category (distinct from the health-insurance scope of pharma_health_insurance).'
  WHERE fec_committee_id = 'C00406215';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'State Farm Mutual Automobile Insurance PAC -- general/auto insurance, not health-specific. General/life-insurance cluster.'
  WHERE fec_committee_id = 'C00544817';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'iHeartMedia Inc PAC -- radio/media broadcasting company. Part of the recurring telecom/media cluster with no current fitting category (flagged to Melissa as a possible new category, not yet decided).'
  WHERE fec_committee_id = 'C00279216';

-- Deliberately left needs_review, insufficient evidence to classify either way:
-- C00163048 CAP-PAC (National Community Action Foundation) -- plausibly people-aligned
--   anti-poverty advocacy, but not independently verified; declined to guess.
-- C00894717 Anti-Woke Fund -- FEC committee lookup returned no data (possible ID error
--   or very recently registered committee); declined to guess without a real record.
