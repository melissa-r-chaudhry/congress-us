-- Pass 23: main dollar-ranked sweep continuation, real FEC-verified classifications.

UPDATE pac_committees SET classification_status='classified', industry_code='healthcare_providers_medical_devices',
  classification_note='Steris Corporation Employee PAC — confirmed real medical sterilization/surgical equipment manufacturer via known public identity, live FEC record confirms real corporate PAC.'
WHERE fec_committee_id='C00368720';

UPDATE pac_committees SET classification_status='classified', industry_code='healthcare_providers_medical_devices',
  classification_note='Thermo Fisher Scientific Inc. PAC — confirmed real scientific-instruments/laboratory/medical-device manufacturer via known public identity.'
WHERE fec_committee_id='C00292318';

UPDATE pac_committees SET classification_status='classified', industry_code='telecom_media',
  classification_note='Nexstar Media Group, Inc. PAC — confirmed real broadcast media/television station ownership corporation via known public identity.'
WHERE fec_committee_id='C00567388';

UPDATE pac_committees SET classification_status='classified', industry_code='general_life_insurance',
  classification_note='Sentry Insurance Company Federal PAC — confirmed real insurance corporation via known public identity.'
WHERE fec_committee_id='C00545194';

UPDATE pac_committees SET classification_status='classified', industry_code='electric_utilities',
  classification_note='America''s Electric Cooperative PAC - Oklahoma (aka "Oklahoma ACRE Committee") — confirmed real electric-cooperative Trade Association via live FEC lookup.'
WHERE fec_committee_id='C00133561';

UPDATE pac_committees SET classification_status='classified', industry_code='healthcare_providers_medical_devices',
  classification_note='National Health Corporation PAC — confirmed real healthcare-provider (nursing home/long-term care operator) corporation via live FEC lookup.'
WHERE fec_committee_id='C00153445';

UPDATE pac_committees SET classification_status='classified', industry_code='general_life_insurance',
  classification_note='National Structured Settlements Trade Association PAC — confirmed real Trade Association for structured-settlement (insurance/annuity-adjacent) financial products via live FEC lookup.'
WHERE fec_committee_id='C00219444';

-- reviewed_no_fit: confirmed real, verified, don't fit any current category
UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='BEEPAC (Building Economic Empowerment PAC) — confirmed real Leadership PAC via live FEC lookup (leadership_pac flag set), not industry money.'
WHERE fec_committee_id='C00494112';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Health Jobs Justice — confirmed real Leadership PAC via live FEC lookup (leadership_pac flag set) despite the healthcare-adjacent name, not industry money.'
WHERE fec_committee_id='C00769109';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Beat the Odds PAC — confirmed real Leadership PAC via live FEC lookup (leadership_pac flag set), not gambling-industry money despite the name.'
WHERE fec_committee_id='C00721233';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Oorah! Political Action Committee — confirmed real Leadership PAC via live FEC lookup (leadership_pac flag set), not industry money.'
WHERE fec_committee_id='C00551853';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Bunge North America Inc PAC — agriculture/grain-trading corporation, no fitting category among current 10.'
WHERE fec_committee_id='C00401687';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Employee Owned S Corporations of America PAC — trade association for a business-structure type, not an industry, no fitting category.'
WHERE fec_committee_id='C00458257';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='American Road and Transportation Builders PAC — infrastructure/construction trade association, no fitting category among current 10.'
WHERE fec_committee_id='C00118208';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Automotive Free International Trade PAC — automotive-industry trade group, no fitting category among current 10.'
WHERE fec_committee_id='C00250399';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Archer Daniels Midland Company PAC — agriculture/food-processing corporation, no fitting category among current 10.'
WHERE fec_committee_id='C00093963';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Auto Care Association PAC — automotive aftermarket trade association, no fitting category among current 10.'
WHERE fec_committee_id='C00250753';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='National Association of Social Workers PACE — professional association for social work, not a fitting industry category (distinct from healthcare-provider/medical-device scope).'
WHERE fec_committee_id='C00060707';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='DLA Piper PAC — confirmed law firm PAC, no fitting industry category.'
WHERE fec_committee_id='C00151340';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Black & Veatch PAC — confirmed real diversified engineering/construction corporation (power, water, telecom infrastructure) via live FEC lookup; held to the established "diversified, not dominant enough in one category" precedent (same as AECOM/Jacobs Solutions), no fitting category.'
WHERE fec_committee_id='C00012310';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Stanley Black & Decker, Inc. PAC — tools/hardware manufacturing corporation, no fitting category among current 10.'
WHERE fec_committee_id='C00060087';

UPDATE pac_committees SET classification_status='reviewed_no_fit',
  classification_note='Cerris Inc. PAC (formerly MMC Corp PAC) — confirmed real corporation via live FEC lookup, specific industry unclear from available data, no confident fitting category.'
WHERE fec_committee_id='C00509356';
