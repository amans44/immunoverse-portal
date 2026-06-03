// ImmunoVerse portal — auth reverse proxy (Deno Deploy)
// =============================================================================
// 4th-tier fallback in the portal's auth endpoint chain (IV_AUTH_BASES):
//   Cloud Run run.app  ->  auth.immuno-verse.com  ->  auth.immunoverse-chat.com
//   ->  THIS proxy (immunoverse-auth.amans44.deno.net)
// Only hit if all three above are unreachable (essentially never), but deno.net
// stays reachable on networks that DNS-sinkhole immunoverse-chat.com (NYU).
//
// SECURITY: fixed UPSTREAM + fixed /api/portal/ prefix + portal-only CORS, so it
// is NOT an open relay. Auth carries via the Authorization: Bearer header (and
// the /refresh body token), so no cookie rewriting is needed.
//
// NOTE: keep every line short — this file is meant to be pasted into a Deno
// Deploy Playground, and long lines can get broken on paste.
// =============================================================================

const UPSTREAM =
  "https://auth-service-739605637035.us-central1.run.app";

const ALLOWED_ORIGINS = new Set([
  "https://immuno-verse.com",
  "https://www.immuno-verse.com",
]);

const ALLOWED_PREFIX = "/api/portal/";

function corsHeaders(origin) {
  const ok = origin && ALLOWED_ORIGINS.has(origin);
  const allow = ok ? origin : "https://immuno-verse.com";
  return {
    "Access-Control-Allow-Origin": allow,
    "Access-Control-Allow-Credentials": "true",
    "Access-Control-Allow-Methods": "GET,POST,PATCH,DELETE,OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Max-Age": "86400",
    "Vary": "Origin",
  };
}

function json(obj, status, cors) {
  const headers = { ...cors, "Content-Type": "application/json" };
  return new Response(JSON.stringify(obj), { status, headers });
}

Deno.serve(async (req) => {
  const origin = req.headers.get("Origin");
  const cors = corsHeaders(origin);
  const url = new URL(req.url);

  if (req.method === "OPTIONS") {
    return new Response(null, { status: 204, headers: cors });
  }

  if (url.pathname === "/" || url.pathname === "/healthz") {
    const headers = { ...cors, "Content-Type": "text/plain" };
    return new Response("ok", { status: 200, headers });
  }

  if (!url.pathname.startsWith(ALLOWED_PREFIX)) {
    return json({ detail: "not found" }, 404, cors);
  }

  const fwd = new Headers();
  const auth = req.headers.get("Authorization");
  if (auth) fwd.set("Authorization", auth);
  const ct = req.headers.get("Content-Type");
  if (ct) fwd.set("Content-Type", ct);
  const cookie = req.headers.get("Cookie");
  if (cookie) fwd.set("Cookie", cookie);

  const hasBody = req.method !== "GET" && req.method !== "HEAD";
  const body = hasBody ? await req.arrayBuffer() : undefined;

  let upstream;
  try {
    upstream = await fetch(UPSTREAM + url.pathname + url.search, {
      method: req.method,
      headers: fwd,
      body,
      redirect: "manual",
    });
  } catch (_e) {
    return json({ detail: "auth upstream unreachable" }, 502, cors);
  }

  const headers = new Headers(cors);
  const respCt = upstream.headers.get("Content-Type");
  if (respCt) headers.set("Content-Type", respCt);
  const setCookies = upstream.headers.getSetCookie?.() ?? [];
  for (const sc of setCookies) headers.append("Set-Cookie", sc);

  const out = await upstream.arrayBuffer();
  return new Response(out, { status: upstream.status, headers });
});
