import postgres from "postgres";

// Known payment-processing conduit committees (ActBlue, WinRed) -- these are real FEC-registered
// "Hybrid PAC (with Non-Contribution Account) - Nonqualified" / "Unauthorized" entities that batch-disburse
// individually-earmarked small-dollar donations to campaigns. FEC sometimes reports their bulk disbursements
// under Schedule A line 11C (real-PAC-contribution line), which is what caused the 2026-07-28 contamination
// bug -- confirmed via direct FEC committee lookup for all three IDs below. Add new IDs here if more are found.
const CONDUIT_COMMITTEE_IDS = new Set([
  'C00401224', // ACTBLUE
  'C00714725', // ACTBLUE (second registered committee ID, same organization)
  'C00694323', // WINRED
  'C00468314', // DEMOCRACY ENGINE, INC., PAC -- confirmed 2026-07-28, same Unauthorized/generic-corporation
  'C00418970', // DEMOCRACY ENGINE FEDERAL PAC -- signature as ActBlue/WinRed; real donation-processing platform
]);

const DB_URL = process.env.CONGRESS_US_DB_URL;
const FEC_KEY = process.env.FEC_API_KEY;
const sql = postgres(DB_URL, { prepare: false });
const CYCLES = [2026, 2024, 2022];

let reqCount = 0;
async function fecGet(path, params) {
  const url = new URL(`https://api.open.fec.gov/v1${path}`);
  url.searchParams.set("api_key", FEC_KEY);
  for (const [k, v] of Object.entries(params || {})) url.searchParams.set(k, v);
  for (let attempt = 0; attempt < 5; attempt++) {
    reqCount++;
    const res = await fetch(url);
    if (res.status === 429) {
      const wait = 5000 * (attempt + 1);
      console.log(`  rate limited, waiting ${wait}ms`);
      await new Promise((r) => setTimeout(r, wait));
      continue;
    }
    if (!res.ok) {
      const text = await res.text();
      throw new Error(`FEC ${res.status}: ${text.slice(0, 200)}`);
    }
    return res.json();
  }
  throw new Error("FEC rate limit retries exhausted");
}

async function findPrincipalCommittee(fecIds, chamber) {
  for (const fecId of fecIds) {
    try {
      const cand = await fecGet(`/candidate/${fecId}/`, {});
      const office = cand.results?.[0]?.office;
      const wantOffice = chamber === "senate" ? "S" : "H";
      if (office && office !== wantOffice) continue;
      // BUG FIX 2026-07-29: this only ever fetched page 1 of /committees/ (default per_page=20).
      // For long-tenured members with many joint-fundraising/leadership-PAC affiliations, the
      // real "P" (Principal campaign committee) entry can land on page 2+ -- confirmed directly
      // against Sen. Cornyn (23 total affiliated committees, "P" entry C00369033 on page 2),
      // which silently produced false "no principal committee found" results for exactly the
      // most-established members (Baldwin, Cornyn, Gillen, Ivey, Moore, Shaheen, Self). Loop
      // pages until found, same page-cap pattern already used for schedule_a below.
      let page = 1, principal = null, authorizedFallback = null;
      while (!principal && page <= 5) {
        const committees = await fecGet(`/candidate/${fecId}/committees/`, { per_page: 100, page });
        principal = committees.results?.find((c) => c.designation === "P");
        // FALLBACK 2026-07-29: confirmed against Rep. Barry Moore that some candidates' FEC
        // records simply have no "P"-designated committee at all -- his real campaign committee
        // (C00639096, "BARRY MOORE FOR CONGRESS") is tagged "A" (Authorized), matched by
        // committee_type against the member's chamber to avoid grabbing an authorized committee
        // for a *different* office (he also has an "A" Senate committee for a 2026 run).
        if (!authorizedFallback) {
          authorizedFallback = committees.results?.find(
            (c) => c.designation === "A" && c.committee_type === wantOffice
          );
        }
        if (principal) break;
        if (page >= (committees.pagination?.pages || 1)) break;
        page++;
      }
      if (principal) return principal.committee_id;
      if (authorizedFallback) return authorizedFallback.committee_id;
    } catch (e) {
      console.log(`  candidate lookup failed for ${fecId}: ${e.message}`);
    }
  }
  return null;
}

async function syncMember(bioguide, fecIds, chamber) {
  const committeeId = await findPrincipalCommittee(fecIds, chamber);
  if (!committeeId) return { ok: false, reason: "no principal committee found" };

  await sql`UPDATE members SET fec_principal_committee_id = ${committeeId} WHERE bioguide_id = ${bioguide}`;

  // Candidate ID for the by_size/by_candidate endpoint (distinct from committeeId above,
  // which is only used for the schedule_a PAC-contribution pull further down).
  const candidateId = fecIds[0];

  let cyclesWithData = 0;
  for (const cycle of CYCLES) {
    // already synced? skip (resumability)
    const existing = await sql`
      SELECT 1 FROM individual_contribution_summary WHERE bioguide_id = ${bioguide} AND cycle_year = ${cycle}
    `;
    if (existing.length > 0) { cyclesWithData++; continue; }

    // BUG FIX 2026-07-27: was calling /schedules/schedule_a/by_size/ with committee_id+cycle,
    // which silently returns empty or stale/wrong-cycle results for many committees (confirmed
    // via direct API comparison: Rep. Meuser's committee C00439448 returned either 0 results or,
    // with a different param combo, real data mislabeled cycle=2008 despite having genuine 2026
    // activity). Correct endpoint is by_size/by_candidate/ with candidate_id, which correctly
    // cycle-filters. Root-caused after Melissa caught his profile showing zero individual
    // donations when FEC's own candidate-totals endpoint shows $890,906.51 for 2026 alone.
    // Every previously-synced member's individual_contribution_summary row was fetched via the
    // broken endpoint and cannot be trusted — this script re-syncs from scratch, not just the
    // members that came back as exactly zero.
    let bySize;
    try {
      bySize = await fecGet("/schedules/schedule_a/by_size/by_candidate/", { candidate_id: candidateId, cycle });
    } catch (e) {
      console.log(`  by_size failed for ${bioguide} cycle ${cycle}: ${e.message}`);
      continue;
    }
    const buckets = {};
    for (const r of bySize.results || []) buckets[r.size] = r;
    const unitemizedTotal = buckets[0]?.total || 0;
    const count200to999 = (buckets[200]?.count || 0) + (buckets[500]?.count || 0);
    const count1000plus = (buckets[1000]?.count || 0) + (buckets[2000]?.count || 0);
    const count200toLimit = count200to999 + count1000plus; // individual legal max ($3500/election) means the 2000+ bucket is effectively bounded by law

    // verified_itemized_count_under200 is intentionally 0, not a bug: FEC's by_size taxonomy has
    // no "itemized but individually under $200" bucket — its smallest itemized bucket starts at
    // 200, and anything below that threshold that lacks its own itemized record falls into the
    // "0" (unitemized) bucket by FEC's own convention. The real under-$200 signal is captured via
    // unitemized_total_amount -> estimated_unitemized_count in the scoring formula, not this field.
    await sql`
      INSERT INTO individual_contribution_summary
        (bioguide_id, cycle_year, verified_itemized_count_under200, verified_itemized_count_200_to_limit, unitemized_total_amount, assumed_avg_unitemized_gift, source_url, synced_at)
      VALUES (${bioguide}, ${cycle}, 0, ${count200toLimit}, ${unitemizedTotal}, 30.00,
        ${`https://www.fec.gov/data/receipts/?committee_id=${committeeId}&two_year_transaction_period=${cycle}`}, now())
      ON CONFLICT (bioguide_id, cycle_year) DO UPDATE SET
        verified_itemized_count_200_to_limit = EXCLUDED.verified_itemized_count_200_to_limit,
        unitemized_total_amount = EXCLUDED.unitemized_total_amount, synced_at = now()
    `;

    // real PAC contributions (line 11C). CORRECTION 2026-07-28: the original comment here claimed
    // line 11C "excludes ActBlue/WinRed-style earmarked individual conduits" -- confirmed FALSE against
    // real data: ~\.2M in ActBlue/WinRed money landed here anyway (their bulk fund-transfer disbursements
    // to campaigns get reported on 11C by FEC even though the underlying money is individually-earmarked,
    // not real PAC decision-making). Known payment-conduit committees are now explicitly excluded below --
    // see CONDUIT_COMMITTEE_IDS -- rather than trusting the line-number filter alone to catch them.
    let page = 1, gotAll = false, pacRows = [];
    while (!gotAll && page <= 10) {
      let sched;
      try {
        sched = await fecGet("/schedules/schedule_a/", {
          committee_id: committeeId, cycle, line_number: "F3-11C", per_page: 100, page, sort: "-contribution_receipt_date",
        });
      } catch (e) {
        console.log(`  schedule_a failed for ${bioguide} cycle ${cycle} page ${page}: ${e.message}`);
        break;
      }
      pacRows.push(...(sched.results || []));
      gotAll = (sched.results || []).length < 100 || page >= (sched.pagination?.pages || 1);
      page++;
    }

    for (const r of pacRows) {
      if (!r.contributor_id) continue;
      const isConduit = CONDUIT_COMMITTEE_IDS.has(r.contributor_id);
      await sql`
        INSERT INTO pac_committees (fec_committee_id, committee_name, classification_status, is_conduit)
        VALUES (${r.contributor_id}, ${r.contributor_name || "UNKNOWN"}, 'needs_review', ${isConduit})
        ON CONFLICT (fec_committee_id) DO UPDATE SET is_conduit = ${isConduit} WHERE pac_committees.is_conduit IS DISTINCT FROM ${isConduit}
      `;
      if (isConduit) continue; // payment-processing conduit (ActBlue/WinRed) -- real money, but not PAC money; individual-contribution sync captures it correctly elsewhere
      // CRITICAL FIX 2026-08-25: this table had NO real uniqueness constraint until migration
      // 0085 -- the bare `ON CONFLICT DO NOTHING` below was a silent no-op the entire time,
      // since there was nothing for it to conflict against. Every resync ever run re-inserted
      // the same real transactions as brand-new duplicate rows (~15x average inflation
      // dataset-wide by the time it was caught). Now explicit against the real constraint added
      // in 0085 (bioguide_id, fec_committee_id, cycle_year, fec_transaction_id) -- this is the
      // actual fix; the ON CONFLICT clause only works because that constraint now exists.
      await sql`
        INSERT INTO pac_contributions (bioguide_id, cycle_year, fec_committee_id, amount, contribution_date, fec_transaction_id, source_url, synced_at)
        VALUES (${bioguide}, ${cycle}, ${r.contributor_id}, ${r.contribution_receipt_amount || 0},
          ${r.contribution_receipt_date}, ${r.sub_id}, ${`https://www.fec.gov/data/receipts/?committee_id=${committeeId}`}, now())
        ON CONFLICT ON CONSTRAINT pac_contributions_natural_key DO NOTHING
      `;
    }
    cyclesWithData++;
  }
  return { ok: true, cyclesWithData };
}

async function main() {
  const limitArg = process.argv[2] ? parseInt(process.argv[2]) : null;
  // TARGET_BIOGUIDES: optional comma-separated bioguide_id allowlist, added 2026-07-29 to let a
  // gap-fill run skip the ~500 already-healthy members entirely instead of burning 1-2 FEC API
  // calls each on a committee-lookup that's just going to be discarded when every cycle turns out
  // already-synced. Unset (default) preserves the original full-roster behavior exactly.
  const targetIds = process.env.TARGET_BIOGUIDES
    ? process.env.TARGET_BIOGUIDES.split(",").map((s) => s.trim()).filter(Boolean)
    : null;
  // 2026-07-27: removed "AND m.fec_principal_committee_id IS NULL" from this WHERE clause —
  // that condition made sense for the original first-pass sync, but now we need to re-run
  // the individual-contribution fetch (see BUG FIX comment above) for members who already have
  // a committee ID from the first pass. Re-deriving the committee ID is a cheap, idempotent
  // 1-2 extra API calls per member; individual_contribution_summary rows were cleared separately
  // before this run so the per-cycle "already synced" resumability check won't skip them.
  const members = await sql`
    SELECT m.bioguide_id, m.fec_candidate_ids, mt.chamber
    FROM members m
    JOIN member_terms mt ON mt.bioguide_id = m.bioguide_id AND mt.is_current = true
    WHERE array_length(m.fec_candidate_ids, 1) > 0
    ${targetIds ? sql`AND m.bioguide_id IN ${sql(targetIds)}` : sql``}
    ORDER BY m.bioguide_id
    ${limitArg ? sql`LIMIT ${limitArg}` : sql``}
  `;
  console.log(`Processing ${members.length} members (already-synced cycles skipped per-member)`);

  let ok = 0, fail = 0;
  for (const m of members) {
    process.stdout.write(`${m.bioguide_id} (${m.chamber})... `);
    try {
      const r = await syncMember(m.bioguide_id, m.fec_candidate_ids, m.chamber);
      if (r.ok) { ok++; console.log(`ok, ${r.cyclesWithData}/3 cycles`); }
      else { fail++; console.log(`skip: ${r.reason}`); }
    } catch (e) {
      fail++;
      console.log(`ERROR: ${e.message}`);
    }
  }
  console.log(`\nDone. ok=${ok} fail=${fail} total_requests=${reqCount}`);
  await sql.end();
}

main().catch((e) => { console.error(e); process.exit(1); });
