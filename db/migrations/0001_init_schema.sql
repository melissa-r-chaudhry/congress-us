-- Congress.US initial schema
-- Approved architecture: /Users/macuser/.claude/plans/mutable-spinning-acorn.md

CREATE TABLE congresses (
    congress_number INT PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    label TEXT
);

CREATE TABLE scoring_config (
    key TEXT PRIMARY KEY,
    value TEXT NOT NULL,
    description TEXT,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE pac_industries (
    code TEXT PRIMARY KEY,
    label TEXT NOT NULL,
    polarity TEXT NOT NULL CHECK (polarity IN ('negative', 'positive')),
    description TEXT,
    is_active BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE members (
    bioguide_id TEXT PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    birthday DATE,
    gender TEXT,
    photo_url TEXT,
    official_url TEXT,
    social_media JSONB DEFAULT '{}'::jsonb,
    slug TEXT NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE member_terms (
    id SERIAL PRIMARY KEY,
    bioguide_id TEXT NOT NULL REFERENCES members(bioguide_id),
    congress_number INT NOT NULL REFERENCES congresses(congress_number),
    chamber TEXT NOT NULL CHECK (chamber IN ('house', 'senate')),
    state TEXT NOT NULL,
    district INT,
    party TEXT NOT NULL,
    term_start DATE,
    term_end DATE,
    is_current BOOLEAN NOT NULL DEFAULT false
);
CREATE INDEX idx_member_terms_bioguide ON member_terms(bioguide_id);
CREATE INDEX idx_member_terms_current ON member_terms(is_current) WHERE is_current = true;

CREATE TABLE tracked_items (
    id SERIAL PRIMARY KEY,
    slug TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    short_description TEXT,
    long_description TEXT,
    item_type TEXT NOT NULL CHECK (item_type IN ('bill_tracker', 'compliance_tracker')),
    category TEXT,
    display_order INT NOT NULL DEFAULT 0,
    contributes_to_score BOOLEAN NOT NULL DEFAULT true,
    poll_status TEXT CHECK (poll_status IN ('sourced', 'needs_research')),
    poll_source TEXT,
    poll_url TEXT,
    poll_date DATE,
    poll_stat_text TEXT
);

CREATE TABLE tracked_item_bills (
    id SERIAL PRIMARY KEY,
    tracked_item_id INT NOT NULL REFERENCES tracked_items(id),
    congress_number INT NOT NULL REFERENCES congresses(congress_number),
    bill_type TEXT NOT NULL,
    bill_number INT NOT NULL,
    official_title TEXT,
    latest_action_text TEXT,
    latest_action_date DATE,
    introduced_date DATE,
    sponsor_bioguide_id TEXT REFERENCES members(bioguide_id),
    is_enacted BOOLEAN NOT NULL DEFAULT false,
    enacted_date DATE,
    verification_status TEXT NOT NULL DEFAULT 'needs_review' CHECK (verification_status IN ('verified', 'needs_review')),
    verification_note TEXT,
    is_active BOOLEAN NOT NULL DEFAULT true,
    source_url TEXT,
    synced_at TIMESTAMPTZ,
    UNIQUE(congress_number, bill_type, bill_number)
);
CREATE INDEX idx_tracked_item_bills_item ON tracked_item_bills(tracked_item_id);

CREATE TABLE compliance_trackers (
    id SERIAL PRIMARY KEY,
    tracked_item_id INT NOT NULL UNIQUE REFERENCES tracked_items(id),
    law_citation TEXT,
    law_url TEXT,
    required_action_description TEXT,
    deadline_date DATE,
    overall_status TEXT NOT NULL DEFAULT 'unknown' CHECK (overall_status IN ('compliant', 'partial', 'noncompliant', 'unknown'))
);

CREATE TABLE compliance_updates (
    id SERIAL PRIMARY KEY,
    compliance_tracker_id INT NOT NULL REFERENCES compliance_trackers(id),
    update_date DATE NOT NULL,
    status_as_of TEXT,
    summary TEXT NOT NULL,
    source_url TEXT NOT NULL,
    source_name TEXT,
    entered_by TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_compliance_updates_tracker ON compliance_updates(compliance_tracker_id);

CREATE TABLE member_bill_positions (
    id SERIAL PRIMARY KEY,
    bioguide_id TEXT NOT NULL REFERENCES members(bioguide_id),
    tracked_item_bill_id INT NOT NULL REFERENCES tracked_item_bills(id),
    position_type TEXT NOT NULL CHECK (position_type IN ('sponsor', 'cosponsor', 'voted_yea', 'voted_nay', 'voted_present')),
    position_date DATE,
    source_url TEXT,
    synced_at TIMESTAMPTZ,
    -- future-proofing for the deferred "structural block" feature (Phase 3) — unused in v1
    structural_block_note TEXT,
    structural_block_source_url TEXT,
    structural_block_entered_by TEXT,
    UNIQUE(bioguide_id, tracked_item_bill_id, position_type)
);
CREATE INDEX idx_member_bill_positions_bioguide ON member_bill_positions(bioguide_id);
CREATE INDEX idx_member_bill_positions_bill ON member_bill_positions(tracked_item_bill_id);

CREATE TABLE pac_committees (
    fec_committee_id TEXT PRIMARY KEY,
    committee_name TEXT NOT NULL,
    industry_code TEXT REFERENCES pac_industries(code),
    classification_status TEXT NOT NULL DEFAULT 'needs_review' CHECK (classification_status IN ('classified', 'needs_review')),
    classification_source_url TEXT,
    classification_note TEXT,
    last_reviewed_date DATE
);

CREATE TABLE pac_contributions (
    id BIGSERIAL PRIMARY KEY,
    bioguide_id TEXT NOT NULL REFERENCES members(bioguide_id),
    cycle_year INT NOT NULL,
    fec_committee_id TEXT NOT NULL REFERENCES pac_committees(fec_committee_id),
    amount NUMERIC(12, 2) NOT NULL,
    contribution_date DATE,
    fec_transaction_id TEXT,
    source_url TEXT,
    synced_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_pac_contributions_bioguide_cycle ON pac_contributions(bioguide_id, cycle_year);
CREATE INDEX idx_pac_contributions_committee ON pac_contributions(fec_committee_id);

CREATE TABLE individual_contribution_summary (
    id SERIAL PRIMARY KEY,
    bioguide_id TEXT NOT NULL REFERENCES members(bioguide_id),
    cycle_year INT NOT NULL,
    verified_itemized_count_under200 INT NOT NULL DEFAULT 0,
    verified_itemized_count_200_to_limit INT NOT NULL DEFAULT 0,
    unitemized_total_amount NUMERIC(14, 2) NOT NULL DEFAULT 0,
    assumed_avg_unitemized_gift NUMERIC(8, 2),
    estimated_unitemized_count NUMERIC GENERATED ALWAYS AS (
        CASE WHEN assumed_avg_unitemized_gift IS NOT NULL AND assumed_avg_unitemized_gift > 0
             THEN unitemized_total_amount / assumed_avg_unitemized_gift
             ELSE 0 END
    ) STORED,
    source_url TEXT,
    synced_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE(bioguide_id, cycle_year)
);

-- Houses the AIPAC V3.0-style traced signal (0.5 confidence weight), and later the deferred
-- employer/occupation-based reclassification for the other 4 industries. `source` distinguishes
-- 'trackaipac' (ingested third-party) from 'internal_donor_match' (if we build our own) from
-- 'employer_match' (Phase 3, other industries) without any schema change between those paths.
CREATE TABLE external_funding_signals (
    id SERIAL PRIMARY KEY,
    bioguide_id TEXT NOT NULL REFERENCES members(bioguide_id),
    cycle_year INT NOT NULL,
    source TEXT NOT NULL,
    signal_type TEXT NOT NULL,
    industry_code TEXT REFERENCES pac_industries(code),
    amount NUMERIC(12, 2) NOT NULL,
    source_url TEXT,
    confidence_note TEXT,
    synced_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_external_funding_signals_bioguide ON external_funding_signals(bioguide_id, cycle_year);

CREATE TABLE member_scores (
    id SERIAL PRIMARY KEY,
    bioguide_id TEXT NOT NULL UNIQUE REFERENCES members(bioguide_id),
    congress_number INT NOT NULL REFERENCES congresses(congress_number),
    funding_raw_score NUMERIC,
    funding_display_score NUMERIC,
    alignment_raw_score NUMERIC,
    alignment_display_score NUMERIC,
    composite_score NUMERIC,
    top_negative_industry_code TEXT REFERENCES pac_industries(code),
    funding_data_status TEXT NOT NULL DEFAULT 'insufficient_data' CHECK (funding_data_status IN ('ready', 'insufficient_data')),
    alignment_data_status TEXT NOT NULL DEFAULT 'insufficient_data' CHECK (alignment_data_status IN ('ready', 'insufficient_data')),
    computed_at TIMESTAMPTZ
);
