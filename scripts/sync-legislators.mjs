import { load as yamlLoad } from "js-yaml";
import postgres from "postgres";
import fs from "fs";
import { execSync } from "child_process";

const DB_URL = process.env.CONGRESS_US_DB_URL;
const sql = postgres(DB_URL, { prepare: false });

const IMAGES_DIR = "/Users/edible/haven-server/n8n/public-images/congress";
fs.mkdirSync(IMAGES_DIR, { recursive: true });

function slugify(first, last, bioguide) {
  const base = `${first}-${last}`.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "");
  return base;
}

async function main() {
  console.log("Fetching legislators-current.yaml...");
  const res = await fetch("https://unitedstates.github.io/congress-legislators/legislators-current.yaml");
  const text = await res.text();
  const legislators = yamlLoad(text);
  console.log(`Parsed ${legislators.length} legislators`);

  const slugCounts = {};
  let memberCount = 0, termCount = 0, imgOk = 0, imgFail = 0;

  for (const leg of legislators) {
    const bioguide = leg.id?.bioguide;
    if (!bioguide) continue;
    const first = leg.name.first;
    const last = leg.name.last;
    const fullName = leg.name.official_full || `${first} ${last}`;
    const birthday = leg.bio?.birthday || null;
    const fecIds = leg.id?.fec || [];
    const gender = leg.bio?.gender || null;

    // current term = term covering today (or last term as fallback)
    const now = new Date();
    let currentTerm = leg.terms.find(t => new Date(t.start) <= now && now <= new Date(t.end));
    if (!currentTerm) currentTerm = leg.terms[leg.terms.length - 1];

    let baseSlug = slugify(first, last, bioguide);
    slugCounts[baseSlug] = (slugCounts[baseSlug] || 0) + 1;
    const slug = slugCounts[baseSlug] > 1 ? `${baseSlug}-${bioguide.toLowerCase()}` : baseSlug;

    // headshot
    const imgUrl = `https://unitedstates.github.io/images/congress/450x550/${bioguide}.jpg`;
    const localPath = `${IMAGES_DIR}/${bioguide}.jpg`;
    let photoUrl = null;
    if (!fs.existsSync(localPath)) {
      try {
        const imgRes = await fetch(imgUrl);
        if (imgRes.ok) {
          const buf = Buffer.from(await imgRes.arrayBuffer());
          fs.writeFileSync(localPath, buf);
          imgOk++;
        } else {
          imgFail++;
        }
      } catch (e) {
        imgFail++;
      }
    } else {
      imgOk++;
    }
    if (fs.existsSync(localPath)) {
      photoUrl = `https://images.haven-server.online/congress/${bioguide}.jpg`;
    }

    const officialUrl = currentTerm.url || null;
    const socialMedia = JSON.stringify({});

    await sql`
      INSERT INTO members (bioguide_id, first_name, last_name, full_name, birthday, gender, photo_url, official_url, social_media, slug, fec_candidate_ids, updated_at)
      VALUES (${bioguide}, ${first}, ${last}, ${fullName}, ${birthday}, ${gender}, ${photoUrl}, ${officialUrl}, ${socialMedia}::jsonb, ${slug}, ${fecIds}, now())
      ON CONFLICT (bioguide_id) DO UPDATE SET
        first_name = EXCLUDED.first_name, last_name = EXCLUDED.last_name, full_name = EXCLUDED.full_name,
        birthday = EXCLUDED.birthday, gender = EXCLUDED.gender, photo_url = EXCLUDED.photo_url,
        official_url = EXCLUDED.official_url, slug = EXCLUDED.slug, fec_candidate_ids = EXCLUDED.fec_candidate_ids, updated_at = now()
    `;
    memberCount++;

    const chamber = currentTerm.type === "sen" ? "senate" : "house";
    const district = currentTerm.type === "rep" ? currentTerm.district : null;

    // clear previous is_current flags for this member's 119th term, then insert fresh (idempotent)
    await sql`
      DELETE FROM member_terms WHERE bioguide_id = ${bioguide} AND congress_number = 119 AND is_current = true
    `;
    await sql`
      INSERT INTO member_terms (bioguide_id, congress_number, chamber, state, district, party, term_start, term_end, is_current)
      VALUES (${bioguide}, 119, ${chamber}, ${currentTerm.state}, ${district}, ${currentTerm.party}, ${currentTerm.start}, ${currentTerm.end}, true)
    `;
    termCount++;
  }

  console.log(`Upserted ${memberCount} members, ${termCount} current terms`);
  console.log(`Images: ${imgOk} ok, ${imgFail} failed`);
  await sql.end();
}

main().catch(e => { console.error(e); process.exit(1); });
