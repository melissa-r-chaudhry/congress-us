-- Adds a third classification_status: 'reviewed_no_fit' — distinguishes "nobody has
-- looked at this committee yet" (needs_review) from "someone looked and it genuinely
-- doesn't fit any of our 9 industry categories" (reviewed_no_fit). Melissa explicitly
-- wants rationale visible for the "no" decisions too, not just the "yes" ones.

ALTER TABLE pac_committees DROP CONSTRAINT pac_committees_classification_status_check;
ALTER TABLE pac_committees ADD CONSTRAINT pac_committees_classification_status_check
  CHECK (classification_status = ANY (ARRAY['classified'::text, 'needs_review'::text, 'reviewed_no_fit'::text]));
