-- Exhaustive PAC classification, pass 5. Real FEC verification for ambiguous cases;
-- well-established public identity relied on for unambiguous major companies
-- (same standard as prior passes). Rate limit hit on the FEC key partway through;
-- one committee (FOREVER YOUTH ORGANIZATION UTILIZING A NEW GENERATION PAC,
-- C00683508) left needs_review rather than guessed, per the "decline to guess"
-- standard already established (Rock Holdings Inc PAC, CAP-PAC, Anti-Woke Fund
-- in earlier passes).

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00424838/', classification_note = 'Novo Nordisk Inc. PAC — major pharmaceutical manufacturer.'
  WHERE fec_committee_id = 'C00424838';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00033969/', classification_note = 'Novartis Corporation PAC — major pharmaceutical manufacturer.'
  WHERE fec_committee_id = 'C00033969';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00397851/', classification_note = 'Centene PAC — major health insurer (Medicaid managed care).'
  WHERE fec_committee_id = 'C00397851';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00194746/', classification_note = 'BLUEPAC — Blue Cross and Blue Shield Association PAC — major health insurance trade association.'
  WHERE fec_committee_id = 'C00194746';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'surveillance_weapons',
  classification_source_url = 'https://www.fec.gov/data/committee/C00325092/', classification_note = 'Huntington Ingalls Industries PAC — largest US military shipbuilder (Navy ships/submarines).'
  WHERE fec_committee_id = 'C00325092';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'surveillance_weapons',
  classification_source_url = 'https://www.fec.gov/data/committee/C00367995/', classification_note = 'Sierra Nevada Corporation PAC — major aerospace/defense contractor.'
  WHERE fec_committee_id = 'C00367995';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00817585/', classification_note = 'Western Alliance Bancorporation PAC — bank holding company.'
  WHERE fec_committee_id = 'C00817585';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00497917/', classification_note = 'Depository Trust & Clearing Corporation PAC — confirmed via live FEC lookup as a Corporation; DTCC is core US securities clearing/settlement financial market infrastructure.'
  WHERE fec_committee_id = 'C00497917';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://www.fec.gov/data/committee/C00255877/', classification_note = 'The Options Clearing Corporation PAC — major US options-market clearinghouse, financial market infrastructure.'
  WHERE fec_committee_id = 'C00255877';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_source_url = 'https://www.fec.gov/data/committee/C00027532/', classification_note = 'American Maritime Officers Voluntary Political Action Fund — confirmed via live FEC lookup as organization_type "Labor Organization".'
  WHERE fec_committee_id = 'C00027532';

-- reviewed_no_fit, real reasoning per committee, no silent skips

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Herzog PAC — rail/transit construction company (Herzog Contracting/Herzog Transit Services). No fitting category among current 9.'
  WHERE fec_committee_id = 'C00391979';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Confirmed via live FEC lookup: designation "Leadership PAC" — not industry money despite defense-adjacent name.'
  WHERE fec_committee_id = 'C00480228';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Confirmed via live FEC lookup: Unauthorized/ideological issue PAC, org_type None — not industry money.'
  WHERE fec_committee_id = 'C00894717';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Confirmed via live FEC lookup: designation "Leadership PAC" — not industry money.'
  WHERE fec_committee_id = 'C00574970';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Confirmed via live FEC lookup: Unauthorized/ideological PAC, org_type None — not industry money.'
  WHERE fec_committee_id = 'C00692327';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Confirmed via live FEC lookup: Unauthorized PAC — the real moderate-Republican House caucus (Tuesday Group), a political/ideological grouping, not an industry.'
  WHERE fec_committee_id = 'C00433060';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'CAP-PAC / National Community Action Foundation — confirmed via live FEC lookup as a Membership Organization representing anti-poverty Community Action Agencies. No fitting category.'
  WHERE fec_committee_id = 'C00163048';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Fluor Corporation PAC — diversified global engineering/construction firm spanning oil & gas, government/defense (nuclear cleanup, DOD facilities), infrastructure, and mining. No single dominant segment confirmed; same diversification standard already applied to SpaceX/Blue Origin/Textron this session.'
  WHERE fec_committee_id = 'C00034132';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Manufactured Housing Institute PAC — manufactured/mobile housing industry trade association. No fitting category among current 9.'
  WHERE fec_committee_id = 'C00043463';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'J Street PAC — explicitly excluded from aipac_aligned per this project''s own established methodology: TrackAIPAC (the site this project cites as a methodology influence) states "J Street is not an automatic disqualifier," treating J Street as a distinct, more dovish alternative to AIPAC rather than part of the same lobby bloc. No other fitting category.'
  WHERE fec_committee_id = 'C00441949';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Exelon Corporation PAC — electric utility. Part of a recurring cluster (Exelon/Pinnacle West/Vistra this pass) flagged to Melissa as a possible new-category candidate, not yet decided.'
  WHERE fec_committee_id = 'C00141218';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Pinnacle West Capital Corporation PAC — electric utility. Same recurring utilities cluster as Exelon/Vistra this pass.'
  WHERE fec_committee_id = 'C00015933';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Vistra Employee PAC — electric utility (power generation). Same recurring utilities cluster as Exelon/Pinnacle West this pass.'
  WHERE fec_committee_id = 'C00226548';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Nuclear Energy Institute Federal PAC — nuclear power industry trade group. Adjacent to the electric-utilities cluster but distinct from oil_gas. No fitting category.'
  WHERE fec_committee_id = 'C00239848';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Principal Life Insurance Company PAC — general life insurance, broader than the current health-specific pharma_health_insurance scope. Part of the recurring "general/life insurance" gap already flagged.'
  WHERE fec_committee_id = 'C00128918';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'National Federation of Independent Business Federal PAC — general small-business advocacy, not a single industry. No fitting category.'
  WHERE fec_committee_id = 'C00101105';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'The Walt Disney Company Employees PAC — media/entertainment conglomerate. Part of the recurring "telecom/media" gap already flagged.'
  WHERE fec_committee_id = 'C00197749';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Caterpillar Inc. PAC — heavy equipment manufacturer. No fitting category among current 9.'
  WHERE fec_committee_id = 'C00148031';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Squire Patton Boggs PAC — law/lobbying firm. No fitting category, matches the law-firm pattern already declined in prior passes.'
  WHERE fec_committee_id = 'C00401083';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'LKQ Corporation Employee GGF — auto parts recycling/aftermarket. No fitting category.'
  WHERE fec_committee_id = 'C00458158';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Publix Super Markets Associates PAC — grocery retail. No fitting category.'
  WHERE fec_committee_id = 'C00400705';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'National Ready Mixed Concrete Association PAC — construction materials trade group. No fitting category.'
  WHERE fec_committee_id = 'C00114025';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Greenberg Traurig PAC — law firm. No fitting category, matches the law-firm pattern already declined in prior passes.'
  WHERE fec_committee_id = 'C00266585';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Florida Sugar Cane League PAC — agriculture. No fitting category, matches the ag-industry pattern already declined in prior passes.'
  WHERE fec_committee_id = 'C00012328';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Association of Oral and Maxillofacial Surgeons PAC — healthcare-provider professional association, distinct from the health-INSURANCE-payer scope of pharma_health_insurance. Part of the recurring "healthcare providers" gap already flagged.'
  WHERE fec_committee_id = 'C00005660';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Vulcan Materials Company PAC — construction aggregates/materials. No fitting category.'
  WHERE fec_committee_id = 'C00116020';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Michigan Sugar Company Growers PAC — agriculture. No fitting category, matches the ag-industry pattern already declined in prior passes.'
  WHERE fec_committee_id = 'C00384354';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Resort Development Association Resort Owners Coalition PAC (ARDA-ROC) — timeshare/resort industry. No fitting category.'
  WHERE fec_committee_id = 'C00358663';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Animal Wellness Action PAC — animal-welfare advocacy, not an industry PAC. No fitting category.'
  WHERE fec_committee_id = 'C00679860';

-- Left needs_review — FEC lookup hit the shared key's rate limit and the committee
-- name does not clearly indicate its actual purpose; declining to guess, consistent
-- with prior passes' handling of Rock Holdings/CAP-PAC/Anti-Woke Fund before those
-- were independently confirmed.
-- (no UPDATE for C00683508 "FOREVER YOUTH ORGANIZATION UTILIZING A NEW GENERATION PAC")
