# ImmunoVerse portal — Deno auth proxy

A locked-down reverse proxy for the portal auth API, deployed to **Deno Deploy**.
It is the **4th-tier fallback** in the frontend's `IV_AUTH_BASES` chain:

```
1. https://auth-service-739605637035.us-central1.run.app   (Cloud Run, primary)
2. https://auth.immuno-verse.com                            (optional same-site host)
3. https://auth.immunoverse-chat.com                        (legacy)
4. https://immunoverse-auth.amans44.deno.net                (THIS proxy)
```

It exists because some networks (e.g. NYU's Palo Alto firewall) DNS-sinkhole
`immunoverse-chat.com`, while `deno.net`/`deno.dev` stays reachable. The proxy
forwards to the auth service's stable Cloud Run URL, so login keeps working even
if every custom domain is blocked.

It is **not** an open proxy: fixed `UPSTREAM`, fixed `/api/portal/` path prefix,
CORS only for the portal's own origins. (Contrast the image proxy, which takes
`?url=` and whose source unfortunately lives only in a dashboard.)

## Deploy (one-time) — Deno Deploy **Playground**

This org (`amans44`) deploys via Playgrounds (same as the existing
`immunoverse-proxy`), so apps live at `<name>.amans44.deno.net`.

1. Deno Deploy dashboard → **New Playground**.
2. Delete the starter code, paste the entire contents of `main.ts`.
3. **Rename** the playground/project to **`immunoverse-auth`** (so the URL is
   `https://immunoverse-auth.amans44.deno.net`, which the frontend expects).
4. Playgrounds deploy on save — done.

## After deploying — verify
```bash
curl https://immunoverse-auth.amans44.deno.net/healthz                 # -> ok
curl -s -o /dev/null -w "%{http_code}\n" \
     https://immunoverse-auth.amans44.deno.net/api/portal/auth/me       # -> 401 (reachable + wired)
```

## If your deployed URL differs
The frontend hardcodes `https://immunoverse-auth.amans44.deno.net` in
`IV_AUTH_BASES` (in `index.html`, `login.html`, `account.html`, `admin.html`,
`reset.html`). If your playground keeps a different name/host, update that one
string in those files and re-run `sync_reviewers.py`.

## Changing the upstream
If the Cloud Run service URL ever changes, edit `UPSTREAM` at the top of
`main.ts` and redeploy. Keep this file as the source of truth.
