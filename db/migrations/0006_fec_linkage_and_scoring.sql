-- FEC candidate ID linkage (from unitedstates/congress-legislators' id.fec array)
ALTER TABLE members ADD COLUMN fec_candidate_ids TEXT[] DEFAULT '{}';
ALTER TABLE members ADD COLUMN fec_principal_committee_id TEXT;
