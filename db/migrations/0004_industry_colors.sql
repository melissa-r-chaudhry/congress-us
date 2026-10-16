-- Industry accent colors, validated against the app's charcoal surface (#1a1c22)
-- via the dataviz skill's palette validator (OKLCH lightness/chroma bands, CVD
-- all-pairs separation, normal-vision floor >= 15). All 5 negative industries
-- pass fully; two industries (surveillance/weapons, pharma/health insurance)
-- deviate from Melissa's literal color descriptions ("gunmetal grey", "gross
-- brown") because those exact hues could not be made pairwise-distinguishable
-- from the others under deuteranopia/protanopia simulation — pushed toward
-- teal and indigo respectively while keeping the same "cold/industrial" and
-- "sickly/off" character. Ship with visible text labels always (never color
-- alone) per the two WARN-level checks (CVD floor-band, sub-3:1 contrast).

ALTER TABLE pac_industries ADD COLUMN color_hex TEXT;

UPDATE pac_industries SET color_hex = '#a8203d' WHERE code = 'aipac_aligned';           -- scabby dark blood-red
UPDATE pac_industries SET color_hex = '#aa7f00' WHERE code = 'oil_gas';                 -- puce/murky yellow
UPDATE pac_industries SET color_hex = '#47aa62' WHERE code = 'vice_guns_gambling_alcohol'; -- rotten-egg green
UPDATE pac_industries SET color_hex = '#00899e' WHERE code = 'surveillance_weapons';    -- cold industrial teel-steel (deviated from literal gunmetal grey — see note above)
UPDATE pac_industries SET color_hex = '#5656b0' WHERE code = 'pharma_health_insurance'; -- sickly indigo (deviated from literal brown — see note above)
