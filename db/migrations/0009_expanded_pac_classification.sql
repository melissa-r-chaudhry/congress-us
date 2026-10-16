-- Expanded PAC industry classification, ranked by total dollar volume among
-- currently-uncategorized committees across ALL members (not per-member),
-- Pareto-style: classify the biggest contributors first for maximum coverage
-- per unit of research effort. Every row sourced against FEC's committee
-- lookup API. Ambiguous/diversified/non-industry-fitting committees (banking,
-- tech, general retail, leadership PACs, party committees, ActBlue itself)
-- deliberately left `needs_review` rather than force-fit — see fork report
-- in businessventures/project_congress_us.md memory for the full reasoning
-- and the list of high-dollar committees explicitly NOT classified.

CREATE OR REPLACE FUNCTION _classify(p_committee_id TEXT, p_industry TEXT, p_note TEXT) RETURNS VOID AS $$
BEGIN
  UPDATE pac_committees
  SET industry_code = p_industry,
      classification_status = 'classified',
      classification_source_url = 'https://www.fec.gov/data/committee/' || p_committee_id || '/',
      classification_note = p_note,
      last_reviewed_date = CURRENT_DATE
  WHERE fec_committee_id = p_committee_id;
END;
$$ LANGUAGE plpgsql;

-- Oil & Gas
SELECT _classify('C00236489', 'oil_gas', 'Koch Industries PAC — diversified conglomerate, but oil refining/petrochemicals is a core, well-documented business line.');
SELECT _classify('C00513549', 'oil_gas', 'Phillips 66 — oil refining company PAC.');
SELECT _classify('C00109546', 'oil_gas', 'Valero Energy — oil refining company PAC.');
SELECT _classify('C00496307', 'oil_gas', 'Marathon Petroleum — oil refining company employee PAC.');

-- Surveillance / Weapons
SELECT _classify('C00097568', 'surveillance_weapons', 'RTX Corporation (Raytheon) employee PAC — confirmed via FEC committee lookup as a Corporation-type PAC; major defense contractor.');
SELECT _classify('C00546234', 'surveillance_weapons', 'Leidos — major defense/intelligence/government-IT contractor PAC.');
SELECT _classify('C00100321', 'surveillance_weapons', 'L3Harris Technologies — major defense electronics/communications contractor PAC.');
SELECT _classify('C00096156', 'surveillance_weapons', 'Honeywell International "Technologies Public Affairs Council" — confirmed via FEC as a Corporation PAC; diversified industrial, but Aerospace/Defense is a major identifiable segment.');
SELECT _classify('C00215285', 'surveillance_weapons', 'General Atomics — defense/drone (Predator/Reaper) manufacturer PAC.');
SELECT _classify('C00281212', 'surveillance_weapons', 'BAE Systems USA — major defense contractor PAC.');
SELECT _classify('C00103549', 'surveillance_weapons', 'Parsons Corporation — defense/intelligence/critical-infrastructure contractor PAC.');
SELECT _classify('C00024869', 'surveillance_weapons', 'GE Aerospace — jet engine manufacturer with substantial military engine contracts; recently spun off as standalone company.');
SELECT _classify('C00383992', 'surveillance_weapons', 'Peraton Corp. — major defense/intelligence contractor PAC.');

-- Pharma / Health Insurance
SELECT _classify('C00082792', 'pharma_health_insurance', 'Eli Lilly and Company — major pharmaceutical manufacturer PAC.');
SELECT _classify('C00396895', 'pharma_health_insurance', 'Gilead Sciences — major pharmaceutical manufacturer PAC.');
SELECT _classify('C00010983', 'pharma_health_insurance', 'Johnson & Johnson — major pharmaceutical/health products manufacturer PAC.');
SELECT _classify('C00430256', 'pharma_health_insurance', 'Molina Healthcare — health insurer (Medicaid managed care) PAC.');
SELECT _classify('C00536573', 'pharma_health_insurance', 'AbbVie — major pharmaceutical manufacturer PAC.');
SELECT _classify('C00251876', 'pharma_health_insurance', 'Amgen — major pharmaceutical/biotech manufacturer PAC.');
SELECT _classify('C00040279', 'pharma_health_insurance', 'Abbott Laboratories — major pharmaceutical/health products manufacturer PAC.');
SELECT _classify('C00271007', 'pharma_health_insurance', 'Humana — major health insurer PAC.');
SELECT _classify('C00035675', 'pharma_health_insurance', 'Bristol-Myers Squibb — major pharmaceutical manufacturer PAC.');
SELECT _classify('C00332833', 'pharma_health_insurance', 'Cardinal Health — major pharmaceutical distributor/wholesaler PAC.');

-- Guns / Gambling / Alcohol / Vice
SELECT _classify('C00144766', 'vice_guns_gambling_alcohol', 'National Beer Wholesalers Association — alcohol industry trade PAC.');
SELECT _classify('C00089136', 'vice_guns_gambling_alcohol', 'Altria Group — tobacco company PAC (Marlboro), a classic vice industry.');
SELECT _classify('C00480863', 'vice_guns_gambling_alcohol', 'National Shooting Sports Foundation — firearms industry trade PAC.');
SELECT _classify('C00147173', 'vice_guns_gambling_alcohol', 'Wine and Spirits Wholesalers of America — alcohol industry trade PAC.');

-- Labor Union (positive)
SELECT _classify('C00011114', 'labor_union', 'AFSCME PEOPLE — major public-employee labor union PAC.');
SELECT _classify('C00035451', 'labor_union', 'Air Line Pilots Association — airline pilots union PAC.');
SELECT _classify('C00029504', 'labor_union', 'International Union of Operating Engineers (EPEC) — labor union PAC.');
SELECT _classify('C00002469', 'labor_union', 'International Association of Machinists — labor union PAC.');
SELECT _classify('C00001016', 'labor_union', 'United Brotherhood of Carpenters and Joiners — labor union PAC.');
SELECT _classify('C00267849', 'labor_union', 'Allied Pilots Association — airline pilots union PAC.');
SELECT _classify('C00028860', 'labor_union', 'American Federation of Teachers, AFL-CIO COPE — labor union PAC.');
SELECT _classify('C00238725', 'labor_union', 'National Air Traffic Controllers Association (NATCA) — federal-employee labor union PAC.');
SELECT _classify('C00007542', 'labor_union', 'SMART (Sheet Metal, Air, Rail, Transportation Workers) — labor union PAC.');
SELECT _classify('C00007922', 'labor_union', 'LIUNA (Laborers'' International Union of North America) — labor union PAC.');
SELECT _classify('C00029447', 'labor_union', 'International Association of Fire Fighters — labor union PAC.');
SELECT _classify('C00032979', 'labor_union', 'D.R.I.V.E. — the PAC of the International Brotherhood of Teamsters, labor union.');
SELECT _classify('C00027342', 'labor_union', 'International Brotherhood of Electrical Workers — labor union PAC.');
SELECT _classify('C00003251', 'labor_union', 'NEA Fund for Children and Public Education — National Education Association, labor union PAC.');
SELECT _classify('C00032995', 'labor_union', 'Amalgamated Transit Union COPE — labor union PAC.');
SELECT _classify('C00008268', 'labor_union', 'Transport Workers Union of America — labor union PAC.');
SELECT _classify('C00072025', 'labor_union', 'National Rural Letter Carriers'' Association — postal workers labor union PAC.');
SELECT _classify('C00023580', 'labor_union', 'National Association of Letter Carriers Political Fund — postal workers labor union PAC.');
SELECT _classify('C00012476', 'labor_union', 'United Association of Plumbers & Pipefitters — labor union PAC.');
SELECT _classify('C00027359', 'labor_union', 'International Association of Bridge, Structural, Ornamental & Reinforcing Iron Workers (IPAL) — labor union PAC.');
SELECT _classify('C00002766', 'labor_union', 'United Food and Commercial Workers Active Ballot Club — labor union PAC.');
SELECT _classify('C00002089', 'labor_union', 'Communications Workers of America COPE — labor union PAC.');
SELECT _classify('C00001636', 'labor_union', 'SMART Transportation Division PAC — labor union PAC.');
SELECT _classify('C00010322', 'labor_union', 'American Postal Workers Union COPA — labor union PAC.');
SELECT _classify('C00000885', 'labor_union', 'International Union of Painters & Allied Trades — labor union PAC.');
SELECT _classify('C00107128', 'labor_union', 'National Treasury Employees Union — federal-employee labor union PAC.');
SELECT _classify('C00009936', 'labor_union', 'American Federation of Government Employees — federal-employee labor union PAC.');
SELECT _classify('C00383950', 'labor_union', 'National Elevator Constructors — labor union PAC.');
SELECT _classify('C00002840', 'labor_union', 'UAW-V-CAP — United Auto Workers, labor union PAC.');
SELECT _classify('C00003590', 'labor_union', 'United Steel Workers Political Action Fund — labor union PAC.');
SELECT _classify('C00360669', 'labor_union', 'Southwest Airlines Pilots Association (SWAPA) — airline pilots union PAC.');

DROP FUNCTION _classify(TEXT, TEXT, TEXT);
