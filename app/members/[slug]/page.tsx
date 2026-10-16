import { notFound } from "next/navigation";
import {
  getMemberBySlug,
  getMemberCurrentTerm,
  getMemberScore,
  getMemberPositions,
  getMemberFundingSummary,
  getMemberFundingByIndustry,
  listPacIndustries,
  getTopNegativeIndustries,
  getDatasetAvgPeoplePacRatio,
  getPeacePledgeSignature,
  listForeignPolicyContextNotes,
  getMemberTopPacs,
} from "@/lib/congress-db";
import { generateMemberWriteup } from "@/lib/member-writeup";

export const dynamic = "force-dynamic";

const POSITION_LABEL: Record<string, string> = {
  sponsor: "Sponsored",
  cosponsor: "Cosponsored",
  voted_yea: "Voted Yes",
  voted_nay: "Voted No",
  voted_present: "Voted Present",
};

const POSITION_COLOR: Record<string, string> = {
  sponsor: "text-green-400",
  cosponsor: "text-green-400",
  voted_yea: "text-green-400",
  voted_nay: "text-red-400",
  voted_present: "text-gray-400",
};

const TABS = [
  { key: "pacs", label: "The People vs. The PACs" },
  { key: "bills", label: "The 80% Bill" },
  { key: "independence", label: "Independence / Israel" },
  { key: "lean", label: "PAC Lean" },
] as const;
type TabKey = (typeof TABS)[number]["key"];

// Same calculated red<->magenta<->blue interpolation used on the member card grid -- kept in
// sync intentionally, see app/members/page.tsx for the canonical comment.
function leanColor(direction: number | null): string {
  if (direction === null) return "#6b7280";
  const hue = (240 + 120 * direction) % 360;
  return hslToHex(hue, 68, 62);
}
function hslToHex(h: number, s: number, l: number): string {
  const sN = s / 100, lN = l / 100;
  const k = (n: number) => (n + h / 30) % 12;
  const a = sN * Math.min(lN, 1 - lN);
  const f = (n: number) => lN - a * Math.max(-1, Math.min(k(n) - 3, Math.min(9 - k(n), 1)));
  const toHex = (x: number) => Math.round(255 * x).toString(16).padStart(2, "0");
  return `#${toHex(f(0))}${toHex(f(8))}${toHex(f(4))}`;
}

export default async function MemberDetailPage({
  params,
  searchParams,
}: {
  params: Promise<{ slug: string }>;
  searchParams: Promise<{ tab?: string }>;
}) {
  const { slug } = await params;
  const { tab } = await searchParams;
  const activeTab: TabKey = TABS.some((t) => t.key === tab) ? (tab as TabKey) : "pacs";

  const member = await getMemberBySlug(slug);
  if (!member) notFound();

  const term = await getMemberCurrentTerm(member.bioguide_id);
  const [score, allPositions, fundingSummary, fundingByIndustry, industries, topNegIndustries, datasetAvgRatio, peacePledge, foreignPolicyNotes, topPacs] = await Promise.all([
    getMemberScore(member.bioguide_id),
    term ? getMemberPositions(member.bioguide_id, term.chamber) : Promise.resolve([]),
    getMemberFundingSummary(member.bioguide_id),
    getMemberFundingByIndustry(member.bioguide_id),
    listPacIndustries(),
    getTopNegativeIndustries(member.bioguide_id),
    getDatasetAvgPeoplePacRatio(),
    getPeacePledgeSignature(member.bioguide_id),
    listForeignPolicyContextNotes(),
    getMemberTopPacs(member.bioguide_id),
  ]);
  const industryByCode = Object.fromEntries(industries.map((i) => [i.code, i]));
  const topIndustryCodes = new Set(topNegIndustries.map((t) => t.industry_code));
  const isTiedTop = topNegIndustries.length > 1;
  const memberRatio = score?.people_pac_ratio !== null && score?.people_pac_ratio !== undefined
    ? Number(score.people_pac_ratio) : null;
  const pacTotal = score?.pac_total_amount ? Number(score.pac_total_amount) : 0;

  const positions = allPositions.filter((p) => p.category !== "foreign_policy");
  const foreignPolicyPositions = allPositions.filter((p) => p.category === "foreign_policy");
  const aipacRow = fundingByIndustry.find((r) => r.code === "aipac_aligned");
  const aipacAmount = aipacRow ? Number(aipacRow.total_amount) : 0;

  const writeup = term
    ? generateMemberWriteup({
        fullName: member.full_name,
        chamber: term.chamber,
        positions: allPositions,
        score,
        fundingByIndustry,
        peacePledge,
        aipacAmount,
        datasetAvgRatio,
      })
    : "";

  const fundingReady = score?.funding_data_status === "ready";
  const totalUnder200 = fundingSummary.reduce(
    (sum, r) => sum + r.verified_itemized_count_under200 + Number(r.estimated_unitemized_count ?? 0),
    0
  );
  const total200ToLimit = fundingSummary.reduce((sum, r) => sum + r.verified_itemized_count_200_to_limit, 0);
  const maxIndustryAmount = Math.max(1, ...fundingByIndustry.map((r) => Number(r.total_amount)));
  const maxPacAmount = Math.max(1, ...topPacs.map((r) => Number(r.total_amount)));

  return (
    <div className="max-w-3xl space-y-6">
      <div className="flex items-center gap-4">
        {member.photo_url ? (
          // eslint-disable-next-line @next/next/no-img-element
          <img src={member.photo_url} alt={member.full_name} className="w-24 h-24 rounded-full object-cover" />
        ) : (
          <div className="w-24 h-24 rounded-full bg-[#33363f] flex items-center justify-center text-xs text-gray-500">
            No photo
          </div>
        )}
        <div>
          <h1 className="text-3xl font-bold">{member.full_name}</h1>
          {term && (
            <p className="text-gray-400">
              {term.chamber === "senate" ? "Senator" : "Representative"} — {term.state}
              {term.district !== null ? `-${term.district}` : ""} ({term.party})
            </p>
          )}
        </div>
      </div>

      <section className="card p-6">
        <h2 className="font-semibold accent-gold mb-3">Score Summary</h2>
        {score?.percentile_rank !== null && score?.percentile_rank !== undefined ? (
          <p className="text-4xl font-bold mb-3">
            {Number(score.percentile_rank).toFixed(0)}<span className="text-lg text-gray-500">th percentile</span>
          </p>
        ) : (
          <p className="text-sm text-gray-400 italic mb-3">
            Insufficient data for a composite score yet — {score?.funding_data_status !== "ready" ? "funding data still syncing" : "alignment data still syncing"}.
          </p>
        )}
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 text-sm">
          <div>
            <p className="text-gray-400">Funding Independence</p>
            <p className="font-semibold">
              {score?.funding_percentile_rank !== null && score?.funding_percentile_rank !== undefined
                ? `${Number(score.funding_percentile_rank).toFixed(0)}th pct`
                : <span className="text-gray-500 italic text-xs">syncing</span>}
            </p>
          </div>
          <div>
            <p className="text-gray-400">PAC Funding Lean</p>
            <p className="font-semibold" style={{ color: score?.funding_lean_direction !== null && score?.funding_lean_direction !== undefined ? leanColor(Number(score.funding_lean_direction)) : undefined }}>
              {score?.funding_lean_intensity !== null && score?.funding_lean_intensity !== undefined
                ? `${(Number(score.funding_lean_intensity) / 10).toFixed(1)} / 10`
                : <span className="text-gray-500 italic text-xs">no PAC data</span>}
            </p>
          </div>
          <div>
            <p className="text-gray-400">80% Bill Alignment</p>
            <p className="font-semibold">
              {score?.alignment_percentile_rank !== null && score?.alignment_percentile_rank !== undefined
                ? `${Number(score.alignment_percentile_rank).toFixed(0)}th pct`
                : <span className="text-gray-500 italic text-xs">syncing</span>}
            </p>
          </div>
          <div>
            <p className="text-gray-400">Foreign Lobby Indep.</p>
            <p className="font-semibold">
              {score?.foreign_lobby_percentile_rank !== null && score?.foreign_lobby_percentile_rank !== undefined
                ? `${Number(score.foreign_lobby_percentile_rank).toFixed(0)}th pct`
                : <span className="text-gray-500 italic text-xs">no PAC data</span>}
            </p>
          </div>
        </div>
      </section>

      <section className="card p-6">
        <h2 className="font-semibold accent-gold mb-2">Summary</h2>
        <p className="text-gray-300 leading-relaxed">{writeup}</p>
      </section>

      <nav className="flex flex-wrap gap-2 border-b border-[#33363f] pb-0">
        {TABS.map((t) => (
          <a
            key={t.key}
            href={t.key === "pacs" ? `/members/${slug}` : `/members/${slug}?tab=${t.key}`}
            className={`px-4 py-2 text-sm font-medium rounded-t-md -mb-px border-b-2 transition-colors ${
              activeTab === t.key
                ? "border-[var(--gold)] accent-gold"
                : "border-transparent text-gray-400 hover:text-gray-200"
            }`}
          >
            {t.label}
          </a>
        ))}
      </nav>

      {activeTab === "pacs" && (
        <section className="card p-6">
          <h2 className="font-semibold accent-gold mb-3">The People vs. The PACs</h2>
          {!fundingReady ? (
            <p className="text-sm text-gray-500 italic">Funding data not yet available — FEC sync in progress.</p>
          ) : (
            <>
              <div className="grid grid-cols-2 gap-4 text-sm mb-4">
                <div>
                  <p className="text-gray-400">Grassroots gifts (under $200)</p>
                  <p className="text-xl font-semibold text-green-400">{Math.round(totalUnder200).toLocaleString()}</p>
                </div>
                <div>
                  <p className="text-gray-400">Large individual gifts ($200+)</p>
                  <p className="text-xl font-semibold">{total200ToLimit.toLocaleString()}</p>
                </div>
              </div>

              {fundingByIndustry.length > 0 && (
                <div>
                  <p className="text-gray-400 text-sm mb-2">PAC contributions by industry</p>
                  <ul className="space-y-2">
                    {fundingByIndustry.map((row) => {
                      const label = row.label ?? "Uncategorized (needs review)";
                      const color = row.color_hex ?? "#4a4f57";
                      const isTop = row.code ? topIndustryCodes.has(row.code) : false;
                      const widthPct = Math.max(4, (Number(row.total_amount) / maxIndustryAmount) * 100);
                      return (
                        <li key={row.code ?? "uncategorized"}>
                          <div className="flex items-center justify-between text-xs mb-1">
                            <span className="flex items-center gap-2">
                              <span className="w-2.5 h-2.5 rounded-full shrink-0" style={{ backgroundColor: color }} />
                              {label}
                              {isTop && (
                                <span className="badge-compliance text-[10px] px-1.5 py-0.5 rounded">
                                  {isTiedTop ? "Tied for top negative source" : "Top negative source"}
                                </span>
                              )}
                            </span>
                            <span className="text-gray-400">
                              ${Number(row.total_amount).toLocaleString()} · {row.contribution_count} contribution{row.contribution_count === "1" ? "" : "s"}
                            </span>
                          </div>
                          <div className="h-2 rounded bg-[#33363f]">
                            <div className="h-2 rounded" style={{ width: `${widthPct}%`, backgroundColor: color }} />
                          </div>
                        </li>
                      );
                    })}
                  </ul>
                </div>
              )}

              <div className="mt-4 pt-4 border-t border-[#33363f]">
                <p className="text-gray-400 text-sm mb-1">People vs. PAC funding ratio</p>
                {pacTotal === 0 ? (
                  <p className="text-sm">
                    <span style={{ color: "#d4af37" }} className="font-semibold">▲ No PAC money at all</span>{" "}
                    <span className="text-gray-500">— entirely grassroots/individual funded in our dataset.</span>
                  </p>
                ) : memberRatio !== null ? (() => {
                  const relDiff = datasetAvgRatio !== 0 ? (memberRatio - datasetAvgRatio) / datasetAvgRatio : 0;
                  const isAboutAverage = Math.abs(relDiff) < 0.01;
                  const isAbove = memberRatio > datasetAvgRatio;
                  return (
                    <p className="text-sm">
                      <span
                        style={isAboutAverage ? { color: "#9aa1ab" } : isAbove ? { color: "#d4af37" } : { color: "#9aa1ab" }}
                        className="font-semibold"
                      >
                        {isAboutAverage ? "●" : isAbove ? "▲" : "▼"} {memberRatio.toFixed(3)}:1
                      </span>{" "}
                      <span className="text-gray-500">
                        grassroots-to-PAC dollars ({isAboutAverage ? "about even with" : isAbove ? "above" : "below"} the dataset average of {datasetAvgRatio.toFixed(3)}:1
                        {isAboutAverage ? " — right in line with the typical tracked member." : ` — ${isAbove ? "more people-funded" : "more PAC-funded"} than the typical tracked member.`}
                      </span>
                    </p>
                  );
                })() : (
                  <p className="text-sm text-gray-500 italic">Not enough data yet to compute this ratio.</p>
                )}
              </div>
            </>
          )}
        </section>
      )}

      {activeTab === "bills" && (
        <section className="card p-6">
          <h2 className="font-semibold accent-gold mb-3">The 80% Bill</h2>
          {positions.length === 0 ? (
            <p className="text-sm text-gray-500 italic">No tracked bills applicable to this member yet.</p>
          ) : (
            <ul className="space-y-3">
              {positions.map((p) => (
                <li key={p.tracked_item_bill_id} className="text-sm border-t border-[#33363f] pt-3 first:border-t-0 first:pt-0">
                  <div className="flex items-center justify-between gap-2">
                    <span className="flex items-center gap-2">
                      <span
                        className={`text-xs px-1.5 py-0.5 rounded ${p.item_type === "compliance_tracker" ? "badge-compliance" : "badge-bill"}`}
                      >
                        {p.item_type === "compliance_tracker" ? "Compliance" : "Bill"}
                      </span>
                      <a href={`/bills/${p.tracked_item_slug}`} className="underline">
                        {p.tracked_item_title}
                      </a>
                    </span>
                    <span className={`font-medium ${p.position_type ? POSITION_COLOR[p.position_type] : "text-gray-500"}`}>
                      {p.position_type ? POSITION_LABEL[p.position_type] : "No action yet"}
                    </span>
                  </div>
                  {p.position_date && <p className="text-gray-500 text-xs mt-1">{p.position_date}</p>}
                </li>
              ))}
            </ul>
          )}
        </section>
      )}

      {activeTab === "independence" && (
        <section className="card p-6">
          <h2 className="font-semibold accent-gold mb-1">Independence / Israel</h2>
          <p className="text-xs text-gray-500 mb-4">
            AIPAC-aligned funding and the PEACE Pledge feed the Foreign Lobby Independence score above. The itemized
            votes and context note below are shown for reference only — they are not counted toward any score.
          </p>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 text-sm mb-5 pb-5 border-b border-[#33363f]">
            <div>
              <p className="text-gray-400">AIPAC-aligned PAC money</p>
              <p className="font-semibold">
                {aipacAmount > 0 ? `$${aipacAmount.toLocaleString()}` : <span className="text-gray-300">$0 — none on record</span>}
              </p>
            </div>
            <div>
              <p className="text-gray-400">TrackAIPAC PEACE Pledge</p>
              {peacePledge ? (
                <p className="font-semibold" style={{ color: "#9b8ef0" }}>
                  Signed{peacePledge.signed_date ? ` ${peacePledge.signed_date}` : ""} —{" "}
                  <a href={peacePledge.source_url} target="_blank" rel="noopener noreferrer" className="underline">source</a>
                </p>
              ) : (
                <p className="text-gray-300">Has not signed</p>
              )}
            </div>
          </div>

          {foreignPolicyPositions.length > 0 && (
            <div className="mb-5 pb-5 border-b border-[#33363f]">
              <p className="text-gray-400 text-sm mb-2">Itemized record</p>
              <ul className="space-y-3">
                {foreignPolicyPositions.map((p) => (
                  <li key={p.tracked_item_bill_id} className="text-sm">
                    <div className="flex items-center justify-between gap-2">
                      <span>{p.tracked_item_title}</span>
                      <span className={`font-medium ${p.position_type ? POSITION_COLOR[p.position_type] : "text-gray-500"}`}>
                        {p.position_type ? POSITION_LABEL[p.position_type] : "No action on record"}
                      </span>
                    </div>
                    {p.position_date && <p className="text-gray-500 text-xs mt-1">{p.position_date}</p>}
                  </li>
                ))}
              </ul>
            </div>
          )}

          {foreignPolicyNotes.length > 0 && (
            <div>
              <p className="text-gray-400 text-sm mb-2">Context — not attributed to individual members</p>
              {foreignPolicyNotes.map((note) => (
                <div key={note.slug} className="text-sm mb-3 last:mb-0">
                  <p className="font-medium">{note.title}</p>
                  <p className="text-gray-400 text-xs leading-relaxed mt-1">{note.body}</p>
                  <a href={note.source_url} target="_blank" rel="noopener noreferrer" className="text-xs underline text-gray-500">source</a>
                </div>
              ))}
            </div>
          )}
        </section>
      )}

      {activeTab === "lean" && (
        <section className="card p-6">
          <h2 className="font-semibold accent-gold mb-1">PAC Lean</h2>
          <p className="text-xs text-gray-500 mb-4">
            Top PACs by dollar amount over the same trailing 3-cycle window used everywhere else on this site. Each
            PAC&apos;s color reflects its own giving pattern dataset-wide (red = gives mostly to Republicans, blue =
            mostly to Democrats, magenta/purple = splits more evenly) — descriptive only, not scored good or bad.
          </p>
          {topPacs.length === 0 ? (
            <p className="text-sm text-gray-500 italic">No PAC contributions on record for this member.</p>
          ) : (
            <ul className="space-y-2">
              {topPacs.map((row) => {
                const direction = row.lean_direction !== null ? Number(row.lean_direction) : null;
                const color = leanColor(direction);
                const widthPct = Math.max(4, (Number(row.total_amount) / maxPacAmount) * 100);
                return (
                  <li key={row.fec_committee_id}>
                    <div className="flex items-center justify-between text-xs mb-1">
                      <span className="flex items-center gap-2">
                        <span className="w-2.5 h-2.5 rounded-full shrink-0" style={{ backgroundColor: color }} />
                        {row.committee_name}
                      </span>
                      <span className="text-gray-400">
                        ${Number(row.total_amount).toLocaleString()} · {row.contribution_count} contribution{row.contribution_count === "1" ? "" : "s"}
                      </span>
                    </div>
                    <div className="h-2 rounded bg-[#33363f]">
                      <div className="h-2 rounded" style={{ width: `${widthPct}%`, backgroundColor: color }} />
                    </div>
                  </li>
                );
              })}
            </ul>
          )}
        </section>
      )}
    </div>
  );
}
