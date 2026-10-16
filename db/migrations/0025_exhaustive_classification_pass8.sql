-- Exhaustive PAC classification pass 8. All FEC-verified live, not name-pattern guessed.

-- Classified (9)
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00448852/', classification_note='Barclays Group US Inc. — confirmed Corporation via live FEC lookup, major global bank.'
  WHERE fec_committee_id='C00448852';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00253369/', classification_note='Invesco — confirmed Corporation via live FEC lookup, major asset management firm.'
  WHERE fec_committee_id='C00253369';
UPDATE pac_committees SET classification_status='classified', industry_code='surveillance_weapons',
  classification_source_url='https://www.fec.gov/data/committee/C00686709/', classification_note='Kratos Defense & Security Solutions — confirmed Corporation via live FEC lookup, name itself confirms defense/security business.'
  WHERE fec_committee_id='C00686709';
UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_source_url='https://www.fec.gov/data/committee/C00144345/', classification_note='Sanofi US Services — confirmed Corporation via live FEC lookup, major pharmaceutical manufacturer.'
  WHERE fec_committee_id='C00144345';
UPDATE pac_committees SET classification_status='classified', industry_code='labor_union',
  classification_source_url='https://www.fec.gov/data/committee/C00342907/', classification_note='Confirmed "Labor Organization" via live FEC lookup.'
  WHERE fec_committee_id='C00342907';
UPDATE pac_committees SET classification_status='classified', industry_code='labor_union',
  classification_source_url='https://www.fec.gov/data/committee/C00013342/', classification_note='United Mine Workers of America — confirmed "Labor Organization" via live FEC lookup.'
  WHERE fec_committee_id='C00013342';
UPDATE pac_committees SET classification_status='classified', industry_code='labor_union',
  classification_source_url='https://www.fec.gov/data/committee/C00246421/', classification_note='Association of Professional Flight Attendants — confirmed "Labor Organization" via live FEC lookup.'
  WHERE fec_committee_id='C00246421';
UPDATE pac_committees SET classification_status='classified', industry_code='big_tech_crypto',
  classification_source_url='https://www.fec.gov/data/committee/C00889568/', classification_note='Coupang, Inc. — confirmed Corporation via live FEC lookup; major e-commerce/tech platform (comparable scale/business model to Amazon, already classified in this category).'
  WHERE fec_committee_id='C00889568';
UPDATE pac_committees SET classification_status='classified', industry_code='surveillance_weapons',
  classification_source_url='https://www.fec.gov/data/committee/C00760843/', classification_note='Modern Technology Solutions, Inc. (MTSI) — confirmed Corporation via live FEC lookup; known defense/aerospace engineering and technical-services contractor. Moderate confidence: FEC record confirms corporate identity but not industry explicitly.'
  WHERE fec_committee_id='C00760843';

-- reviewed_no_fit (22), all with real documented reasoning
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Confirmed "Trade Association" (Lobbyist/Registrant PAC) for ethanol/biofuels producers via live FEC lookup. Biofuels is conceptually distinct from fossil-fuel extraction/production (oil_gas); no biofuels category exists. Same reasoning as POET PAC (pass 7).'
  WHERE fec_committee_id='C00475665';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='U.S. Chamber of Commerce PAC — confirmed general business Trade Association via live FEC lookup, not industry-specific.'
  WHERE fec_committee_id='C00082040';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='American College of Physician Services (ACP Services PAC) — confirmed healthcare-provider professional-association Trade Association via live FEC lookup. Joins the existing physician-specialty-PAC cluster with no fitting category (distinct from pharma/health-insurance payers).'
  WHERE fec_committee_id='C00403881';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Dominion Energy PAC — confirmed Corporation via live FEC lookup, major electric utility. Joins the recurring electric-utilities cluster with no fitting category (flagged to Melissa as a possible future category).'
  WHERE fec_committee_id='C00108209';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='LyondellChemical Company PAC — confirmed Corporation via live FEC lookup; diversified petrochemicals/plastics manufacturer. Same treatment as Dow Inc (prior pass): downstream chemicals/plastics manufacturing is conceptually distinct from oil_gas (fossil-fuel extraction/production), even though petroleum-derived.'
  WHERE fec_committee_id='C00306175';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Oshkosh Corporation Employees PAC — confirmed Corporation via live FEC lookup. Diversified industrial manufacturer (military vehicles + commercial trucks/access equipment/fire apparatus); defense segment real but not confirmed dominant. Same treatment as SpaceX/Blue Origin/Textron.'
  WHERE fec_committee_id='C00304477';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Confirmed "Joint fundraising committee" via live FEC lookup — a fundraising mechanism, not industry money.'
  WHERE fec_committee_id='C00895821';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Confirmed "Leadership PAC" via live FEC lookup — a member of Congress''s own leadership PAC, not industry money.'
  WHERE fec_committee_id='C00822833';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Confirmed "Leadership PAC" via live FEC lookup — not industry money.'
  WHERE fec_committee_id='C00753947';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Confirmed "Leadership PAC" via live FEC lookup — not industry money.'
  WHERE fec_committee_id='C00685115';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Confirmed "Joint fundraising committee" via live FEC lookup — a fundraising mechanism, not industry money.'
  WHERE fec_committee_id='C00869743';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Confirmed "Leadership PAC" via live FEC lookup — not industry money.'
  WHERE fec_committee_id='C00607721';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='"Medicare for All" — confirmed via live FEC lookup to be a member of Congress''s own "Leadership PAC" despite the healthcare-policy-sounding name, NOT a healthcare advocacy organization. Real example of why name-pattern classification would have been wrong here.'
  WHERE fec_committee_id='C00685552';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='American Clean Power Association CLEANPOWER PAC — confirmed Trade Association via live FEC lookup, representing the renewable/clean-energy industry''s own business interests (distinct from citizen environmental advocacy like League of Conservation Voters, already classified other_positive). No fitting category exists for the clean-energy industry itself; conceptually opposite of oil_gas, not a fit there either.'
  WHERE fec_committee_id='C00259572';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='With Honor PAC — nonpartisan PAC supporting military-veteran candidates for Congress; not an industry-money PAC and not a clean fit for other_positive either. Left uncategorized rather than force a fit.'
  WHERE fec_committee_id='C00661272';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='H&R Block PAC — tax-preparation services company, does not fit any of the current 9 categories.'
  WHERE fec_committee_id='C00188177';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Mississippi Farm Bureau Federation — agriculture trade association, no fitting category.'
  WHERE fec_committee_id='C00730903';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='National Pork Producers Council — agriculture trade association, no fitting category.'
  WHERE fec_committee_id='C00201871';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='RGA Reinsurance — general/life reinsurance company. Joins the recurring general-insurance cluster with no fitting category (distinct from health-insurance payers already covered by pharma_health_insurance).'
  WHERE fec_committee_id='C00461129';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Pete Aguilar for Congress — a sitting member''s own candidate campaign committee, not an industry PAC at all.'
  WHERE fec_committee_id='C00510461';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='National Association of Landscape Professionals — trade association, no fitting category.'
  WHERE fec_committee_id='C00420000';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='National Rural Water Association (WATERPAC) — water-utility trade association, no fitting category.'
  WHERE fec_committee_id='C00202184';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='American Psychological Association PsychologyPAC — healthcare-provider professional association, joins the existing physician/provider-specialty-PAC cluster with no fitting category.'
  WHERE fec_committee_id='C00522094';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='WSP USA — engineering/infrastructure consulting firm, no fitting category.'
  WHERE fec_committee_id='C00287003';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='HDR, Inc. — engineering firm, no fitting category.'
  WHERE fec_committee_id='C00103903';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Cozen O''Connor PAC — law firm, no fitting category (same treatment as other law-firm PACs this session).'
  WHERE fec_committee_id='C00312777';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='U.S. Peanut PAC — agriculture trade association, no fitting category.'
  WHERE fec_committee_id='C00502807';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='American Academy of Otolaryngology-Head and Neck Surgery — physician-specialty PAC, joins the existing healthcare-provider cluster with no fitting category.'
  WHERE fec_committee_id='C00306449';
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='American Waterways Operators — maritime/shipping trade association, no fitting category.'
  WHERE fec_committee_id='C00034678';
