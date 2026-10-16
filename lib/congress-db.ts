import postgres from "postgres";

let _sql: ReturnType<typeof postgres> | null = null;

function getSql() {
  if (!_sql) {
    const url = process.env.CONGRESS_US_DB_URL;
    if (!url) throw new Error("CONGRESS_US_DB_URL is not set");
    _sql = postgres(url, { prepare: false, max: 5 });
  }
  return _sql;
}

export interface TrackedItemRow {
  id: number;
  slug: string;
  title: string;
  short_description: string | null;
  long_description: string | null;
  item_type: "bill_tracker" | "compliance_tracker";
  category: string | null;
  display_order: number;
  poll_status: "sourced" | "needs_research" | null;
  poll_source: string | null;
  poll_url: string | null;
  poll_date: string | null;
  poll_stat_text: string | null;
}

export interface TrackedItemBillRow {
  id: number;
  congress_number: number;
  bill_type: string;
  bill_number: number;
  official_title: string | null;
  latest_action_text: string | null;
  latest_action_date: string | null;
  is_enacted: boolean;
  verification_status: "verified" | "needs_review";
  source_url: string | null;
}

export interface ComplianceTrackerRow {
  id: number;
  law_citation: string | null;
  law_url: string | null;
  required_action_description: string | null;
  deadline_date: string | null;
  overall_status: "compliant" | "partial" | "noncompliant" | "unknown";
}

export interface ComplianceUpdateRow {
  id: number;
  update_date: string;
  status_as_of: string | null;
  summary: string;
  source_url: string;
  source_name: string | null;
}

export interface ScoringConfigRow {
  key: string;
  value: string;
  description: string | null;
}

export interface MemberRow {
  bioguide_id: string;
  first_name: string;
  last_name: string;
  full_name: string;
  photo_url: string | null;
  slug: string;
}

export interface MemberTermRow {
  chamber: "house" | "senate";
  state: string;
  district: number | null;
  party: string;
  is_current: boolean;
}

export async function listTrackedItems() {
  const sql = getSql();
  return sql<TrackedItemRow[]>`
    SELECT id, slug, title, short_description, long_description, item_type, category,
           display_order, poll_status, poll_source, poll_url, poll_date, poll_stat_text
    FROM tracked_items
    ORDER BY display_order
  `;
}

export async function getTrackedItemBySlug(slug: string) {
  const sql = getSql();
  const rows = await sql<TrackedItemRow[]>`
    SELECT id, slug, title, short_description, long_description, item_type, category,
           display_order, poll_status, poll_source, poll_url, poll_date, poll_stat_text
    FROM tracked_items WHERE slug = ${slug}
  `;
  return rows[0] ?? null;
}

export async function getTrackedItemBills(trackedItemId: number) {
  const sql = getSql();
  return sql<TrackedItemBillRow[]>`
    SELECT id, congress_number, bill_type, bill_number, official_title, latest_action_text,
           latest_action_date, is_enacted, verification_status, source_url
    FROM tracked_item_bills
    WHERE tracked_item_id = ${trackedItemId}
    ORDER BY congress_number DESC
  `;
}

export async function getComplianceTracker(trackedItemId: number) {
  const sql = getSql();
  const rows = await sql<ComplianceTrackerRow[]>`
    SELECT id, law_citation, law_url, required_action_description, deadline_date, overall_status
    FROM compliance_trackers WHERE tracked_item_id = ${trackedItemId}
  `;
  return rows[0] ?? null;
}

export async function getComplianceUpdates(complianceTrackerId: number) {
  const sql = getSql();
  return sql<ComplianceUpdateRow[]>`
    SELECT id, update_date, status_as_of, summary, source_url, source_name
    FROM compliance_updates
    WHERE compliance_tracker_id = ${complianceTrackerId}
    ORDER BY update_date DESC
  `;
}

export async function getScoringConfig() {
  const sql = getSql();
  const rows = await sql<ScoringConfigRow[]>`
    SELECT key, value, description FROM scoring_config ORDER BY key
  `;
  const byKey: Record<string, string> = {};
  for (const r of rows) byKey[r.key] = r.value;
  return { rows, byKey };
}

export interface PacIndustryRow {
  code: string;
  label: string;
  polarity: "negative" | "positive";
  description: string | null;
  color_hex: string | null;
  severity_weight: string;
}

export async function listPacIndustries() {
  const sql = getSql();
  return sql<PacIndustryRow[]>`
    SELECT code, label, polarity, description, color_hex, severity_weight
    FROM pac_industries
    WHERE is_active = true
    ORDER BY polarity DESC, severity_weight DESC, code
  `;
}

export async function listMembers(opts: { search?: string } = {}) {
  const sql = getSql();
  const term = `%${(opts.search ?? "").toLowerCase()}%`;
  if (opts.search) {
    return sql<MemberRow[]>`
      SELECT bioguide_id, first_name, last_name, full_name, photo_url, slug
      FROM members
      WHERE lower(full_name) LIKE ${term}
      ORDER BY last_name, first_name
    `;
  }
  return sql<MemberRow[]>`
    SELECT bioguide_id, first_name, last_name, full_name, photo_url, slug
    FROM members ORDER BY last_name, first_name
  `;
}

export async function getMemberBySlug(slug: string) {
  const sql = getSql();
  const rows = await sql<MemberRow[]>`
    SELECT bioguide_id, first_name, last_name, full_name, photo_url, slug
    FROM members WHERE slug = ${slug}
  `;
  return rows[0] ?? null;
}

export async function getMemberCurrentTerm(bioguideId: string) {
  const sql = getSql();
  const rows = await sql<MemberTermRow[]>`
    SELECT chamber, state, district, party, is_current
    FROM member_terms WHERE bioguide_id = ${bioguideId} AND is_current = true
    LIMIT 1
  `;
  return rows[0] ?? null;
}

export async function findMemberByStateDistrict(state: string, district: number | null) {
  const sql = getSql();
  const rows = district === null
    ? await sql<(MemberRow & MemberTermRow)[]>`
        SELECT m.bioguide_id, m.first_name, m.last_name, m.full_name, m.photo_url, m.slug,
               mt.chamber, mt.state, mt.district, mt.party, mt.is_current
        FROM members m JOIN member_terms mt ON mt.bioguide_id = m.bioguide_id
        WHERE mt.is_current = true AND mt.state = ${state} AND mt.chamber = 'senate'
      `
    : await sql<(MemberRow & MemberTermRow)[]>`
        SELECT m.bioguide_id, m.first_name, m.last_name, m.full_name, m.photo_url, m.slug,
               mt.chamber, mt.state, mt.district, mt.party, mt.is_current
        FROM members m JOIN member_terms mt ON mt.bioguide_id = m.bioguide_id
        WHERE mt.is_current = true AND mt.state = ${state} AND mt.district = ${district}
      `;
  return rows;
}

export interface MemberDirectoryRow {
  bioguide_id: string;
  full_name: string;
  last_name: string;
  photo_url: string | null;
  slug: string;
  chamber: "house" | "senate";
  state: string;
  district: number | null;
  party: string;
  composite_score: string | null;
  funding_data_status: "ready" | "insufficient_data";
  alignment_data_status: "ready" | "insufficient_data";
  top_negative_industry_code: string | null;
  percentile_rank: string | null;
  funding_percentile_rank: string | null;
  alignment_percentile_rank: string | null;
  funding_lean_intensity: string | null;
  funding_lean_direction: string | null;
  foreign_lobby_percentile_rank: string | null;
}

export async function listMembersForDirectory(opts: {
  search?: string;
  state?: string;
  sortBy?: "name" | "party" | "score";
} = {}) {
  const sql = getSql();
  const searchTerm = opts.search ? `%${opts.search.toLowerCase()}%` : null;
  const rows = await sql<MemberDirectoryRow[]>`
    SELECT m.bioguide_id, m.full_name, m.last_name, m.photo_url, m.slug,
           mt.chamber, mt.state, mt.district, mt.party,
           ms.composite_score, ms.top_negative_industry_code, ms.percentile_rank,
           ms.funding_percentile_rank, ms.alignment_percentile_rank,
           ms.funding_lean_intensity, ms.funding_lean_direction, ms.foreign_lobby_percentile_rank,
           COALESCE(ms.funding_data_status, 'insufficient_data') AS funding_data_status,
           COALESCE(ms.alignment_data_status, 'insufficient_data') AS alignment_data_status
    FROM members m
    JOIN member_terms mt ON mt.bioguide_id = m.bioguide_id AND mt.is_current = true
    LEFT JOIN member_scores ms ON ms.bioguide_id = m.bioguide_id
    WHERE (${searchTerm}::text IS NULL OR lower(m.full_name) LIKE ${searchTerm})
      AND (${opts.state ?? null}::text IS NULL OR mt.state = ${opts.state ?? null})
    ORDER BY
      CASE WHEN ${opts.sortBy ?? "name"} = 'party' THEN mt.party END ASC,
      CASE WHEN ${opts.sortBy ?? "name"} = 'score' THEN ms.composite_score END DESC NULLS LAST,
      m.last_name ASC
  `;
  return rows;
}

export interface FundingSummaryRow {
  cycle_year: number;
  verified_itemized_count_under200: number;
  verified_itemized_count_200_to_limit: number;
  unitemized_total_amount: string;
  estimated_unitemized_count: string | null;
}

export interface FundingIndustryBreakdownRow {
  code: string | null;
  label: string | null;
  polarity: "negative" | "positive" | null;
  color_hex: string | null;
  total_amount: string;
  contribution_count: string;
}

export async function getMemberFundingSummary(bioguideId: string) {
  const sql = getSql();
  return sql<FundingSummaryRow[]>`
    SELECT cycle_year, verified_itemized_count_under200, verified_itemized_count_200_to_limit,
           unitemized_total_amount, estimated_unitemized_count
    FROM individual_contribution_summary
    WHERE bioguide_id = ${bioguideId}
    ORDER BY cycle_year DESC
  `;
}

export async function getMemberFundingByIndustry(bioguideId: string) {
  const sql = getSql();
  // pi.code is NULL for both needs_review and reviewed_no_fit committees (neither has an
  // industry_code) — group on classification_status too so genuinely-unreviewed money is
  // never visually conflated with money that WAS reviewed and deliberately found not to fit
  // any of our 9 categories. See 0017/0018 migrations for why this distinction matters.
  return sql<FundingIndustryBreakdownRow[]>`
    SELECT pi.code, 
           COALESCE(pi.label, 
             CASE pcm.classification_status
               WHEN 'reviewed_no_fit' THEN 'Reviewed — no fitting category'
               ELSE 'Uncategorized (needs review)'
             END
           ) AS label,
           pi.polarity, pi.color_hex,
           SUM(pc.amount)::text AS total_amount,
           COUNT(*)::text AS contribution_count
    FROM pac_contributions pc
    JOIN pac_committees pcm ON pcm.fec_committee_id = pc.fec_committee_id
    LEFT JOIN pac_industries pi ON pi.code = pcm.industry_code
    WHERE pc.bioguide_id = ${bioguideId}
    GROUP BY pi.code, pi.label, pi.polarity, pi.color_hex, pcm.classification_status
    ORDER BY SUM(pc.amount) DESC
  `;
}

export interface MemberScoreRow {
  funding_raw_score: string | null;
  funding_display_score: string | null;
  alignment_raw_score: string | null;
  alignment_display_score: string | null;
  composite_score: string | null;
  top_negative_industry_code: string | null;
  percentile_rank: string | null;
  grassroots_total_amount: string | null;
  pac_total_amount: string | null;
  people_pac_ratio: string | null;
  funding_data_status: "ready" | "insufficient_data";
  alignment_data_status: "ready" | "insufficient_data";
  funding_percentile_rank: string | null;
  alignment_percentile_rank: string | null;
  funding_lean_intensity: string | null;
  funding_lean_direction: string | null;
  funding_lean_percentile_rank: string | null;
  foreign_lobby_percentile_rank: string | null;
}

export async function getMemberScore(bioguideId: string) {
  const sql = getSql();
  const rows = await sql<MemberScoreRow[]>`
    SELECT funding_raw_score, funding_display_score, alignment_raw_score, alignment_display_score,
           composite_score, top_negative_industry_code, percentile_rank, grassroots_total_amount, pac_total_amount,
           people_pac_ratio, funding_data_status, alignment_data_status,
           funding_percentile_rank, alignment_percentile_rank,
           funding_lean_intensity, funding_lean_direction, funding_lean_percentile_rank,
           foreign_lobby_percentile_rank
    FROM member_scores WHERE bioguide_id = ${bioguideId}
  `;
  return rows[0] ?? null;
}

export interface TopNegativeIndustryRow {
  industry_code: string;
  label: string;
  color_hex: string | null;
  amount: string;
}

// Returns ALL industries tied for top (usually 1 row, occasionally more on a genuine
// exact-dollar tie — real case: Rep. Danny K. Davis, $240,000 each from two industries).
// Never silently picks a single winner among ties.
export async function getTopNegativeIndustries(bioguideId: string) {
  const sql = getSql();
  return sql<TopNegativeIndustryRow[]>`
    SELECT mt.industry_code, pi.label, pi.color_hex, mt.amount::text
    FROM member_top_negative_industries mt
    JOIN pac_industries pi ON pi.code = mt.industry_code
    WHERE mt.bioguide_id = ${bioguideId}
    ORDER BY mt.industry_code
  `;
}

// Pooled dataset-wide average of grassroots-$-total / PAC-$-total, cached in
// scoring_config and refreshed by refresh_member_scores() — read live, never hardcoded.
export async function getDatasetAvgPeoplePacRatio(): Promise<number> {
  const sql = getSql();
  const rows = await sql<{ value: string }[]>`
    SELECT value FROM scoring_config WHERE key = 'dataset_avg_people_pac_ratio'
  `;
  return rows[0] ? parseFloat(rows[0].value) : 0;
}

export interface MemberPositionRow {
  tracked_item_slug: string;
  tracked_item_title: string;
  item_type: "bill_tracker" | "compliance_tracker";
  category: string | null;
  tracked_item_bill_id: number;
  congress_number: number;
  bill_type: string;
  bill_number: number;
  official_title: string | null;
  position_type: "sponsor" | "cosponsor" | "voted_yea" | "voted_nay" | "voted_present" | null;
  position_date: string | null;
}

/**
 * A tracked_item_bill applies to this member if their chamber matches the bill's chamber, and
 * either (a) it's a current (119th) Congress bill — every current member is presumed eligible to
 * have acted on it, or (b) it's an older Congress's bill AND we have an actual position record for
 * this member. (b) exists because member_terms only has 119th-Congress data (Legislators Sync only
 * pulls current terms) — we can't yet verify who held office during the 117th/118th Congress, so we
 * can't safely count silence on an older bill as a real "no action" signal for every current member.
 * Known limitation, not a bug: this means older-Congress-only items (End Forever Wars, Tax the
 * Ultra-Wealthy) will only show up for members who have an actual synced position on them.
 */
export async function getMemberPositions(bioguideId: string, chamber: "house" | "senate") {
  const sql = getSql();
  const billTypes = chamber === "house" ? ["hr", "hjres"] : ["s", "sjres"];
  return sql<MemberPositionRow[]>`
    SELECT ti.slug AS tracked_item_slug, ti.title AS tracked_item_title, ti.item_type, ti.category,
           tib.id AS tracked_item_bill_id, tib.congress_number, tib.bill_type, tib.bill_number,
           tib.official_title, mbp.position_type, mbp.position_date::text AS position_date
    FROM tracked_items ti
    JOIN tracked_item_bills tib ON tib.tracked_item_id = ti.id
    LEFT JOIN member_bill_positions mbp
      ON mbp.tracked_item_bill_id = tib.id AND mbp.bioguide_id = ${bioguideId}
    WHERE tib.bill_type = ANY(${billTypes})
      AND (
        tib.congress_number = 119
        OR EXISTS (
          SELECT 1 FROM member_bill_positions mbp2
          WHERE mbp2.tracked_item_bill_id = tib.id AND mbp2.bioguide_id = ${bioguideId}
        )
      )
    ORDER BY ti.display_order
  `;
}

export interface HomepageStats {
  membersScored: number;
  totalMembers: number;
  billsTracked: number;
  pacsClassified: number;
  pacMoneyMillions: number;
}

/** Real, live counts for the homepage hero — never hardcoded, so they stay honest as data grows. */
export async function getHomepageStats(): Promise<HomepageStats> {
  const sql = getSql();
  const rows = await sql<
    {
      total_members: number;
      members_scored: number;
      bills_tracked: number;
      pacs_classified: number;
      pac_money_millions: string;
    }[]
  >`
    SELECT
      (SELECT COUNT(*) FROM members) AS total_members,
      (SELECT COUNT(*) FROM member_scores WHERE composite_score IS NOT NULL) AS members_scored,
      (SELECT COUNT(*) FROM tracked_items) AS bills_tracked,
      (SELECT COUNT(DISTINCT fec_committee_id) FROM pac_committees WHERE classification_status = 'classified') AS pacs_classified,
      (SELECT ROUND(SUM(amount) / 1000000.0, 1) FROM pac_contributions) AS pac_money_millions
  `;
  const r = rows[0];
  return {
    membersScored: r?.members_scored ?? 0,
    totalMembers: r?.total_members ?? 0,
    billsTracked: r?.bills_tracked ?? 0,
    pacsClassified: r?.pacs_classified ?? 0,
    pacMoneyMillions: r ? parseFloat(r.pac_money_millions) : 0,
  };
}

export interface PeacePledgeRow {
  signed_date: string | null;
  source_url: string;
}

/** Whether this member signed TrackAIPAC's PEACE Pledge. Manually seeded, not live-synced -- see
 * the peace_pledge_signatures table comment for the checked_at staleness caveat. */
export async function getPeacePledgeSignature(bioguideId: string) {
  const sql = getSql();
  const rows = await sql<PeacePledgeRow[]>`
    SELECT signed_date::text, source_url FROM peace_pledge_signatures WHERE bioguide_id = ${bioguideId}
  `;
  return rows[0] ?? null;
}

export interface ForeignPolicyContextNoteRow {
  slug: string;
  title: string;
  body: string;
  source_url: string;
}

/** Informational-only context notes (e.g. FY27 NDAA Section 219/224) -- deliberately NOT tied to
 * any per-member position, see the table comment in migration 0083 for why. */
export async function listForeignPolicyContextNotes() {
  const sql = getSql();
  return sql<ForeignPolicyContextNoteRow[]>`
    SELECT slug, title, body, source_url FROM foreign_policy_context_notes ORDER BY id
  `;
}

export interface MemberTopPacRow {
  fec_committee_id: string;
  committee_name: string;
  total_amount: string;
  contribution_count: string;
  lean_direction: string | null;
  lean_intensity: string | null;
}

/** Top 12 PACs by dollar amount funding this member, within the same trailing cycle window used
 * everywhere else on the site -- each with its OWN committee-level partisan lean (persisted by
 * refresh_member_scores.sql, migration 0086), for the "PAC Lean" tab. */
export async function getMemberTopPacs(bioguideId: string) {
  const sql = getSql();
  const rows = await sql<MemberTopPacRow[]>`
    WITH ranked_cycles AS (
      SELECT DISTINCT cycle_year FROM pac_contributions
      ORDER BY cycle_year DESC
      LIMIT (SELECT value::int FROM scoring_config WHERE key = 'funding_cycle_window')
    )
    SELECT pcm.fec_committee_id, pcm.committee_name,
           SUM(pc.amount)::text AS total_amount, COUNT(*)::text AS contribution_count,
           pcm.lean_direction::text, pcm.lean_intensity::text
    FROM pac_contributions pc
    JOIN pac_committees pcm ON pcm.fec_committee_id = pc.fec_committee_id
    WHERE pc.bioguide_id = ${bioguideId}
      AND pc.cycle_year IN (SELECT cycle_year FROM ranked_cycles)
      AND COALESCE(pcm.is_conduit, false) = false
    GROUP BY pcm.fec_committee_id, pcm.committee_name, pcm.lean_direction, pcm.lean_intensity
    ORDER BY SUM(pc.amount) DESC
    LIMIT 12
  `;
  return rows;
}
