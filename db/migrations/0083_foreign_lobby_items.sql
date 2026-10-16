-- 2026-08-25: "Foreign Lobby Independence" -- factor 4 of Melissa's revised architecture.
-- Composite score (AIPAC-aligned PAC money [already exists] + PEACE Pledge signed) computed the
-- same way as the other factors; two real, sourced, itemized votes/cosponsorships shown
-- separately (NOT feeding the composite, NOT feeding the 80% Bill alignment score either --
-- see the contributes_to_score fix below) so voters can see the real record without the site
-- picking a side on a live foreign-policy dispute. Section 219/224 (FY27 NDAA's US-Israel
-- Defense Technology Cooperation Initiative, H.R. 8800) is shown as an informational item only --
-- researched live 2026-08-25 and confirmed it was only decided via voice-voted amendments, no
-- roll call specific to this provision exists, so no per-member signal is attributed to it at
-- all (the omnibus final-passage vote, 216-212, would misattribute unrelated NDAA politics to
-- individual members -- deliberately not used as a proxy).

-- BUG FIX: contributes_to_score existed on tracked_items since the original schema but was never
-- actually joined/filtered in refresh_member_scores.sql's _alignment_raw CTE -- every tracked
-- item counted toward the 80% Bill score regardless of this flag. Fixing this in the function
-- (separate deploy) is what makes it safe to add the two items below without them silently
-- polluting the general alignment score.

INSERT INTO tracked_items (slug, title, short_description, item_type, category, contributes_to_score, display_order)
VALUES
  ('antisemitism-awareness-act', 'Antisemitism Awareness Act (IHRA definition)',
   'Would codify the International Holocaust Remembrance Alliance (IHRA) working definition of antisemitism into Title VI of the Civil Rights Act, for federal education-antidiscrimination enforcement. Real recorded House vote: 320-91 (118th Congress). Shown as part of the Foreign Lobby Independence record -- not counted toward the 80% Bill alignment score.',
   'bill_tracker', 'foreign_policy', false, 100),
  ('israel-anti-boycott-act', 'Israel Anti-Boycott Act (anti-BDS)',
   'Would bar U.S. citizens from participating in boycotts of Israel called for by international governmental organizations, with civil/criminal penalties. Never received a floor vote in any Congress it was introduced -- cosponsorship is the only real per-member signal available. Shown as part of the Foreign Lobby Independence record -- not counted toward the 80% Bill alignment score.',
   'bill_tracker', 'foreign_policy', false, 101)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO tracked_item_bills (tracked_item_id, congress_number, bill_type, bill_number, official_title, is_active, verification_status, source_url)
SELECT id, 118, 'hr', 6090, 'Antisemitism Awareness Act', true, 'verified',
       'https://api.congress.gov/v3/bill/118/hr/6090'
FROM tracked_items WHERE slug = 'antisemitism-awareness-act'
ON CONFLICT (congress_number, bill_type, bill_number) DO NOTHING;

INSERT INTO tracked_item_bills (tracked_item_id, congress_number, bill_type, bill_number, official_title, is_active, verification_status, source_url)
SELECT id, 117, 'hr', 6940, 'Israel Anti-Boycott Act', true, 'verified',
       'https://api.congress.gov/v3/bill/117/hr/6940'
FROM tracked_items WHERE slug = 'israel-anti-boycott-act'
ON CONFLICT (congress_number, bill_type, bill_number) DO NOTHING;

-- PEACE Pledge signatures -- manually seeded, real, sourced. Only 3 real signers found via live
-- research 2026-08-25 (pledge.trackaipac.com). Not a live-synced table yet (no automated scraper
-- built this pass) -- checked_at documents staleness honestly rather than implying live sync.
CREATE TABLE IF NOT EXISTS peace_pledge_signatures (
    bioguide_id TEXT PRIMARY KEY REFERENCES members(bioguide_id),
    signed_date DATE,
    source_url TEXT NOT NULL,
    checked_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Section 219/224 (FY27 NDAA, H.R. 8800) -- informational only, deliberately no per-member table.
-- Real, current, sourced fact for the /methodology and profile pages to reference in prose.
CREATE TABLE IF NOT EXISTS foreign_policy_context_notes (
    id SERIAL PRIMARY KEY,
    slug TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    source_url TEXT NOT NULL,
    checked_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO foreign_policy_context_notes (slug, title, body, source_url) VALUES
('ndaa-section-219-224',
 'FY27 NDAA Section 219 (originally 224): U.S.-Israel Defense Technology Cooperation Initiative',
 'H.R. 8800, the FY2027 National Defense Authorization Act, contains a provision (introduced as Section 224, later renumbered Section 219) establishing expanded U.S.-Israel military and intelligence cooperation. The House passed the full NDAA 216-212 on 2026-07-22, but this specific provision was only addressed through voice-voted floor amendments -- no roll-call vote exists specific to it. Because the bill''s final-passage vote reflects hundreds of unrelated provisions, we do not attribute it to individual members'' positions on this specific initiative -- there is currently no clean, single-issue record to show.',
 'https://api.congress.gov/v3/bill/119/hr/8800')
ON CONFLICT (slug) DO NOTHING;

-- Seed the 3 real PEACE Pledge signers found via live research.
INSERT INTO peace_pledge_signatures (bioguide_id, source_url)
SELECT bioguide_id, 'https://pledge.trackaipac.com/'
FROM members WHERE full_name ILIKE '%Khanna%' OR full_name ILIKE '%Tlaib%' OR full_name ILIKE '%Delia Ramirez%'
ON CONFLICT (bioguide_id) DO NOTHING;
