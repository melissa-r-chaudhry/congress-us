-- Exhaustive PAC classification, pass 1 (dollar-rank #1-80 of 3,550 needs_review committees).
-- Real FEC verification done for all wall_street_banking_finance / pharma_health_insurance
-- classifications where rate limits allowed (shared FEC key hit real hourly limits mid-pass
-- from concurrent sync/fork activity this session — noted per-row where verification was
-- name/public-record-based rather than a fresh live API call).

-- ===== CLASSIFIED: wall_street_banking_finance =====
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00012245/', classification_note='UBS Americas Inc. — FEC-confirmed Corporation, major global investment bank/wealth manager.'
  WHERE fec_committee_id='C00012245';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00432252/', classification_note='Regions Financial Corporation — FEC-confirmed Corporation, major regional bank holding company.'
  WHERE fec_committee_id='C00432252';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00501429/', classification_note='TD Bank US Holding Company — FEC-confirmed Corporation, major bank.'
  WHERE fec_committee_id='C00501429';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00105981/', classification_note='Investment Company Institute — FEC-confirmed Trade Association representing the mutual fund/investment fund industry.'
  WHERE fec_committee_id='C00105981';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00005249/', classification_note='National Association of Insurance and Financial Advisors — FEC-confirmed Trade Association, financial-advisor-focused (mixed with insurance sales, but financial-services framing dominant).'
  WHERE fec_committee_id='C00005249';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00447565/', classification_note='FINSECA — FEC-confirmed Trade Association for financial security/insurance/annuity professionals; financial-services-oriented mission.'
  WHERE fec_committee_id='C00447565';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00193631/', classification_note='Farm Credit Council — represents Farm Credit System lending institutions (agricultural banks); fundamentally a financial/lending-industry PAC despite ag sector focus. Public-record name match; live FEC verification blocked by rate limit this pass.'
  WHERE fec_committee_id='C00193631';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00004812/', classification_note='Mortgage Bankers Association (MORPAC) — mortgage banking industry trade group. Public-record name match; live FEC verification blocked by rate limit this pass.'
  WHERE fec_committee_id='C00004812';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00038604/', classification_note='American Financial Services Association — consumer credit/financial services industry trade group. Public-record name match; live FEC verification blocked by rate limit this pass.'
  WHERE fec_committee_id='C00038604';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00326595/', classification_note='Capital One Financial Corp — major bank/credit card company. Public-record name match; live FEC verification blocked by rate limit this pass.'
  WHERE fec_committee_id='C00326595';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance',
  classification_source_url='https://www.fec.gov/data/committee/C00431361/', classification_note='TIAA — major financial services/retirement and annuity company. Public-record name match; live FEC verification blocked by rate limit this pass.'
  WHERE fec_committee_id='C00431361';

-- ===== CLASSIFIED: pharma_health_insurance =====
UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_source_url='https://www.fec.gov/data/committee/C00034157/', classification_note='AFLAC — FEC-confirmed Corporation, major supplemental health/accident insurance company.'
  WHERE fec_committee_id='C00034157';
UPDATE pac_committees SET classification_status='classified', industry_code='pharma_health_insurance',
  classification_source_url='https://www.fec.gov/data/committee/C00283135/', classification_note='NABIP (National Association of Benefits and Insurance Professionals, formerly NAHU) — health insurance/employee-benefits brokers specifically, per its own name and mission. Public-record name match; live FEC verification blocked by rate limit this pass.'
  WHERE fec_committee_id='C00283135';

-- ===== REVIEWED, NO FIT: real estate / housing =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Real estate industry trade association (National Association of Realtors) — no fitting category among current 9.' WHERE fec_committee_id='C00030718';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Homebuilding industry trade association (NAHB) — no fitting category among current 9.' WHERE fec_committee_id='C00000901';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Apartment/multifamily real estate trade association — no fitting category among current 9.' WHERE fec_committee_id='C00113241';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Multifamily housing industry trade association — no fitting category among current 9.' WHERE fec_committee_id='C00130773';

-- ===== REVIEWED, NO FIT: professional services / accounting / law =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Accounting profession trade association (AICPA) — professional services, no fitting category among current 9.' WHERE fec_committee_id='C00077321';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Big-4 accounting/professional-services firm — not a bank/investment firm per se, no fitting category among current 9.' WHERE fec_committee_id='C00227744';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Big-4 accounting/professional-services firm — no fitting category among current 9.' WHERE fec_committee_id='C00211318';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Big-4 accounting/professional-services firm — no fitting category among current 9.' WHERE fec_committee_id='C00107235';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='DC lobbying/law firm PAC (Brownstein Hyatt Farber Schreck) — professional services, not an industry-specific PAC.' WHERE fec_committee_id='C00390583';

-- ===== REVIEWED, NO FIT: agriculture / food =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Agricultural commodity company (sugar) — no fitting category among current 9.' WHERE fec_committee_id='C00110338';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Cotton industry trade association — agriculture, no fitting category among current 9.' WHERE fec_committee_id='C00023028';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Sugar cane agriculture industry — no fitting category among current 9.' WHERE fec_committee_id='C00081414';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Cattle/beef industry trade association — agriculture, no fitting category among current 9.' WHERE fec_committee_id='C00028787';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='State farm bureau agricultural fund — no fitting category among current 9.' WHERE fec_committee_id='C00214981';

-- ===== REVIEWED, NO FIT: retail / auto / manufacturing / logistics =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Auto dealer trade association — no fitting category among current 9.' WHERE fec_committee_id='C00040998';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Home improvement retailer — no fitting category among current 9.' WHERE fec_committee_id='C00284885';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Auto manufacturer — no fitting category among current 9.' WHERE fec_committee_id='C00542365';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='General retail corporation — no fitting category among current 9.' WHERE fec_committee_id='C00093054';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Package delivery/logistics company — no fitting category among current 9.' WHERE fec_committee_id='C00064766';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Auto manufacturer — no fitting category among current 9.' WHERE fec_committee_id='C00076810';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Convenience store retail trade association — not specifically a vice-industry group (general convenience retail), no fitting category among current 9.' WHERE fec_committee_id='C00126763';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Franchise industry trade association (retail/restaurant franchising) — no fitting category among current 9.' WHERE fec_committee_id='C00084491';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Hotel/lodging industry trade association — no fitting category among current 9.' WHERE fec_committee_id='C00001198';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Boat manufacturing trade association — no fitting category among current 9.' WHERE fec_committee_id='C00245548';

-- ===== REVIEWED, NO FIT: telecom/media/cable — FLAGGED CLUSTER, see report =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Cable/broadband/telecom carrier (Charter/Spectrum) — traditionally classified as telecom, not "Big Tech" platform company; flagged for possible future telecom category decision.' WHERE fec_committee_id='C00426775';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Telecom/wireless carrier (AT&T) — traditionally telecom, not "Big Tech"; flagged for possible future telecom category decision.' WHERE fec_committee_id='C00109017';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Telecom/wireless carrier (Verizon) — traditionally telecom, not "Big Tech"; flagged for possible future telecom category decision.' WHERE fec_committee_id='C00186288';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Cable/media conglomerate (Cox Enterprises) — telecom/media, not "Big Tech"; flagged for possible future telecom category decision.' WHERE fec_committee_id='C00477653';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Cable/media conglomerate (Comcast/NBCUniversal) — traditionally classified as telecom/media, not "Big Tech" platform company despite real streaming/broadband tech elements; flagged for possible future telecom category decision.' WHERE fec_committee_id='C00248716';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Broadcast media trade association — media, not "Big Tech"; no fitting category among current 9.' WHERE fec_committee_id='C00009985';

-- ===== REVIEWED, NO FIT: construction/engineering/industrial/energy =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Engineering firms trade association — no fitting category among current 9.' WHERE fec_committee_id='C00010868';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Construction industry trade association — no fitting category among current 9.' WHERE fec_committee_id='C00010421';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Electrical contractors trade association — no fitting category among current 9.' WHERE fec_committee_id='C00113811';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='General contractors trade association — no fitting category among current 9.' WHERE fec_committee_id='C00082917';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Stone/sand/gravel mining industry — no fitting category among current 9.' WHERE fec_committee_id='C00089458';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Electric utility cooperative association — energy sector but electric power generation/distribution, distinct from "oil & gas" fossil-fuel extraction category; flagged for possible future utilities category decision.' WHERE fec_committee_id='C00002972';

-- ===== REVIEWED, NO FIT: transportation/rail/air =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Railroad company — no fitting category among current 9.' WHERE fec_committee_id='C00010470';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Railroad company — no fitting category among current 9.' WHERE fec_committee_id='C00235739';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Railroad company — no fitting category among current 9.' WHERE fec_committee_id='C00163832';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Airline — no fitting category among current 9.' WHERE fec_committee_id='C00104802';

-- ===== REVIEWED, NO FIT: medical PROVIDER/professional associations — FLAGGED CLUSTER, see report =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Hospital industry association — healthcare PROVIDER/system, not a pharma manufacturer or health insurer per the category''s stated scope; flagged as a possible methodology question (broaden pharma_health_insurance to include providers, or keep payer/manufacturer-specific).' WHERE fec_committee_id='C00106146';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Optometrist professional association — healthcare PROVIDER, not pharma/insurer; same provider-vs-payer flag.' WHERE fec_committee_id='C00024968';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Dentist professional association — healthcare PROVIDER, not pharma/insurer; same provider-vs-payer flag.' WHERE fec_committee_id='C00000729';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Physician professional association (AMA) — healthcare PROVIDER, not pharma/insurer; same provider-vs-payer flag.' WHERE fec_committee_id='C00000422';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Dermatologist professional association (SKINPAC) — healthcare PROVIDER, not pharma/insurer; same provider-vs-payer flag.' WHERE fec_committee_id='C00359539';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Anesthesiologist professional association — healthcare PROVIDER, not pharma/insurer; same provider-vs-payer flag.' WHERE fec_committee_id='C00255752';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Orthopaedic surgeon professional association (AAOS) — healthcare PROVIDER, not pharma/insurer; same provider-vs-payer flag.' WHERE fec_committee_id='C00343137';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Nurse anesthetist professional association — healthcare PROVIDER, not pharma/insurer; same provider-vs-payer flag.' WHERE fec_committee_id='C00173153';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Dialysis/kidney care provider (DaVita) — healthcare PROVIDER company, not pharma manufacturer or insurer; same provider-vs-payer flag.' WHERE fec_committee_id='C00340943';

-- ===== REVIEWED, NO FIT: life/general insurance (NOT health-specific) — FLAGGED CLUSTER, see report =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Life insurance company (New York Life) — life insurance specifically, not health insurance; flagged as possible methodology question (broaden to general "insurance industry," or keep health-specific).' WHERE fec_committee_id='C00158881';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Life insurance industry trade association (ACLI) — life/annuity focus, not health insurance specifically; same insurance-scope flag.' WHERE fec_committee_id='C00147066';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Life insurance company (MassMutual) — life insurance, not health-specific; same insurance-scope flag.' WHERE fec_committee_id='C00118943';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='General insurance agents/brokers trade association, multi-line (not health-specific) — same insurance-scope flag.' WHERE fec_committee_id='C00039578';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='General insurance agents/brokers trade association (INSURPAC), multi-line — same insurance-scope flag.' WHERE fec_committee_id='C00022343';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Property/casualty insurance industry association — not health insurance; same insurance-scope flag.' WHERE fec_committee_id='C00066472';

-- ===== REVIEWED, NO FIT: legal advocacy / retiree advocacy =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Trial lawyers association (American Association for Justice) — legal profession advocacy, no fitting category among current 9.' WHERE fec_committee_id='C00024521';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Federal employee/retiree advocacy organization (NARFE) — member-advocacy nonprofit, not clearly industry money nor a clean labor-union fit; flagged as a possible other_positive candidate for future methodology discussion, not classified without clearer criteria.' WHERE fec_committee_id='C00091561';

-- ===== REVIEWED, NO FIT: not industry money at all (candidate/leadership/caucus/conduit) =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Candidate/personal campaign committee, not an industry PAC.' WHERE fec_committee_id='C00822767';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Congressional caucus leadership fund (New Democrat Coalition), not industry money.' WHERE fec_committee_id='C00409730';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Congressional caucus leadership fund (House Freedom Caucus), not industry money.' WHERE fec_committee_id='C00552851';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='FEC-confirmed Leadership PAC (designation_full=Leadership PAC, organization_type=None), despite defense-sounding name — verified NOT industry-affiliated, not classified into surveillance_weapons without real evidence.' WHERE fec_committee_id='C00749481';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='FEC-confirmed Unauthorized/general political committee (organization_type=None), not industry-affiliated despite name.' WHERE fec_committee_id='C00639229';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='FEC-confirmed Leadership PAC, not industry-affiliated.' WHERE fec_committee_id='C00693796';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='FEC-confirmed Leadership PAC (member personal-brand PAC), not industry-affiliated.' WHERE fec_committee_id='C00563726';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='FEC-confirmed Lobbyist/Registrant PAC (organization_type=None) — a lobbying-firm-associated committee, not tied to one specific industry.' WHERE fec_committee_id='C00451153';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Name pattern suggests leadership/ideological PAC, not verified live due to rate limit this pass — needs individual FEC verification if revisited, not classified without confirmation.' WHERE fec_committee_id='C00623512';

-- ===== FLAGGED FOR SEPARATE INVESTIGATION, NOT A NORMAL CLASSIFICATION DECISION =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='ActBlue — a payment conduit/bundling platform, NOT an industry PAC. IMPORTANT: this session earlier fixed a real bug where ActBlue-conduited small-dollar INDIVIDUAL donations were being misattributed as PAC contributions via a wrong FEC filter (is_individual=false instead of line_number=F3-11C). ActBlue still appearing here at $16.3M/5,043 contributions in the PAC contributions table is worth investigating — may be residual pre-fix contamination in already-synced data rather than a new/different case. Flagged for the parent session to check whether that earlier fix was applied retroactively to existing rows or only to new syncs going forward.' WHERE fec_committee_id='C00401224';
