import type { Metadata } from "next";
import Link from "next/link";
import { Fraunces, Inter, IBM_Plex_Mono } from "next/font/google";
import "./globals.css";

const fraunces = Fraunces({
  subsets: ["latin"],
  variable: "--font-display",
  weight: ["500", "600", "700"],
  style: ["normal", "italic"],
});

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-body",
});

const plexMono = IBM_Plex_Mono({
  subsets: ["latin"],
  variable: "--font-data",
  weight: ["500", "600"],
});

export const metadata: Metadata = {
  title: "Congress.US — Of, By, and For the People",
  description: "Tracking who Congress works for: the people, or the donors.",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={`${fraunces.variable} ${inter.variable} ${plexMono.variable}`}>
      <body>
        <header className="site-header">
          <Link href="/" className="wordmark">
            Congress<span className="accent-red">.</span>US
          </Link>
          <nav className="site-nav">
            <Link href="/bills">Bills</Link>
            <Link href="/members">Members</Link>
            <Link href="/find-your-rep">Find Your Rep</Link>
            <Link href="/methodology">Methodology</Link>
            <Link href="/about">About</Link>
          </nav>
        </header>
        <main className="max-w-5xl mx-auto px-6 py-10">{children}</main>
        <footer className="site-footer">
          <div className="max-w-5xl mx-auto px-6 py-10 flex flex-col gap-3 text-sm text-gray-400">
            <p>
              Of, By, and For the People.{" "}
              <Link href="/about" className="underline">
                Full attribution &amp; sources
              </Link>
              .
            </p>
            <p className="text-gray-500">
              A project of{" "}
              <span className="text-gray-300 font-medium">Constitution Defenders</span>{" "}
              (EIN 42-4700816), a registered Washington charity — federal 501(c)(3) status
              pending. Donations coming soon.
            </p>
          </div>
        </footer>
      </body>
    </html>
  );
}
