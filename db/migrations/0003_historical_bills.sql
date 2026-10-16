-- Historical Congress records, needed for the 3-congress trailing window on People-Alignment
-- scoring (mirrors the 3-cycle funding window) — see scoring_config.funding_cycle_window and
-- the matching rule added for alignment scoring, 2026-07-24.
INSERT INTO congresses (congress_number, start_date, end_date, label) VALUES
    (118, '2023-01-03', '2025-01-03', '118th Congress (2023-2024)'),
    (117, '2021-01-03', '2023-01-03', '117th Congress (2021-2022)');

INSERT INTO scoring_config (key, value, description) VALUES
    ('alignment_congress_window', '3',
     'Number of trailing Congresses (current + 2 prior) considered for People-Alignment scoring, mirroring funding_cycle_window. A tracked bill from an earlier Congress in this window counts toward a member''s score ONLY if member_terms shows they held office (correct chamber) during that Congress — otherwise the item is not applicable for them (excluded, not scored as neutral-zero). This lets items with no confirmed current-Congress successor (e.g. end-forever-wars, tax-ultra-wealthy) still contribute real signal from members who were in office when the bill was live, without penalizing newer members who had no opportunity to act on it.');

-- end-forever-wars and tax-ultra-wealthy: no confirmed 119th-Congress successor exists (per
-- 2026-07-22 research), so track the historical 118th-Congress bill directly instead, per
-- Melissa's 2026-07-24 decision. Titles/status confirmed live via congress.gov API.
INSERT INTO tracked_item_bills (tracked_item_id, congress_number, bill_type, bill_number, official_title, latest_action_text, latest_action_date, verification_status, source_url) VALUES
    ((SELECT id FROM tracked_items WHERE slug = 'end-forever-wars'), 118, 's', 316,
     'A bill to repeal the authorizations for use of military force against Iraq.',
     'Held at the desk.', '2023-03-30', 'verified',
     'https://www.congress.gov/bill/118th-congress/senate-bill/316'),
    ((SELECT id FROM tracked_items WHERE slug = 'tax-ultra-wealthy'), 118, 'hr', 6498,
     'Billionaire Minimum Income Tax Act',
     'Referred to the House Committee on Ways and Means.', '2023-11-29', 'verified',
     'https://www.congress.gov/bill/118th-congress/house-bill/6498');
