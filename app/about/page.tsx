export default function AboutPage() {
  return (
    <div className="max-w-3xl space-y-6">
      <h1 className="text-3xl font-bold mb-2">About &amp; Attribution</h1>
      <p className="text-gray-300 leading-relaxed">
        Congress.US exists to make one dynamic transparent: whether the people who represent us
        vote with the people who elected them, or with the donors who fund them. Full methodology
        is on our <a href="/methodology" className="underline accent-gold">Methodology</a> page.
      </p>

      <section className="card p-5">
        <h2 className="font-semibold accent-gold mb-3">Sources &amp; Credit</h2>
        <ul className="space-y-3 text-sm text-gray-300">
          <li>
            <a href="https://the80percentbill.com" target="_blank" rel="noopener noreferrer" className="underline accent-gold font-semibold">the80percentbill.com</a>
            {" "}— the original curated list of bills broadly popular with the American people. We
            carry this list forward, updated to the current Congress, with member-level scoring added.
          </li>
          <li>
            <a href="https://doi.org/10.1017/S1537592714001595" target="_blank" rel="noopener noreferrer" className="underline accent-gold font-semibold">Gilens &amp; Page (2014)</a>,
            {" "}&ldquo;Testing Theories of American Politics: Elites, Interest Groups, and Average
            Citizens,&rdquo; <em>Perspectives on Politics</em> — the research finding that
            motivated this site&apos;s entire premise.
          </li>
          <li>
            <a href="https://www.trackaipac.com" target="_blank" rel="noopener noreferrer" className="underline accent-gold font-semibold">TrackAIPAC</a>
            {" "}— methodology reference for identifying AIPAC-aligned funding, including direct
            PAC data and donor-network tracing techniques.
          </li>
          <li>
            <a href="https://api.congress.gov" target="_blank" rel="noopener noreferrer" className="underline accent-gold font-semibold">congress.gov API</a>
            {" "}— official bill status, cosponsors, and votes.
          </li>
          <li>
            <a href="https://github.com/unitedstates/congress-legislators" target="_blank" rel="noopener noreferrer" className="underline accent-gold font-semibold">unitedstates/congress-legislators</a>
            {" "}— open dataset of current members of Congress.
          </li>
          <li>
            <a href="https://www.fec.gov/data/" target="_blank" rel="noopener noreferrer" className="underline accent-gold font-semibold">FEC (Federal Election Commission)</a>
            {" "}— official campaign finance data.
          </li>
          <li>
            <a href="https://geocoding.geo.census.gov" target="_blank" rel="noopener noreferrer" className="underline accent-gold font-semibold">U.S. Census Bureau Geocoder</a>
            {" "}— address-to-district lookup.
          </li>
        </ul>
      </section>
    </div>
  );
}
