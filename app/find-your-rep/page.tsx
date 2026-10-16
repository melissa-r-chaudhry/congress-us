"use client";

import { useState } from "react";

interface GeocodeResult {
  matchedAddress?: string;
  state: string | null;
  district: number | null;
  isAtLarge: boolean;
  error?: string;
}

export default function FindYourRepPage() {
  const [address, setAddress] = useState("");
  const [result, setResult] = useState<GeocodeResult | null>(null);
  const [loading, setLoading] = useState(false);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    setResult(null);
    try {
      const res = await fetch(`/api/geocode?address=${encodeURIComponent(address)}`);
      const data = await res.json();
      setResult(res.ok ? data : { state: null, district: null, isAtLarge: false, error: data.error });
    } catch {
      setResult({ state: null, district: null, isAtLarge: false, error: "Lookup failed — try again." });
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="max-w-xl">
      <h1 className="text-3xl font-bold mb-2">Find Your Representative</h1>
      <p className="text-gray-400 mb-6">Enter your address to find your district and members of Congress.</p>

      <form onSubmit={handleSubmit} className="flex gap-2 mb-6">
        <input
          type="text"
          value={address}
          onChange={(e) => setAddress(e.target.value)}
          placeholder="123 Main St, Anytown, WA 98101"
          className="flex-1 px-3 py-2 rounded bg-[#24272f] border border-[#33363f] text-white"
          required
        />
        <button type="submit" disabled={loading} className="px-4 py-2 rounded bg-[var(--gold)] text-[var(--charcoal)] font-semibold">
          {loading ? "Looking up…" : "Find"}
        </button>
      </form>

      {result?.error && <p className="text-red-400">{result.error}</p>}

      {result && !result.error && (
        <div className="card p-5">
          <p className="text-gray-300 mb-1">Matched: {result.matchedAddress}</p>
          <p className="text-lg">
            <span className="accent-gold font-semibold">{result.state}</span>
            {result.district !== null && (
              <span> — District {result.isAtLarge ? "At-Large" : result.district}</span>
            )}
          </p>
          <p className="text-sm text-gray-500 mt-3 italic">
            Member lookup for this district isn&apos;t wired up yet — member data hasn&apos;t synced.
          </p>
        </div>
      )}
    </div>
  );
}
