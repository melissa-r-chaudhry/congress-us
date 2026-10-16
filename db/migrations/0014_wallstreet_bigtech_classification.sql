-- Wall Street/Banking/Finance and Big Tech/Crypto committee classifications.
-- Every committee individually verified against FEC's own committee record
-- (organization_type_full) before classifying, not name-pattern-matched.
-- "RIPPLE OF HOPE PAC" was investigated and deliberately EXCLUDED — confirmed
-- via FEC as a Leadership PAC (a politician's personal fund), unrelated to the
-- Ripple crypto company despite the name.

UPDATE pac_committees SET industry_code = 'wall_street_banking_finance',
  classification_status = 'classified',
  classification_source_url = 'https://www.fec.gov/data/committee/' || fec_committee_id || '/',
  classification_note = 'Verified Corporation/Trade Association via FEC organization_type_full, 2026-07-27',
  last_reviewed_date = CURRENT_DATE
WHERE fec_committee_id IN (
  'C00004275', -- American Bankers Association (BANKPAC)
  'C00007880', -- America's Credit Unions PAC (CULAC)
  'C00337626', -- Morgan Stanley PAC
  'C00104299', -- JPMorgan Chase & Co. Federal PAC
  'C00128512', -- JPMorgan Chase & Co. PAC
  'C00350744', -- The Goldman Sachs Group, Inc. PAC
  'C00265124', -- The Goldman Sachs Group PAC
  'C00479246', -- BlackRock Funds Services Group LLC PAC
  'C00008474', -- Citigroup Inc. PAC - Federal
  'C00039305', -- Citigroup Inc. PAC - State
  'C00364778', -- Bank of America Corporation Federal PAC
  'C00300178', -- Wells Fargo and Company Employees Good Government Federal Fund II
  'C00034595', -- Wells Fargo and Company Employee PAC
  'C00012518'  -- Wells Fargo and Company Employees Good Government
);

UPDATE pac_committees SET industry_code = 'big_tech_crypto',
  classification_status = 'classified',
  classification_source_url = 'https://www.fec.gov/data/committee/' || fec_committee_id || '/',
  classification_note = 'Verified Corporation via FEC organization_type_full, 2026-07-27',
  last_reviewed_date = CURRENT_DATE
WHERE fec_committee_id IN (
  'C00428623', -- Google LLC NetPAC
  'C00369751', -- Dell Technologies, Inc. PAC
  'C00360354', -- Amazon.com Services, Inc. SSF
  'C00227546', -- Microsoft Corporation Stakeholders Voluntary PAC
  'C00502906', -- Meta Platforms Inc. PAC
  'C00804179', -- Coinbase, Inc. Innovation PAC
  'C00680355', -- Coinbase, Inc. PAC
  'C00411116'  -- Space Exploration Technologies Corp PAC (SpaceX)
);
