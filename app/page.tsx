import { getHomepageStats } from "@/lib/congress-db";
import EmailSignup from "@/components/EmailSignup";

function formatMoney(millions: number): string {
  if (millions >= 1000) return `$${(millions / 1000).toFixed(1)}B`;
  return `$${Math.round(millions)}M`;
}

export default async function HomePage() {
  const stats = await getHomepageStats();

  return (
    <div className="space-y-10">
      <section className="hero">
        <h1 className="font-display">
          Of, By, and <span className="accent-gold">For the People</span>
        </h1>
        <p className="hero-sub">
          Congress.US tracks whether members of Congress vote with the people who elected
          them, or with the donors who fund them. Every score is built from public data,
          with a fully open methodology.
        </p>

        <div className="stat-row">
          <div>
            <div className="stat-value font-data">{stats.membersScored}</div>
            <div className="stat-label">Members Scored</div>
          </div>
          <div>
            <div className="stat-value font-data">{formatMoney(stats.pacMoneyMillions)}</div>
            <div className="stat-label">PAC Money Tracked</div>
          </div>
          <div>
            <div className="stat-value font-data">{stats.pacsClassified.toLocaleString()}</div>
            <div className="stat-label">PACs Classified</div>
          </div>
          <div>
            <div className="stat-value font-data">{stats.billsTracked}</div>
            <div className="stat-label">Bills Tracked</div>
          </div>
        </div>
      </section>

      <section className="card p-4 flex flex-wrap items-center justify-center gap-4 text-sm">
        <span className="font-semibold">Reading the scores:</span>
        <span className="flex items-center gap-2">
          <span className="px-2 py-0.5 rounded bg-red-900/40 text-red-300 font-semibold">0th pct</span>
          <span className="text-gray-400">worst</span>
        </span>
        <span className="flex-1 max-w-xs h-2 rounded-full" style={{ background: "linear-gradient(to right, #7a1f2b, #d4af37)" }} />
        <span className="flex items-center gap-2">
          <span className="text-gray-400">best</span>
          <span className="px-2 py-0.5 rounded bg-[var(--gold)] text-[var(--charcoal)] font-semibold">100th pct</span>
        </span>
        <span className="text-gray-500 basis-full text-center sm:basis-auto">
          (percentile among all scored members — PAC Lean is shown separately and is descriptive only, not scored good/bad)
        </span>
      </section>

      <section className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <a href="/find-your-rep" className="card p-6 hover:border-[var(--gold)] transition-colors">
          <svg className="nav-card-icon mb-3" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.75">
            <circle cx="10.5" cy="10.5" r="6.5" />
            <path d="M15.5 15.5L21 21" strokeLinecap="round" />
          </svg>
          <h2 className="text-lg font-semibold font-display mb-2">Find Your Rep</h2>
          <p className="text-sm text-gray-400">Look up your representative and senators by address.</p>
        </a>
        <a href="/bills" className="card p-6 hover:border-[var(--gold)] transition-colors">
          <svg className="nav-card-icon mb-3" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.75">
            <path d="M6 3h9l4 4v13a1 1 0 0 1-1 1H6a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1z" strokeLinejoin="round" />
            <path d="M9 11h6M9 15h6M9 7h3" strokeLinecap="round" />
          </svg>
          <h2 className="text-lg font-semibold font-display mb-2">The Bills</h2>
          <p className="text-sm text-gray-400">21 bills, broadly popular with the American people — see who&apos;s acting on them.</p>
        </a>
        <a href="/methodology" className="card p-6 hover:border-[var(--gold)] transition-colors">
          <svg className="nav-card-icon mb-3" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.75">
            <path d="M12 3v18M7 21h10" strokeLinecap="round" />
            <path d="M12 6l-6 3 6 3 6-3-6-3z" strokeLinejoin="round" />
            <path d="M6 9l-2.5 5a2.5 2.5 0 0 0 5 0L6 9zM18 9l-2.5 5a2.5 2.5 0 0 0 5 0L18 9z" strokeLinejoin="round" />
          </svg>
          <h2 className="text-lg font-semibold font-display mb-2">Our Methodology</h2>
          <p className="text-sm text-gray-400">Exactly how every score is calculated — fully public, nothing hidden.</p>
        </a>
      </section>

      <section className="signup-bar">
        <div>
          <h2 className="text-lg font-semibold font-display accent-gold">Stay tuned for updates</h2>
          <p className="text-sm text-gray-400 mt-1">New scores, new bills tracked, new reporting — no spam, unsubscribe anytime.</p>
        </div>
        <EmailSignup />
      </section>
    </div>
  );
}
