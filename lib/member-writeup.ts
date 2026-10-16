import type { MemberPositionRow, FundingIndustryBreakdownRow, MemberScoreRow, PeacePledgeRow } from "./congress-db";

const CHAMBER_TITLE: Record<string, string> = { house: "Rep.", senate: "Sen." };

export function generateMemberWriteup(params: {
  fullName: string;
  chamber: "house" | "senate";
  positions: MemberPositionRow[];
  score: MemberScoreRow | null;
  fundingByIndustry: FundingIndustryBreakdownRow[];
  peacePledge?: PeacePledgeRow | null;
  aipacAmount?: number;
  datasetAvgRatio?: number;
}): string {
  const { fullName, chamber, positions, score, fundingByIndustry, peacePledge, aipacAmount, datasetAvgRatio } = params;
  const title = CHAMBER_TITLE[chamber] ?? "";
  const shortName = `${title} ${fullName}`.trim();

  // Only 80% Bill items feed this narrative -- foreign-policy items (category='foreign_policy')
  // get their own dedicated sentence below, same separation the scoring function itself enforces.
  const billPositions = positions.filter((p) => p.category !== "foreign_policy");
  const engaged = billPositions.filter(
    (p) => p.position_type === "sponsor" || p.position_type === "cosponsor"
  );
  const votedNo = billPositions.filter((p) => p.position_type === "voted_nay");
  const applicable = billPositions.length;

  const sentences: string[] = [];

  if (applicable === 0) {
    sentences.push(
      `${shortName} does not yet have any tracked bills applicable to their chamber in our dataset.`
    );
  } else if (engaged.length === 0 && votedNo.length === 0) {
    sentences.push(
      `Of the ${applicable} tracked bill${applicable === 1 ? "" : "s"} ${shortName} could act on, ` +
        `they have not yet cosponsored, sponsored, or voted on any of them.`
    );
  } else {
    const example = engaged[0];
    const exampleVerb = example ? (example.position_type === "sponsor" ? "sponsoring" : "cosponsoring") : null;
    if (example) {
      sentences.push(
        `${shortName} has engaged with ${engaged.length} of ${applicable} tracked bill` +
          `${applicable === 1 ? "" : "s"} applicable to their chamber, including ${exampleVerb} ` +
          `${example.official_title ?? `${example.bill_type.toUpperCase()} ${example.bill_number}`}.`
      );
    }
    if (votedNo.length > 0) {
      sentences.push(
        `They have voted against ${votedNo.length} tracked bill${votedNo.length === 1 ? "" : "s"} that reached the floor.`
      );
    }
  }
  if (score?.alignment_percentile_rank !== null && score?.alignment_percentile_rank !== undefined) {
    sentences.push(
      `That places them in the ${Math.round(Number(score.alignment_percentile_rank))}th percentile on 80% Bill alignment among tracked members.`
    );
  }

  if (score?.funding_data_status === "ready") {
    const negativeRows = fundingByIndustry.filter((r) => r.polarity === "negative" && r.code);
    const negativeTotal = negativeRows.reduce((sum, r) => sum + Number(r.total_amount), 0);
    const top = score.top_negative_industry_code
      ? negativeRows.find((r) => r.code === score.top_negative_industry_code)
      : null;

    if (top && negativeTotal > 0) {
      const pct = Math.round((Number(top.total_amount) / negativeTotal) * 100);
      sentences.push(
        `Of the flagged-industry PAC money in our dataset, ${pct}% traces to ${top.label} — ` +
          `see the full funding breakdown below.`
      );
    } else if (negativeTotal === 0) {
      sentences.push(
        `No contributions from our flagged industries were found in ${shortName}'s synced FEC data.`
      );
    }

    if (score.people_pac_ratio !== null && datasetAvgRatio !== undefined && datasetAvgRatio > 0) {
      const ratio = Number(score.people_pac_ratio);
      const relDiff = (ratio - datasetAvgRatio) / datasetAvgRatio;
      if (Math.abs(relDiff) < 0.01) {
        sentences.push(`Their grassroots-to-PAC funding ratio is about even with the typical tracked member.`);
      } else if (relDiff > 0) {
        sentences.push(`Their grassroots-to-PAC funding ratio runs ahead of the typical tracked member — more people-funded than most.`);
      } else {
        sentences.push(`Their grassroots-to-PAC funding ratio trails the typical tracked member — more PAC-funded than most.`);
      }
    }

    if (score.funding_lean_intensity !== null && score.funding_lean_intensity !== undefined) {
      const intensity = Number(score.funding_lean_intensity);
      const direction = score.funding_lean_direction !== null ? Number(score.funding_lean_direction) : null;
      if (intensity >= 70) {
        const skew = direction !== null ? (direction > 0.5 ? "Republican-leaning" : "Democratic-leaning") : null;
        sentences.push(
          `The PACs funding them tend to be one-sided in their giving` +
            (skew ? `, mostly toward other ${skew} candidates` : "") + `.`
        );
      } else if (intensity < 30) {
        sentences.push(`The PACs funding them tend to give fairly evenly across both parties.`);
      }
    }
  } else {
    sentences.push(
      `Funding data for ${shortName} is still being synced from FEC records — check back soon for the full funding breakdown.`
    );
  }

  if (score?.foreign_lobby_percentile_rank !== null && score?.foreign_lobby_percentile_rank !== undefined) {
    const pct = Math.round(Number(score.foreign_lobby_percentile_rank));
    const parts: string[] = [];
    if (aipacAmount && aipacAmount > 0) {
      parts.push(`$${aipacAmount.toLocaleString()} in AIPAC-aligned PAC money`);
    } else {
      parts.push("no AIPAC-aligned PAC money on record");
    }
    if (peacePledge) parts.push("has signed TrackAIPAC's PEACE Pledge");
    sentences.push(
      `On foreign lobby independence, ${shortName} has ${parts.join(" and ")}, placing them in the ${pct}th percentile — see the Independence/Israel tab for the itemized record.`
    );
  }

  return sentences.join(" ");
}
