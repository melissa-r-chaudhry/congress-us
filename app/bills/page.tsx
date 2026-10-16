import Link from "next/link";
import { listTrackedItems } from "@/lib/congress-db";

export const dynamic = "force-dynamic";

export default async function BillsPage() {
  const items = await listTrackedItems();

  return (
    <div>
      <h1 className="text-3xl font-bold mb-2">The Bills</h1>
      <p className="text-gray-400 mb-8">
        21 items, broadly popular with the American people — carried forward from{" "}
        <a href="https://the80percentbill.com/bill/" className="underline accent-gold" target="_blank" rel="noreferrer">
          the80percentbill.com
        </a>.
      </p>

      <div className="space-y-3">
        {items.map((item) => (
          <Link
            key={item.slug}
            href={`/bills/${item.slug}`}
            className="card p-5 flex items-start justify-between hover:border-[var(--gold)] transition-colors block"
          >
            <div>
              <h2 className="font-semibold">{item.title}</h2>
              <p className="text-sm text-gray-400 mt-1">{item.short_description}</p>
            </div>
            <span
              className={`text-xs px-2 py-1 rounded shrink-0 ml-4 ${
                item.item_type === "compliance_tracker" ? "badge-compliance" : "badge-bill"
              }`}
            >
              {item.item_type === "compliance_tracker" ? "Compliance Tracker" : "Bill Tracker"}
            </span>
          </Link>
        ))}
      </div>
    </div>
  );
}
