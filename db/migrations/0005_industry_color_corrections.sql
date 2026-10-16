-- Corrects pac_industries.color_hex to the final validated palette (2026-07-24).
-- Migration 0004 shipped a first pass (vice=green) that Melissa caught colliding
-- visually with the unvalidated green fallback used for positive-PAC categories.
-- Final set: vice becomes a middling grey (explicit override); surveillance and
-- pharma shift hue to stay CVD-distinguishable from the new grey; positive
-- categories get the site's existing gold accent instead of a competing hue
-- (reframed as a status color, not part of the 5-industry categorical set).
-- Full validation history: businessventures/project_congress_us.md memory file.

UPDATE pac_industries SET color_hex = '#aa2446' WHERE code = 'aipac_aligned';
UPDATE pac_industries SET color_hex = '#ad8700' WHERE code = 'oil_gas';
UPDATE pac_industries SET color_hex = '#7a53b4' WHERE code = 'pharma_health_insurance';
UPDATE pac_industries SET color_hex = '#0092df' WHERE code = 'surveillance_weapons';
UPDATE pac_industries SET color_hex = '#5c6165' WHERE code = 'vice_guns_gambling_alcohol';
UPDATE pac_industries SET color_hex = '#d4af37' WHERE polarity = 'positive';
