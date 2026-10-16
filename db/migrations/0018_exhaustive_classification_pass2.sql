-- Exhaustive PAC classification, pass 2 (dollar-rank #81-160).

-- ===== CLASSIFIED: wall_street_banking_finance =====
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='Capital Group Companies (American Funds) — major investment management firm.' WHERE fec_committee_id='C00540518';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='Independent Community Bankers of America — community banking industry trade association.' WHERE fec_committee_id='C00032698';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='Securities Industry and Financial Markets Association (SIFMA) — securities/financial industry trade association.' WHERE fec_committee_id='C00431312';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='USAA — diversified financial services company (banking, insurance, investments) for military community; primary identity as financial services firm.' WHERE fec_committee_id='C00164145';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='Truist Financial Corporation (formerly SunTrust) — major bank.' WHERE fec_committee_id='C00386524';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='Managed Funds Association — hedge fund industry trade association.' WHERE fec_committee_id='C00306894';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='Edward Jones — major investment/brokerage firm.' WHERE fec_committee_id='C00410407';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='LPL Financial — major independent broker-dealer/wealth management firm.' WHERE fec_committee_id='C00486217';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='Vanguard — major investment management firm.' WHERE fec_committee_id='C00410266';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='Small Business Investor Alliance — private equity/investment industry trade association.' WHERE fec_committee_id='C00109991';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='Ally Financial — major bank/auto lender.' WHERE fec_committee_id='C00579540';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='FMR LLC (Fidelity Investments) — major investment management firm.' WHERE fec_committee_id='C00380550';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='Thrivent Financial for Lutherans — financial services organization (insurance/investments), faith-based fraternal structure but genuinely a financial services firm.' WHERE fec_committee_id='C00121319';
UPDATE pac_committees SET classification_status='classified', industry_code='wall_street_banking_finance', classification_note='National Association of Real Estate Investment Trusts (Nareit) — REITs are securities/investment vehicles, closer to investment industry than direct real estate brokerage/homebuilding (which were left uncategorized).' WHERE fec_committee_id='C00303339';

-- ===== CLASSIFIED: big_tech_crypto =====
UPDATE pac_committees SET classification_status='classified', industry_code='big_tech_crypto', classification_note='Samsung Electronics America — major global consumer electronics/technology manufacturer.' WHERE fec_committee_id='C00590315';
UPDATE pac_committees SET classification_status='classified', industry_code='big_tech_crypto', classification_note='NCTA - The Internet & Television Association — explicitly "Internet" in its official name/mission (rebranded from cable-only framing); distinguished from pure telecom carriers (AT&T/Verizon/Charter, left uncategorized) by its internet-industry policy focus.' WHERE fec_committee_id='C00010082';

-- ===== CLASSIFIED: surveillance_weapons =====
UPDATE pac_committees SET classification_status='classified', industry_code='surveillance_weapons', classification_note='SAIC (Science Applications International Corporation) — major government IT/cybersecurity/defense-technology contractor, same business category as previously-classified Leidos/L3Harris/Peraton.' WHERE fec_committee_id='C00300418';
UPDATE pac_committees SET classification_status='classified', industry_code='surveillance_weapons', classification_note='Booz Allen Hamilton — major government/defense/intelligence consulting and technology services firm, same business category as previously-classified Leidos/SAIC.' WHERE fec_committee_id='C00709816';

-- ===== CLASSIFIED: labor_union =====
UPDATE pac_committees SET classification_status='classified', industry_code='labor_union', classification_note='UNITE HERE — well-known hospitality/service-industry labor union.' WHERE fec_committee_id='C00004861';
UPDATE pac_committees SET classification_status='classified', industry_code='labor_union', classification_note='International Union of Bricklayers and Allied Craftworkers — construction trades labor union.' WHERE fec_committee_id='C00003632';
UPDATE pac_committees SET classification_status='classified', industry_code='labor_union', classification_note='NetJets Association of Shared Aircraft Pilots — represents pilot-employees collectively, functions as a labor union similar to ALPA; moderate confidence, not independently FEC-verified beyond name this pass.' WHERE fec_committee_id='C00488262';

-- ===== REVIEWED, NO FIT: medical/veterinary PROVIDER associations (same flagged cluster as pass 1) =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Thoracic surgeon professional association — healthcare PROVIDER, same provider-vs-payer flag as pass 1.' WHERE fec_committee_id='C00325936';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Emergency physician professional association (ACEP) — healthcare PROVIDER, same flag.' WHERE fec_committee_id='C00140061';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Nurse practitioner professional association — healthcare PROVIDER, same flag.' WHERE fec_committee_id='C00358903';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Radiology professional association — healthcare PROVIDER, same flag.' WHERE fec_committee_id='C00343459';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Veterinary medicine association — ANIMAL health, not human health/pharma; distinct reason from the provider cluster.' WHERE fec_committee_id='C00114132';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Surgeon professional association (ACS) — healthcare PROVIDER, same flag.' WHERE fec_committee_id='C00382424';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Cardiology professional association (HEARTPAC) — healthcare PROVIDER, same flag.' WHERE fec_committee_id='C00375360';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Orthodontist professional association — healthcare PROVIDER, same flag.' WHERE fec_committee_id='C00293910';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Physical therapy professional association — healthcare PROVIDER, same flag.' WHERE fec_committee_id='C00012880';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Oncology practice network — healthcare PROVIDER (practice/treatment network), same flag.' WHERE fec_committee_id='C00339655';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Independent/community pharmacist association — dispensing/retail pharmacy, provider-adjacent rather than pharma-manufacturer; borderline, left uncategorized pending methodology clarity on pharmacy vs. manufacturer scope.' WHERE fec_committee_id='C00030809';

-- ===== REVIEWED, NO FIT: general/life insurance, NOT health-specific (same flagged cluster) =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Mutual property/casualty insurance trade association — not health insurance, same insurance-scope flag as pass 1.' WHERE fec_committee_id='C00170258';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Allstate — primarily auto/home/property insurer, not health insurance, same flag.' WHERE fec_committee_id='C00040253';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Liberty Mutual — primarily property/casualty insurer, not health insurance, same flag.' WHERE fec_committee_id='C00171843';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Northwestern Mutual — life insurance company, not health-specific, same flag.' WHERE fec_committee_id='C00197095';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Crop insurance industry association — agricultural insurance, not health, same flag.' WHERE fec_committee_id='C00503680';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Title insurance industry (real estate closing/settlement) — not health insurance, distinct sector.' WHERE fec_committee_id='C00012914';

-- ===== REVIEWED, NO FIT: electric utilities / energy (non-oil-gas, same flagged cluster) =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Electric utility company — same utilities-vs-oil/gas flag as pass 1 (National Rural Electric).' WHERE fec_committee_id='C00363879';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Electric utility/power generation company — same utilities flag.' WHERE fec_committee_id='C00793711';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Energy utility holding company with both gas and electric operations — mixed profile, more genuinely gas-adjacent than pure-electric peers but not confidently classified as oil_gas without closer review; flagged for revisit.' WHERE fec_committee_id='C00008748';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Electric utility company (AEP) — same utilities flag.' WHERE fec_committee_id='C00096842';

-- ===== REVIEWED, NO FIT: telecom (not "Big Tech" per pass-1 flag) =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Wireless telecom carrier (T-Mobile) — same telecom-vs-bigtech flag as pass 1.' WHERE fec_committee_id='C00361758';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Rural broadband/telecom cooperative association — same telecom-vs-bigtech flag.' WHERE fec_committee_id='C00004473';

-- ===== REVIEWED, NO FIT: agriculture/food (no fit) =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Rice industry trade association — agriculture, no fitting category.' WHERE fec_committee_id='C00308478';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Sugar beet farming cooperative — agriculture, no fitting category.' WHERE fec_committee_id='C00164939';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Food/meat processing company (Tyson) — no fitting category.' WHERE fec_committee_id='C00169821';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Corn growers trade association — agriculture, no fitting category.' WHERE fec_committee_id='C00376343';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Soybean growers trade association — agriculture, no fitting category.' WHERE fec_committee_id='C00408468';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Baking industry trade association — food industry, no fitting category.' WHERE fec_committee_id='C00016386';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Sugar company — agriculture, no fitting category.' WHERE fec_committee_id='C00326389';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Farm equipment manufacturer (John Deere) — no fitting category.' WHERE fec_committee_id='C00204099';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Fast food restaurant chain (McDonalds) — no fitting category.' WHERE fec_committee_id='C00063164';

-- ===== REVIEWED, NO FIT: manufacturing/industrial (no fit) =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Timber/forest products manufacturer — no fitting category.' WHERE fec_committee_id='C00007948';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Building materials manufacturer — no fitting category.' WHERE fec_committee_id='C00346353';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Steel manufacturer — no fitting category.' WHERE fec_committee_id='C00379628';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Engine/industrial equipment manufacturer — no fitting category.' WHERE fec_committee_id='C00377952';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Asphalt/paving industry trade association — no fitting category.' WHERE fec_committee_id='C00444539';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='HVAC contractors trade association — no fitting category.' WHERE fec_committee_id='C00013961';

-- ===== REVIEWED, NO FIT: aerospace/defense-diversified conglomerates — consistent with earlier session precedent =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Textron — diversified conglomerate (Bell helicopters, Cessna, defense systems segment); consistent with this session''s earlier documented decision to leave Textron uncategorized as defense revenue is real but not dominant enough of its diversified business.' WHERE fec_committee_id='C00123612';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Airbus Americas — commercial aerospace primarily; consistent with earlier session precedent leaving Airbus uncategorized (defense/military segment not dominant).' WHERE fec_committee_id='C00421230';

-- ===== REVIEWED, NO FIT: transportation/logistics/aviation (companies, not the pilots' union above) =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Airline — no fitting category.' WHERE fec_committee_id='C00101766';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Shipping/logistics company — no fitting category.' WHERE fec_committee_id='C00024752';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Package delivery company (FedEx) — no fitting category.' WHERE fec_committee_id='C00068692';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Car rental company — no fitting category.' WHERE fec_committee_id='C00219642';

-- ===== REVIEWED, NO FIT: real estate services (title, not investment vehicle) =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Senior housing industry trade association — real estate services, no fitting category.' WHERE fec_committee_id='C00325332';

-- ===== REVIEWED, NO FIT: professional services / accounting =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Big-4-adjacent accounting/professional-services firm (KPMG) — no fitting category, same as EY/Deloitte/PwC in pass 1.' WHERE fec_committee_id='C00280222';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='DC lobbying/law firm PAC (Holland & Knight) — professional services, no fitting category, same as pass-1 law-firm exclusion.' WHERE fec_committee_id='C00171330';

-- ===== REVIEWED, NO FIT: postal/government employee management associations (possible other_positive, not classified) =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Postal management/supervisor association — represents management-level employees, not a rank-and-file labor union; flagged as a possible other_positive candidate for future methodology discussion, not classified without clearer criteria (same flag as NARFE in pass 1).' WHERE fec_committee_id='C00100404';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Postal supervisor association — same management-vs-union flag as above.' WHERE fec_committee_id='C00092957';

-- ===== REVIEWED, NO FIT: not industry money (candidate/leadership/reform-advocacy) =====
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Candidate committee (Jim Jordan for Congress), not an industry PAC.' WHERE fec_committee_id='C00416594';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Campaign-finance-reform advocacy PAC (End Citizens United) — reform advocacy group, not an industry PAC.' WHERE fec_committee_id='C00573261';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Name indicates partisan leadership PAC ("Electing Majority Making Effective Republicans"), not industry-affiliated.' WHERE fec_committee_id='C00592089';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Name indicates leadership/motivational-branded PAC ("The Eye of the Tiger"), likely leadership PAC based on naming convention; not individually FEC-verified this pass.' WHERE fec_committee_id='C00467431';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Name indicates leadership PAC ("Supporting Electing American Leaders"), not industry-affiliated.' WHERE fec_committee_id='C00570226';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Name indicates a state-based leadership/campaign PAC ("Working for Ohio"), not industry-affiliated; not individually FEC-verified this pass.' WHERE fec_committee_id='C00783167';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Name indicates explicitly partisan leadership PAC ("Republicans United to Defend You"), not industry-affiliated.' WHERE fec_committee_id='C00823351';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Name indicates likely party-leadership PAC ("Majority Committee PAC"), not industry-affiliated; not individually FEC-verified this pass.' WHERE fec_committee_id='C00428052';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Ambiguous generic name, no clear industry signal; not individually FEC-verified this pass due to rate limiting — needs verification if revisited.' WHERE fec_committee_id='C00817338';
UPDATE pac_committees SET classification_status='reviewed_no_fit', classification_note='Ambiguous generic name, no clear industry signal; not individually FEC-verified this pass due to rate limiting — needs verification if revisited.' WHERE fec_committee_id='C00517235';
