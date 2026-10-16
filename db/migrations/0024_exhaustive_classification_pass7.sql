-- Exhaustive PAC classification, pass 7. Verified live via FEC where noted; POET PAC
-- was the item pass 6 missed. Several items left in needs_review due to hitting the
-- shared FEC key's rate limit mid-pass (Coupang, Growth Energy, US Chamber, ACP Services)
-- rather than classifying from name/memory alone.

UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00410274/', classification_note = 'Mastercard International Employee PAC — confirmed Lobbyist/Registrant PAC, major payments/financial services company.'
  WHERE fec_committee_id = 'C00410274';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00307249/', classification_note = 'Citizens Financial Group PAC — confirmed Lobbyist/Registrant PAC, major US bank.'
  WHERE fec_committee_id = 'C00307249';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00327072/', classification_note = 'Santander Holdings USA PAC — confirmed Lobbyist/Registrant PAC, major bank.'
  WHERE fec_committee_id = 'C00327072';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00072751/', classification_note = 'State Street Bank and Trust PAC — confirmed Lobbyist/Registrant PAC, major bank/asset manager.'
  WHERE fec_committee_id = 'C00072751';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00236414/', classification_note = 'TransAmerica Corporation PAC — confirmed Lobbyist/Registrant PAC, major insurance/financial services.'
  WHERE fec_committee_id = 'C00236414';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'wall_street_banking_finance',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00414474/', classification_note = 'Ameriprise Financial PAC — confirmed Lobbyist/Registrant PAC, major financial services.'
  WHERE fec_committee_id = 'C00414474';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'pharma_health_insurance',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00420398/', classification_note = 'Boehringer Ingelheim USA PAC — confirmed Lobbyist/Registrant PAC, major pharmaceutical manufacturer.'
  WHERE fec_committee_id = 'C00420398';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'oil_gas',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00040394/', classification_note = 'Williams Companies PAC — confirmed Lobbyist/Registrant PAC, major natural gas pipeline/energy infrastructure company.'
  WHERE fec_committee_id = 'C00040394';
UPDATE pac_committees SET classification_status = 'classified', industry_code = 'big_tech_crypto',
  classification_source_url = 'https://api.open.fec.gov/v1/committee/C00196725/', classification_note = 'Hewlett Packard Enterprise PAC — confirmed Lobbyist/Registrant PAC, major technology company.'
  WHERE fec_committee_id = 'C00196725';

UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'POET PAC — confirmed real Lobbyist/Registrant PAC for POET LLC, largest US ethanol producer. Ethanol/biofuels is conceptually distinct from fossil-fuel extraction/refining; does not fit oil_gas, and no biofuels category currently exists.'
  WHERE fec_committee_id = 'C00450692';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'No Labels PAC — confirmed Unauthorized PAC, an ideological/centrist political movement organization, not industry money.'
  WHERE fec_committee_id = 'C00629709';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'AmeriPAC: The Fund for a Greater America — confirmed Leadership PAC, not industry money.'
  WHERE fec_committee_id = 'C00271338';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'A New Nation PAC — confirmed Leadership PAC, not industry money.'
  WHERE fec_committee_id = 'C00531764';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Advancing Democracy and Mobilization PAC — confirmed Leadership PAC, not industry money.'
  WHERE fec_committee_id = 'C00422774';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Patriots in Action — confirmed Leadership PAC, not industry money.'
  WHERE fec_committee_id = 'C00531590';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Medical Device Manufacturers Association PAC — medical device trade association; healthcare-provider/device cluster with no current fitting category (recurring pattern, flagged for Melissa alongside electric utilities/telecom/insurance/real estate).'
  WHERE fec_committee_id = 'C00484162';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Quest Diagnostics PAC — clinical diagnostics/lab services company, not a drug manufacturer or insurer; healthcare-provider cluster.'
  WHERE fec_committee_id = 'C00329185';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Smith & Nephew PAC — medical device manufacturer, same healthcare-provider/device cluster as Medical Device Manufacturers Assn PAC.'
  WHERE fec_committee_id = 'C00374066';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Boston Scientific PAC — medical device manufacturer, same cluster.'
  WHERE fec_committee_id = 'C00357863';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Psychiatric Association PAC — medical professional association, healthcare-provider cluster, not a pharma manufacturer or insurer.'
  WHERE fec_committee_id = 'C00373696';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Academy of Neurology PAC (BRAINPAC) — medical professional association, same cluster.'
  WHERE fec_committee_id = 'C00435933';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Health Care Association PAC — nursing home/long-term care industry association, healthcare-provider cluster.'
  WHERE fec_committee_id = 'C00006080';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Ameren Federal PAC — electric utility; recurring cluster with no current fitting category (flagged for Melissa).'
  WHERE fec_committee_id = 'C00206136';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Xcel Energy Employee PAC — electric utility, same cluster.'
  WHERE fec_committee_id = 'C00107771';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Insured Retirement Institute PAC — general/life insurance trade association; recurring cluster with no current fitting category (flagged for Melissa).'
  WHERE fec_committee_id = 'C00490474';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Commercial Real Estate Finance Council PAC — real estate; recurring cluster with no current fitting category (flagged for Melissa).'
  WHERE fec_committee_id = 'C00411173';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'International Council of Shopping Centers PAC — real estate, same cluster.'
  WHERE fec_committee_id = 'C00217638';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Nelson Mullins Riley & Scarborough Federal PAC — law firm, not an industry PAC.'
  WHERE fec_committee_id = 'C00278895';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Foley & Lardner Political Fund — law firm, not an industry PAC.'
  WHERE fec_committee_id = 'C00105338';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Balch & Bingham Federal Political Committee — law firm, not an industry PAC.'
  WHERE fec_committee_id = 'C00358440';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'American Forest & Paper Association PAC — general trade association, no fitting category among current 9.'
  WHERE fec_committee_id = 'C00029348';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Seaboard Corporation PAC — diversified agribusiness/shipping conglomerate, no fitting category.'
  WHERE fec_committee_id = 'C00246736';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'National Roofing Contractors Association PAC — trade association, no fitting category.'
  WHERE fec_committee_id = 'C00244863';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Trucking PAC of the American Trucking Associations — trade association, no fitting category.'
  WHERE fec_committee_id = 'C00002881';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'Lowe''s Companies PAC — general retail, no fitting category.'
  WHERE fec_committee_id = 'C00251751';
UPDATE pac_committees SET classification_status = 'reviewed_no_fit',
  classification_note = 'McKinsey & Company PAC — management consulting, no fitting category.'
  WHERE fec_committee_id = 'C00908228';
