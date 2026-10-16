-- Bootstrap PAC industry classifications: major, well-known organizations per industry,
-- verified via FEC's own committee search (/v1/committees/?q=...) on 2026-07-24.
-- Not exhaustive — coverage grows over time as more committees sync and get reviewed;
-- anything not classified stays 'needs_review' (weight 0), never silently negative.

INSERT INTO pac_committees (fec_committee_id, committee_name, industry_code, classification_status, classification_source_url, classification_note, last_reviewed_date) VALUES
-- Oil & Gas
('C00121368', 'EXXON MOBIL CORPORATION POLITICAL ACTION COMMITTEE', 'oil_gas', 'classified', 'https://www.fec.gov/data/committee/C00121368/', 'ExxonMobil corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00035006', 'CHEVRON EMPLOYEES POLITICAL ACTION COMMITTEE', 'oil_gas', 'classified', 'https://www.fec.gov/data/committee/C00035006/', 'Chevron corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00112896', 'CONOCOPHILLIPS SPIRIT PAC', 'oil_gas', 'classified', 'https://www.fec.gov/data/committee/C00112896/', 'ConocoPhillips corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00483677', 'AMERICAN PETROLEUM INSTITUTE POLITICAL ACTION COMMITTEE', 'oil_gas', 'classified', 'https://www.fec.gov/data/committee/C00483677/', 'API industry trade association PAC, verified via FEC committee search', '2026-07-24'),
-- Surveillance / Weapons
('C00303024', 'LOCKHEED MARTIN CORPORATION EMPLOYEES'' POLITICAL ACTION COMMITTEE', 'surveillance_weapons', 'classified', 'https://www.fec.gov/data/committee/C00303024/', 'Lockheed Martin corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00035683', 'RAYTHEON TECHNOLOGIES CORPORATION PAC', 'surveillance_weapons', 'classified', 'https://www.fec.gov/data/committee/C00035683/', 'RTX/Raytheon corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00088591', 'EMPLOYEES OF NORTHROP GRUMMAN CORPORATION PAC', 'surveillance_weapons', 'classified', 'https://www.fec.gov/data/committee/C00088591/', 'Northrop Grumman corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00078451', 'GENERAL DYNAMICS CORPORATION POLITICAL ACTION COMMITTEE', 'surveillance_weapons', 'classified', 'https://www.fec.gov/data/committee/C00078451/', 'General Dynamics corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00142711', 'THE BOEING COMPANY PAC', 'surveillance_weapons', 'classified', 'https://www.fec.gov/data/committee/C00142711/', 'Boeing corporate PAC (defense division), verified via FEC committee search', '2026-07-24'),
-- Pharma / Health Insurance
('C00021972', 'PHARMACEUTICAL RESEARCH & MANUFACTURERS OF AMERICA BETTER GOVERNMENT COMMITTEE', 'pharma_health_insurance', 'classified', 'https://www.fec.gov/data/committee/C00021972/', 'PhRMA industry trade association PAC, verified via FEC committee search', '2026-07-24'),
('C00016683', 'PFIZER INC. PAC', 'pharma_health_insurance', 'classified', 'https://www.fec.gov/data/committee/C00016683/', 'Pfizer corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00274431', 'UNITEDHEALTH GROUP INCORPORATED PAC', 'pharma_health_insurance', 'classified', 'https://www.fec.gov/data/committee/C00274431/', 'UnitedHealth Group corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00197228', 'ELEVANCE HEALTH, INC. POLITICAL ACTION COMMITTEE', 'pharma_health_insurance', 'classified', 'https://www.fec.gov/data/committee/C00197228/', 'Elevance Health (formerly Anthem) corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00085316', 'THE CIGNA GROUP EMPLOYEE POLITICAL ACTION COMMITTEE', 'pharma_health_insurance', 'classified', 'https://www.fec.gov/data/committee/C00085316/', 'Cigna corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00384818', 'CVS HEALTH PAC', 'pharma_health_insurance', 'classified', 'https://www.fec.gov/data/committee/C00384818/', 'CVS Health (incl. Aetna) corporate PAC, verified via FEC committee search', '2026-07-24'),
-- AIPAC-aligned (pro-Israel lobby network — per TrackAIPAC's treatment of AIPAC as a synecdoche for the broader network, not just AIPAC's own name)
('C00247403', 'NORPAC', 'aipac_aligned', 'classified', 'https://www.fec.gov/data/committee/C00247403/', 'NORPAC — major AIPAC-affiliated pro-Israel bundling PAC, verified via FEC committee search', '2026-07-24'),
('C00797670', 'AMERICAN ISRAEL PUBLIC AFFAIRS COMMITTEE POLITICAL ACTION COMMITTEE', 'aipac_aligned', 'classified', 'https://www.fec.gov/data/committee/C00797670/', 'AIPAC''s own directly-named PAC, verified via FEC committee search', '2026-07-24'),
('C00699470', 'PRO-ISRAEL AMERICA PAC', 'aipac_aligned', 'classified', 'https://www.fec.gov/data/committee/C00699470/', 'Pro-Israel America PAC, verified via FEC committee search', '2026-07-24'),
-- Guns / Gambling / Alcohol / Vice
('C00053553', 'NATIONAL RIFLE ASSOCIATION OF AMERICA POLITICAL VICTORY FUND', 'vice_guns_gambling_alcohol', 'classified', 'https://www.fec.gov/data/committee/C00053553/', 'NRA''s federal PAC, verified via FEC committee search', '2026-07-24'),
('C00419051', 'SMITH & WESSON BRANDS, INC. POLITICAL ACTION COMMITTEE', 'vice_guns_gambling_alcohol', 'classified', 'https://www.fec.gov/data/committee/C00419051/', 'Smith & Wesson corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00299321', 'MGM RESORTS INTERNATIONAL PAC', 'vice_guns_gambling_alcohol', 'classified', 'https://www.fec.gov/data/committee/C00299321/', 'MGM Resorts (gaming) corporate PAC, verified via FEC committee search', '2026-07-24'),
('C00034488', 'ANHEUSER-BUSCH COMPANIES LLC POLITICAL ACTION COMMITTEE', 'vice_guns_gambling_alcohol', 'classified', 'https://www.fec.gov/data/committee/C00034488/', 'Anheuser-Busch corporate PAC, verified via FEC committee search', '2026-07-24'),
-- Labor Union (positive)
('C00003806', 'AFL-CIO COPE POLITICAL CONTRIBUTIONS COMMITTEE', 'labor_union', 'classified', 'https://www.fec.gov/data/committee/C00003806/', 'National AFL-CIO PAC, verified via FEC committee search', '2026-07-24'),
('C00004036', 'SEIU COPE (SERVICE EMPLOYEES INTERNATIONAL UNION COMMITTEE ON POLITICAL EDUCATION)', 'labor_union', 'classified', 'https://www.fec.gov/data/committee/C00004036/', 'National SEIU PAC, verified via FEC committee search', '2026-07-24')
ON CONFLICT (fec_committee_id) DO UPDATE SET
  industry_code = EXCLUDED.industry_code, classification_status = EXCLUDED.classification_status,
  classification_source_url = EXCLUDED.classification_source_url, classification_note = EXCLUDED.classification_note,
  last_reviewed_date = EXCLUDED.last_reviewed_date;
