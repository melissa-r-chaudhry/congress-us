import { NextRequest, NextResponse } from "next/server";

// Listmonk's public subscription endpoint — no auth required, designed for front-end forms.
// List 139 = "Congress.US: Stay Tuned for Updates", created 2026-08-24 specifically for this
// signup bar. Kept separate from every M4C campaign list on purpose: this is a project update
// list, not campaign email.
const LISTMONK_URL = "https://listmonk.haven-server.online/api/public/subscription";
const LIST_UUID = "f70d77cf-7175-4db5-851c-4fb457636716";

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

export async function POST(req: NextRequest) {
  let body: { email?: string };
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: "Invalid request." }, { status: 400 });
  }

  const email = (body.email || "").trim();
  if (!email || !EMAIL_RE.test(email)) {
    return NextResponse.json({ error: "Enter a valid email address." }, { status: 400 });
  }

  try {
    const res = await fetch(LISTMONK_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, list_uuids: [LIST_UUID] }),
    });
    if (!res.ok) {
      const text = await res.text();
      console.error(`Listmonk subscribe failed: ${res.status} ${text.slice(0, 300)}`);
      return NextResponse.json({ error: "Something went wrong. Try again in a moment." }, { status: 502 });
    }
    return NextResponse.json({ ok: true });
  } catch (e) {
    console.error("Listmonk subscribe error:", e);
    return NextResponse.json({ error: "Something went wrong. Try again in a moment." }, { status: 502 });
  }
}
