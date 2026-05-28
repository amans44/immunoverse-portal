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
- **Input:** `#globalSearch` in the topnav. **Expand-on-focus pattern:** the wrap takes a fixed `flex: 0 0 220px` slot so neighbors (queries pill, theme toggle, CTA) never shift. The inner `.search-input-row` is `position: absolute` on top of the wrap and grows to `min(520px, calc(100vw - 80px))` on `:focus-within`, overlaying neighbors. Click out → transitions back to 220 px. Below 960 px viewport, a media query resets this and the search drops to its own full-width row (`flex: 1 1 100%; position: relative`).
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

### Drawer section order (main `index.html`)

Top-to-bottom, the peptide drawer now lays out as:

1. **Drawer header** — peptide, copy/bookmark/Download-all buttons
2. **Pill row** — aa count, PSMs, abundance, recurrence, etc.
3. **`heroCallout`** — includes the collapsible "Show raw annotation" details
4. **Presentation metrics** — four-bar at-a-glance score block
5. **Expression window (RNA · TPM)** — tumor median vs max GTEx normal
6. **Gene expression boxplot** *(or splice/TE/chimeric differential plot for non-canonical rows)*
7. **Peptide intensity percentile** plot — SVG-first
8. **MS/MS spectrum** plot — SVG-first
9. **PSM rank-abundance** plot — **PNG-first** with optional "SVG" toggle
10. **Per-sample MS intensity** (table-like bar block) — `intensBlock`
11. **Per-HLA binding — observed samples** (table)
12. **Population coverage estimate** (data block)
13. **Extended NetMHCpan 4.1 panel** (table)
14. **Normal-tissue safety** (table)
15. **Therapeutic interpretation** (paragraph)
16. **Cross-references** (external links)

Plots cluster directly under the Expression window so readers see the figures first; the data tables that used to sit between them and the plots now appear below the plots.

### Render chain — percentile and spectrum (SVG-first)

For both plots, the `<img>` `src` is set to the **SVG URL** at NYU: `{ASSET_SVG_BASE}/{code}/{pep}_{kind}.svg` (or `spectrum_{pep}.svg`). Browser loads it cross-origin via `<img>` — **no proxy needed for display**.
- If the SVG returns 404 (peptide has no SVG yet), `onerror` fires → calls `_figFallbackToPng(this, pngUrl)` which swaps `src` to the PNG at `{ASSET_BASE}/{code}_{pep}_{kind}.png`.
- If the PNG also 404s, second `onerror` triggers → wrap gets `.no-plot` class and the `<img>` is removed (spectrum has a custom "Annotated spectrum not available" message via `_spectrumFallbackToPng`).

### Render chain — rank-abundance (PNG-first with manual SVG toggle)

Rank-abundance SVGs are noticeably larger than the corresponding PNGs (often 400–600 KB), so this plot defaults to **PNG**.
- `<img>` `src` = `{rankAbundanceUrl}` (the PNG) on initial render.
- A small "SVG" button sits left of the PNG-download button, **hidden by default**.
- After drawer renders, `_probeAndShowSvgToggle(wrap)` creates a hidden `Image()` with `src = wrap.dataset.svgUrl`. On `load`, the button un-hides; on `error`, it stays hidden — so the toggle only appears when an SVG actually exists for this peptide.
- Click button → `toggleRankAbundanceSvg(btn)` swaps `<img src>` from PNG↔SVG in place, and flips the button label ("SVG" → "PNG" → "SVG" …). PNG download button always downloads the PNG regardless of the current view. **No SVG download** is offered through the UI.
- The wrap does **not** carry `data-svg-kind`, so the auto `_upgradeFiguresToSvg` pass leaves rank-abundance alone (otherwise the PNG would be replaced by the interactive SVG, defeating the PNG-default behavior).

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

### 2026-05-28 — Scifi-figure legend accepts single-allele category labels
**Why:** After the previous fix landed, peptides like NBL/`RPAPPGAWV` and NBL/`IVLTNLPNR` rendered their interactive figure WITH dots but WITHOUT legend chips — console showed "no legends extracted". Root cause: the legend-collection filter in `_ivExtractMplScatter` required `;` in the comment (`!/[;]/.test(cmt)`), which meant only semicolon-separated multi-allele category labels (`A*24:02;B*18:01`) made the cut. Single-allele labels (`B*15:01`, `A*23:01`, etc.) got dropped, leaving `categories` empty even though the legend group clearly contained valid HLA entries.
**What:** Replaced the semicolon test with a new `HLA_CAT_RX = /^[A-DG]\*\d{2}:\d{2}/` (no `$` anchor, so it still passes for semicolon-joined sets — the regex just checks the comment *starts* with an HLA token). Multi-allele peptides keep working; single-allele peptides now produce legend chips too. `_ivHlaCategoryColor`'s `split(';')` is already safe for single-token labels (`'B*15:01'.split(';')` → `['B*15:01']`).
**Files:** `index.html`.
**Commit:** (this commit).

### 2026-05-28 — Scifi-figure extractors handle low-HLA + non-1.0 Y-axis peptides
**Why:** Users found a string of NBL peptides whose drawer fell through to the static themed-matplotlib rendering instead of the interactive scifi composition (RYLPSSVFL, RYYSALRHY, ETASNEVVY, KVYADTGLY, WASLPGPSM, and "many more"). Two independent extractor bailouts were at fault:
1. `_ivExtractMplHeatmap` hard-bailed when `hlas.length < 2` or `tissues.length < 5`. Single-HLA peptides like RYLPSSVFL (only `A*24:02`) were filtered out.
2. `_ivExtractMplScatter` required *both* `0.0` AND `1.0` Y-axis tick labels to back-compute percentile. Peptides whose data never reaches 1.0 get matplotlib Y-axes capped at lower values (RYYSALRHY's tops out at 0.7), so the 1.0 tick is absent and the function returned null.
**What:**
1. **Heatmap:** dropped thresholds to `hlas.length < 1` and `tissues.length < 1` — single-row/column heatmaps still render meaningfully.
2. **Scatter:** replaced the hardcoded `(0,1)` tick check with "pick whichever numeric ticks are actually present, sort, use min & max". The pct calculation became a generalized linear interpolation `vMin + (vMax - vMin) * (yPxMin - yPx) / (yPxMin - yPxMax)` so peptides with truncated Y-axes still produce correctly-scaled percentile values.
**Files:** `index.html`.
**Commit:** (this commit).

### 2026-05-28 — Invalidate stale SVG-exists localStorage cache
**Why:** User reported only one NBL peptide (`QYNPIRTTF`) was rendering the interactive SVG upgrade — the rest were just showing the static `<img>` (which looks similar but lacks hover tooltips, color-filter chips, zoom). Root cause: `fetchSvgIfExists` writes a `localStorage` entry keyed `svgexist:<url>` storing `exists: false` (with 12 h TTL) when a proxy fetch fails. While the proxy was broken earlier, many peptide-percentile URLs got cached as `exists: false`. The proxy works now, but those entries are still in localStorage and short-circuit the upgrade for 12 h.
**What:**
- Bumped the cache-key prefix from `svgexist:` to `svgexist:v2:` so every stale entry becomes invisible to the new code; next drawer-open triggers a fresh probe via `_proxiedFetch`. Any peptide whose SVG is actually available will now get the interactive upgrade.
- Reduced `SVG_EXISTS_TTL` from 12 h → 1 h so any future proxy hiccup self-heals within an hour instead of staying broken for half a day.
**Convention:** future proxy or NYU asset-tree changes that might affect SVG-existence verdicts should bump the cache key suffix (`v2` → `v3`, etc.) so users don't have to wait out the TTL.
**Files:** `index.html`.
**Commit:** (this commit).

### 2026-05-28 — Editable remarks on saved peptides and saved filter searches
**Why:** Aman wanted users to be able to edit the remark on any saved item from the account page (not just at creation time), so they can refine their notes later.
**What:**
- `account.html` `renderSavedCard()` now renders the existing remark with `data-edit-remark="<id>"` (click to edit) and, for cards without a remark, renders a dashed "+ Add remark" button with the same data-attribute.
- New `editSavedRemark(id, reload)` helper: prompts for the new remark (pre-filled with the current value), then DELETEs the existing `saved_searches` entry and POSTs a fresh one with the same `label` + `params` but updated `_remark`. Backend doesn't expose PATCH/PUT, so delete+recreate is the workaround. Side effect: `created_at` resets, but for this UX that's fine.
- New module-level `SAVED_ITEMS_BY_ID` cache so the edit handler can recover the original label + params without an extra round-trip.
- `wireSavedCardClicks()` also wires `[data-edit-remark]` clicks and stops them propagating to the card's "Open" navigation.
- New `.search-card-add-remark` button style (dashed border, primary tint on hover) and a `cursor: text` + hover state on `.search-card-remark`.
**Files:** `account.html`.
**Commit:** (pending — will batch with the next push).

### 2026-05-28 — Deep-link fix + Saved peptides section + responsive topnav
**Why:** Three user-reported issues hit in one pass.
1. **Deep-link `#explorer?cancer=X&open=PEPTIDE` was opening the cancer view but never the peptide drawer.** Root cause: `loadAll` called `applyFilters()` which is hooked to call `pushUrlState()`, and `pushUrlState` rebuilds the URL from `STATE` + `DRAWER_URL` — DRAWER_URL was null at that point, so `open=` was stripped before the wrapper at the end of `loadAll` could read it. The "Open" link in account.html for both saved searches and recently-viewed history was therefore broken.
2. **Bookmarked peptides landed in "Recently viewed", not a "Saved peptides" section.** The bookmark button POSTed to `/api/portal/history` — same endpoint as auto-history — so all it really did was refresh the timestamp. There was no separate Saved peptides UI.
3. **Topnav overflowed on 960–1280 px laptops/tablets.** Search bar, queries pill, theme toggle, sign-in chip, and CTA all competed for the same row and the right-most items got pushed off-screen.

**What:**
1. **Deep-link** (`index.html` near line 8170): capture `cancer` and `open` from `location.hash` into local vars *before* `_origLoadAll` runs, then use the captured values afterward. Single-file, ~10-line change.
2. **Saved peptides:**
   - Bookmark button (`index.html` near line 8542) now POSTs to `/api/portal/saved_searches` with `params: { cancer, pep, open, gene?, _remark? }` and a user-supplied label + optional remark. Prompts for both on click.
   - "Save this search" button also now prompts for an optional remark and stores it as `params._remark`.
   - `account.html` adds a new `<div id="savedPeptides">` card above the existing `<div id="savedSearches">` card. `loadSaved()` fetches once from `/api/portal/saved_searches`, splits results by `s.params.pep` presence into peptide-grid vs filter-grid, renders both with the new `renderSavedCard()` helper.
   - Each card surfaces `params._remark` (when present) inside a `.search-card-remark` block (📝 prefix, primary-tinted left border).
   - `renderParamChips` skips keys starting with `_` so `_remark` doesn't show as a chip.
3. **Topnav responsive layering** (`index.html` CSS): new breakpoints at 1280, 1180, 1100, 960, 520 px. Each step hides/shrinks one decorative element. **`#ivSignInBtn` (or `#ivUserMenu`) and `nav .cta` ("Explore atlas") stay visible at every width** — they're outside `.links` so the hamburger collapse below 960 px doesn't swallow them.

**Tradeoff to note:** Issue 2 stores `_remark` inside `params`. If the auth backend strictly validates which `params` keys it accepts, it may strip `_remark` server-side — in which case bookmarks would still work but the remark would silently vanish. From the spec we can see, `saved_searches` stores `params` as a JSON blob, so this should pass through fine. Flagging it here in case it ever needs a backend-side schema update.

**Files:** `index.html`, `account.html`.
**Commit:** (pending — Aman wants to test locally first before pushing).

### 2026-05-28 — Skip auth fetch for anonymous visitors (stops Chrome LNA prompt)
**Why:** Every page load was firing `fetch('https://auth.immunoverse-chat.com/api/portal/auth/me', { credentials: 'include' })` to check session state, even for anonymous visitors who had never signed in. This credentialed cross-origin fetch was tripping **Chrome's Local Network Access permission prompt** ("immuno-verse.com wants to Access other devices on your local network") — users would dismiss/block it without understanding, and it would visually appear at the same moment a peptide drawer was opening, so users conflated the prompt with the figures and walked away thinking "no plots for this peptide."
**What:** Gated the page-load `/auth/me` probe behind a `sessionStorage.getItem('iv_portal_access')` check. Anonymous visitors (no token) → `__IV_PORTAL_USER = null; showSignIn()` is called immediately, no network fetch. Visitors with a stored token (i.e., who've previously signed in) still hit `/auth/me` as before. Drawer-open history POST is also unaffected because it's already gated on `window.__IV_PORTAL_USER`.
**Tradeoff:** if any user is logged in via cookie only (no token in sessionStorage), they'll see "Sign in" on a new tab even though their session is still valid server-side. From the current code, `authedFetch` uses the stored token as a Bearer header, so this is unlikely to affect anyone in practice — but flagged here so future-me knows.
**Files:** `index.html`.
**Commit:** (pending — Aman wants to test locally first before pushing).

### 2026-05-28 — Drawer plots before tables; rank-abundance PNG-first with SVG toggle
**Why:** Aman asked for the peptide drawer to surface the figures first (right under Presentation metrics) before the data tables, since plots are the most visually communicative summary. Rank-abundance specifically defaults to PNG because its SVG is much larger (often 400–600 KB) — adding a manual "SVG" toggle so users who want the high-res version can opt in, without paying the load cost up-front for every drawer open.
**What:**
- **New section order** (top→bottom): drawer header → pill row → heroCallout → Presentation metrics → Expression window → Gene expression / differential plot → Peptide intensity percentile (SVG-first) → MS/MS spectrum (SVG-first) → PSM rank-abundance (PNG-first + SVG toggle) → Per-sample MS intensity → Per-HLA binding → Population coverage → Extended NetMHCpan panel → Normal-tissue safety → Therapeutic interpretation → Cross-references.
- **Rank-abundance becomes PNG-default.** `<img src>` now starts with the PNG URL. The wrap drops `data-svg-kind` so `_upgradeFiguresToSvg` skips it (no auto-promotion to interactive SVG). New `<button class="svg-toggle-btn">` sits left of the PNG-download button, hidden until `_probeAndShowSvgToggle` confirms the SVG exists at NYU. Click → `toggleRankAbundanceSvg` swaps `<img src>` in place and flips the button label. PNG download button always downloads PNG; SVG download is never offered.
- Two new JS helpers near `_figFallbackToPng`: `_probeAndShowSvgToggle(wrap)` and `toggleRankAbundanceSvg(btn)`.
- New CSS rule `.dl-figure-btn.svg-toggle-btn` (same positioning + cyan tint as `.iv-back-to-svg`) plus `[hidden] { display: none }` so the SDK's `hidden` attr cooperates with the absolute positioning.
**Files:** `index.html`.
**Commit:** (pending — Aman wants to test locally first before pushing).

### 2026-05-21 — Expand-on-focus search instead of flex-shrink
**Why:** The previous fix (`min-width: 320px` on `.search-wrap`) prevented the search from squeezing to a sliver, but pushed the "Explore atlas" CTA off the right edge of the topnav on narrow desktop viewports. User wanted the search to behave like a compact button that expands on click without disturbing neighboring topnav items.
**What:** Switched `.search-wrap` to a **fixed compact slot** (`flex: 0 0 220px`, explicit `height: 38px`). The actual `.search-input-row` is now `position: absolute` inside the wrap with `width: 100%` by default. On `:focus-within`, it grows to `width: min(520px, calc(100vw - 80px))` with a 0.2s ease transition, **overlaying** neighbors instead of pushing them. Click outside → input row collapses back to 220 px. Mobile media query at 960 px resets this so the search still gets its own full-width row.
**Files:** `index.html`.
**Commit:** (this commit)

### 2026-05-21 — Stop the search input from collapsing when topnav is crowded
**Why:** Users on viewports between ~960 px (the mobile breakpoint) and ~1300 px saw the search input squeezed down to a sliver — only half of the first typed letter was visible. Cause: `.search-wrap` was `flex: 1 1 auto; min-width: 0`, so the flex algorithm freely shrank it to make room for the rest of the topnav.
**What:** Set `.search-wrap { min-width: 320px; }`. That guarantees ~228 px of typable text area even on a crowded topnav. Other topnav items have to compress instead, which is the desired tradeoff. Below 960 px the existing media query still takes over and gives the search its own full-width row.
**Files:** `index.html`.
**Commit:** (this commit)

### 2026-05-21 — Make typed search text reliably visible
**Why:** Users reported typing in the global search and seeing the dropdown populate but not seeing their text in the input itself. Likely causes: Chrome autofill yellow-bg style hiding text, `-webkit-text-fill-color` overriding `color`, invisible caret, or the `<input type="search">` clear-button overlapping typed characters.
**What:** Layered defensive fixes on `.search-input`:
- Explicit `-webkit-text-fill-color: var(--text-0)` alongside `color` (some browsers/extensions respect one but not the other).
- `caret-color: var(--accent-cyan)` so the cursor is visible against the input's dark background.
- Bump `font-size` from 13.5 px → 14 px.
- Override Chrome's `:-webkit-autofill` style (inset box-shadow + text-fill-color) so saved searches don't render with the yellow/white "you can't see me" combination.
- Hide the `::-webkit-search-cancel-button` (x) that can overlap typed characters on narrow inputs.
- Re-assert `color` and `-webkit-text-fill-color` on `:focus` to defeat any focus-state override.
**Files:** `index.html`.
**Commit:** (this commit)

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
