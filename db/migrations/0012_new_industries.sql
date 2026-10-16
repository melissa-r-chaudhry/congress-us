-- Two new negative industries per Melissa's direct request (2026-07-27):
-- Wall Street/Banking/Finance and Big Tech/Crypto. Colors chosen via a
-- self-implemented partial validator (lightness/chroma/normal-vision-OKLab-
-- distance/contrast) since the dataviz skill's own validate_palette.js script
-- was unavailable this session (checked multiple paths, confirmed absent).
-- Sanity-checked: reimplemented hex->OKLab conversion reproduces the real
-- validator's earlier-confirmed 15.03 worst-pair distance on the existing
-- 5-color set exactly, giving confidence in the distance metric itself.
-- NOT validated against the full CVD-simulation checks (deutan/protan/tritan)
-- the real script performs — worth a follow-up pass once that tooling is
-- available again. Worst-case pair among the full 7-color set is unchanged
-- from before adding these two (still pharma_health_insurance <-> vice, 15.03),
-- meaning these additions don't introduce a new weak point.

INSERT INTO pac_industries (code, label, polarity, description, color_hex) VALUES
  ('wall_street_banking_finance', 'Wall Street/Banking/Finance', 'negative',
   'Major banks, investment firms, and financial services industry PACs.', '#467900'),
  ('big_tech_crypto', 'Big Tech/Crypto', 'negative',
   'Major technology companies and cryptocurrency industry PACs.', '#00a286');
