import Link from "next/link";
import { listMembersForDirectory, listPacIndustries } from "@/lib/congress-db";
import StateMap from "@/components/StateMap";

export const dynamic = "force-dynamic";

const PARTY_LABEL: Record<string, string> = {
  Democrat: "D",
  Republican: "R",
  Independent: "I",
};

// Calculated, not picked from a palette: red (Republican) <-> magenta/purple <-> blue (Democrat),
// interpolated through real HSL hue space so the midpoint reads as a genuine magenta/indigo
// rather than the muddy gray a flat RGB average would produce. direction is 0 (PACs funding this
// member lean fully Democrat) to 1 (fully Republican) -- see funding_lean_direction in
// refresh_member_scores.sql for how it's computed.
function leanColor(direction: number | null): string {
  if (direction === null) return "#6b7280";
  const hue = (240 + 120 * direction) % 360; // 240=blue -> 300=magenta -> 360/0=red
  return hslToHex(hue, 68, 62);
}

function hslToHex(h: number, s: number, l: number): string {
  const sN = s / 100;
  const lN = l / 100;
  const k = (n: number) => (n + h / 30) % 12;
  const a = sN * Math.min(lN, 1 - lN);
  const f = (n: number) => lN - a * Math.max(-1, Math.min(k(n) - 3, Math.min(9 - k(n), 1)));
  const toHex = (x: number) => Math.round(255 * x).toString(16).padStart(2, "0");
  return `#${toHex(f(0))}${toHex(f(8))}${toHex(f(4))}`;
}

function StatCell({ label, value, color }: { label: string; value: string; color: string }) {
  return (
    <div>
      <div className="font-data text-sm font-semibold" style={{ color }}>{value}</div>
      <div className="text-[0.65rem] uppercase tracking-wide text-gray-500 mt-0.5">{label}</div>
    </div>
  );
}

export default async function MembersPage({
  searchParams,
}: {
  searchParams: Promise<{ search?: string; state?: string; sort?: string }>;
}) {
  const params = await searchParams;
  const sortBy = params.sort === "party" || params.sort === "score" ? params.sort : "name";

  const [members, industries] = await Promise.all([
    listMembersForDirectory({ search: params.search, state: params.state, sortBy }),
    listPacIndustries(),
  ]);
  const industryByCode = Object.fromEntries(industries.map((i) => [i.code, i]));

  return (
    <div>
      <h1 className="text-3xl font-bold mb-2">Members of Congress</h1>
      <p className="text-gray-400 mb-6">House and Senate, scored on funding independence, PAC funding lean, 80% Bill alignment, and foreign lobby independence.</p>
      <p className="text-sm text-gray-300 mb-6">
        <span className="px-2 py-0.5 rounded bg-red-900/40 text-red-300 font-semibold">0 = worst</span>
        <span className="mx-2 text-gray-500">→</span>
        <span className="px-2 py-0.5 rounded bg-[var(--gold)] text-[var(--charcoal)] font-semibold">100 = best</span>
        <span className="text-gray-500 ml-3">(percentile among all scored members; PAC Lean is descriptive only, not scored good/bad)</span>
      </p>

      <div className="mb-6">
        <StateMap activeState={params.state} />
      </div>

      <form className="flex flex-wrap gap-3 mb-6" action="/members" method="get">
        <input
          type="text"
          name="search"
          defaultValue={params.search ?? ""}
          placeholder="Search by name..."
          className="card px-3 py-2 flex-1 min-w-[200px] bg-transparent placeholder:text-gray-500"
        />
        {params.state && <input type="hidden" name="state" value={params.state} />}
        <select name="sort" defaultValue={sortBy} className="card px-3 py-2 bg-[var(--charcoal-light)]">
          <option value="name">Sort: Name</option>
          <option value="party">Sort: Party</option>
          <option value="score">Sort: Score (best to worst)</option>
        </select>
        <button type="submit" className="px-4 py-2 rounded card accent-gold hover:border-[var(--gold)]">
          Apply
        </button>
        {(params.search || params.state) && (
          <a href="/members" className="px-4 py-2 rounded card text-gray-400 hover:border-[var(--gold)]">
            Clear
          </a>
        )}
      </form>

      {params.state && (
        <p className="text-sm text-gray-400 mb-4">
          Showing members from <strong className="accent-gold">{params.state}</strong> —{" "}
          <a href="/members" className="underline">view all states</a>
        </p>
      )}

      {members.length === 0 ? (
        <div className="card p-8 text-center text-gray-400">
          <p>No members match this search.</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {members.map((m) => {
            const topIndustry = m.top_negative_industry_code ? industryByCode[m.top_negative_industry_code] : null;
            const direction = m.funding_lean_direction !== null ? Number(m.funding_lean_direction) : null;
            const leanValue = m.funding_lean_intensity !== null ? (Number(m.funding_lean_intensity) / 10).toFixed(1) : "—";
            return (
              <Link
                key={m.bioguide_id}
                href={`/members/${m.slug}`}
                className="card p-4 hover:border-[var(--gold)] transition-colors"
              >
                <div className="flex items-center gap-4">
                  {m.photo_url ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img src={m.photo_url} alt={m.full_name} className="w-20 h-20 rounded-full object-cover shrink-0" />
                  ) : (
                    <div className="w-20 h-20 rounded-full bg-[#33363f] shrink-0 flex items-center justify-center text-xs text-gray-500">
                      N/A
                    </div>
                  )}
                  <div className="min-w-0">
                    <p className="font-medium font-display text-lg truncate">{m.full_name}</p>
                    <p className="text-xs text-gray-400">
                      {PARTY_LABEL[m.party] ?? m.party}-{m.state}
                      {m.district !== null ? `-${m.district}` : ""} · {m.chamber === "senate" ? "Senate" : "House"}
                    </p>
                    <p className="text-xs text-gray-500 mt-1 flex items-center gap-1.5">
                      {topIndustry ? (
                        <>
                          <span
                            className="w-2 h-2 rounded-full shrink-0"
                            style={{ backgroundColor: topIndustry.color_hex ?? "#888" }}
                          />
                          Top PAC Industry: <span className="text-gray-400">{topIndustry.label}</span>
                        </>
                      ) : (
                        <span className="italic">No top PAC industry on record</span>
                      )}
                    </p>
                  </div>
                </div>

                <div className="grid grid-cols-4 gap-2 mt-4 pt-3 border-t border-[#33363f]">
                  <StatCell
                    label="Funding Indep."
                    value={m.funding_percentile_rank !== null ? `${Number(m.funding_percentile_rank).toFixed(0)}` : "—"}
                    color={m.funding_percentile_rank !== null ? "#d4af37" : "#6b7280"}
                  />
                  <StatCell
                    label="PAC Lean"
                    value={leanValue}
                    color={leanColor(direction)}
                  />
                  <StatCell
                    label="80% Bill"
                    value={m.alignment_percentile_rank !== null ? `${Number(m.alignment_percentile_rank).toFixed(0)}` : "—"}
                    color={m.alignment_percentile_rank !== null ? "#d4af37" : "#6b7280"}
                  />
                  <StatCell
                    label="Foreign Lobby"
                    value={m.foreign_lobby_percentile_rank !== null ? `${Number(m.foreign_lobby_percentile_rank).toFixed(0)}` : "—"}
                    color={m.foreign_lobby_percentile_rank !== null ? "#d4af37" : "#6b7280"}
                  />
                </div>
              </Link>
            );
          })}
        </div>
      )}
    </div>
  );
}
