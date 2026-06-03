// ImmunoVerse portal — auth reverse proxy (Deno Deploy)
// =============================================================================
// 4th-tier fallback in the portal's auth endpoint chain (IV_AUTH_BASES). The
// chain is: Cloud Run run.app URL → auth.immuno-verse.com → auth.immunoverse-
// chat.com → THIS proxy. It only ever gets hit if all three of those are
// unreachable (essentially never), but deno.net is reachable on networks that
// DNS-sinkhole immunoverse-chat.com (e.g. NYU's Palo Alto firewall), so it's a
// guaranteed-reachable backstop.
//
// SECURITY — unlike the open image proxy (which takes ?url=), this proxy has a
// FIXED upstream and a FIXED path prefix, and only sets CORS for the portal's
// own origins. It cannot be used to reach anything other than the portal auth
// API, so it is not an open relay.
//
// Auth carries over the proxy via the Authorization: Bearer header (and the
// /refresh body token) — both host-agnostic — so cookie rewriting is not
// required for the proxy to authenticate. Set-Cookie is still passed through
// best-effort (portal cookies are host-only, so the browser binds them to the
// proxy host).
//
// Deploy: see README.md in this folder. Source is version-controlled HERE (do
// not let it drift into the Deno dashboard only).
// =============================================================================

// The auth service's own Cloud Run URL (stable; not blocked by NYU).
const UPSTREAM = "https://auth-service-739605637035.us-central1.run.app";

// Browser origins allowed to use this proxy (credentialed CORS → must echo an
// explicit origin, never "*").
const ALLOWED_ORIGINS = new Set<string>([
  "https://immuno-verse.com",
  "https://www.immuno-verse.com",
]);

// Only the portal auth API surface may be proxied.
const ALLOWED_PREFIX = "/api/portal/";

function corsHeaders(origin: string | null): Record<string, string> {
  const allow = origin && ALLOWED_ORIGINS.has(origin) ? origin : "https://immuno-verse.com";
  return {
    "Access-Control-Allow-Origin": allow,
    "Access-Control-Allow-Credentials": "true",
    "Access-Control-Allow-Methods": "GET,POST,PATCH,DELETE,OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Max-Age": "86400",
    "Vary": "Origin",
  };
}

Deno.serve(async (req: Request): Promise<Response> => {
  const origin = req.headers.get("Origin");
  const cors = corsHeaders(origin);
  const url = new URL(req.url);

  // CORS preflight.
  if (req.method === "OPTIONS") {
    return new Response(null, { status: 204, headers: cors });
  }

  // Lightweight health check for the chain probe / manual testing.
  if (url.pathname === "/" || url.pathname === "/healthz") {
    return new Response("ok", { status: 200, headers: { ...cors, "Content-Type": "text/plain" } });
  }

  // Refuse anything outside the portal auth API.
  if (!url.pathname.startsWith(ALLOWED_PREFIX)) {
    return new Response(JSON.stringify({ detail: "not found" }), {
      status: 404,
      headers: { ...cors, "Content-Type": "application/json" },
    });
  }

  // Build the upstream request: copy method, body, and the host-agnostic auth
  // headers. We deliberately do NOT forward the browser Origin (CORS is enforced
  // by this proxy, not upstream).
  const fwd = new Headers();
  const auth = req.headers.get("Authorization");
  if (auth) fwd.set("Authorization", auth);
  const ct = req.headers.get("Content-Type");
  if (ct) fwd.set("Content-Type", ct);
  const cookie = req.headers.get("Cookie");
  if (cookie) fwd.set("Cookie", cookie);

  const hasBody = req.method !== "GET" && req.method !== "HEAD";
  const body = hasBody ? await req.arrayBuffer() : undefined;

  let upstream: Response;
  try {
    upstream = await fetch(UPSTREAM + url.pathname + url.search, {
      method: req.method,
      headers: fwd,
      body,
      redirect: "manual",
    });
  } catch (_e) {
    return new Response(JSON.stringify({ detail: "auth upstream unreachable" }), {
      status: 502,
      headers: { ...cors, "Content-Type": "application/json" },
    });
  }

  // Relay the upstream response + our CORS headers. Pass Set-Cookie through
  // (multiple cookies → getSetCookie()).
  const headers = new Headers(cors);
  const respCt = upstream.headers.get("Content-Type");
  if (respCt) headers.set("Content-Type", respCt);
  const setCookies = upstream.headers.getSetCookie?.() ?? [];
  for (const sc of setCookies) headers.append("Set-Cookie", sc);

  const out = await upstream.arrayBuffer();
  return new Response(out, { status: upstream.status, headers });
});
