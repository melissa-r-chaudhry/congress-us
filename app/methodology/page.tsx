import { getScoringConfig, listPacIndustries } from "@/lib/congress-db";

export const dynamic = "force-dynamic";

export default async function MethodologyPage() {
  const { byKey } = await getScoringConfig();
  const industries = await listPacIndustries();
  const negativeIndustries = industries.filter((i) => i.polarity === "negative");
  const positiveIndustries = industries.filter((i) => i.polarity === "positive");
  const fullWeightIndustries = negativeIndustries.filter((i) => Number(i.severity_weight) >= 1);
  const halfWeightIndustries = negativeIndustries.filter((i) => Number(i.severity_weight) < 1);

  const G = byKey["grassroots_avg_gift_G"] ?? "—";
  const confDirect = byKey["confidence_direct"] ?? "—";
  const confInferred = byKey["confidence_inferred"] ?? "—";
  const posWeight = byKey["positive_pac_weight"] ?? "—";
  const cycleWindow = byKey["funding_cycle_window"] ?? "—";
  const congressWindow = byKey["alignment_congress_window"] ?? "—";
  const normMethod = byKey["funding_normalization_method"] ?? "—";
  const limit = byKey["large_individual_limit_2025_2026"] ?? "—";

  return (
    <div className="max-w-3xl space-y-8">
      <div>
        <h1 className="text-3xl font-bold mb-2">Our Methodology</h1>
        <p className="text-gray-400">
          Every number on this site is computed by a documented formula from public data. This
          page explains exactly how, including the parts we&apos;re still refining.
        </p>
      </div>

      <section>
        <h2 className="text-xl font-semibold accent-gold mb-2">Why this site exists</h2>
        <p className="text-gray-300 leading-relaxed">
          A 2014 study by political scientists Martin Gilens (Princeton) and Benjamin I. Page
          (Northwestern), &ldquo;Testing Theories of American Politics: Elites, Interest Groups,
          and Average Citizens&rdquo; (<em>Perspectives on Politics</em>), examined 1,779 policy
          issues and found that economic elites and organized business interests have substantial
          independent influence on U.S. government policy, while average citizens have little or
          none. We built this website to make this dynamic transparent to the people, so we can
          collectively make better decisions. Our per-member score is a simplified, illustrative
          measure inspired by that finding — not a reproduction of Gilens &amp; Page&apos;s
          statistical method.
        </p>
      </section>

      <section>
        <h2 className="text-xl font-semibold accent-gold mb-2">The Composite Score</h2>
        <p className="text-gray-300 leading-relaxed">
          Each member&apos;s overall score is a 50/50 blend of two components: <strong>Funding
          Independence</strong> (who funds them) and <strong>People-Alignment</strong> (whether
          they act with the public or with donors on the bills we track). A composite score only
          displays once both components have enough real data — we never substitute a misleading
          default.
        </p>
      </section>

      <section>
        <h2 className="text-xl font-semibold accent-gold mb-2">Funding Independence</h2>
        <p className="text-gray-300 leading-relaxed mb-3">
          We count donations, not just dollars — because a candidate funded by thousands of small
          donors is meaningfully different from one funded by a handful of large checks, even if
          the totals happen to match. Grassroots gifts under $200 are the strongest positive
          signal in our system.
        </p>
        <ul className="text-gray-300 space-y-1 list-disc list-inside mb-3">
          <li>Individual gifts under $200: full positive weight (confidence {confDirect})</li>
          <li>Individual gifts $200–${limit} (the current FEC per-election limit): neutral</li>
          <li>PAC money from a flagged industry: negative, direct confidence weight {confDirect}</li>
          <li>PAC money from people-aligned sources (e.g. unions): positive, weight {posWeight}</li>
        </ul>
        <p className="text-gray-300 leading-relaxed mb-3">
          Any dollar amount converts into &ldquo;grassroots-equivalent points&rdquo; by dividing
          by <code className="bg-black/30 px-1 rounded">G</code>, the average grassroots donation
          size — currently <strong>${G}</strong> (a placeholder pending recomputation from real
          FEC data; this value is read live from our database, not hardcoded in this page).
        </p>
        <p className="text-gray-300 leading-relaxed">
          Some funding signals are direct and certain (a named PAC check) — those carry confidence
          weight {confDirect}. Others are inferred, such as donor-network tracing for AIPAC-aligned
          money (adapted from{" "}
          <a href="https://www.trackaipac.com" className="underline" target="_blank" rel="noreferrer">TrackAIPAC</a>
          &apos;s methodology) — those carry a lower confidence weight of {confInferred}, reflecting
          real uncertainty in that technique.
        </p>
      </section>

      <section>
        <h2 className="text-xl font-semibold accent-gold mb-2">Flagged Industries</h2>
        <p className="text-gray-300 leading-relaxed mb-3">
          Negative industries are weighted in two tiers, not treated as equally severe. Each
          member&apos;s profile calls out whichever industry funds them most, using the color
          below, so the pattern is visible at a glance. These colors are picked for accessibility
          (validated for colorblind readers), not just aesthetics — identity is never carried by
          color alone, always paired with the label.
        </p>
        <h3 className="text-gray-200 font-semibold mb-2">Full weight</h3>
        <ul className="space-y-2 mb-4">
          {fullWeightIndustries.map((ind) => (
            <li key={ind.code} className="flex items-center gap-3">
              <span
                className="inline-block w-4 h-4 rounded-full shrink-0 border border-white/20"
                style={{ backgroundColor: ind.color_hex ?? "#888" }}
                aria-hidden="true"
              />
              <span className="text-gray-200 font-medium">{ind.label}</span>
              {ind.description && (
                <span className="text-gray-400 text-sm">— {ind.description}</span>
              )}
            </li>
          ))}
        </ul>
        <h3 className="text-gray-200 font-semibold mb-2">Half weight</h3>
        <p className="text-gray-300 leading-relaxed mb-3">
          These five industries are real, tracked, and still count against a member&apos;s score
          — but at half the severity of the industries above. This reflects a judgment call about
          relative severity, made deliberately and stated plainly rather than hidden in the math.
        </p>
        <ul className="space-y-2 mb-4">
          {halfWeightIndustries.map((ind) => (
            <li key={ind.code} className="flex items-center gap-3">
              <span
                className="inline-block w-4 h-4 rounded-full shrink-0 border border-white/20"
                style={{ backgroundColor: ind.color_hex ?? "#888" }}
                aria-hidden="true"
              />
              <span className="text-gray-200 font-medium">{ind.label}</span>
              {ind.description && (
                <span className="text-gray-400 text-sm">— {ind.description}</span>
              )}
            </li>
          ))}
        </ul>
        <p className="text-gray-300 leading-relaxed mb-3">
          On the positive side, PAC money from people-aligned sources counts toward a member&apos;s
          score too, at half the weight of grassroots giving:
        </p>
        <ul className="space-y-2 mb-4">
          {positiveIndustries.map((ind) => (
            <li key={ind.code} className="flex items-center gap-3">
              <span
                className="inline-block w-4 h-4 rounded-full shrink-0 border border-white/20"
                style={{ backgroundColor: ind.color_hex ?? "#4a4" }}
                aria-hidden="true"
              />
              <span className="text-gray-200 font-medium">{ind.label}</span>
              {ind.description && (
                <span className="text-gray-400 text-sm">— {ind.description}</span>
              )}
            </li>
          ))}
        </ul>
        <h3 className="text-gray-200 font-semibold mb-2">What counts as &ldquo;people-aligned&rdquo; on the positive side</h3>
        <p className="text-gray-300 leading-relaxed">
          We hold this side to a specific, narrow test, stated plainly so it can be checked:{" "}
          <strong>partisan turnout organizations are neutral, period.</strong> Get-out-the-vote
          and candidate-mobilization operations don&apos;t count as a positive funding signal just
          because they&apos;re not corporate money — that would let us quietly favor one side of
          the aisle under the banner of &ldquo;people-powered.&rdquo; <strong>Nonpartisan
          power-building, pro-democracy, and good-governance organizations are positive</strong> —
          groups working on voting rights, campaign finance reform, redistricting reform, or
          government accountability, regardless of who they tend to help politically. General
          issue-advocacy groups (on the environment, civil rights, reproductive rights,
          immigration, and similar causes) are real and often grassroots-funded, but under this
          test they&apos;re neutral too, not positive — advocating for a cause, however
          sympathetic, isn&apos;t the same thing as building nonpartisan democratic infrastructure.
          We apply this test the same way regardless of which side of a debate an organization is
          on — including reclassifying organizations we&apos;d previously counted positive, once
          we adopted this stricter, symmetric standard.
        </p>
      </section>

      <section>
        <h2 className="text-xl font-semibold accent-gold mb-2">The 3-Cycle / 3-Congress Window</h2>
        <p className="text-gray-300 leading-relaxed">
          Funding data is blended, equally weighted, across the last {cycleWindow} election
          cycles — not just the most recent one. This is deliberate: industries sometimes
          reorganize their giving (new PAC names, altered donation patterns) right before an
          election to look cleaner than their real track record. A multi-cycle window keeps older,
          unmassaged data anchoring the picture. The same logic applies to bill-alignment scoring
          across the last {congressWindow} Congresses — a member&apos;s historical vote still
          counts if they held office at the time, but a bill that predates a member&apos;s term
          never counts against them.
        </p>
      </section>

      <section>
        <h2 className="text-xl font-semibold accent-gold mb-2">Score Normalization</h2>
        <p className="text-gray-300 leading-relaxed">
          Display scores (0–100) use <strong>{normMethod}</strong> normalization across all
          currently-tracked members — chosen specifically so an extreme outlier always displays
          near the bottom regardless of what other members&apos; data does.
        </p>
      </section>

      <section>
        <h2 className="text-xl font-semibold accent-gold mb-2">Attribution</h2>
        <p className="text-gray-300 leading-relaxed">
          This project carries forward the bill list originated by{" "}
          <a href="https://the80percentbill.com/bill/" className="underline" target="_blank" rel="noreferrer">
            the80percentbill.com
          </a>
          , extending it with current bill tracking, member-level funding scores, and this full
          public methodology. See our{" "}
          <a href="/about" className="underline">About &amp; Attribution</a> page for the complete
          list of sources.
        </p>
      </section>
    </div>
  );
}
