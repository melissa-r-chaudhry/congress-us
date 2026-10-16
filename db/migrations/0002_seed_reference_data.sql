-- Congress.US seed reference data

INSERT INTO congresses (congress_number, start_date, end_date, label) VALUES
    (119, '2025-01-03', '2027-01-03', '119th Congress (2025-2026)');

INSERT INTO scoring_config (key, value, description) VALUES
    ('grassroots_avg_gift_G', '27.50', 'PLACEHOLDER — average grassroots (<$200) donation size in dollars. Must be recomputed from real aggregate FEC data before launch; do not treat as final. All dollar-denominated signals convert to points via amount / G.'),
    ('confidence_direct', '1.0', 'Weight multiplier for direct/certain funding signals (named PAC contribution, named large-individual contribution).'),
    ('confidence_inferred', '0.5', 'Weight multiplier for inferred/traced funding signals (AIPAC V3.0-style donor-network tracing; later, employer/occupation reclassification for other industries).'),
    ('positive_pac_weight', '0.5', 'Weight for PAC contributions from people-aligned sources (unions etc.) — half of grassroots strength by original design choice, distinct concept from confidence_inferred despite the same number.'),
    ('large_individual_limit_2025_2026', '3500', 'Current FEC per-election individual contribution limit (2025-2026 cycle). Upper bound of the neutral "large individual" bucket.'),
    ('funding_cycle_window', '3', 'Number of trailing election cycles blended (equal-weighted) into the funding score, to reduce the influence of recent donor-pattern shifts ("shapeshifting").'),
    ('funding_normalization_method', 'minmax', 'How funding_raw_score becomes funding_display_score (0-100): min-max across all currently-tracked members, not percentile rank.'),
    ('assumed_avg_unitemized_gift_default', '30.00', 'Default fallback for individual_contribution_summary.assumed_avg_unitemized_gift when not otherwise available.');

INSERT INTO pac_industries (code, label, polarity, description) VALUES
    ('oil_gas', 'Oil & Gas', 'negative', 'Fossil fuel extraction, refining, and distribution industry PACs.'),
    ('surveillance_weapons', 'Surveillance / Weapons', 'negative', 'Defense contractors and surveillance technology industry PACs — distinct from the civilian gun industry.'),
    ('pharma_health_insurance', 'Pharma / Health Insurance', 'negative', 'Pharmaceutical manufacturers and health insurance industry PACs.'),
    ('aipac_aligned', 'AIPAC-Aligned', 'negative', 'Pro-Israel lobby PACs, including AIPAC-affiliated bundlers (e.g. NORPAC) — AIPAC itself does not donate directly.'),
    ('vice_guns_gambling_alcohol', 'Guns / Gambling / Alcohol / Vice', 'negative', 'Civilian firearms industry, gambling, alcohol, and related vice-industry PACs.'),
    ('labor_union', 'Labor Union', 'positive', 'Labor union PACs — people-aligned funding source.'),
    ('other_positive', 'Other People-Aligned', 'positive', 'Other PACs judged people-aligned, not fitting the labor_union category specifically.');

-- Tracked items: "the 80% bill" list, carried forward from https://the80percentbill.com/bill/
-- Bill numbers resolved to 119th Congress per research pass, 2026-07-22. verification_status
-- reflects confidence in that mapping — see project_congress_us.md memory for full research notes.

INSERT INTO tracked_items (slug, title, short_description, item_type, category, display_order) VALUES
    ('stock-trading-ban', 'Ban Congressional Stock Trading', 'Prohibits Members and families from owning individual stocks; requires divestment or blind trusts.', 'bill_tracker', 'ethics', 1),
    ('end-forever-wars', 'End Forever Wars', 'Repeals outdated war authorizations to restore Congressional war powers.', 'bill_tracker', 'foreign_policy', 2),
    ('lifetime-lobbying-ban', 'Lifetime Lobbying Ban', 'Bans former Members from registered lobbying activities permanently.', 'bill_tracker', 'ethics', 3),
    ('tax-ultra-wealthy', 'Tax the Ultra-Wealthy', 'Closes tax loopholes; establishes minimum tax for billionaires.', 'bill_tracker', 'economy', 4),
    ('ban-corporate-pacs', 'Ban Corporate PACs', 'Prohibits for-profit corporations from forming Political Action Committees.', 'bill_tracker', 'campaign_finance', 5),
    ('audit-the-pentagon', 'Audit the Pentagon', 'Mandates independent Pentagon audit to identify waste and fraud.', 'bill_tracker', 'government_accountability', 6),
    ('medicare-drug-negotiation', 'Medicare Drug Negotiation', 'Expands drug price negotiation; closes the Orphan Drug loophole.', 'bill_tracker', 'healthcare', 7),
    ('fair-elections-gerrymandering', 'Fair Elections & End Gerrymandering', 'Bans partisan gerrymandering; restores Voting Rights Act provisions.', 'bill_tracker', 'voting_rights', 8),
    ('protect-us-farmland', 'Protect US Farmland', 'Bans adversarial foreign governments from purchasing American farmland.', 'bill_tracker', 'national_security', 9),
    ('ban-corporate-home-purchases', 'Ban Corporate Purchase of Single-Family Homes', 'Imposes excise tax on corporate purchase of existing homes; allows new construction.', 'bill_tracker', 'housing', 10),
    ('fund-social-security', 'Fund Social Security', 'Lifts the wage cap; taxes investment income for earners over $400k.', 'bill_tracker', 'economy', 11),
    ('police-body-cameras', 'Police Body Cameras', 'Mandates federal officer cameras; conditions state funding on compliance.', 'bill_tracker', 'justice', 12),
    ('ban-dark-money', 'Ban Dark Money', 'Provision to overturn Citizens United; bans corporate dark money.', 'bill_tracker', 'campaign_finance', 13),
    ('paid-family-leave', 'Paid Family Leave', 'Guarantees 12 weeks paid leave funded by payroll insurance.', 'bill_tracker', 'labor', 14),
    ('epstein-files-compliance', 'Release the Epstein Files', 'Full, unredacted release of all files (victim-privacy redactions only) — the underlying bill already passed into law; this item tracks ongoing compliance, not cosponsorship.', 'compliance_tracker', 'government_accountability', 15),
    ('disclose-act', 'The DISCLOSE Act', 'Requires donor disclosure ($10k+); includes trace-back rules.', 'bill_tracker', 'campaign_finance', 16),
    ('close-tax-loopholes', 'Close Tax Loopholes', 'Reclassifies carried interest as ordinary income.', 'bill_tracker', 'economy', 17),
    ('right-to-repair', 'Right to Repair', 'Guarantees parts/manuals access; bans software pairing restrictions.', 'bill_tracker', 'consumer_protection', 18),
    ('ban-junk-fees', 'Ban Junk Fees', 'Requires all-in pricing; prohibits dynamic pricing post-disclosure.', 'bill_tracker', 'consumer_protection', 19),
    ('congressional-term-limits', 'Congressional Term Limits', 'Establishes term limits for Members of Congress.', 'bill_tracker', 'ethics', 20),
    ('data-privacy', 'Comprehensive Data Privacy', 'Data privacy framework — original bill (American Privacy Rights Act) was not reintroduced; tracked via two replacement bills.', 'bill_tracker', 'consumer_protection', 21);

-- tracked_item_bills: one row per bill (Data Privacy gets two, Epstein's enacted bill still gets one
-- to keep feeding People-Alignment scoring even though the item's live status is now compliance-tracking)
INSERT INTO tracked_item_bills (tracked_item_id, congress_number, bill_type, bill_number, official_title, is_enacted, verification_status, source_url) VALUES
    ((SELECT id FROM tracked_items WHERE slug = 'stock-trading-ban'), 119, 'hr', 5106, 'Restore Trust in Congress Act', false, 'verified', 'https://www.congress.gov/bill/119th-congress/house-bill/5106'),
    ((SELECT id FROM tracked_items WHERE slug = 'lifetime-lobbying-ban'), 119, 'hr', 3554, 'Close the Revolving Door Act of 2025', false, 'verified', 'https://www.congress.gov/bill/119th-congress/house-bill/3554'),
    ((SELECT id FROM tracked_items WHERE slug = 'ban-corporate-pacs'), 119, 'hr', 4799, 'Ban Corporate PACs Act', false, 'verified', 'https://www.congress.gov/bill/119th-congress/house-bill/4799'),
    ((SELECT id FROM tracked_items WHERE slug = 'audit-the-pentagon'), 119, 'hr', 7555, 'Audit the Pentagon Act of 2026', false, 'verified', 'https://www.congress.gov/bill/119th-congress/house-bill/7555'),
    ((SELECT id FROM tracked_items WHERE slug = 'medicare-drug-negotiation'), 119, 'hr', 6166, 'Lowering Drug Costs for American Families Act', false, 'verified', 'https://www.congress.gov/bill/119th-congress/house-bill/6166'),
    ((SELECT id FROM tracked_items WHERE slug = 'fair-elections-gerrymandering'), 119, 'hr', 14, 'John R. Lewis Voting Rights Advancement Act of 2025', false, 'needs_review', 'https://www.congress.gov/bill/119th-congress/house-bill/14'),
    ((SELECT id FROM tracked_items WHERE slug = 'protect-us-farmland'), 119, 'hr', 1438, 'Protecting America''s Agricultural Land from Foreign Harm Act of 2025', false, 'verified', 'https://www.congress.gov/bill/119th-congress/house-bill/1438'),
    ((SELECT id FROM tracked_items WHERE slug = 'ban-corporate-home-purchases'), 119, 's', 788, 'HOPE for Homeownership Act', false, 'needs_review', 'https://www.congress.gov/bill/119th-congress/senate-bill/788'),
    ((SELECT id FROM tracked_items WHERE slug = 'fund-social-security'), 119, 's', 1690, 'Medicare and Social Security Fair Share Act', false, 'verified', 'https://www.congress.gov/bill/119th-congress/senate-bill/1690'),
    ((SELECT id FROM tracked_items WHERE slug = 'police-body-cameras'), 119, 'hr', 5361, 'George Floyd Justice in Policing Act of 2025', false, 'verified', 'https://www.congress.gov/bill/119th-congress/house-bill/5361'),
    ((SELECT id FROM tracked_items WHERE slug = 'ban-dark-money'), 119, 'hjres', 54, 'Proposing an amendment to the Constitution relative to contributions and expenditures intended to affect elections', false, 'needs_review', 'https://www.congress.gov/bill/119th-congress/house-joint-resolution/54'),
    ((SELECT id FROM tracked_items WHERE slug = 'paid-family-leave'), 119, 'hr', 5390, 'FAMILY Act', false, 'verified', 'https://www.congress.gov/bill/119th-congress/house-bill/5390'),
    ((SELECT id FROM tracked_items WHERE slug = 'epstein-files-compliance'), 119, 'hr', 4405, 'Epstein Files Transparency Act', true, 'verified', 'https://www.congress.gov/bill/119th-congress/house-bill/4405'),
    ((SELECT id FROM tracked_items WHERE slug = 'disclose-act'), 119, 's', 3991, 'DISCLOSE Act of 2026', false, 'verified', 'https://www.congress.gov/bill/119th-congress/senate-bill/3991'),
    ((SELECT id FROM tracked_items WHERE slug = 'close-tax-loopholes'), 119, 's', 445, 'Carried Interest Fairness Act of 2025', false, 'verified', 'https://www.congress.gov/bill/119th-congress/senate-bill/445'),
    ((SELECT id FROM tracked_items WHERE slug = 'right-to-repair'), 119, 'hr', 1566, 'REPAIR Act', false, 'verified', 'https://www.congress.gov/bill/119th-congress/house-bill/1566'),
    ((SELECT id FROM tracked_items WHERE slug = 'ban-junk-fees'), 119, 'hr', 6430, 'Junk Fee Prevention Act', false, 'verified', 'https://www.congress.gov/bill/119th-congress/house-bill/6430'),
    ((SELECT id FROM tracked_items WHERE slug = 'congressional-term-limits'), 119, 'hjres', 12, 'Proposing an amendment to the Constitution to set term limits for Members of Congress', false, 'verified', 'https://www.congress.gov/bill/119th-congress/house-joint-resolution/12'),
    ((SELECT id FROM tracked_items WHERE slug = 'data-privacy'), 119, 'hr', 8413, 'SECURE Data Act', false, 'needs_review', 'https://www.congress.gov/bill/119th-congress/house-bill/8413'),
    ((SELECT id FROM tracked_items WHERE slug = 'data-privacy'), 119, 's', 4211, 'Consumer Data Privacy and Security Act', false, 'needs_review', 'https://www.congress.gov/bill/119th-congress/senate-bill/4211');
    -- NOTE: 'tax-ultra-wealthy' intentionally has NO row yet — 3 competing 119th successor bills,
    -- no single confirmed match per research. 'end-forever-wars' intentionally has NO row —
    -- no clean single successor (partial progress via NDAA rider only, 2001 AUMF still active).
    -- Both need a deliberate editorial call before a bill row is added, not an automatic pick.

INSERT INTO compliance_trackers (tracked_item_id, law_citation, law_url, required_action_description, overall_status) VALUES
    ((SELECT id FROM tracked_items WHERE slug = 'epstein-files-compliance'), 'Public Law 119-38 (Epstein Files Transparency Act)', 'https://www.congress.gov/bill/119th-congress/house-bill/4405', 'Full, unredacted release of all Epstein-related files and names, with victim-privacy redactions only, per the law''s mandated deadline.', 'unknown');
