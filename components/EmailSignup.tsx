"use client";

import { useState } from "react";

type Status = "idle" | "submitting" | "done" | "error";

export default function EmailSignup() {
  const [email, setEmail] = useState("");
  const [status, setStatus] = useState<Status>("idle");
  const [message, setMessage] = useState("");

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (status === "submitting") return;
    setStatus("submitting");
    try {
      const res = await fetch("/api/subscribe", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email }),
      });
      if (!res.ok) {
        const data = await res.json().catch(() => ({}));
        throw new Error(data.error || "Something went wrong. Try again in a moment.");
      }
      setStatus("done");
      setMessage("You're on the list — thanks for staying with us.");
      setEmail("");
    } catch (err) {
      setStatus("error");
      setMessage(err instanceof Error ? err.message : "Something went wrong. Try again in a moment.");
    }
  }

  if (status === "done") {
    return <p className="text-sm accent-gold font-medium">{message}</p>;
  }

  return (
    <div>
      <form onSubmit={handleSubmit} className="signup-form">
        <input
          type="email"
          required
          placeholder="you@example.com"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          className="signup-input"
          aria-label="Email address"
          disabled={status === "submitting"}
        />
        <button type="submit" className="signup-button" disabled={status === "submitting"}>
          {status === "submitting" ? "Signing up…" : "Stay tuned"}
        </button>
      </form>
      {status === "error" && <p className="text-sm text-red-400 mt-2">{message}</p>}
    </div>
  );
}
