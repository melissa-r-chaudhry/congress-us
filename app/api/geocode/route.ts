import { NextRequest, NextResponse } from "next/server";

const FIPS_TO_ABBR: Record<string, string> = {
  "01": "AL", "02": "AK", "04": "AZ", "05": "AR", "06": "CA", "08": "CO", "09": "CT",
  "10": "DE", "11": "DC", "12": "FL", "13": "GA", "15": "HI", "16": "ID", "17": "IL",
  "18": "IN", "19": "IA", "20": "KS", "21": "KY", "22": "LA", "23": "ME", "24": "MD",
  "25": "MA", "26": "MI", "27": "MN", "28": "MS", "29": "MO", "30": "MT", "31": "NE",
  "32": "NV", "33": "NH", "34": "NJ", "35": "NM", "36": "NY", "37": "NC", "38": "ND",
  "39": "OH", "40": "OK", "41": "OR", "42": "PA", "44": "RI", "45": "SC", "46": "SD",
  "47": "TN", "48": "TX", "49": "UT", "50": "VT", "51": "VA", "53": "WA", "54": "WV",
  "55": "WI", "56": "WY", "72": "PR",
};

export async function GET(req: NextRequest) {
  const address = req.nextUrl.searchParams.get("address");
  if (!address) {
    return NextResponse.json({ error: "Missing ?address= parameter" }, { status: 400 });
  }

  const url = new URL("https://geocoding.geo.census.gov/geocoder/geographies/onelineaddress");
  url.searchParams.set("address", address);
  url.searchParams.set("benchmark", "Public_AR_Current");
  url.searchParams.set("vintage", "Current_Current");
  url.searchParams.set("layers", "Congressional Districts");
  url.searchParams.set("format", "json");

  const res = await fetch(url.toString());
  if (!res.ok) {
    return NextResponse.json({ error: "Census Geocoder request failed" }, { status: 502 });
  }
  const data = await res.json();

  const matches = data?.result?.addressMatches;
  if (!matches || matches.length === 0) {
    return NextResponse.json({ error: "Address not found or ambiguous" }, { status: 404 });
  }

  const match = matches[0];
  const geographies = match.geographies ?? {};
  const cdLayerKey = Object.keys(geographies).find((k) => k.includes("Congressional Districts"));
  const cdEntry = cdLayerKey ? geographies[cdLayerKey]?.[0] : null;

  if (!cdEntry) {
    return NextResponse.json({ error: "Congressional district layer not found in response" }, { status: 502 });
  }

  const stateFips: string | undefined = cdEntry.STATE;
  const stateAbbr = (cdEntry.STUSAB as string | undefined) ?? (stateFips ? FIPS_TO_ABBR[stateFips] : undefined);
  const districtRaw: string | undefined = cdEntry.CD119 ?? cdEntry.CDFP ?? cdEntry.BASENAME;
  const district = districtRaw !== undefined ? parseInt(districtRaw, 10) : null;

  return NextResponse.json({
    matchedAddress: match.matchedAddress,
    state: stateAbbr ?? null,
    district: district !== null && !Number.isNaN(district) ? district : null,
    isAtLarge: districtRaw === "00" || districtRaw === "0" || Boolean((cdEntry.BASENAME as string | undefined)?.toLowerCase().includes("at large")),
    raw: cdEntry,
  });
}
