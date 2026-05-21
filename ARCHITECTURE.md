# ImmunoVerse Portal — Architecture & Change Log

This document is the single source of truth for *how the portal works and why
it works that way*. It has two parts:

1. **Current state** (top): every system that's live right now, organized by
   concern. Updated in place when something changes.
2. **Change log** (bottom): one entry per significant change, in reverse
   chronological order. Append-only — never edit past entries.

> **Maintenance convention for Claude:** every time we change anything
> non-trivial (a new page, a different proxy, a new analytics layer, a new
> Worker, a sync script tweak, etc.), update the relevant section of the
> "Current state" block AND append a dated entry to the change log. Commit
> the doc change in the same PR/push as the code change so the two stay in
> sync.

---

## Table of contents

- [Pages](#pages)
- [Data pipeline](#data-pipeline)
- [Analytics stack](#analytics-stack)
- [Visible UI elements](#visible-ui-elements)
- [Figure rendering (drawer)](#figure-rendering-drawer)
- [CORS proxies](#cors-proxies)
- [Cloudflare Workers](#cloudflare-workers)
- [External services & URLs](#external-services--urls)
- [Daily auto-sync (GitHub Actions)](#daily-auto-sync-github-actions)
- [Change log](#change-log)

---

## Pages

| Path | File | Audience | Notes |
|---|---|---|---|
| `/` | `index.html` | Main public landing — full atlas (21 cancers, all peptides, drawer, search, chatbot) | Production. All recent figure-rendering & proxy changes live here first. |
| `/demo/` | `demo/index.html` | Public preview — curated subset (AML, NBL, SKCM only) | Intentionally pinned: Aman wants demo & reviewers untouched unless explicitly asked. |
| `/reviewers/` | `reviewers/index.html` | Editor / paper-reviewer access | Same constraint as `/demo/`. |
| `/hub/` | `hub/index.html` | Curated *unprocessed* immunopeptidomic datasets — metadata + SLURM download scripts. Separate from the Atlas. | Light theme by default, dark toggle (localStorage-persisted). 33 cancers driven by `hub/data_js/_index.js` + per-cancer JS modules. |

Pages share the topnav and link to each other via plain `/`, `/demo/`, `/reviewers/`, `/hub/`. The Hub link lives in the **footer "Explore" column** of the main portal (`index.html`) — kept out of the topnav to avoid crowding (search bar was overlapping the brand area when Hub was also a topnav link).

---

## Data pipeline

Two independent sync flows, both daily:

### Atlas data — Dropbox → `data_js/`
- **Script:** `integrate_data.py`
- **Source:** A Dropbox share Frank (Li Guangyuan) maintains. URL is hardcoded in the script but overridable via the `IMMUNOVERSE_DROPBOX_URL` env var.
- **Cache:** `~/.cache/immunoverse/extracted/` (24h TTL by default, overridable via `IMMUNOVERSE_CACHE_TTL`).
- **Outputs:** `data_js/{CANCER}.js`, `data_js/{CANCER}_detail.js`, `data_js/_search_index.js`, `data_js/_summary.js`, and a `data/` folder with derived CSVs.
- **Input columns it expects:** see the module docstring in `integrate_data.py`.

### Hub data — NYU public share → `hub/data_js/`
- **Script:** `sync_hub.py`
- **Source:** `https://genome.med.nyu.edu/public/yarmarkovichlab/ImmunoVerse/ImmunoVerse_Hub/` (public HTTP directory, no auth needed).
- **Inputs:** `{CANCER}_metadata.txt` (TSV: study, batch, sample, biology, HLA, special_note) and `{CANCER}_download.sbatch` (SLURM scripts pointing at PRIDE FTP URLs).
- **Outputs:**
  - `hub/data_js/{CANCER}.js` — per-cancer JS module (`window.IMMUNOVERSE_HUB[code] = {...}`).
  - `hub/data_js/_index.js` — summary index with totals (cancers, samples, cohorts) used by the hero stats.
  - `hub/data/raw/{CANCER}_metadata.txt` and `{CANCER}_download.sbatch` — raw mirrors so the per-card download buttons can serve the files straight from GitHub Pages.
- **Regex for cancer codes:** `[A-Za-z0-9]+_metadata\.txt` (case-insensitive — `ependymoma` and `meningioma` are lowercase at NYU).
- **Display-name map:** `CANCER_DISPLAY` in `sync_hub.py` (TCGA codes → human names; falls back to the code itself if unknown).
- **Category map:** `CANCER_CATEGORY` (Leukemia / Lymphoma / Sarcoma / Pediatric / CNS / Solid). Drives the filter chips on `/hub`.

### Gitignore note
`*_metadata.txt` is globally ignored (the main portal pulls fresh metadata from Dropbox and doesn't store it). The Hub re-allows them via the negation rule `!hub/data/raw/*_metadata.txt` in `.gitignore`.

---

## Analytics stack

Three layers, in increasing visibility:

| Layer | Where its data lives | Used for |
|---|---|---|
| **Cloudflare Web Analytics** | Cloudflare dashboard (`dash.cloudflare.com` → Analytics & Logs → Web Analytics) | Private detailed dashboard: countries, devices, top pages, referrers. Beacon token `3d25bed96fe3453ea6e41d1af78967cf` embedded in `index.html`, `demo/index.html`, `reviewers/index.html`, `hub/index.html`. |
| **GoatCounter** | `https://immuno-verse.goatcounter.com` (private dashboard) + `https://immuno-verse.goatcounter.com/counter/TOTAL.json` (public JSON endpoint, enabled in Settings) | Cookieless visit tracking. The public JSON endpoint feeds the visible "Queries" pill. |
| **Cloudflare Worker query counter** | KV namespace `IMMUNOVERSE_COUNTERS` on the `immunoverse-queries` Worker | Counts real action events (search submission + chatbot send) as a private metric. Kept running silently in the background even though the pill no longer reads from it. Useful as a paper-supplementary stat. |

**The visible "Queries" pill** in the main portal's topnav fetches `GoatCounter /counter/TOTAL.json` on page load and renders the cumulative all-time visit count. The pulsing cyan dot is purely visual; the number is not real-time (refreshes per page load).

---

## Visible UI elements

### Live "Queries" counter pill
- **HTML:** `index.html` — inside `<nav class="topnav">`, after `.links`, before `.theme-toggle`.
- **CSS class:** `.live-stat` (pill body), `.live-dot` (pulsing dot), `.live-num` (number), `.live-label` (caption).
- **JS:** inline `<script>` at the bottom of `index.html` — fetches `GC_TOTAL` (`https://immuno-verse.goatcounter.com/counter/TOTAL.json`) on load, renders the count. Also exposes `window.__bumpQueryCounter` (fire-and-forget POST to the Worker `/increment` endpoint) so search + chatbot actions still log to the Worker counter in the background.
- **Hooks that fire `__bumpQueryCounter`:** `runSearch` (debounced typeahead in `#globalSearch`), the `results` click handler (search-result selection), and the chatbot `send()` function in `chatbot/chatbot.js`.
- **Hidden on screens < 560px** to avoid topnav crowding.

### Global search
- **Input:** `#globalSearch` in the topnav. Wrapper `max-width: 460px`.
- **Driven by:** `data_js/_search_index.js` (pre-built lookup tables for peptides / genes / cancers / HLA alleles).
- **Live typeahead** with 150 ms debounce. Each completed search bumps the Worker counter; the Cloudflare Worker rate-limits to 1 increment per 3 seconds per IP (TTL stored in KV with 60s minimum).
- **Results dropdown (`#searchResults`)** is intentionally **wider than the input**: `width: 560px`, `min-width: 100%`, `max-width: calc(100vw - 32px)`. Anchored to the input's left edge, extends rightward. Keeps long peptide/gene labels readable instead of getting truncated.
- **`⌘K` / `Ctrl+K` hint badge (`#searchKbd`)** is hidden by default and revealed on `.search-wrap:hover`. Hidden again on `:focus-within` so it never overlaps text the user is actively typing. (Originally it was always visible, but `Ctrl+K` on PC is wider than the input's right padding reserves, so it overlapped typed text.)

### Theme toggle
- Lives on **`/hub/` only** for now. Light is default; dark is opt-in via localStorage key `iv-hub-theme`.
- Main portal (`index.html`) has its own pre-existing dark theme toggle (`toggleTheme()` in script tag — not added by this work).

---

## Figure rendering (drawer)

**Only `index.html` has the SVG-first rendering path. `demo/index.html` and `reviewers/index.html` still use the original PNG-first path** — they were intentionally pinned at user's request because they were perceived to be working as before.

### Render chain (main `index.html` only)

For each of the three drawer plots (percentile, rank-abundance, spectrum):

1. The `<img>` `src` is set to the **SVG URL** at NYU: `{ASSET_SVG_BASE}/{code}/{pep}_{kind}.svg` (or `spectrum_{pep}.svg`). Browser loads it cross-origin via `<img>` — **no proxy needed for display**.
2. If the SVG returns 404 (peptide has no SVG yet), `onerror` fires → calls `_figFallbackToPng(this, pngUrl)` which swaps `src` to the PNG at `{ASSET_BASE}/{code}_{pep}_{kind}.png`.
3. If the PNG also 404s, second `onerror` triggers → wrap gets `.no-plot` class and the `<img>` is removed (spectrum has a custom "Annotated spectrum not available" message via `_spectrumFallbackToPng`).

### Why this approach
- **`<img src=SVG>` cross-origin works without CORS** because `<img>` tags don't read pixel bytes from JS.
- **No proxy dependency for display.** Even if both proxies fail, the figures still render.
- **Auto-onboarding** for new cancers: as Fran uploads SVGs to NYU under `/assets_svg/{CODE}/`, they appear automatically.

### Currently SVGs exist on NYU for:
- `NBL/` — confirmed working (1,016 SVG files listed in the directory)
- `AML/` — per Aman; subdirectory listing returns 404 to our HTTP probe but specific files may exist
- All others → `<img>` 404s, falls back to PNG silently

### Right-click protection
- Each drawer `<img>` carries `oncontextmenu="return false;"` — blocks the browser's "Save image as…" menu.
- Soft restriction only — determined users can grab SVGs via DevTools or the public NYU URL directly.

### PNG download button
- Calls `downloadDrawerFigure(pngUrl, label)` → `downloadImage(nyuUrl, filename)` → `_fetchImageBlob(nyuUrl)`.
- `_fetchImageBlob` uses `_proxiedFetch` (see [CORS proxies](#cors-proxies) below) which tries Deno first then Cloudflare.
- On success: blob → `_triggerDownload` triggers a real one-click save with the filename `{CODE}_{PEP}_{kind}.png`.
- On failure of all proxies: falls through to `window.open(nyuUrl, '_blank')` (legacy "open in new tab" fallback).

---

## CORS proxies

The portal needs to read the *bytes* of NYU figures in two cases:
1. **Download as PNG** — fetch blob → trigger named download.
2. **Interactive SVG upgrade** — fetch SVG text → parse → mount inline with hover/zoom (legacy feature; mostly superseded now that `<img>` loads SVG directly).

Cross-origin `fetch()` requires CORS headers, which NYU doesn't send. We proxy through a CORS-enabled middleman.

### Fallback chain (in `index.html` only)

Defined as `IMG_PROXIES` at `index.html:~4297`:

```js
const IMG_PROXIES = [
  'https://immunoverse-proxy.amans44.deno.net/?url=',         // primary
  'https://immunoverse-proxy.amansharma-e44.workers.dev/?url=', // fallback
];
const IMG_PROXY = IMG_PROXIES[0]; // kept for truthy checks elsewhere
```

`_proxiedFetch(targetUrl)` iterates the array; first proxy to return a 2xx wins.

`demo/index.html` and `reviewers/index.html` still use a single `IMG_PROXY = 'https://immunoverse-proxy.amansharma-e44.workers.dev/?url='`.

### Why two proxies
- **Deno Deploy** (`immunoverse-proxy.amans44.deno.net`): runs on Deno's network, reliably reaches NYU. Primary.
- **Cloudflare Worker** (`immunoverse-proxy.amansharma-e44.workers.dev`): runs on Cloudflare. We had a long episode where Cloudflare-to-NYU routing was misbehaving (responses were arriving from NYU Langone's atnyulmc.org Drupal CMS instead of the genome research server). It's currently working again as of 2026-05-21 — could be edge-cache rotation, network reconfig, or a transient routing fix. Kept as a fallback for resilience.

---

## Cloudflare Workers

### `immunoverse-proxy` (CORS proxy)
- **URL:** `https://immunoverse-proxy.amansharma-e44.workers.dev`
- **Endpoint:** `GET /?url=<encoded-nyu-url>`
- **Allowlist:** host must be `genome.med.nyu.edu`, path must start with `/public/yarmarkovichlab/ImmunoVerse`.
- **Source code:** lives only in the Cloudflare dashboard (no repo file). To edit: dashboard → Workers & Pages → immunoverse-proxy → Edit code.
- **Caveat:** the original setup had this Worker connected to the GitHub repo via Cloudflare's "Workers auto-config" integration, which periodically replaced the Worker code with a static-assets-only deployment, breaking the proxy silently. The current Worker is the *recreated* version (deleted + re-created with code pasted in). Do NOT reconnect Git auto-config to it.

### `immunoverse-queries` (action counter)
- **URL:** `https://immunoverse-queries.amansharma-e44.workers.dev`
- **Endpoints:**
  - `GET /total` → `{count: <int>}` — reads `queries:total` from KV (10 s edge cache).
  - `POST /increment` → `{count, throttled?}` — origin-locked to `immuno-verse.com` / `www.immuno-verse.com`, 3 s per-IP cooldown enforced via timestamp comparison (KV minimum TTL is 60 s, so we store the timestamp under a 60 s key but compute `now - last < 3000` in code).
- **KV namespace binding:** variable name `IMMUNOVERSE_COUNTERS`, namespace `immunoverse-counters`.
- **Used by:** `index.html`'s `window.__bumpQueryCounter` (fire-and-forget POST on each global-search submission and each chatbot send).

---

## External services & URLs

| Service | URL | Purpose |
|---|---|---|
| GitHub Pages (production) | `https://immuno-verse.com` | Hosts the portal (CNAME → GitHub Pages). |
| GitHub repo | `https://github.com/amans44/immunoverse-portal` | Source of truth. |
| Chatbot agent | `https://immunoverse-agent-739605637035.us-central1.run.app` | Cloud Run service. Sets `window.IMMUNOVERSE_AGENT_BASE` in `index.html` (and demo/reviewers via `chatbot/chatbot.js`). |
| NYU public share | `https://genome.med.nyu.edu/public/yarmarkovichlab/ImmunoVerse/` | Root of all NYU-hosted assets (PNG figures, SVG figures, Hub metadata, Hub sbatch scripts). |
| NYU `/assets/` | `…/ImmunoVerse/assets/` | PNG figures — `{CODE}_{PEP}_{percentile,rank_abundance,spectrum}.png`. 21 cancer codes present. |
| NYU `/assets_svg/` | `…/ImmunoVerse/assets_svg/{CODE}/` | Interactive SVG figures — `{PEP}_{percentile,rank_abundance}.svg` and `spectrum_{PEP}.svg`. Only `NBL/` listed at the parent directory; other cancers TBD. |
| NYU `/ImmunoVerse_Hub/` | `…/ImmunoVerse/ImmunoVerse_Hub/` | Curated dataset hub — `{CANCER}_metadata.txt` + `{CANCER}_download.sbatch`. 33 cancers. |
| Dropbox share | (in `integrate_data.py`) | Daily Dropbox refresh source for the Atlas. |
| GoatCounter dashboard | `https://immuno-verse.goatcounter.com` | Private analytics dashboard. |

---

## Daily auto-sync (GitHub Actions)

### `.github/workflows/refresh-data.yml`
- **Schedule:** cron `15 6 * * *` (06:15 UTC daily) + `workflow_dispatch` (manual button).
- **Steps:**
  1. Checkout repo (fetch-depth: 0).
  2. Setup Python 3.11.
  3. Run `integrate_data.py` (rebuilds `data_js/` from Dropbox).
  4. Run `sync_hub.py` (rebuilds `hub/data_js/` from the NYU public share).
  5. Stage `data_js/`, `data/`, `hub/data_js/`, `hub/data/` and commit only if changed (`chore(data): daily refresh from Dropbox`).
  6. Push to `main`.
  7. Notify via comment on a tracking GitHub issue (label `ci-refresh-success`). On failure, posts to a separate issue labeled `ci-refresh-failure`.
- **Bot identity for commits:** `immunoverse-bot <immunoverse-bot@users.noreply.github.com>`.

---

## Change log

Newest at the top. Each entry: date, headline, summary, files touched, commit SHA(s).

### 2026-05-21 — Hide ⌘K hint badge by default, reveal on hover
**Why:** The "Ctrl+K" badge on PCs (5+ characters) is wider than the input's reserved right padding (56 px), so it overlapped the rightmost portion of typed text. User couldn't see what they were typing past a certain length.
**What:** `.search-kbd` now has `opacity: 0` by default; `.search-wrap:hover` reveals it (`opacity: 1`); `.search-wrap:focus-within` keeps it hidden so it never overlaps active typing. Keyboard shortcut still works (the JS `keydown` handler is unchanged) — only the visual hint is hover-gated.
**Files:** `index.html`.
**Commit:** (this commit)

### 2026-05-21 — Move Hub link to footer; widen search-results dropdown
**Why:** Topnav was over-crowded (9 links + search + pill + theme toggle + CTA) and the search input was visually overlapping the brand area. Search-results dropdown was inheriting the input's narrow width, so long peptide/gene labels were getting truncated.
**What:**
- Removed `<a href="/hub/">Hub</a>` from the topnav `.links` row.
- Added `<a href="/hub/">ImmunoVerse Hub</a>` to the footer "Explore" column (alongside Atlas, Explorer, Aberration classes, Highlights).
- Decoupled `.search-results` width from the input: `width: 560px`, `min-width: 100%`, `max-width: calc(100vw - 32px)`. Anchored to the input's left edge so it extends rightward.
- Decision (recorded for future me): **kept the search as a visible input, not a magnifying-glass icon.** Search is the primary action on a research portal — hiding it behind a click adds friction for the core use case. If topnav crowding ever returns, narrow the search wrap further rather than collapsing it.
**Files:** `index.html`.
**Commit:** (this commit)

### 2026-05-21 — Add Deno→Cloudflare proxy fallback chain
**Why:** Single proxy = single point of failure. Adding a fallback chain so PNG downloads (and the legacy interactive-SVG upgrade) stay alive if either proxy goes down.
**What:** `IMG_PROXY` (string) → `IMG_PROXIES` (array). New `_proxiedFetch(url)` helper iterates the array. Both `_fetchImageBlob` and `fetchSvgIfExists` route through it.
**Files:** `index.html` only (demo + reviewers intentionally untouched).
**Commit:** `523d7c1`.

### 2026-05-21 — Point IMG_PROXY at Deno Deploy for one-click PNG download
**Why:** Cloudflare proxy was returning HTML 404s for NYU paths (cf-to-cf routing issue at the time). PNG download button was falling through to "open in new tab" instead of triggering a real save.
**What:** Created a Deno Deploy playground (`immunoverse-proxy.amans44.deno.net`) running a 30-line CORS proxy. Set `IMG_PROXY` to point at it.
**Files:** `index.html`. New external service: Deno Deploy playground.
**Commit:** `e1039ee`.

### 2026-05-21 — Block right-click save on drawer figures; drop dead IMG_PROXY ref
**Why:** Since the displayed figure is now SVG, right-clicking it would let users save the `.svg` file. We only want users to download the PNG (via the explicit button).
**What:** Added `oncontextmenu="return false;"` to all three drawer `<img>` tags. Temporarily set `IMG_PROXY = ''` (later restored to Deno proxy).
**Files:** `index.html`.
**Commit:** `d6ecd32`.

### 2026-05-21 — Render SVG-first via `<img>`, fall back to PNG on 404
**Why:** Restore the original "load SVG when available, else PNG" behavior without relying on the broken proxy. Browsers handle cross-origin SVG via `<img>` natively.
**What:** Three drawer `<img src>` tags swap from PNG URL → SVG URL. New `_figFallbackToPng` and `_spectrumFallbackToPng` helpers handle the `onerror` fallback chain (SVG → PNG → no-plot).
**Files:** `index.html` only (demo + reviewers untouched).
**Commit:** `5c9fb91`.

### 2026-05-21 — Un-ignore `hub/data/raw/*_metadata.txt` so downloads actually serve
**Why:** Global `*_metadata.txt` rule in `.gitignore` (originally to keep main-portal metadata out of git) was silently dropping the Hub mirror. The Hub's "Metadata" download buttons were returning the GitHub 404 HTML page.
**What:** Added the negation rule `!hub/data/raw/*_metadata.txt` and committed all 33 metadata files.
**Files:** `.gitignore`, 33 new files under `hub/data/raw/`.
**Commit:** `a548012`.

### 2026-05-21 — Include lowercase-named cancers in /hub (ependymoma, meningioma)
**Why:** `sync_hub.py` regex required all-caps cancer codes, so the two lowercase NYU entries (`ependymoma`, `meningioma`) were skipped.
**What:** Loosened regex to `[A-Za-z0-9]+`, added display names + CNS category mapping for the two. Reran sync. Totals went from 31 cancers / 4,177 samples / 144 cohorts to 33 / 4,276 / 147.
**Files:** `sync_hub.py`, `hub/data_js/*`, `hub/data/raw/*`.
**Commit:** `1111f66`.

### 2026-05-21 — Fix Yarmarkovich Lab URL in /hub footer (.org → .com)
**Why:** I hardcoded `.org` but the actual lab site is `.com`. Saved as a memory entry so I don't get this wrong again.
**Files:** `hub/index.html`.
**Commit:** `d43f09e`.

### 2026-05-20 — Add `/hub` page with auto-synced NYU immunopeptidomic datasets
**Why:** Fran requested a curated-but-unprocessed datasets resource that auto-picks-up new cancers Fran uploads to NYU. Separate from the Atlas.
**What:** New `sync_hub.py` script that scrapes the NYU public share for `{CANCER}_metadata.txt` + `{CANCER}_download.sbatch`, generates per-cancer JS modules + an index. New standalone `hub/index.html` (light theme default, dark toggle via localStorage), Stitch-design-aligned hero + filterable card grid. Extended `refresh-data.yml` to run `sync_hub.py` daily alongside `integrate_data.py`. Added `/hub` link to main topnav.
**Files:** `sync_hub.py`, `hub/index.html`, `hub/data_js/`, `hub/data/raw/`, `.github/workflows/refresh-data.yml`, `index.html` (topnav).
**Commit:** `2c14471`.

### 2026-05-19 — Drive Queries pill from GoatCounter, keep Worker as private metric
**Why:** The custom Cloudflare Worker query counter was unreliable for the visible pill (intermittent failures from search-hook firing path). GoatCounter's `/counter/TOTAL.json` endpoint is rock-solid. Visitor count ≈ what we wanted to display anyway.
**What:** Swapped the pill's data source from the Worker `/total` endpoint to GoatCounter's TOTAL endpoint. Worker `/increment` still gets called on each search/chatbot action — accumulating a separate private "actions" count for paper-supplementary use.
**Files:** `index.html`.
**Commit:** `75c7cc9`.

### 2026-05-19 — Add live query pill to topnav (initial version)
**Why:** Stitch design specced a live counter pill in the header.
**What:** Pill HTML in the topnav (`#liveStat`), pulsing-dot animation, JetBrains Mono numerals. Wired the Cloudflare Worker query counter (`immunoverse-queries.amansharma-e44.workers.dev`) with KV namespace `IMMUNOVERSE_COUNTERS`. Hooked search-result clicks + chatbot send + typeahead `runSearch` to fire `window.__bumpQueryCounter()`. Also widened the "Explore atlas →" CTA so the arrow stays inline.
**Files:** `index.html`, `chatbot/chatbot.js`.
**Commits:** `76920b4`, `34ff050`, `b178e60`, `d0b62f7`, `70862fc`.

### 2026-05-19 — Add GoatCounter alongside Cloudflare Web Analytics
**Why:** GoatCounter is cookieless and exposes a public JSON endpoint we can read from the browser (Cloudflare Web Analytics is dashboard-only).
**What:** Added the GoatCounter `<script>` snippet (`https://immuno-verse.goatcounter.com/count`) to `index.html`, `demo/index.html`, `reviewers/index.html`. Enabled "Allow getting site statistics via /counter/<path>.json" in GoatCounter settings.
**Files:** `index.html`, `demo/index.html`, `reviewers/index.html`.
**Commit:** `74d9bac`.

### 2026-05-19 — Add Cloudflare Web Analytics beacon to portal pages
**Why:** Need a private analytics dashboard for traffic insights (countries, top pages, devices).
**What:** Beacon script (token `3d25bed96fe3453ea6e41d1af78967cf`) installed in the `<head>` of `index.html`, `demo/index.html`, `reviewers/index.html`. Dashboard at `dash.cloudflare.com` → Analytics & Logs → Web Analytics.
**Files:** `index.html`, `demo/index.html`, `reviewers/index.html`.
**Commit:** `0992d47`.
