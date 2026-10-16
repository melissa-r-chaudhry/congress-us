-- Fixes a real data-integrity bug found 2026-07-28: payment-processing conduit committees
-- (ActBlue, WinRed) were being written into pac_contributions as if they were real PAC money.
-- Confirmed via FEC's own committee record: both are "Hybrid PAC (with Non-Contribution
-- Account) - Nonqualified" / "Unauthorized" entities -- real FEC registrations, but functionally
-- payment conduits for individually-earmarked small-dollar donations, not independent PAC
-- political spending. Scoring impact: refresh_member_scores()'s negative_pac_total/
-- positive_pac_total were NOT affected (they correctly exclude uncategorized-industry money),
-- but pac_total_amount (used by the new people_pac_ratio feature) summed ALL pac_contributions
-- with no polarity filter, so this conduit money was double-counting real grassroots giving
-- against members as if it were PAC money -- making anyone with substantial ActBlue/WinRed
-- funding look artificially more PAC-dependent than reality.

ALTER TABLE pac_committees ADD COLUMN is_conduit BOOLEAN NOT NULL DEFAULT false;

UPDATE pac_committees SET is_conduit = true, classification_note = 'Payment-processing conduit for earmarked individual donations (Hybrid PAC/Unauthorized per FEC) -- not real PAC money, excluded from pac_contributions going forward'
WHERE fec_committee_id IN ('C00401224', 'C00714725', 'C00694323');

DELETE FROM pac_contributions WHERE fec_committee_id IN ('C00401224', 'C00714725', 'C00694323');
