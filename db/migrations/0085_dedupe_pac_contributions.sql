-- CRITICAL FIX 2026-08-25: pac_contributions had NO real uniqueness constraint (only a bare
-- surrogate `id` PRIMARY KEY) -- sync-fec.mjs's `ON CONFLICT DO NOTHING` on this table has been
-- a silent no-op since day one, because there was nothing for it to conflict against. Every
-- resync this entire project has ever run (and there were many, across the whole multi-day/
-- multi-session build) re-inserted the same real FEC transactions as brand-new duplicate rows.
-- Discovered 2026-08-25 when Melissa flagged an implausible $8.94M "reviewed_no_fit" bucket on
-- Rep. Gabe Evans' individual profile -- turned out dataset-wide, not member- or category-
-- specific: 2,258,110 total rows, only 148,825 distinct real transactions (~15x average
-- inflation, 515 of 537 members affected). Explains the site-wide "$5.0B PAC money tracked"
-- figure -- real total is $329.77M.
--
-- FIRST ATTEMPT (superseded, do not use): a straightforward
--   `DELETE FROM pac_contributions WHERE id NOT IN (SELECT MIN(id) FROM ... GROUP BY ...)`
-- was tried first and CANCELED after running 75+ minutes with 222GB of block I/O against a
-- table that should only be ~1-2GB -- a pathological plan (NOT IN anti-join without hashing),
-- not genuine slow-but-steady progress. Canceled cleanly (nothing had committed, pg_cancel_backend,
-- confirmed zero data loss via unchanged row count) and replaced with the approach below, which
-- completed in 4.5 seconds for the same result.

BEGIN;

-- Build a deduplicated copy via a single sequential scan + sort -- no anti-join against millions
-- of rows, which is what made the first attempt pathological.
CREATE TABLE pac_contributions_new AS
SELECT DISTINCT ON (bioguide_id, fec_committee_id, cycle_year, fec_transaction_id)
  id, bioguide_id, cycle_year, fec_committee_id, amount, contribution_date, fec_transaction_id, source_url, synced_at
FROM pac_contributions
ORDER BY bioguide_id, fec_committee_id, cycle_year, fec_transaction_id, id;

-- Swap the old table aside (kept as pac_contributions_old, NOT dropped by this migration --
-- dropping it is a separate, explicit step per the standing no-unilateral-deletion-of-records
-- rule; Melissa's call once she's confirmed the corrected numbers look right).
ALTER TABLE pac_contributions RENAME TO pac_contributions_old;
ALTER TABLE pac_contributions_old RENAME CONSTRAINT pac_contributions_pkey TO pac_contributions_pkey_old;
ALTER TABLE pac_contributions_old RENAME CONSTRAINT pac_contributions_bioguide_id_fkey TO pac_contributions_bioguide_id_fkey_old;
ALTER TABLE pac_contributions_old RENAME CONSTRAINT pac_contributions_fec_committee_id_fkey TO pac_contributions_fec_committee_id_fkey_old;
ALTER INDEX idx_pac_contributions_bioguide_cycle RENAME TO idx_pac_contributions_bioguide_cycle_old;
ALTER INDEX idx_pac_contributions_committee RENAME TO idx_pac_contributions_committee_old;

ALTER TABLE pac_contributions_new RENAME TO pac_contributions;

-- Recreate the original shape plus the new natural-key uniqueness constraint that's the actual
-- point of this fix -- this is what makes sync-fec.mjs's ON CONFLICT clause finally do something.
ALTER TABLE pac_contributions ALTER COLUMN id SET NOT NULL;
ALTER TABLE pac_contributions ALTER COLUMN bioguide_id SET NOT NULL;
ALTER TABLE pac_contributions ALTER COLUMN cycle_year SET NOT NULL;
ALTER TABLE pac_contributions ALTER COLUMN fec_committee_id SET NOT NULL;
ALTER TABLE pac_contributions ALTER COLUMN amount SET NOT NULL;
ALTER TABLE pac_contributions ALTER COLUMN synced_at SET NOT NULL;
ALTER TABLE pac_contributions ALTER COLUMN synced_at SET DEFAULT now();

ALTER TABLE pac_contributions ALTER COLUMN id SET DEFAULT nextval('pac_contributions_id_seq');
ALTER SEQUENCE pac_contributions_id_seq OWNED BY pac_contributions.id;
SELECT setval('pac_contributions_id_seq', (SELECT MAX(id) FROM pac_contributions));

ALTER TABLE pac_contributions ADD CONSTRAINT pac_contributions_pkey PRIMARY KEY (id);
ALTER TABLE pac_contributions ADD CONSTRAINT pac_contributions_natural_key
  UNIQUE (bioguide_id, fec_committee_id, cycle_year, fec_transaction_id);
ALTER TABLE pac_contributions ADD CONSTRAINT pac_contributions_bioguide_id_fkey
  FOREIGN KEY (bioguide_id) REFERENCES members(bioguide_id);
ALTER TABLE pac_contributions ADD CONSTRAINT pac_contributions_fec_committee_id_fkey
  FOREIGN KEY (fec_committee_id) REFERENCES pac_committees(fec_committee_id);

CREATE INDEX idx_pac_contributions_bioguide_cycle ON pac_contributions (bioguide_id, cycle_year);
CREATE INDEX idx_pac_contributions_committee ON pac_contributions (fec_committee_id);

COMMIT;
