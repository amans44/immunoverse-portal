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
- [Authentication & accounts](#authentication--accounts)
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

**The "Queries" pill** in the main portal's topnav fetches `GoatCounter /counter/TOTAL.json` on page load and renders the cumulative all-time visit count. The pulsing cyan dot is purely visual; the number is not real-time (refreshes per page load). **As of 2026-06-03 the pill is admin-only:** it is `display:none` by default and is revealed only for signed-in users whose `role === 'admin'` (via `setQueriesPillVisible()` in the auth bootstrap). Anonymous and non-admin signed-in visitors never see it. Query *counting* (the Worker `/increment` + GoatCounter fetch) still runs for everyone regardless of visibility.

---

## Visible UI elements

### Live "Queries" counter pill
- **HTML:** `index.html` — inside `<nav class="topnav">`, after `.links`, before `.theme-toggle`.
- **CSS class:** `.live-stat` (pill body), `.live-dot` (pulsing dot), `.live-num` (number), `.live-label` (caption).
- **JS:** inline `<script>` at the bottom of `index.html` — fetches `GC_TOTAL` (`https://immuno-verse.goatcounter.com/counter/TOTAL.json`) on load, renders the count. Also exposes `window.__bumpQueryCounter` (fire-and-forget POST to the Worker `/increment` endpoint) so search + chatbot actions still log to the Worker counter in the background.
- **Hooks that fire `__bumpQueryCounter`:** `runSearch` (debounced typeahead in `#globalSearch`), the `results` click handler (search-result selection), and the chatbot `send()` function in `chatbot/chatbot.js`.
- **Admin-only visibility:** the pill carries inline `style="display:none"` and is revealed only for signed-in admins by `setQueriesPillVisible(user)` (called from `showAccount`/`showSignIn`). It clears the inline style for admins rather than forcing a value, so the responsive `@media` hide rules below still apply.
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

## Authentication & accounts

The portal's account system (sign-in, sign-up, saved searches, peptide history,
admin console) is served by a **separate backend**, not by these static pages.

- **Frontend pages (this repo):** `login.html` (sign in / create account / request
  access), `account.html` (profile, saved items, sessions, change password),
  `admin.html` (admin console — users, access requests, inquiries, admin
  allow-list), and `reset.html` (forgot-password + set-password-after-approval).
  All call the backend through an **auth endpoint fallback chain** `IV_AUTH_BASES`
  (in every auth page + `index.html`):
  **`https://auth-service-739605637035.us-central1.run.app`** (primary — Cloud
  Run's own URL, not blocked by NYU, no DNS needed) →
  **`https://auth.immuno-verse.com`** (optional same-site host, needs a DNS record
  on the portal domain) → **`https://auth.immunoverse-chat.com`** (legacy fallback,
  sinkholed at NYU) → **`https://immunoverse-auth.amans44.deno.net`** (Deno Deploy reverse
  proxy, last-resort backstop — `deno.dev` stays reachable on networks that block
  the custom domains). The Deno proxy source is version-controlled at
  `deno-auth-proxy/main.ts` (fixed upstream + `/api/portal/` prefix + portal-only
  CORS, so it is NOT an open relay — unlike the image proxy whose source lives only
  in a dashboard). Auth carries across any base via the `Authorization: Bearer`
  header (+ `/refresh` body token), so cookie rewriting isn't needed for the proxy.
  `ivAuthFetch(path, opts)` tries each base in order; a network/DNS failure on one
  (exactly what NYU's DNS-sinkhole of `immunoverse-chat.com` produces) falls
  through to the next, while any HTTP response counts as "reached". The winning
  base is cached per session in `sessionStorage.iv_auth_base`. **Why:** the lab is
  at NYU, whose Palo Alto firewall DNS-sinkholes `immunoverse-chat.com` — serving
  auth from an `immuno-verse.com` subdomain keeps login working on NYU's network.
  Override the order with `window.IMMUNOVERSE_AUTH_BASES = [...]`; a localhost-only
  `?authbase=http://localhost:PORT` override still wins (persisted in `localStorage`
  as `iv_dev_authbase`; `?authbase=clear` resets it). Cookies stay **host-only**
  (`PORTAL_AUTH_COOKIE_DOMAIN` unset) so each auth host sets its own; the
  localStorage bearer token authenticates across the fallback. **Requires** a Cloud
  Run domain mapping for `auth.immuno-verse.com` + a `CNAME → ghs.googlehosted.com`
  at the immuno-verse.com DNS (see `deploy/gcp/deploy_auth.sh`).
- **Backend (sibling repo `immunoVerse_agent`, package `portal_auth/`):** FastAPI
  + Firestore, deployed to Cloud Run service **`auth-service`** (project
  `immunoverse-chat`, us-central1). JWT (HS256, `ns:"portal"` claim) in
  cross-site cookies `iv_portal_access` / `iv_portal_refresh`; bcrypt passwords.
  Collections are `portal_*` (e.g. `portal_users`, `portal_access_requests`,
  `portal_password_reset_tokens`, `portal_deleted_users`).
- **Session persistence ("stay signed in", as of 2026-06-03):** access token TTL
  60 min, refresh token TTL **30 days** (`portal_auth/auth.py`). `/refresh`
  *rotates* the refresh token and re-issues with a fresh 30-day expiry, so the
  window **slides** — any active use resets the clock; 30 days of true inactivity
  (or explicit sign-out) ends it. Frontend stores `iv_portal_access` +
  `iv_portal_refresh` in **`localStorage`** (NOT `sessionStorage`) so a session is
  shared across tabs and survives a browser restart. Each page (`index.html`,
  `account.html`, `admin.html`, `login.html`) does **refresh-on-401**: if
  `/auth/me` 401s, it calls `/refresh` once (cookie and/or the localStorage
  refresh-token fallback for Safari ITP) and retries before treating the user as
  signed out. `index.html` exposes `window.ivAuthSession` ({getToken,setTokens,
  clear,refresh}). Sign-out clears both tokens (`ivClearTokens`) but **keeps** the
  remembered account.
- **Access gating ("locked cancers") — ENABLED (2026-06-08).**
  `window.IV_GATING_ENABLED = true` in `index.html` (top of the ACCESS GATING
  block). Signed-out visitors see **NBL only** (`ANON_UNLOCKED = {'NBL'}`); the
  other 20 cancers are locked behind sign-in. The gate is **contextual** — it
  opens only when an anon visitor reaches for locked data (clicks a locked
  cancer/peptide/download, or searches one), never as an on-load interstitial.
  **Kill switch:** set `IV_GATING_ENABLED = false` (one line) to reopen everything
  instantly if a login outage would otherwise lock people out of 20/21 cancers.
  `isLocked(code) = GATING_ENABLED && !signedIn && !ANON_UNLOCKED.has(code)`.
  `__IV_SIGNED_IN` is
  seeded synchronously from token presence and corrected by `/auth/me`
  (`ivSyncSignedIn` → `window.ivApplyLockState()` re-renders + reloads if it
  flipped). `__IV_SIGNED_IN` is
  seeded synchronously from token presence and corrected by `/auth/me`
  (`ivSyncSignedIn` → `window.ivApplyLockState()` re-renders + reloads if it
  flipped). Locked surfaces, all routed to `openAuthGate()` → `window.ivOpenAuthGate()`:
  grid tiles (🔒 badge), the cancer `<select>` (disabled options), the downloads
  grid, body-map pins (via `selectCancer`), global-search peptide/cancer hits, and
  the URL deep-link openers (single-drawer, compare, popstate). The explorer only
  *loads* unlocked cancers (`loadAll` filters by `isLocked`), so locked data is
  never fetched client-side. **Bypass:** `IV_BYPASS_LOCK` is true under
  `/reviewers/`, so the (regenerated) reviewers mirror stays fully open and
  un-gated. To change the free set, edit `ANON_UNLOCKED`.
  **Resume-after-login:** `openAuthGate(intended)` stashes the visitor's intended
  destination in `window.__IV_GATE_RETURN`; `gateReturnUrl({cancer,pep,gene,hla,cls,
  compare})` builds a self-contained `index.html#explorer?…` deep link (same scheme
  as `pushUrlState`). The gate modal's Log in / Create links are refreshed on every
  open from that value, so `login.html?return=…` lands the user **exactly where they
  were headed** (the cancer/peptide they clicked) instead of `account.html`. Bare
  `openAuthGate()` (deep-link, compare, popstate) falls back to the current URL,
  which already IS the target. Gene/HLA/class search hits gate only when
  `applyFilters()` returns 0 for an anon (match exists only in locked cancers).
- **"Welcome" / sign-in-gate modal (homepage):** one modal (`#ivWbBackdrop` in
  `index.html`) with two faces, chosen by `ivFillAuthModal()`:
  - *Returning* (a remembered account exists in `localStorage`
    `iv_portal_last_account = {name,email}`, written on every sign-in by
    `index.html`/`account.html`/`login.html`) → **"Welcome back"** + account card
    (avatar + name + email + ✕ to forget) → `login.html?email=…` (prefilled);
    "Log in to another account"; "Create account".
  - *First-time* (no remembered account) → **"Welcome to ImmunoVerse"** + "Log in"
    / "Create account" (no card).
  `maybeShowWelcomeBack()` would auto-show it on signed-out homepage load, but its
  flag **`window.IV_WELCOME_MODAL_ENABLED` is now FALSE (2026-06-08)** — the on-load
  auto-popup read as spammy, so we nudge sign-up only at the moment a visitor
  reaches for locked data. The SAME modal is still opened on demand by the gate
  (`window.ivOpenAuthGate()`), so first-time/returning faces, the account card, and
  the resume links all still apply — just contextually, never as an interstitial.
  Dismissible via ✕ / backdrop / Esc; suppressed under `/reviewers/`. Flip
  `IV_WELCOME_MODAL_ENABLED = true` to bring back the soft on-load nudge.
  "Create account" deep-links to `login.html#create`.
- **Access model:** institutional emails (`.edu`/`.ac.*`/partner list in
  `auth/domain_check.py`) auto-activate on register; individuals submit an
  access request that an admin approves. Admin allow-list via
  `PORTAL_ADMIN_EMAILS` env + `portal_admin_allow_list` collection.
  - **Statuses:** `pending` (can't sign in — *"awaiting approval"*; admin
    **Activate**s them), `active` (full access), `suspended` (can't sign in;
    admin **Reinstate**s). Pending/suspended users see only the anon level
    (NBL) until activated. Required fields in the `login.html` register form are
    marked with a red `*`.
  - **Review-needed gets a mandatory justification (2026-06-08):** when a
    registration will land `pending` — a non-academic, OR an academic with an
    **unrecognized** domain (`INST_REGEX` client-side / `check_email_domain`
    server-side) — the form requires an **affiliation + an ≥80-char reason**, and
    `routes.register` enforces the same (400 otherwise). Recognized academics stay
    instant/frictionless (no reason asked). The reason is stored on the
    `PortalUser` (`reason` field) and shown inline in the **admin Users** table
    (`admin.html`) so an admin sees *why* someone asked — including after approval.
    Approved access requests also remain viewable via the Access-requests tab's
    **"Approved"** filter.
- **Password flows:**
  - *Forgot password* — `POST /api/portal/auth/reset-password` (emails a
    one-time link) → user lands on `reset.html?token=…` → `POST
    /reset-password/confirm`.
  - *Set password after approval* — approving an access request issues the same
    kind of token (`purpose:"setup"`, 24 h) and emails a set-password link; the
    admin response also surfaces the link + a one-time password as a fallback.
  - Tokens live in `portal_password_reset_tokens` (sha256-hashed); confirming
    activates a pending account and revokes all old sessions.
- **Admin user deletion (soft-delete + archive):** `DELETE
  /api/portal/admin/users/{id}` snapshots the user (and their saved searches /
  peptide history) into `portal_deleted_users`, then removes them from
  `portal_users` so the email is free to register fresh later. The admin keeps
  the archive permanently; a later registration under the same email is flagged
  `previously_deleted` in the user list, and `GET /api/portal/admin/deleted-users`
  shows the archive with a `reregistered` flag. Admins can't delete themselves
  or another admin (demote first).
- **Email delivery:** `portal_auth/email.py` is provider-agnostic. Today the live
  service has **no mail provider configured**, so reset/approval links fall back
  to the server console + the admin-surfaced link. Plugging in Resend/SendGrid/
  SMTP later is a config change (intended from address: `noreply@immuno-verse.com`,
  which needs DNS access to that domain — currently pending).

## Private in-house datasets (lab-only cancers)

In-house cohorts (**MB** medulloblastoma, **OS** osteosarcoma, **DIPG**, **NEPC**,
**CHORDOMA** — 5 live as of 2026-06-15) are hosted privately and folded into the
**same explorer** as the 21 public cancers, so they're directly comparable — not a
separate page. Visible ONLY to a lab allow-list;
invisible to everyone else (nav, dropdown, grid, search). Adding a cohort is purely
data-side (transform → upload → register a Firestore doc); the frontend discovers it
dynamically via `ivLoadInhouseGated`, no redeploy.

- **Storage:** private GCS bucket `immunoverse-private-datasets` (project
  `immunoverse-chat`, public-access-prevention ENFORCED), one folder per cancer at
  the bucket ROOT (e.g. `medulloblastoma/{MB.js, MB_detail.js, MB_metadata.txt,
  final_enhanced.txt, assets/}`). Raw `final_enhanced.txt` is transformed into the
  explorer's `window.__PD__["MB"]={…}` format by **`integrate_inhouse.py`** (reuses
  `integrate_data.py` helpers; asset names carry NO code prefix). Never served from
  `/hub` (that page is public-only).
- **Backend** (`portal_auth/dataset_routes.py`, mounted `/api/portal/data`): a
  Firestore doc `portal_private_datasets/<id>` records `cancer_code`,
  `storage_prefix`, `visibility`, plus per-dataset `allowed_emails` **and
  `allowed_groups`**. All 5 in-house datasets are `visibility:restricted` (2026-06-15)
  so the **In-house access board is the single source of truth** — the legacy flat
  `portal_lab_allow_list` / `PORTAL_LAB_EMAILS` no longer grants (and its admin tab is
  removed). (`lab` visibility + the flat list still exist in code for any future
  dataset that wants the simple "whole-lab" model.)
- **Granular per-dataset access board** (admin **"In-house access"** tab — the ONLY
  in-house access UI): each dataset has its own allow-list of reusable **groups** +
  individual **emails**, so an outside collaborator can be granted ONE cohort without
  joining the whole lab. Reusable groups live in `portal_access_groups/<name>`
  (`{members}`); a dataset's `allowed_groups` reference them. Access (non-admin) =
  email in `allowed_emails` OR in any `allowed_group`'s members OR (`visibility:lab`
  only) a central lab member. **Admins bypass everything — they see all datasets.**
  The whole lab is the `yarmarkovichlab` group assigned to every dataset.
  Endpoints under `/api/portal/data/admin`: `GET access-board`, group CRUD
  (`access-groups[...]`), and per-dataset `datasets/{id}/{emails,groups}` add/remove.
  This is the portal's OWN board — **separate** from the immunoVerse-chat board
  (`chat_access_groups` / `chat_cohort_access`); the two never share state.
  `GET /datasets` lists only what the caller may see; `/file?path=` proxies
  bytes (access-checked); `POST /sign` returns short-lived **V4 signed URLs** so
  `<img>`/downloads load cross-browser without cookies (avoids Safari/Firefox ITP).
  Signing uses IAM `signBlob` with a **cloud-platform-scoped** token (the storage
  scope alone is rejected). Toggle the whole feature with `PORTAL_PRIVATE_BACKEND`
  (`gcs` live / `filesystem` dev-or-off).
- **Frontend** (`index.html`): `ivLoadInhouseGated()` (signed-in only) fetches
  `/datasets`; a non-member gets `[]` and sees nothing. Members get the cancers
  registered into `window.IV_INHOUSE` (badged **🔒 In-house** in grid + dropdown).
  **Three members-only entry points** (`ivRevealInhouse`), all toggling the same
  in-house-only filter (`STATE.inhouseOnly`) and kept in sync by `ivSyncInhouseUI`:
  a compact **🔒 In-house pill** in the topnav (id `ivInhouseNav`, collapses to the
  lock icon < 1180px so it never pushes the CTA off-screen), a **🔒 In-house cohorts**
  item in the account dropdown (id `ivDdInhouse`), and a **banner above the explorer**
  (`#ivInhouseBanner`, `ivRenderInhouseBanner`) that lists the cohorts by name —
  the unmissable primary cue. Plus full comparability (global search, compare modal,
  bundle download); in-house cancers are never lock-gated (`isLocked` returns false
  for them). The data JS + assets are fetched with **relative** `/api/portal/data/...`
  paths through `ivAuthedFetch` (which prepends the resolved auth base itself — baking
  the base in too would double it and the fetch would silently throw, so the cancer
  never appears even though the entries show). Figures resolve via `ivSignInhouse()`
  (signed URLs in prod, local files under `?ivlocal=`).
- **Sharing** (`share.html` + account "Shared links"): a member shares a peptide OR
  a whole cohort. `POST /datasets/{id}/shares` mints a link `/share.html?s={id}` +
  a **retrievable** password (owner can re-view it in `account.html` and **revoke**
  via `GET /my-shares` + `DELETE /shares/{id}`). A collaborator opens the read-only
  `share.html`, enters the password (`POST /shares/{id}/unlock` → a scoped share
  JWT), and sees ONLY the shared content — a peptide share calls
  `GET /datasets/{id}/peptide`, which enforces the token's peptide claim server-side
  so the rest of the cohort is never sent. Assets stream via `/file?…&share={token}`.

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

### 2026-06-17 — Chat figures: GraphPad palettes + SVG hover tooltips + zoom panel + PNG/SVG/CSV downloads
**Where this lives:** the **chat agent** (`../immunoVerse_agent`, service `immunoverse-agent`,
rev `00042-9fw`), not the portal static pages. (See the entry below for the base figure tool.)
**Why:** the generated plots looked flat (default matplotlib colors) and were download-/
interaction-free. Make them publication-quality, recolorable on request, and genuinely usable.
**What:**
- **Palettes** (`plotting.py`): 9 named publication palettes — `prism` (default), `npg`,
  `lancet`, `nejm`, `jama`, `aaas`, `vibrant`, `colorblind` (Okabe-Ito), `classic` — plus a
  despined GraphPad-style look. `plot_peptides` gains `palette=` (named) and `colors=`
  (explicit hex list; for tumor-vs-normal the first = tumor, second = normal) so the agent
  recolors on request ("nature colors" → npg, "colorblind-safe" → colorblind, "dark red
  tumor / grey normal" → colors=[...]).
- **Three deliverables per figure**: PNG (always-renders markdown image) + **SVG** with
  native `<title>` **hover tooltips** (gid + XML injection) + **CSV** of the exact values
  drawn. `figures.save_figure` stores `<id>.png/.svg/.csv` under one id; `GET /figure/{key}`
  serves all three with correct media types (csv as an attachment).
- **Chat UI** (`web/chat.html` + `web/app.js`, `app.js?v=20260617a`): `enhanceChatFigures()`
  wraps each `/figure` plot in a card with **separate PNG / SVG / CSV download buttons**,
  upgrades the `<img>` to **inline SVG** so hover tooltips work (falls back to PNG; hides the
  SVG/CSV buttons for assets that have none, e.g. served boxplots), and a **Zoom** button that
  opens a **right-docked side-panel** (mirrors the 3D-viewer pattern) with mouse-wheel
  zoom-to-cursor + drag-pan on the vector SVG.
- **Verified in prod**: tool returns image_url/svg_url/csv_url + palette; `/figure/*.svg` is
  `image/svg+xml` with `<title>` tooltips; `/figure/*.csv` is `text/csv` with full-precision
  values; `palette=npg` and `colors=[...]` both recolor.
**Files:** _agent repo_ `plotting.py`, `figures.py`, `api_server.py`,
`immunoVerse_chat_mcp.py`, `web/chat.html`, `web/app.js`. **Commit:** _agent_ `21bde2e`.

### 2026-06-17 — Chat agent: server-rendered figure tool (8 plot types) + multi-gene compare
**Where this lives:** the **chat agent** (`../immunoVerse_agent`, Cloud Run service
`immunoverse-agent`), NOT the portal static pages. Logged here because the chat is
launched from the portal (`index.html` → `window.IMMUNOVERSE_AGENT_BASE`) and this is the
canonical change log. (The portal's own *drawer* figures are unrelated — see
[Figure rendering (drawer)](#figure-rendering-drawer) above.)
**Why:** the agent was fabricating "I made a graph" links and inventing example values.
Replace that with REAL figures rendered from NeoVerse table values only.
**What:**
- **`plotting.py`** (new) — pure matplotlib (Agg) renderers, one per plot type, each takes
  a DataFrame of real peptide rows and returns PNG bytes. Plot types:
  `per_sample_intensity`, `intensity_percentile`, `tumor_normal_specificity`,
  `prioritization_bubble`, `hla_coverage`, `peptide_length`, `expression_boxplot`
  (pre-rendered per-tissue tumor-vs-GTEx boxplot — **served, not drawn**), and
  `gene_expression_compare` (multi-gene tumor-vs-normal bars).
- **`figures.py`** (new) — figure store: `save_figure(png)` → same-domain
  `GET /figure/<uuid>.png` URL (https-upgraded to avoid mixed-content blocks). Public
  expression boxplots are fetched from the NYU asset share **server-side** and re-served
  via `/figure` (dodges NYU hotlink/cross-domain blank-image); in-house boxplots come from
  the private bucket, gated by the caller's cohort access.
- **`plot_peptides` tool** (`immunoVerse_chat_mcp.py`) — accepts `peptides=[...]`,
  `gene=...`, or `genes=[...]`; routes to the renderer; embeds the image URL as markdown.
- **`gene_expression_compare`** aggregates rows to the GENE level (median_tumor /
  max_median_gtex are gene-level), draws one tumor (red) + normal-max (blue) bar-pair per
  gene, is **not** row-capped, and matches **exact** gene tokens (a "TYR" request no longer
  drags in TYROBP/TYRP1). `only={requested}` keeps secondary-token matches from adding
  stray bars.
- **Verified in prod** (rev `immunoverse-agent-00041-sdt`): all 8 plot types return valid
  PNGs; PMEL-vs-TYR renders exactly two gene pairs.
**Files:** _agent repo_ `plotting.py`, `figures.py`, `immunoVerse_chat_mcp.py`,
`api_server.py`, `deploy/requirements.txt`. **Commits:** _agent_ `07d3b8b`, `f5fe84b`
(+ earlier figure-tool commits).

### 2026-06-15 — Portal in-house access = admins + board (retire the flat lab tab)
**Why:** The flat "Lab data access" list and the granular "In-house access" board were
redundant — a `yarmarkovichlab` group assigned to all 5 datasets already replicates
"whole lab sees all in-house", with per-dataset collaborators on top. Consolidate to
one place and make admins all-seeing.
**What:**
- **Admin bypass** (`portal_auth/dataset_routes.py`): `resolve_dataset_access` +
  `list_datasets` grant admins EVERY dataset regardless of visibility/lab/group. Access
  model = **admins + lab members (group) + per-dataset collaborators (emails)**. (auth-
  service rev 00026.)
- **Datasets flipped `visibility: lab → restricted`** so the board (groups + emails) is
  the SINGLE source of truth — the flat `portal_lab_allow_list` no longer silently
  grants. Safe: `yarmarkovichlab` (14 NYU + gli9) covers the lab; the only flat-list-only
  email was the admin, now covered by the bypass.
- **Removed the "Lab data access" tab** from `admin.html` (button, section, JS, init,
  switchTab). The In-house access board is the only place to manage in-house access.
  (The chat reached this state earlier — its lab tab was replaced by the board, and chat
  admins already bypass via `_request_allowed_cohorts`.)
**Files:** `admin.html`; _backend_ `portal_auth/dataset_routes.py`. **Commit:** _portal_
+ _auth-service_ — this change.

### 2026-06-15 — Exhaustive per-PNG audit: recover every renderable in-house figure
**Why:** A full audit (classify every asset → map to its peptide → is it rendered?)
found a handful of TRUE gaps: peptides showing NO figure though one exists. Causes:
multi-mapped (`not_unique`) ERV/splice/TE sources where `compute_diff_plot` bailed,
and the `intron_retention` CHM13 layout (`CHM13_G…|GENE|chr|…`) the pipeline didn't
handle. (Most "unrendered" figures are benign — secondary genes of multi-gene peptides
that already show a primary figure; the explorer has one figure slot per peptide.)
**What:** `integrate_inhouse.py` adds an **asset-anchored fallback** for non-canonical
rows when class derivation returns nothing: scan the RAW source for ERV/TE `*_dup<N>`
tokens + `chr:start-end` splice coords and attach any matching figure that ACTUALLY
exists (runs before the gene-boxplot fallback so a TE/splice peptide prefers its own
figure). intron_retention CHM13 figures derived by joining the first 7 `|`-fields with
commas. Re-audited all 5 cohorts: **0 broken links, 0 true gaps** — every peptide with
any figure renders one. Coverage up (OS 312→319 peptides-with-a-figure). Regenerated +
uploaded all 5 `.js`; verified live (MB 207, OS 319, DIPG 58, NEPC 41, chordoma 149).
**Files:** `integrate_inhouse.py`. **Commit:** _portal_ — this change.

### 2026-06-15 — Render the nuORF qualitative figure (chordoma cryptic ORFs)
**Why:** A scan of all 5 cohorts' nuORF peptides found chordoma uniquely ships a
`nuorf_qualitative_<pep>.png` figure for 33 of its cryptic ORFs — present in the
bucket but never rendered (the pipeline didn't emit it and the drawer had no slot).
(nuORF peptides are gene-less, so they have no expression boxplot — this qualitative
figure is the only extra evidence figure they get.)
**What:**
- `integrate_inhouse.py`: for `nuORF` rows, emit `extra.nuorfQual =
  nuorf_qualitative_<pep>.png` when that asset exists (guarded — only chordoma has
  them, so other cohorts are unaffected).
- `index.html` drawer: sign/resolve `nuorfQualUrl` and render a **"Cryptic ORF —
  qualitative expression"** plot-wrap section (expand + PNG-download), and include it
  in the "Download all" bundle. Regenerated + uploaded chordoma's `.js`; verified live
  (33 entries; figure serves 200).
**Files:** `index.html`, `integrate_inhouse.py`. **Commit:** _portal_ — this change.

### 2026-06-15 — Atlas table: wrap the Gene column + reset drawer scroll on open
**Why:** Peptides mapping to long multi-gene lists (histone clusters, e.g.
`H2AFX/HIST1H2AL/HIST1H2AJ/HIST1H2AB/…`) stretched the Gene column far off-screen
(cells are `white-space:nowrap`). Separately, opening a peptide drawer, scrolling
down, closing, then opening another showed the new drawer pre-scrolled to the old
position instead of its top.
**What:**
- Gene cell tagged `col-gene`; CSS gives it `min-width:170px` (so a single ENSG/ENST id
  like `ENST00000506424` never wraps — `overflow-wrap:anywhere` otherwise lets auto-
  layout collapse the column) and `max-width:270px`, and **wraps fully** (`white-space:
  normal` + `overflow-wrap:anywhere` + `word-break:break-word`) — the ENTIRE gene list
  stays visible across as many lines as needed, no truncation. Applies to every
  cancer's table (shared renderer). `<th data-col="gene">` matched.
- `openDrawer()` sets `#drawerBody.scrollTop = 0` right after the drawer opens (it's
  the only scrolling element), so each peptide opens at its header.
**Files:** `index.html`. **Commit:** _portal_ — this change.

### 2026-06-15 — Onboard DIPG, NEPC, Chordoma to the portal + robust figure attachment
**Why:** Three new in-house cohorts (DIPG, NEPC, Chordoma) were in the private bucket
(final_enhanced.txt + assets) but never processed into the explorer. Rendering them
"like MB" surfaced two figure-naming gaps that the MB-tuned `integrate_inhouse.py`
missed, risking broken/mis-attached figures.
**What:**
- `integrate_inhouse.py` hardened so EVERY shipped figure attaches to its correct
  peptide and nothing breaks: (1) **asset-existence guard** (`_guard_diff_plot`) — a
  figure ref is emitted only if that PNG exists in the cohort's `assets/` (no broken
  links); (2) gene expr-boxplots matched by **ENSG alone** via an `ENSG→asset` index,
  not reconstructed `ENSG_SYMBOL` — so multi-gene peptides (e.g. FOXP1/FOXP2/FOXP4)
  and histone symbol aliases (H2BC1 vs HIST1H2BA) still attach. Audited per cohort:
  **0 broken links**; diff-plot coverage up (DIPG 35→58, chordoma 74→114); the few
  residual unshown boxplots are peptides that already display a primary class figure
  (one figure slot per peptide, same as MB). Non-canonical source labels verified
  clean (gene/location, no `base_*`/`SRR` run-ids) via `clean_gene_inhouse`.
- Generated `<CODE>.js`/`<CODE>_detail.js` for the 3, uploaded to the bucket, and
  registered `portal_private_datasets` docs (dipg/nepc/chordoma, `visibility:lab`).
  Verified LIVE: a lab member lists all 5 cohorts; data JS + boxplot/percentile
  figures serve 200 through the access-checked proxy.
- MB + OS .js ALSO regenerated with the same hardened logic (audited 0 broken, 0 true
  gaps): MB diff-plots 206→207, **OS 268→312 (+44)** — OS's symbol-first self_gene
  layout had been missing boxplots that the ENSG-index match now recovers. Residual
  unshown boxplots in every cohort are only secondary genes of multi-gene peptides
  that already display their primary figure (one figure slot per peptide). Uploaded +
  verified live.
**Files:** `integrate_inhouse.py`. **Commit:** _portal_ — this change.

### 2026-06-14 — Granular per-dataset access board (groups + per-cohort emails)
**Why:** Some in-house cohorts have outside collaborators who should see ONE cohort,
not the whole lab (Frank's vision: e.g. Chordoma→Matija Snuderl, DIPG→Russell,
NEPC→John Maris). The flat `portal_lab_allow_list` was all-or-nothing. We add
granular, per-dataset access controlled from a new admin board — managed in the UI,
no code edits. Deliberately **separate per product**: this is the portal's board;
the immunoVerse-chat has its own independent one.
**What:**
- **Backend** (`portal_auth`): new reusable groups (`portal_access_groups/<name>` =
  `{members}`) + a `allowed_groups` list on each `portal_private_datasets` doc.
  `PortalPrivateDataset.allows_email(email, is_lab_member, user_groups)` now grants on
  allowed_emails OR a matching group OR (lab-visibility) lab membership;
  `resolve_dataset_access` + `GET /datasets` compute the caller's `user_groups`. New
  admin endpoints under `/api/portal/data/admin`: `GET access-board`, group CRUD, and
  per-dataset `datasets/{id}/{emails,groups}` add/remove (`require_portal_admin`).
  Group names validated (no reserved `__*__`/`/` Firestore ids → clean 400).
- **Frontend** (`admin.html`): new **"In-house access"** tab — a Groups manager
  (create/expand/add-member/delete) + a per-dataset board (assign group via dropdown,
  add/remove individual collaborator email, chips with × to revoke). Mirrors the chat
  board UI. Verified end-to-end against live Firestore (create→assign→read→cleanup).
**Files:** `admin.html` (board tab + JS + styles); _backend_ `portal_auth/models.py`,
`portal_auth/private_data.py`, `portal_auth/dataset_routes.py`. **Commit:** _portal_ +
_auth-service_ — this change (local, not yet deployed).

### 2026-06-11 — Fix percentile heatmap tooltip: cells are normal samples, not peptides
**Why:** Frank flagged that the interactive percentile figure's HLA×tissue heatmap
tooltip read "N peptides", but each cell value is the number of **normal samples**
(of that tissue) that carry that HLA — not a peptide count.
**What:** One-line wording fix in `_ivBuildScifiFigure`'s heatmap cell `data-tip`:
`${hla} × ${tissue} · ${v} normal sample(s) with this HLA`. Applies to every cancer
(the renderer is shared). No data/structure change.
**Files:** `index.html`. **Commit:** _portal_ — this commit.

### 2026-06-11 — Shared peptide page shows the full drawer data (not a stub)
**Why:** A peptide-scoped share rendered only the header, a pill row, the per-HLA
table and 2 figures — far less than the portal drawer shows for that peptide.
**What:** The backend `/peptide` endpoint already returns the full 19-col row + the
detail (`addq`, `intens`, `extra{diffPlot, source, mutations}`), so `share.html`'s
`renderPeptide` was expanded to match the drawer: presentation metrics (abundance,
spectral score, homogeneity, DepMap), the expression window (tumor vs normal TPM +
interpretation), source annotation for non-canonical rows (coords / transcript /
links / raw), all figures (spectrum, percentile, rank-abundance, gene boxplot,
splicing, ERV), per-HLA binding, the extended predicted-binder panel (`additional_
query`), per-sample MS intensity, HLA-Ligand-Atlas normal-tissue safety, mutations,
and cross-reference links. No backend change. Read-only and still peptide-scoped
(the token's peptide claim is enforced server-side).
**Files:** `share.html`. **Commit:** _portal_ — this commit.

### 2026-06-11 — Add osteosarcoma in-house cohort + fix non-canonical source names
**Why:** Frank's second in-house cohort (osteosarcoma, 640 peptides) is ready in GCS;
and the drawer showed the wrong "source name" for non-canonical medulloblastoma
peptides (it displayed the sample/run ID like `base_HDMB03_ERR4880042` instead of the
real gene/TE).
**What:**
- **Source-name fix (`integrate_inhouse.py`).** The public `clean_gene()` fallback
  regex grabbed the last `|`-token of the source, which in-house data fills with a
  sample/run ID (the public format has none). New class-aware `clean_gene_inhouse()`:
  `self_gene/variant/rna_edit` → the symbol (`STX2`, `GSTP1`); `splicing` → the gene
  (`HES6`, `RPP21`); `TE_chimeric` → host gene (`IDE`, `SCAP`); `ERV` → TE family
  (`MER52A`, `L1ME4a`); `nuORF` → transcript; `circRNA` → coords-only. Never returns a
  `base_*`/`add_*`/`*_ERR|SRR|DRR` token. Verified: 0 sample-name genes across MB(352)
  + OS(640). Medulloblastoma data was regenerated + re-uploaded with the fix.
- **Osteosarcoma live.** `OS.js`/`OS_detail.js` built (group Pediatric) and uploaded to
  `OS/`; Firestore `portal_private_datasets/osteosarcoma` (code `OS`, prefix `OS/`,
  **visibility lab**). Also made the metadata glob match `metadata.txt` (OS) as well as
  `MB_metadata.txt`. Smoke-tested live: a member sees MB + OS, OS data proxies, OS
  assets sign + fetch. No frontend change — `ivLoadInhouseGated` auto-discovers it; the
  banner now reads "Your lab in-house cohorts (2): Medulloblastoma, Osteosarcoma".
**Files:** `integrate_inhouse.py` (+ bucket data, Firestore). **Commit:** _portal_ — this commit.

### 2026-06-11 — Fix: in-house drawer detail (diffPlot figures, mutations, source) never loaded
**Why:** In-house peptides (e.g. medulloblastoma `SPKLGGIGF`) showed no gene-expression
boxplot, splicing/ERV differential, mutations, or source panel — even though the
assets exist in the bucket and sign + fetch fine.
**Root cause:** `loadDetail(code)` only knew the public path — it did
`loadScript('data_js/<code>_detail.js')`, which 404s for in-house cancers, then fell
back to `DETAIL_CACHE[code] = {}`. But `ivRegisterInhouse` had *already* fetched and
executed the detail JS into `window.__PD__["<code>_detail"]`; `loadDetail` just never
looked there. So `extra = {}` → no `diffPlot`, no mutations, no `source`. (The bars
that *did* show come from the row in `<code>.js`, not the detail — which is why it
looked like only the figures were broken.) Backend signing was fine all along.
**Fix:** `loadDetail` now returns `window.__PD__["<code>_detail"]` when it's already
loaded (the in-house case), before attempting the public `loadScript`. One-line-ish
change; fixes the drawer, the compare modal, and the bundle download together.
**Files:** `index.html`. **Commit:** _portal_ — see this commit.

### 2026-06-11 — Topnav never overflows: shrink search/brand + hamburger ≤1366 + first-name chip
**Why:** "Explore atlas →" kept running off-screen on laptops — 8 section links +
search + pill + account + CTA don't fit one row at ~1280–1440px. The biggest hidden
culprit was the search box: a fixed, non-shrinking `flex: 0 0 220px` that hogged
width no matter what.
**What:**
- **Search box shrinks.** `.search-wrap` → `flex: 0 1 200px; min-width: 130px;` so it
  gives up width under pressure instead of shoving the CTA off (the focus-expand
  overlay to 520px is absolutely positioned, so it's unaffected).
- **Account chip shows the first name only** (`showAccount`): `Aman` not `Aman
  Sharma`. The dropdown header keeps the full name.
- **Responsive bands.** ≤1599px: tighten gaps, hide the (admin-only) Queries pill,
  links → 12.5px, in-house pill → lock icon only. ≤1399px: drop the "Atlas" subtitle,
  compact the logo/wordmark (15px, 26px mark), links → 12px, smaller CTA/theme.
- **Hamburger at ≤1366px.** The 8 section links collapse into the `☰` dropdown (moved
  up from 960 → 1366 so all common laptop widths fold them into the menu); the search
  box, in-house pill, account chip and CTA stay in the bar — so the CTA is *always*
  visible. Search still drops to its own row ≤960px.
- **Hamburger closes on outside click / link choice / Esc** (not only when the ☰
  button is tapped again) — a document-level click handler that ignores the toggle
  button and in-menu chrome.
**Files:** `index.html`. **Commits:** _portal_ `51601c1` (chip + first bands), `38d6411`
(search shrink + compact brand + ≤1366), plus the menu-dismiss handler.

### 2026-06-10 — Fix: in-house cancer never loaded (double-base URL) + declutter topnav
**Why:** Right after go-live, a signed-in lab member saw the In-house entry but the
medulloblastoma cohort never appeared in the explorer, and the extra topnav link
pushed the "Explore atlas →" CTA off-screen.
**What:**
- **Data never loaded (root cause).** `ivLoadInhouseGated()` built the dataset
  `dataUrl`/`detailUrl` with the auth base already baked in, *then* fetched them via
  `ivAuthedFetch`, which prepends the resolved base again → `https://base` +
  `https://base/api/...` = a malformed URL → `fetch` throws → swallowed by
  `ivRegisterInhouse`'s catch → the cancer silently never registers (but the nav
  entry still shows, since reveal is unconditional). Fixed by making the data paths
  **relative** (`/api/portal/data/...`), matching the already-correct `/sign` path.
- **Topnav declutter → three discovery surfaces.** The **🔒 In-house** link had
  become a 9th item in the 8-link nav row and overflowed the "Explore atlas →" CTA.
  Final design (members-only, all toggling the same in-house-only filter, synced by
  `ivSyncInhouseUI`): a compact **🔒 In-house pill** in the topnav (outside the
  section-link row; collapses to the lock icon < 1180px so the CTA never overflows),
  the **🔒 In-house cohorts** item in the account dropdown, AND a **banner above the
  explorer** listing the cohorts by name (the unmissable primary cue, scales as OS
  etc. are added) — so an allow-listed member can't miss that the lab has private
  cancers. Broadened `.iv-user-dropdown button[role="menuitem"]` styling so the menu
  item (and the previously-unstyled Send-feedback button) render as proper rows.
**Files:** `index.html`. **Commit:** _portal_ — see this commit.

### 2026-06-10 — Private in-house datasets go LIVE: gated explorer + collaborator sharing
**Why:** Frank's in-house cohorts (medulloblastoma now, OS later) need to be hosted
privately for the lab yet be directly comparable to the 21 public cancers, and lab
members need to share a peptide or a cohort with outside collaborators.
**What:**
- **Live in-house cancer.** `medulloblastoma` (code `MB`, 352 peptides) registered
  in Firestore (`portal_private_datasets/medulloblastoma`, `visibility:lab`,
  `storage_prefix:medulloblastoma/`) and served from the private bucket. Folded into
  the main explorer for members only; badged **🔒 In-house**, with a topnav filter,
  search/compare/bundle parity, and never lock-gated. Non-members see nothing.
- **Cross-browser figures.** Images load via short-lived V4 **signed URLs**
  (`POST /datasets/{id}/sign`), not cookie-proxied — so Safari/Firefox ITP can't
  block them. Fixed a signer bug where the storage-scoped token was rejected by IAM
  `signBlob` (`ACCESS_TOKEN_SCOPE_INSUFFICIENT`); now mints a cloud-platform-scoped
  token for signing. Verified end-to-end with a live smoke test before shipping.
- **Sharing.** A member shares a **peptide** or a **whole cohort** from the drawer
  (**Share** button) → link `/share.html?s={id}` + a retrievable password. The
  read-only `share.html` gates on the password and renders ONLY the shared content;
  a peptide share is enforced server-side (`GET /datasets/{id}/peptide`) so the rest
  of the cohort is never exposed. Members see/copy their passwords and **revoke** any
  share from the new **"Shared links"** card in `account.html`.
**Files:** `index.html` (in-house registry/gating/badges/filter, signed-URL figures,
Share dialog), `account.html` ("Shared links" card), `share.html` (new read-only
landing page), `admin.html` ("Lab data access" tab), `integrate_inhouse.py` (new
transform); backend (sibling `immunoVerse_agent`): `portal_auth/dataset_routes.py`,
`models.py`, `private_data.py` (commit `c845bc7`). Go-live ops: bucket IAM
(`objectViewer` + `serviceAccountTokenCreator` on the SA), `iamcredentials` API,
`PORTAL_PRIVATE_BACKEND=gcs` + `PORTAL_LAB_EMAILS`, auth-service revision
`auth-service-00022+`. **Commit:** _portal_ — see this commit.

### 2026-06-08 — Require affiliation + a justification for review-needed sign-ups; show it in admin
**Why:** Pending users (esp. academics with unrecognized domains, who went through
the "Academics" tab) arrived with no message and often no affiliation, so admins had
nothing to review. Keep that context — and keep it visible after approval.
**What:**
- `login.html`: required fields now carry a red `*`. New `syncRegisterRequirements()`
  + `isReviewNeeded()` centralize which fields are shown/required. On the Academics
  tab, an **unrecognized email domain** (account will be pending) now reveals +
  requires the **affiliation** and a **≥80-char reason**; recognized academics stay
  frictionless. `handleRegister` validates this and sends `reason` to `/register`.
- `admin.html`: the Users table shows the user's reason inline under their
  name/email (`reason-cell`), so the "why" is visible for every user, even after
  they're activated. (Approved access requests already persist under the Access-
  requests "Approved" filter.)
- Backend (sibling `portal_auth`, LOCAL/unpushed): `PortalUser.reason`,
  `PortalRegisterRequest`/`PortalUserOut.reason`, and `routes.register` enforces
  affiliation + ≥80-char reason whenever the account will be pending. See that
  repo's `CHANGELOG.md`. Server-side enforcement goes live on the next auth deploy.
**Files:** `login.html`, `admin.html`, `ARCHITECTURE.md`. **Commit:** (pending —
batches with the auth-backend deploy; client-side validation works immediately).

### 2026-06-08 — Turn on cancer locking (NBL free), contextual gate, resume-after-login
**Why:** Lock the 20 non-NBL cancers behind sign-in, but make it feel non-spammy.
The on-load welcome interstitial annoyed visitors; instead the sign-in prompt
should appear only when someone actually reaches for locked data — and after they
sign in they should land back where they were, not on their account page.
**What (`index.html`):**
- `IV_GATING_ENABLED = true` (was `false`) → signed-out visitors get NBL only;
  `loadAll()` still fetches only unlocked cancers so locked data never hits the
  client. `IV_GATING_ENABLED = false` remains the one-line kill switch.
- `IV_WELCOME_MODAL_ENABLED = false` (was `true`) → no on-load auto-popup; the
  same modal is now used only on demand by the contextual gate.
- **Resume-after-login:** new `gateReturnUrl({cancer,pep,gene,hla,cls,compare})`
  builds an `index.html#explorer?…` deep link; `openAuthGate(intended)` stashes it
  in `window.__IV_GATE_RETURN`; the gate modal's Log in / Create links + the
  remembered-account button are refreshed on every open so `login.html?return=…`
  lands the user exactly where they were headed (`login.html` already honored
  `return`, defaulting to `account.html`).
- Call sites now pass the intended target: `selectCancer`, the `fCancer` change
  handler, the downloads grid, and global-search peptide/cancer hits. Gene/HLA/
  class search hits gate only when `applyFilters()` (now returns its filtered row
  count) yields 0 for an anon — i.e. the match lives only in locked cancers. Bare
  `openAuthGate()` (deep-link/compare/popstate) still defaults to the current URL.
**Files:** `index.html`, `ARCHITECTURE.md`. **Note:** `/reviewers/` mirror stays
ungated (`IV_BYPASS_LOCK`). Not yet committed/pushed.

### 2026-06-03 — Freeze /reviewers/ + keep the Welcome popup as a soft sign-up nudge
**Why:** (1) `/reviewers/` must stay independent + login-free for paper reviewers,
unaffected by main-site changes. (2) Cancers stay unlocked, but we still want the
Welcome popup as a gentle "create an account" reminder.
**What:**
- **Reviewers frozen:** reverted `reviewers/index.html` + `reviewers/chatbot/` to
  pristine (zero gating/auth code), set `sync_reviewers.py` `COPY_INDEX = False`
  and dropped `chatbot/` from `MIRRORS`. Only data (`data_js/`, `data/`,
  `pancancer_image.png`) is still mirrored, so reviewers stay data-current with no
  UI changes leaking in.
- **Welcome modal decoupled from gating:** new `window.IV_WELCOME_MODAL_ENABLED =
  true` (separate from `IV_GATING_ENABLED = false`). `maybeShowWelcomeBack()` now
  keys off the modal flag, so the dismissible popup shows as a sign-up nudge while
  all cancers remain open. First-timer subtitle reworded to benefits-based copy
  (no "to explore", since nothing is locked).
**Files touched:** `index.html`, `sync_reviewers.py`, `reviewers/index.html` +
`reviewers/chatbot/chatbot.js` (reverted), `ARCHITECTURE.md`. Commit SHA: _pending_.

### 2026-06-03 — Disable cancer locking behind a feature flag (keep the code, don't gate the public)
**Why:** Decision to NOT lock cancers publicly until the login system is hardened
— a single auth hiccup with gating on would lock everyone out of 20/21 cancers.
**What:** Added `window.IV_GATING_ENABLED = false` in `index.html`. While false:
`isLocked()` always returns false (all 21 cancers open, full explorer loads for
everyone), the homepage Welcome/sign-in modal does NOT auto-show, and
`ivApplyLockState()` no-ops. The public site behaves exactly as before gating. All
the locking + modal code stays in place — re-enabling is a one-line flip to
`true`. Everything else from today's work stays live (hero count fix, admin-only
Queries pill, persistent localStorage sessions + refresh-on-401, the auth endpoint
fallback chain run.app→…→Deno). `window.ivOpenAuthGate()` still works on demand.
**Files touched:** `index.html` (+ regenerated `reviewers/index.html`),
`ARCHITECTURE.md`. Commit SHA: _pending_.

### 2026-06-03 — Auth endpoint fallback chain (Cloud Run run.app primary — fixes NYU login, no DNS needed)
**Update:** the primary base is the auth service's own
`https://auth-service-739605637035.us-central1.run.app` Cloud Run URL. Verified on
NYU WiFi it returns 401 (reachable) while `immunoverse-chat.com` is sinkholed — so
`run.app` (and `deno.net`) are NOT blocked; only `immunoverse-chat.com` is. This
needs **no custom domain, no DNS, no redeploy** — it works the moment the frontend
is published. `auth.immuno-verse.com` (needs a DNS record from the domain owner)
stays in the chain as an optional nicer same-site host; `auth.immunoverse-chat.com`
is the legacy last resort. CORS already allows the `immuno-verse.com` origin
regardless of which auth host serves, and cross-site cookies (SameSite=none) +
the localStorage bearer token authenticate across hosts. Also added a **4th-tier
Deno Deploy reverse proxy** (`https://immunoverse-auth.amans44.deno.net`) as a
guaranteed-reachable backstop; its source is version-controlled at
`deno-auth-proxy/main.ts` (deploy via `deno-auth-proxy/README.md`). Requires a
one-time `deployctl deploy --project=immunoverse-auth` to go live; until then the
4th entry is just a dead probe that's never reached in practice.


**Why:** NYU's network (Palo Alto firewall, DNS Security) **DNS-sinkholes
`immunoverse-chat.com`** — confirmed: on NYU WiFi all `*.immunoverse-chat.com`
names resolve to `sinkhole.paloaltonetworks.com`, while Google `8.8.8.8` returns
the real `ghs.googlehosted.com` (Cloud Run) and a direct-IP HTTPS request to the
service succeeds. So the service is fine; the *domain* is blocked on NYU's
network. Since the lab is at NYU and the portal's login + locking depend on
`auth.immunoverse-chat.com`, sign-in is broken on NYU WiFi. Fix: serve auth from
the portal's own (un-sinkholed) domain, with the chat domain as a fallback —
same idea as the `IMG_PROXIES` Deno→Cloudflare chain, applied to auth.
**What:**
- Every auth-calling page (`index.html`, `login.html`, `account.html`,
  `admin.html`, `reset.html`) now resolves an ordered `IV_AUTH_BASES`
  (`auth.immuno-verse.com` → `auth.immunoverse-chat.com`) and routes all auth
  requests through `ivAuthFetch(path, opts)`, which tries each base, falls through
  on network/DNS failure (not on HTTP status), and caches the winning base in
  `sessionStorage.iv_auth_base`. Replaced all `fetch(AUTH + …)` call sites.
- The localhost `?authbase=` dev override still wins (collapses the chain to one
  base). Order is overridable via `window.IMMUNOVERSE_AUTH_BASES`.
- Backend `deploy/gcp/deploy_auth.sh` (sibling repo): added
  `https://www.immuno-verse.com` to CORS and documented the
  `auth.immuno-verse.com` domain-mapping step. Cookies stay host-only
  (`PORTAL_AUTH_COOKIE_DOMAIN` unset) so both auth hosts work; bearer token covers
  the fallback path.
- Re-ran `sync_reviewers.py`.
**Manual infra still required (one-time):** `gcloud beta run domain-mappings
create --service=auth-service --domain=auth.immuno-verse.com --region=us-central1`,
then add the printed `CNAME auth → ghs.googlehosted.com` at the immuno-verse.com
DNS registrar. Until that's live the primary base fast-fails and the chat-domain
fallback is used (unchanged behaviour off-NYU).
**Files touched:** `index.html`, `login.html`, `account.html`, `admin.html`,
`reset.html` (+ regenerated `reviewers/index.html`),
`immunoVerse_agent/deploy/gcp/deploy_auth.sh`, `ARCHITECTURE.md`.
Commit SHA: _pending_.

### 2026-06-03 — Lock 20 of 21 cancers behind sign-in (NBL free) + first-time-visitor gate modal
**Why:** Make the atlas account-gated: anonymous visitors get a free taste (NBL)
and must sign in / create an account to reach the other 20 cancers. Pair it with a
sign-in gate modal that also greets brand-new visitors.
**What:**
- **Locking (`index.html`):** `ANON_UNLOCKED = {'NBL'}`, `isLocked(code)`,
  `__IV_SIGNED_IN` (optimistic from token, corrected by `/auth/me` via
  `ivSyncSignedIn` → `window.ivApplyLockState`). Gated every access path:
  grid tiles (🔒 badge + `ctile-locked`), `selectCancer`, the cancer `<select>`
  (disabled options), downloads grid (→ gate), body-map pins, global-search
  peptide/cancer hits, and the three URL deep-link loaders (single drawer, compare,
  popstate). `loadAll()` only fetches unlocked cancers, so locked data never hits
  the client. New `openAuthGate()` routes locked clicks to `window.ivOpenAuthGate`.
- **First-time-visitor modal:** the welcome modal now has two faces via
  `ivFillAuthModal()` — "Welcome back" (+ account card) when a remembered account
  exists, else "Welcome to ImmunoVerse" (+ Log in / Create). `ivOpenAuthGate()`
  (exposed on `window`) opens it on demand for locked clicks, ignoring the
  per-tab dismissed flag; auto-greeting still fires on load and is dismissible.
- **Reviewers stay open:** `IV_BYPASS_LOCK` (`/reviewers/` path) disables all
  gating + the auto modal, so the regenerated `reviewers/index.html` mirror is
  fully browsable without an account (its documented purpose). `demo/index.html`
  keeps its own separate static 3-cancer gating — untouched.
- Re-ran `sync_reviewers.py`.
**Files touched:** `index.html` (+ regenerated `reviewers/index.html`),
`ARCHITECTURE.md`. Commit SHA: _pending_.

### 2026-06-03 — Persistent "stay signed in" sessions + ChatGPT-style "Welcome back" modal
**Why:** (1) Sign-in didn't persist — the token lived in `sessionStorage`, so it
died on tab close and wasn't shared across tabs; a fresh tab always looked logged
out. We want Netflix/ChatGPT-style "stay signed in until you sign out." (2) Add a
"Welcome back" account picker on the homepage for returning, signed-out visitors
(ref: `references/create account .png`). Context: most cancers are being locked,
so we want a smooth re-entry path.
**What:**
- **Backend (`immunoVerse_agent/portal_auth/auth.py`):** `REFRESH_TOKEN_TTL_DAYS`
  7 → **30**. `/refresh` already rotates + re-issues the refresh token, so this is
  a **30-day sliding** window (resets on each use). ⚠️ **Needs a Cloud Run
  redeploy of the auth service** to take effect.
- **Token persistence (frontend):** moved `iv_portal_access` + new
  `iv_portal_refresh` from `sessionStorage` → **`localStorage`** in `login.html`,
  `account.html`, `admin.html`, `index.html` (shared across tabs, survives
  restart). httpOnly cookies remain the primary credential; localStorage is the
  cross-site (Safari ITP) bearer fallback.
- **Refresh-on-401:** `index.html` (`ivResolveSession`/`ivTryRefresh`),
  `account.html` + `admin.html` (`boot()`), and `login.html` (`checkSession`)
  now silently `/refresh` once before treating a 401 as signed-out / before
  showing the login form. New `window.ivAuthSession` helper on the homepage.
- **"Welcome back" modal:** new `#ivWbBackdrop` modal + CSS in `index.html`;
  `maybeShowWelcomeBack()` shows it for signed-out visitors with a remembered
  account (`iv_portal_last_account`, written on every sign-in). Dismissible;
  per-tab `iv_wb_dismissed` guard. `login.html` gained `?email=` prefill +
  `#create` deep-link.
- **Sign-out** everywhere now clears both tokens (`ivClearTokens`) but keeps the
  remembered account so the modal can greet the user next time.
- `demo/index.html` has no auth layer → unchanged. Re-ran `sync_reviewers.py` so
  `reviewers/index.html` picks up all of the above.
**Files touched:** `index.html`, `login.html`, `account.html`, `admin.html`
(+ regenerated `reviewers/index.html`), `immunoVerse_agent/portal_auth/auth.py`,
`ARCHITECTURE.md`. Commit SHA: _pending_.

### 2026-06-03 — Gate the live "Queries" pill to signed-in admins only
**Why:** The topnav "Queries" counter was visible to every visitor. We want the
live query/visit count to be an internal metric, shown only to admins after
sign-in — not exposed to the public.
**What:**
- The `#liveStat` pill now carries inline `style="display:none"` and is revealed
  only when the auth bootstrap detects a signed-in user with `role === 'admin'`.
- New helper `setQueriesPillVisible(user)` in the topnav auth IIFE: called from
  `showAccount(user)` (reveals for admins, hides for non-admins) and `showSignIn()`
  (always hides). It clears the inline `display` for admins rather than setting a
  fixed value, so the existing `@media (max-width:560px)` hide rule still applies.
- Query *counting* is unchanged: the GoatCounter fetch and the fire-and-forget
  Worker `/increment` still run for all visitors — only the on-screen display is
  gated.
- `demo/index.html` has no Queries pill, so it needed no change.
- Re-ran `sync_reviewers.py` so `reviewers/index.html` picks up the gated pill.
**Files touched:** `index.html` (+ regenerated `reviewers/index.html`),
`ARCHITECTURE.md`. Commit SHA: _pending_.

### 2026-06-03 — Fix bogus "340,000+" hero stat on the cancers grid
**Why:** The "All 21 cancers" section heading read `21 cancers · 340,000+ ranked
candidate targets`. That number was never computed from the data — it's a leftover
placeholder traceable to the old Google Stitch login mockup
(`login-stitch/v0/code.html`, "over 340,000 unique cancer-specific peptides" /
`340,291`). The manuscript (`cancer_discovery/.../nature_cancer_submission_*.docx`)
never claims 340,000 (its headline is 16,687 tumor-specific pHLAs). The portal's
actual atlas holds **26,603** targets across the 21 cancers — confirmed three ways:
sum of the per-tile `count` fields in `data/*.json`, the row count in
`data_js/_search_index.js` (26,603 rows), and the sum of the visible tile numbers.
The heading sits directly above the explorer it describes ("Click a tile to filter
the explorer"), so it now matches the data exactly.
**What:**
- Changed the hero `<h2>` to `21 cancers · 26,603 ranked candidate targets` in the
  root `index.html` and the hand-maintained `demo/index.html`.
- Changed the same string in the chatbot help text (`chatbot/chatbot.js`,
  `#cancers` line).
- Re-ran `sync_reviewers.py` (propagates root `index.html` + `chatbot/` to
  `reviewers/`) and `build_demo.py` (propagates root `chatbot/` to `demo/chatbot/`),
  so all 6 served copies now read 26,603.
- Note: the stale `340,291` figure still lives in the archived, non-served
  `login-stitch/v0/code.html` mockup and was intentionally left untouched.
**Files touched:** `index.html`, `demo/index.html`, `chatbot/chatbot.js`
(+ regenerated `reviewers/index.html`, `reviewers/chatbot/chatbot.js`,
`demo/chatbot/chatbot.js`). Commit SHA: _pending_.

### 2026-05-29 — Portal auth fixes: forgot-password, set-password-after-approval, admin soft-delete
**Why:** Three reported gaps. (1) Approved individual users had no way to set a
password — approval minted a one-time password returned only in the admin API
response, never delivered, with no set-password page. (2) Admins could only
suspend, never delete a user. (3) No "forgot password" anywhere on the portal.
**What:**
- **Backend (`immunoVerse_agent/portal_auth/`):**
  - New `PortalPasswordResetToken` model (`portal_password_reset_tokens`,
    `purpose` = `reset` | `setup`) and `PortalDeletedUser` archive model
    (`portal_deleted_users`).
  - New endpoints `POST /api/portal/auth/reset-password` and
    `/reset-password/confirm`. Confirm sets the password, activates a pending
    account, revokes all sessions, consumes the token.
  - `approve_request` now also issues a `setup` token + emails a set-password
    link and returns `set_password_url` + `email_sent` alongside the existing
    OTP fallback ("Both" behaviour).
  - New `DELETE /api/portal/admin/users/{id}` (soft-delete: archive user +
    subcollections to `portal_deleted_users`, free the email) and `GET
    /api/portal/admin/deleted-users`. `list_users` flags `previously_deleted`.
  - New provider-agnostic `portal_auth/email.py` (`send_portal_password_email`),
    console fallback when no mail provider is set; from `noreply@immuno-verse.com`.
- **Frontend (this repo):**
  - New `reset.html` (request-reset form when no `?token`, set-password form when
    a token is present).
  - `login.html` — added a "Forgot password?" link to the sign-in form.
  - `admin.html` — added a **Delete** button on non-admin user rows (confirm +
    optional reason) and a "↺ returning" badge for `previously_deleted` users.
  - All four auth pages gained a localhost-only `?authbase=` dev override.
**Verified:** offline test against the in-memory Firestore mock — all flows pass
(approve→set-password→login, forgot-password→login, delete→archive→re-register→
flag, admin self-delete blocked). Browser/live test pending.
**Email caveat:** prod `auth-service` has no mail provider yet, so reset/approval
links are delivered via the admin-shown link + one-time password until
Resend/SendGrid + `immuno-verse.com` DNS are set up.
**Files:** `reset.html`, `login.html`, `admin.html`, `account.html`,
`ARCHITECTURE.md` (portal); `portal_auth/models.py`, `schemas.py`, `routes.py`,
`admin_routes.py`, `email.py` (agent repo).
**Commit:** (pending).

### 2026-05-29 — Make deep-linked drawer / comparison URLs shareable (sync URL on skipUrl path)
**Why:** When the user clicked "Open →" on a saved peptide (or visited a peptide from "Recently viewed", or shared a `&open=PEPTIDE` URL with a colleague), the drawer opened correctly but the URL stayed as `#explorer?cancer=NBL` — the `&open=PEPTIDE` part was missing. Same for saved comparisons: clicking Open rebuilt the COMPARE set and showed the modal, but `compare=…` was gone from the URL. Result: users couldn't copy + share the URL of the thing they were looking at.
**Root cause (drawer):** `openDrawer(row, { skipUrl: true })` from the deep-link handler set `DRAWER_URL` but skipped *both* `history.pushState` AND `pushUrlState()`. The `pushState` skip was intentional (no duplicate back-button entry), but skipping `pushUrlState` meant the URL params never got re-synced after `applyFilters` stripped them earlier in `loadAll`.
**Root cause (comparison):** `pushUrlState` had no concept of the comparison modal state, so even when the modal was open the URL never encoded the active `pep::code` set.
**What:**
1. **`openDrawer` skipUrl branch** now also calls `pushUrlState()` — this uses `replaceState`, so no extra history entry, just URL-param sync. Deep-linked drawers (saved peptides, recent peptides, shared URLs) now produce `?cancer=NBL&open=QYNPIRTTF`.
2. **New `COMPARE_URL` global** mirrors `DRAWER_URL` semantics: holds the active `[pep::code, …]` array when the comparison modal is open, `null` otherwise.
3. **`pushUrlState` emits `compare=`** when `COMPARE_URL` is set with ≥2 keys.
4. **`openCompareModal`** assigns `COMPARE_URL` from the active `COMPARE` set and calls `pushUrlState()` right after rendering. **`closeCompareModal`** clears it and re-syncs.
**Files:** `index.html`.
**Commit:** (this commit).

### 2026-05-29 — Saved comparisons (third saved-search bucket)
**Why:** Aman asked to bring the "Saved comparisons" item from the marketing copy into reality, alongside the already-shipping Saved peptides and Saved filter searches. Frank specifically asked about it.
**What:**
- **Compare modal** gets a new `★ Save this comparison` button in the top-right next to the close `×`. `handleSaveComparison()` prompts for label + optional remark, then POSTs to `/api/portal/saved_searches` with `params: { compare_keys: "PEP1::CODE1,PEP2::CODE2,…", _remark? }`.
- **Backend: no changes.** Same `saved_searches` collection, just a new shape of `params`.
- **`account.html`** splits saved entries into THREE priority-ordered buckets:
  - comparison (has `compare_keys`) — new `★ Saved comparisons` card above the existing two
  - peptide (has `pep` and not `compare_keys`)
  - filter search (neither)
  `renderParamChips` gets a special case for comparisons: shows `N pep × M cancer` + (if one peptide) `pep=…`, rather than dumping the raw key list.
- **`buildExplorerUrl`** emits `compare=` for entries that carry `compare_keys`. Result URL: `#explorer?compare=PEP1::CODE1,PEP2::CODE2,…`.
- **Deep-link**: `loadAll`'s wrapper in `index.html` captures `compare` alongside `open`/`cancer` before `applyFilters` strips it; after the original `loadAll` returns, parses the keys, repopulates the `COMPARE` set, lazy-loads each involved cancer, calls `renderCompareBar()`, opens the modal.
- **Remark editing** works for free — `editSavedRemark` operates on the whole `saved_searches` collection regardless of which bucket it ended up in.
**Files:** `index.html`, `account.html`.
**Commit:** (this commit).

### 2026-05-28 — Fix `tissues.map(t => t.cmt)` → `t.name` (latent bug surfaced by the dual-axes fix)
**Why:** After the dual-axes extractor landed, even peptides that used to work (QYNPIRTTF) showed "undefined" instead of tissue names on the X-axis. Latent bug in the return statement: `tissues` were already mapped to `{ name, x }` objects further up, but the return read `t.cmt` — undefined for every tissue. The old single-axes code happened to plumb `cmt`-shaped objects through some paths so the bug was hidden; the new clean split surfaced it.
**What:** Changed `tissues: tissues.map(t => t.cmt)` → `tissues: tissues.map(t => t.name)`. Single-character fix. HLAs were already returned correctly via `h.name`.
**Files:** `index.html`.
**Commit:** (this commit).

### 2026-05-28 — Extract heatmap HLAs and tissues from independent axes (architecture fix)
**Why:** After the previous legend-union fix, NBL/`RYYSALRHY` showed all 4 HLA rows in the heatmap but the X-axis tissue names disappeared. Root cause: matplotlib splits the percentile figure across multiple `<g id="axes_N">` subplots that share an X-axis — the HEATMAP subplot (`axes_3`) carries the HLA y-tick labels, the PER-TISSUE SCATTER subplot below it (`axes_2`) carries the tissue x-tick labels. The old extractor picked ONE axes by score (#HLAs × #tissues). For RYYSALRHY that was `axes_2` (1×30 = 30 vs `axes_3`'s 4×0 = 0), so HLAs only came from `axes_2` and the heatmap rendered with the wrong row count.
**What:** Replaced the single "best axes" choice with **two independent picks**:
  - `hlaAxesTx` = axes with the most HLA-pattern tick labels (the real heatmap).
  - `tissueAxesTx` = axes with the most tissue-shape tick labels (the per-tissue scatter).
HLAs + their Y positions come from `hlaAxesTx`; tissues + their X positions come from `tissueAxesTx`. Cell-value integer texts are pooled from both. This matches matplotlib's actual subplot architecture instead of assuming everything lives in one axes group.
**Files:** `index.html`.
**Commit:** (this commit).

### 2026-05-28 — Scifi heatmap rows reflect the full legend (predicted + observed HLAs)
**Why:** User reported peptides like NBL/`RYYSALRHY` rendered with 4 HLA chips in the legend but only 1 HLA row in the heatmap below. Cause: the matplotlib heatmap axes only contains HLA-rows that have actual MS *detection* data — the other 3 HLAs in the legend are predicted binders without data, so matplotlib doesn't draw rows for them. Visually inconsistent with the legend chip count.
**What:** `_ivExtractMplHeatmap` now collects HLAs from **both** sources: the heatmap axes (data-rows, with real Y positions) AND the legend group (single-allele or semicolon-joined). Legend-only HLAs are appended with `y: Infinity` so the matrix-cell snap-to-nearest-row logic never assigns data cells to them — they render as empty rows with the row label visible. Result: every HLA in the legend gets a row in the heatmap, even if it has no detection cells.
**Trade-off recorded:** the heatmap now visually includes "candidate" HLAs without data. A reader could interpret this as "tested but no detection" when it's actually "predicted binder, MS may or may not have tested it." If that becomes a documentation problem, swap empty rows for a faint "no data" pattern instead of plain empty.
**Files:** `index.html`.
**Commit:** (this commit).

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
