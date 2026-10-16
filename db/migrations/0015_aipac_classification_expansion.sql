-- AIPAC-aligned PAC classification expansion, triggered by Melissa catching a real
-- gap (Sen. Fetterman's profile showed zero AIPAC-aligned funding despite a $1.9M
-- uncategorized PAC pile containing real pro-Israel-lobby committees).
--
-- Each classification below is evidence-based (web search corroborating actual stated
-- mission, not name pattern alone). Several plausible-looking candidates were
-- investigated and deliberately REJECTED — see notes at bottom.

UPDATE pac_committees SET
  industry_code = 'aipac_aligned',
  classification_status = 'classified',
  classification_source_url = 'https://en.wikipedia.org/wiki/Joint_Action_Committee_for_Political_Affairs',
  classification_note = 'Founded 1981; explicit stated purpose is electing Congress members who support a strong US-Israel relationship and oppose BDS. Confirmed via Wikipedia + jacpac.org "About"/"Issues" pages.'
WHERE fec_committee_id = 'C00139659'; -- JOINT ACTION COMMITTEE FOR POLITICAL AFFAIRS (JAC)

UPDATE pac_committees SET
  industry_code = 'aipac_aligned',
  classification_status = 'classified',
  classification_source_url = 'https://www.fec.gov/data/committee/C00127811/',
  classification_note = 'Name itself explicit; independently confirmed via usisraelpac.org "supports members of Congress who have a positive voting record on pro-Israel issues."'
WHERE fec_committee_id = 'C00127811'; -- U.S. ISRAEL PAC (USI PAC)

UPDATE pac_committees SET
  industry_code = 'aipac_aligned',
  classification_status = 'classified',
  classification_source_url = 'https://www.influencewatch.org/non-profit/republican-jewish-coalition/',
  classification_note = 'RJC-PAC "funds pro-Israel Republican candidates"; parent org places "interventionist and Israel-centric U.S. foreign policy at the heart of its advocacy." Confirmed via InfluenceWatch + Militarist Monitor.'
WHERE fec_committee_id = 'C00345132'; -- REPUBLICAN JEWISH COALITION-PAC (RJC-PAC)

UPDATE pac_committees SET
  industry_code = 'aipac_aligned',
  classification_status = 'classified',
  classification_source_url = 'https://en.wikipedia.org/wiki/Democratic_Majority_for_Israel',
  classification_note = 'Explicit single-issue mission: "maintain the pro-Israel stance of the Democratic party," electing/protecting pro-Israel Democrats. Confirmed via Wikipedia + demmajorityforisrael.org.'
WHERE fec_committee_id = 'C00710848'; -- DMFI PAC

UPDATE pac_committees SET
  industry_code = 'aipac_aligned',
  classification_status = 'classified',
  classification_source_url = 'https://www.opensecrets.org/pacs/lookup2.php?strID=C00141747',
  classification_note = 'OpenSecrets categorizes as a Pro-Israel organization; registered 1981, appears alongside other established pro-Israel PACs in campaign finance tracking.'
WHERE fec_committee_id = 'C00141747'; -- FRIENDS OF ISRAEL PAC (FIPAC)

-- Deliberately NOT classified, investigated and rejected with real evidence:
--   TZEDEK PAC (C00770511) — own stated mission is humanitarian aid, criminal justice
--     reform, religious rights broadly. NOT a pro-Israel-lobby PAC despite Hebrew name.
--   CHUTZ PAC (C00834762) — Rep. Ritchie Torres' personal Leadership PAC, not an
--     issue-focused committee; leadership PACs are excluded from industry classification
--     per this project's existing standard (same reasoning as other leadership PACs).
--   BEND THE ARC JEWISH ACTION PAC (C00573253) — confirmed via press coverage the PAC
--     was explicitly founded to focus on US domestic issues "rather than Israel";
--     the opposite of a pro-Israel-lobby committee despite "Jewish" in the name.
--   DEMOCRATIC JEWISH OUTREACH PA (C00563254) — general Jewish-Democratic civic
--     engagement PAC (reproductive rights, gun violence, environment, education);
--     "support of Israel" is one of several listed values, not the PAC's primary or
--     singular purpose. Judgment call: too broad-mission to classify as AIPAC-aligned
--     specifically — revisit if evidence emerges its actual giving pattern is Israel-focused.
--   ZIONS BANCORPORATION PAC (C00275230) — a real US regional bank holding company
--     (Utah-based, name reflects founding heritage, unrelated to the State of Israel);
--     false positive caught by a naive keyword search, correctly excluded.
--   Also investigated and correctly excluded as unrelated despite matching search terms:
--     Edison International PAC, Safari Club International PAC, National Association of
--     Chain Drug Stores PAC, CDM Smith National PAC, Service Corporation International PAC.
