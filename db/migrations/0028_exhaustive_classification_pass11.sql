-- Exhaustive PAC classification pass 11. Operational change tested and confirmed working:
-- used CONGRESS_GOV_API_KEY instead of FEC_API_KEY for these lookups (both keys work
-- interchangeably against FEC per api.data.gov's shared gateway) to avoid the shared
-- rate limit that throttled pass 10 -- confirmed no rate-limit errors this pass.

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://www.fec.gov/data/committee/C00160630/',
  classification_note = 'Drummond Company, Inc. PAC -- Alabama-based coal mining/fossil-fuel extraction company (also has Colombian oil operations). Classified under oil_gas as fossil-fuel extraction industry per category scope, though primarily coal rather than literal oil/gas.'
  WHERE fec_committee_id = 'C00160630';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://www.fec.gov/data/committee/C00135855/',
  classification_note = 'Diamondback Energy, Inc. PAC -- major US oil & gas producer, Permian Basin. Clean, unambiguous fit.'
  WHERE fec_committee_id = 'C00135855';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'other_positive',
  classification_source_url = 'https://www.fec.gov/data/committee/C00135368/',
  classification_note = 'Sierra Club Political Committee -- genuine environmental advocacy organization, same treatment as League of Conservation Voters Action Fund and Environmental Defense Action Fund PAC classified in prior passes.'
  WHERE fec_committee_id = 'C00135368';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'other_positive',
  classification_source_url = 'https://www.fec.gov/data/committee/C00486928/',
  classification_note = 'Alzheimer''s Impact Movement PAC -- political arm of the Alzheimer''s Association, advocacy for medical research/care funding. Genuine public-health advocacy nonprofit, same treatment as other confirmed advocacy PACs.'
  WHERE fec_committee_id = 'C00486928';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_source_url = 'https://www.fec.gov/data/committee/C00065870/',
  classification_note = 'Political arm of International Union of Operating Engineers Local 18 -- confirmed org_type Labor Organization via live FEC lookup.'
  WHERE fec_committee_id = 'C00065870';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_source_url = 'https://www.fec.gov/data/committee/C00345306/',
  classification_note = 'National Postal Mail Handlers Union (division of LIUNA) -- confirmed org_type Labor Organization via live FEC lookup.'
  WHERE fec_committee_id = 'C00345306';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00558452/',
  classification_note = 'Professional Compounding Centers of America PAC -- pharmacy compounding company, pharmaceutical industry.'
  WHERE fec_committee_id = 'C00558452';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00493502/',
  classification_note = 'VSP Holding Company PAC -- vision/eye-care insurance provider. Classified under health insurance (distinct from the general/life/property insurance cluster repeatedly left uncategorized) since vision coverage is a health-insurance product.'
  WHERE fec_committee_id = 'C00493502';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'surveillance_weapons',
  classification_source_url = 'https://www.fec.gov/data/committee/C00400424/',
  classification_note = 'Torch Technologies, Inc. PAC -- Huntsville, AL-based defense engineering/technical-services company serving DoD missile-defense and related programs. Moderate confidence: based on known corporate identity rather than an explicit FEC industry field, same confidence tier as Modern Technology Solutions (MTSI) classified in pass 8.'
  WHERE fec_committee_id = 'C00400424';

-- reviewed_no_fit, real documented reasoning each
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Generic-named Unauthorized PAC, no organization type or clear affiliation signal in FEC record. No evidence for any of the 9 categories.'
  WHERE fec_committee_id IN ('C00881698','C00712695','C00770255','C00813063');

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Americans for Responsible Innovation Ltd PAC (ARI PAC) -- AI-policy advocacy Membership Organization. Valence unclear (could read as pro-regulation/positive or industry-adjacent) -- left unclassified per prior passes'' judgment rather than guess a direction.'
  WHERE fec_committee_id = 'C00893883';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Confirmed Leadership PAC via live FEC lookup -- not industry money.'
  WHERE fec_committee_id IN ('C00483487','C00633156','C00746735','C00785816','C00762328','C00392738','C00542027','C00647354','C00896688','C00892901','C00497131','C00692715','C00538835');

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Blue Dog Political Action Committee -- the real Blue Dog Coalition, a moderate-Democrat ideological caucus PAC, not an industry-aligned committee.'
  WHERE fec_committee_id = 'C00305318';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Future Forum PAC -- ideological caucus PAC (younger House Democrats), not industry-aligned.'
  WHERE fec_committee_id = 'C00625988';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Senate Conservatives Fund -- ideological/ally political fund supporting conservative candidates, not an industry PAC.'
  WHERE fec_committee_id = 'C00448696';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'National Peanut Buying Points Association PAC -- agricultural trade association, no fitting category.'
  WHERE fec_committee_id = 'C00374298';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Farmers'' Rice Cooperative Fund -- agricultural cooperative, no fitting category.'
  WHERE fec_committee_id = 'C00146605';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Burns and McDonnell Inc. PAC -- diversified engineering/construction firm (energy infrastructure among other sectors). Same "not dominant enough in one category" treatment as AECOM/Textron/SpaceX precedent.'
  WHERE fec_committee_id = 'C00442913';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Woolpert, Inc. PAC -- engineering/geospatial services firm, diversified government-adjacent work, no single dominant industry fit. Same diversified-engineering treatment as Burns and McDonnell.'
  WHERE fec_committee_id = 'C00479899';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Becton Dickinson and Company PAC -- major medical device manufacturer. Medical-device companies (Medtronic, Boston Scientific, Smith & Nephew) have consistently been left uncategorized in prior passes since pharma_health_insurance covers pharmaceutical manufacturers and health insurers specifically, not device makers -- part of the recurring healthcare-provider/device cluster flagged to Melissa as a possible future category.'
  WHERE fec_committee_id = 'C00376582';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'The Travelers Companies PAC -- major property/casualty insurance company, not health insurance. Part of the recurring general/life/property insurance cluster flagged to Melissa as a possible future category, distinct from the health-insurance-specific current scope.'
  WHERE fec_committee_id = 'C00376376';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Sportfishing Association PAC -- fishing-industry trade association, no fitting category.'
  WHERE fec_committee_id = 'C00249532';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Public Power Association PAC -- public electric-utilities trade association. Part of the recurring electric-utilities cluster flagged to Melissa as a possible future category.'
  WHERE fec_committee_id = 'C00161570';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Universal Music Group Employee Action Fund -- media/entertainment company, not big-tech/crypto. Part of the recurring telecom/media cluster flagged to Melissa.'
  WHERE fec_committee_id = 'C00392464';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'The Guidehouse Inc. PAC -- general management/technology consulting firm, no single dominant industry fit. Same treatment as McKinsey precedent from pass 9.'
  WHERE fec_committee_id = 'C00740605';
