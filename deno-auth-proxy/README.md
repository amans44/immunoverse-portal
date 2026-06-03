# ImmunoVerse portal — Deno auth proxy

A locked-down reverse proxy for the portal auth API, deployed to **Deno Deploy**.
It is the **4th-tier fallback** in the frontend's `IV_AUTH_BASES` chain:

```
1. https://auth-service-739605637035.us-central1.run.app   (Cloud Run, primary)
2. https://auth.immuno-verse.com                            (optional same-site host)
3. https://auth.immunoverse-chat.com                        (legacy)
4. https://immunoverse-auth.deno.dev                        (THIS proxy)
```

It exists because some networks (e.g. NYU's Palo Alto firewall) DNS-sinkhole
`immunoverse-chat.com`, while `deno.net`/`deno.dev` stays reachable. The proxy
forwards to the auth service's stable Cloud Run URL, so login keeps working even
if every custom domain is blocked.

It is **not** an open proxy: fixed `UPSTREAM`, fixed `/api/portal/` path prefix,
CORS only for the portal's own origins. (Contrast the image proxy, which takes
`?url=` and whose source unfortunately lives only in a dashboard.)

## Deploy (one-time)

**Option A — `deployctl` (CLI):**
```bash
# install once: deno install -gArf jsr:@deno/deployctl
deployctl deploy --project=immunoverse-auth --prod main.ts
```
Name the project **`immunoverse-auth`** so the URL matches what the frontend
expects: `https://immunoverse-auth.deno.dev`.

**Option B — dashboard:** https://dash.deno.com → New Project → name it
`immunoverse-auth` → paste `main.ts` (or link this repo path) → Deploy.

## After deploying — verify
```bash
curl -s -o /dev/null -w "%{http_code}\n" https://immunoverse-auth.deno.dev/healthz   # 200
curl -s -o /dev/null -w "%{http_code}\n" https://immunoverse-auth.deno.dev/api/portal/auth/me   # 401 = reachable+wired
```

## If your deployed URL differs
The frontend hardcodes `https://immunoverse-auth.deno.dev` in `IV_AUTH_BASES`
(in `index.html`, `login.html`, `account.html`, `admin.html`, `reset.html`). If
your Deno project resolves to a different host (e.g. `…​.deno.net`), update that
one string in those files (and re-run `sync_reviewers.py`).

## Changing the upstream
If the Cloud Run service URL ever changes, edit `UPSTREAM` at the top of
`main.ts` and redeploy. Keep this file as the source of truth.
