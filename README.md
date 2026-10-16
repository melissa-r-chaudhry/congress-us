# Congress.US

A congressional accountability platform scoring members of Congress on two axes: **who funds them**, and **whether they act with the public or with donors**.

Tagline: *"Of, By, and For — Congress for the People."*

## What this is

- Tracks member voting records / sponsorship against a curated list of 21 public-interest bills (the "80% bill" list), mapped to the current Congress.
- Scores each member's funding sources by industry (PACs classified into categories like Wall Street/Banking, Pharma/Health Insurance, Surveillance/Weapons, Oil & Gas, Labor Unions, AIPAC-aligned, etc.), pulled directly from the FEC's own API.
- Combines both into a per-member composite score, with full public methodology.
- Built from scratch (Next.js App Router, TypeScript, PostgreSQL) as a modern successor to [the80percentbill.com](https://the80percentbill.com/bill/), which this project explicitly credits and extends.

## Stack

- **Frontend:** Next.js 14 (App Router), TypeScript (strict), Tailwind
- **Data:** PostgreSQL, synced via standalone Node scripts against the FEC and Congress.gov APIs
- **Scoring:** SQL-based composite scoring function, fully driven by a `scoring_config` table (no hardcoded weights)

## Structure

- `app/` — routes: `/bills`, `/members`, `/find-your-rep`, `/methodology`, `/about`
- `components/` — `StateMap`, `EmailSignup`
- `lib/` — DB access layer, member writeup generation
- `scripts/` — `sync-fec.mjs`, `sync-legislators.mjs` — standalone data-sync jobs
- `db/migrations/`, `db/functions/` — schema and scoring SQL

## Methodology grounding

Scoring is explicitly framed as an illustrative measure inspired by Gilens & Page (2014), *"Testing Theories of American Politics: Elites, Interest Groups, and Average Citizens,"* *Perspectives on Politics* — not a reproduction of their statistical method. The AIPAC-aligned funding category's methodology is additionally informed by [TrackAIPAC](https://trackaipac.com)'s published approach, with explicit acknowledgment of its known criticisms.

## Status

Phase 1 (bills, scoring infrastructure, member pages) is built and functionally verified against real data. Public domain cutover is a deliberate, separate decision — this repo reflects the application code, not production credentials or live data.

---

Built independently, released here as a portfolio piece. `.env` and credentials are intentionally excluded — see `.gitignore`.
