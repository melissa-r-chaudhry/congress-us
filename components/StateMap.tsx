"use client";

import { useRouter } from "next/navigation";
import USAMap from "react-usa-map";
import type { MouseEvent } from "react";

export default function StateMap({ activeState }: { activeState?: string }) {
  const router = useRouter();

  const handleClick = (event: MouseEvent<SVGPathElement>) => {
    const abbr = (event.target as SVGPathElement).dataset.name;
    if (!abbr) return;
    router.push(`/members?state=${abbr}`);
  };

  const customize: Record<string, { fill: string }> = {};
  if (activeState) {
    customize[activeState] = { fill: "#d4af37" };
  }

  return (
    <div className="card p-4">
      <p className="text-sm text-gray-400 mb-3">Click a state to see its Senators and Representatives.</p>
      <div className="max-w-lg mx-auto [&_svg]:w-full [&_svg]:h-auto [&_path]:stroke-[#1a1c22] [&_path]:stroke-2 [&_path]:cursor-pointer [&_path]:transition-opacity hover:[&_path]:opacity-80">
        <USAMap
          title="Click a state to browse its members of Congress"
          defaultFill="#2e4c8a"
          customize={customize}
          onClick={handleClick}
        />
      </div>
    </div>
  );
}
