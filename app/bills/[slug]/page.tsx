import { notFound } from "next/navigation";
import {
  getTrackedItemBySlug,
  getTrackedItemBills,
  getComplianceTracker,
  getComplianceUpdates,
} from "@/lib/congress-db";

export const dynamic = "force-dynamic";

export default async function BillDetailPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const item = await getTrackedItemBySlug(slug);
  if (!item) notFound();

  const bills = await getTrackedItemBills(item.id);
  const compliance = item.item_type === "compliance_tracker" ? await getComplianceTracker(item.id) : null;
  const updates = compliance ? await getComplianceUpdates(compliance.id) : [];

  return (
    <div className="max-w-3xl">
      <span
        className={`text-xs px-2 py-1 rounded ${
          item.item_type === "compliance_tracker" ? "badge-compliance" : "badge-bill"
        }`}
      >
        {item.item_type === "compliance_tracker" ? "Compliance Tracker" : "Bill Tracker"}
      </span>
      <h1 className="text-3xl font-bold mt-3 mb-2">{item.title}</h1>
      <p className="text-gray-300 mb-6">{item.long_description ?? item.short_description}</p>

      <section className="card p-5 mb-6">
        <h2 className="font-semibold accent-gold mb-2">Public Support</h2>
        {item.poll_status === "sourced" ? (
          <p className="text-sm text-gray-300">
            {item.poll_stat_text} — {item.poll_source}
            {item.poll_date ? ` (${item.poll_date})` : ""}
            {item.poll_url && (
              <>
                {" "}
                <a href={item.poll_url} className="underline accent-gold" target="_blank" rel="noreferrer">source</a>
              </>
            )}
          </p>
        ) : (
          <p className="text-sm text-gray-500 italic">No supporting poll citation found yet for this item.</p>
        )}
      </section>

      {item.item_type === "compliance_tracker" && compliance && (
        <section className="card p-5 mb-6">
          <h2 className="font-semibold accent-gold mb-2">Compliance Status</h2>
          <p className="text-sm mb-1">
            <strong>Law:</strong> {compliance.law_citation}{" "}
            {compliance.law_url && (
              <a href={compliance.law_url} className="underline" target="_blank" rel="noreferrer">source</a>
            )}
          </p>
          <p className="text-sm mb-3">{compliance.required_action_description}</p>
          <p className="text-sm mb-4">
            <strong>Current status:</strong>{" "}
            <span className="uppercase tracking-wide accent-gold">{compliance.overall_status}</span>
          </p>
          {updates.length === 0 ? (
            <p className="text-sm text-gray-500 italic">No compliance updates logged yet.</p>
          ) : (
            <ul className="space-y-2">
              {updates.map((u) => (
                <li key={u.id} className="text-sm border-t border-[#33363f] pt-2">
                  <span className="text-gray-400">{u.update_date}</span> — {u.summary}{" "}
                  <a href={u.source_url} className="underline" target="_blank" rel="noreferrer">source</a>
                </li>
              ))}
            </ul>
          )}
        </section>
      )}

      <section className="card p-5">
        <h2 className="font-semibold accent-gold mb-3">Tracked Legislation</h2>
        {bills.length === 0 ? (
          <p className="text-sm text-gray-500 italic">No bill mapped yet — pending editorial review.</p>
        ) : (
          <ul className="space-y-3">
            {bills.map((b) => (
              <li key={b.id} className="text-sm">
                <div className="flex items-center gap-2">
                  <span className="font-mono uppercase">
                    {b.bill_type} {b.bill_number}
                  </span>
                  <span className="text-gray-400">— {b.congress_number}th Congress</span>
                  {b.is_enacted && <span className="text-xs px-1.5 py-0.5 rounded badge-compliance">Enacted</span>}
                  {b.verification_status === "needs_review" && (
                    <span className="text-xs px-1.5 py-0.5 rounded bg-red-900 text-red-200">Needs review</span>
                  )}
                </div>
                <p className="text-gray-300 mt-1">{b.official_title}</p>
                {b.latest_action_text && (
                  <p className="text-gray-500 text-xs mt-1">
                    Latest action: {b.latest_action_text} {b.latest_action_date && `(${b.latest_action_date})`}
                  </p>
                )}
                {b.source_url && (
                  <a href={b.source_url} className="underline accent-gold text-xs" target="_blank" rel="noreferrer">
                    View on congress.gov
                  </a>
                )}
              </li>
            ))}
          </ul>
        )}
      </section>
    </div>
  );
}
