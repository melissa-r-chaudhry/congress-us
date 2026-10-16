-- Two-tier industry severity system, per Melissa's decision 2026-07-28.
-- Original 5 "big-baddie" industries + Wall Street/Big Tech (added separately earlier)
-- stay at full severity weight (1.0). Five new industries added at half weight (0.5) --
-- these are the clusters that had been piling up unclassifiable across nearly every
-- classification pass since pass 2.

ALTER TABLE pac_industries ADD COLUMN severity_weight NUMERIC NOT NULL DEFAULT 1.0;

-- Explicit for clarity, even though 1.0 is already the default
UPDATE pac_industries SET severity_weight = 1.0
WHERE code IN ('oil_gas','surveillance_weapons','pharma_health_insurance','aipac_aligned',
               'vice_guns_gambling_alcohol','wall_street_banking_finance','big_tech_crypto');

INSERT INTO pac_industries (code, label, polarity, description, severity_weight, color_hex) VALUES
  ('electric_utilities', 'Electric Utilities', 'negative',
   'Regulated electric power generation, transmission, and distribution companies.', 0.5, '#db5dab'),
  ('telecom_media', 'Telecom/Media', 'negative',
   'Telecommunications carriers and broadcast/media companies.', 0.5, '#db5dab'),
  ('general_life_insurance', 'General/Life Insurance', 'negative',
   'General property, casualty, and life insurance industry (distinct from health-insurance payers already covered under Pharma/Health Insurance).', 0.5, '#db5dab'),
  ('healthcare_providers_medical_devices', 'Healthcare Providers/Medical Devices', 'negative',
   'Hospital systems, physician-practice associations, and medical device manufacturers (distinct from pharma manufacturers and health insurers).', 0.5, '#db5dab'),
  ('real_estate', 'Real Estate', 'negative',
   'Commercial and residential real estate industry associations and developers.', 0.5, '#db5dab');
