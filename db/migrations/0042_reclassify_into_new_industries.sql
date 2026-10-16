-- Pass 22 part 1: bulk-reclassify already-researched reviewed_no_fit committees into the
-- 5 newly-created half-weight industries (0039-0040). Every one of these was already
-- individually researched and documented with real reasoning in a prior pass -- this is
-- not new classification judgment, just moving them from the old "no fitting category"
-- bucket into the category that their own existing note already describes.

-- Named committees specifically flagged for this pass:
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'electric_utilities'
WHERE fec_committee_id IN ('C00082008', 'C00177469', 'C00507962'); -- Portland General Electric, PG&E, AES Corp

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'general_life_insurance'
WHERE fec_committee_id IN ('C00402107', 'C00686055', 'C00254953'); -- CUNA Mutual/TruStage, Jackson National Life x2

-- Bulk sweep: reviewed_no_fit committees whose existing classification_note already
-- identifies them as belonging to one of the 5 new clusters.
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'electric_utilities'
WHERE classification_status = 'reviewed_no_fit' AND classification_note ILIKE '%electric%utilit%';

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'telecom_media'
WHERE classification_status = 'reviewed_no_fit'
  AND (classification_note ILIKE '%telecom%' OR classification_note ILIKE '%media cluster%');

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'general_life_insurance'
WHERE classification_status = 'reviewed_no_fit'
  AND (classification_note ILIKE '%general%insurance%' OR classification_note ILIKE '%life insurance%' OR classification_note ILIKE '%property%insurance%');

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'healthcare_providers_medical_devices'
WHERE classification_status = 'reviewed_no_fit'
  AND (classification_note ILIKE '%healthcare-provider%' OR classification_note ILIKE '%medical device%' OR classification_note ILIKE '%healthcare provider%');

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'real_estate'
WHERE classification_status = 'reviewed_no_fit' AND classification_note ILIKE '%real estate%';
