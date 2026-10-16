-- Exhaustive PAC classification pass 9. All classifications verified live via
-- FEC committee lookup (api.open.fec.gov) before assignment, per established
-- session standard: no classification from name pattern alone.

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00252684/', classification_note = 'Cambia Health Solutions Inc. PAC — confirmed real regional (Pacific NW) Blue Cross Blue Shield-affiliated health insurer via FEC record.'
  WHERE fec_committee_id = 'C00252684';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00183962/', classification_note = 'Cadence Bank PAC — confirmed real regional bank via FEC record.'
  WHERE fec_committee_id = 'C00183962';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00441733/', classification_note = 'Takeda Pharmaceuticals America PAC — confirmed major pharmaceutical manufacturer via FEC record.'
  WHERE fec_committee_id = 'C00441733';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00007450/', classification_note = 'American Gas Association PAC — natural gas utility/distribution industry trade group; fits oil_gas category description ("...and distribution").'
  WHERE fec_committee_id = 'C00007450';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00004325/', classification_note = 'Seafarers International Union PAC — confirmed "Labor Organization" via live FEC lookup.'
  WHERE fec_committee_id = 'C00004325';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00073056/', classification_note = 'Masters, Mates and Pilots Political Contribution Fund — confirmed "Labor Organization" via live FEC lookup.'
  WHERE fec_committee_id = 'C00073056';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'labor_union',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00251009/', classification_note = 'United Pilots PAC/United Airlines Master Executive Council — confirmed "Labor Organization" via live FEC lookup.'
  WHERE fec_committee_id = 'C00251009';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'other_positive',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00436188/', classification_note = 'Alliance for Retired Americans Political Action Fund — genuine senior/retiree advocacy membership organization, same logic as other classified public-interest advocacy PACs (League of Conservation Voters, Environmental Defense Action Fund).'
  WHERE fec_committee_id = 'C00436188';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00640243/', classification_note = 'LSEG (London Stock Exchange Group) US Holdco Inc. PAC — financial-markets infrastructure company, same category as already-classified CME Group/DTCC/Options Clearing Corp.'
  WHERE fec_committee_id = 'C00640243';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00379768/', classification_note = 'Experian North America PAC — major credit bureau; core financial-services infrastructure (credit reporting/scoring for the banking and lending industry).'
  WHERE fec_committee_id = 'C00379768';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00177469/', classification_note = 'PG&E Corporation Employees EnergyPAC — confirmed real electric/gas utility via FEC record. Part of the recurring electric-utilities cluster with no fitting category among current 9 (flagged to Melissa across multiple passes).'
  WHERE fec_committee_id = 'C00177469';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00311878/', classification_note = 'Medtronic Inc. PAC — medical device manufacturer, not a pharmaceutical manufacturer or health insurer; same treatment as Boston Scientific/Smith & Nephew (already reviewed_no_fit).'
  WHERE fec_committee_id = 'C00311878';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00457234/', classification_note = 'Marsh & McLennan Companies PAC — insurance brokerage/risk-management/consulting firm, general (non-health) insurance; part of the recurring general/life-insurance cluster with no fitting category.'
  WHERE fec_committee_id = 'C00457234';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00754648/', classification_note = 'GRAIL, Inc. PAC — cancer-diagnostics/biotech company, not a pharmaceutical manufacturer or health insurer.'
  WHERE fec_committee_id = 'C00754648';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00017525/', classification_note = 'American Nurses Association PAC — confirmed "Trade Association" via FEC record; healthcare-provider professional association, part of the recurring cluster with no fitting category.'
  WHERE fec_committee_id = 'C00017525';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00327189/', classification_note = 'Value in Electing Women PAC — candidate-election advocacy organized around gender representation, not industry-aligned money; does not map cleanly to any of the current 9 categories.'
  WHERE fec_committee_id = 'C00327189';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00225342/', classification_note = 'McGuireWoods Federal PAC — law firm PAC, same treatment as other classified law firms this session (K&L Gates, Akin Gump, Squire Patton Boggs, etc.).'
  WHERE fec_committee_id = 'C00225342';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00211037/', classification_note = 'Alabama Peanut Producers Association PeanutPAC — confirmed "Trade Association" via FEC record; agriculture, no fitting category.'
  WHERE fec_committee_id = 'C00211037';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00374447/', classification_note = 'AECOM PAC — diversified engineering/infrastructure/construction firm; defense-sector revenue real but not dominant, same treatment as Textron/Dow/SpaceX/Blue Origin.'
  WHERE fec_committee_id = 'C00374447';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00238204/', classification_note = 'Pakistani American Public Affairs Committee (PAK-PAC) — ethnic/foreign-policy community advocacy organization, does not map to any current industry category.'
  WHERE fec_committee_id = 'C00238204';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00098061/', classification_note = 'Target Corporation Citizens Political Forum — confirmed Corporation via FEC record; general retail, no fitting category.'
  WHERE fec_committee_id = 'C00098061';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00257329/', classification_note = 'The Procter & Gamble Company Good Government Fund — confirmed Corporation via FEC record; consumer packaged goods, no fitting category.'
  WHERE fec_committee_id = 'C00257329';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00672733/', classification_note = 'Bulldog PAC — confirmed Leadership PAC via live FEC lookup (designation_full="Leadership PAC"), not industry money.'
  WHERE fec_committee_id = 'C00672733';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00859538/', classification_note = 'ALSOPAC — confirmed leadership_pac flag set via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00859538';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00689208/', classification_note = 'RVFPAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00689208';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00693002/', classification_note = 'Fox Corporation PAC — confirmed real media company via FEC record; part of the recurring telecom/media cluster with no fitting category.'
  WHERE fec_committee_id = 'C00693002';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00365270/', classification_note = 'M-PAC — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00365270';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00574921/', classification_note = 'Ryan LLC Political Action Committee — tax consulting/advisory firm, no fitting category.'
  WHERE fec_committee_id = 'C00574921';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00761957/', classification_note = 'In Our Hands — confirmed Leadership PAC via live FEC lookup, not industry money.'
  WHERE fec_committee_id = 'C00761957';
