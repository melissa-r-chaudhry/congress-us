-- Fix 1: support genuine ties for "top negative industry" (was silently picking one via
-- non-deterministic DISTINCT ON tie-break — real case: Rep. Diana Harshbarger has exactly
-- $30,000/30 contributions from both Oil & Gas and Guns/Gambling/Alcohol/Vice).
CREATE TABLE member_top_negative_industries (
    id SERIAL PRIMARY KEY,
    bioguide_id TEXT NOT NULL REFERENCES members(bioguide_id),
    industry_code TEXT NOT NULL REFERENCES pac_industries(code),
    amount NUMERIC(14, 2) NOT NULL,
    UNIQUE(bioguide_id, industry_code)
);
CREATE INDEX idx_member_top_neg_industries_bioguide ON member_top_negative_industries(bioguide_id);

-- Fix 2: grassroots-vs-PAC dollar ratio, real totals stored per member so the UI doesn't
-- need to re-sum on every request, plus the pooled dataset-average for comparison.
ALTER TABLE member_scores ADD COLUMN grassroots_total_amount NUMERIC(14, 2);
ALTER TABLE member_scores ADD COLUMN pac_total_amount NUMERIC(14, 2);
ALTER TABLE member_scores ADD COLUMN people_pac_ratio NUMERIC;

INSERT INTO scoring_config (key, value, description) VALUES
    ('dataset_avg_people_pac_ratio', '0',
     'Pooled dataset average of grassroots-dollar-total / PAC-dollar-total, computed as SUM(all members'' grassroots $) / SUM(all members'' PAC $) — NOT a mean of individual ratios, which breaks for members with $0 PAC money. Recomputed by refresh_member_scores() every run; this stored value is a cache read by the UI, not hand-maintained.')
ON CONFLICT (key) DO NOTHING;
