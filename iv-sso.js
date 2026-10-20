/* Cross-product sign-in, Portal side (immuno-verse.com). Protocol and threat model live in the
   chat repo: auth/sso_codes.py. In short: no access or refresh token ever goes into a URL; a
   one-time code travels in the URL FRAGMENT, bound to a `state` the destination created and kept
   in its own sessionStorage, and is exchanged exactly once within 60 seconds. */
(function () {
  'use strict';
  var CHAT_START = 'https://auth.immunoverse-chat.com/sso/start';
  var CHAT_AUTHORIZE = 'https://auth.immunoverse-chat.com/sso/authorize';
  var CHAT_CALLBACK = 'https://auth.immunoverse-chat.com/sso/callback';
  var KEY = 'iv_portal_sso_state';

  //  Same host chain and per-session cache as login.html. The dev override is honoured ONLY for
  //  localhost, exactly as login.html does, so a crafted link cannot redirect credentials.
  var BASES = ['https://auth-service-739605637035.us-central1.run.app', 'https://auth.immuno-verse.com',
               'https://auth.immunoverse-chat.com', 'https://immunoverse-auth.amans44.deno.net'];
  try {
    var dev = localStorage.getItem('iv_dev_authbase');
    if (dev && /^https?:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/.test(dev)) BASES = [dev];
  } catch (e) {}
  var cached = null;
  try { cached = sessionStorage.getItem('iv_auth_base'); } catch (e) {}
  if (cached && BASES.indexOf(cached) === -1) cached = null;

  async function authFetch(path, opts) {
    var order = cached ? [cached].concat(BASES.filter(function (b) { return b !== cached; })) : BASES.slice();
    var last;
    for (var i = 0; i < order.length; i++) {
      try {
        var r = await fetch(order[i] + path, opts);
        cached = order[i];
        try { sessionStorage.setItem('iv_auth_base', order[i]); } catch (e) {}
        return r;
      } catch (e) { last = e; }
    }
    throw last || new Error('auth endpoints unreachable');
  }
  function bearer() {
    var t = null; try { t = localStorage.getItem('iv_portal_access'); } catch (e) {}
    return t ? { Authorization: 'Bearer ' + t } : {};
  }
  function store(d) {
    try {
      if (d && d.access_token) localStorage.setItem('iv_portal_access', d.access_token);
      if (d && d.refresh_token) localStorage.setItem('iv_portal_refresh', d.refresh_token);
    } catch (e) {}
  }
  async function signedIn() {
    var r = await authFetch('/api/portal/auth/me', { credentials: 'include', headers: bearer() });
    if (r.ok) return true;
    var stored = null; try { stored = localStorage.getItem('iv_portal_refresh'); } catch (e) {}
    var rf = await authFetch('/api/portal/auth/refresh', { method: 'POST', credentials: 'include',
      headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(stored ? { refresh_token: stored } : {}) });
    if (!rf.ok) return false;
    store(await rf.json().catch(function () { return {}; }));
    return true;
  }
  function newState() {
    var b = new Uint8Array(24); crypto.getRandomValues(b);
    return btoa(String.fromCharCode.apply(null, b)).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
  }
  function say(msg, bad) {
    var el = document.getElementById('sso-msg');
    if (el) { el.textContent = msg; el.style.color = bad ? '#b00020' : ''; }
  }

  // ---- sso.html?client=chat&state=…: Chat asks "who is signed in on the Portal?" --------------
  window.ivPortalSsoForChat = async function () {
    var p = new URLSearchParams(location.search);
    var state = p.get('state') || '';
    if (p.get('client') !== 'chat' || !/^[A-Za-z0-9_-]{16,128}$/.test(state)) {
      say('This sign-in request is not valid.', true); return;
    }
    var ok = false;
    try { ok = await signedIn(); } catch (e) { say('Could not reach the sign-in service.', true); return; }
    if (!ok) {
      if (p.get('prompt') === 'none') { location.replace(CHAT_CALLBACK + '?error=not_signed_in'); return; }
      location.replace('login.html?return=' + encodeURIComponent('sso.html?' + p.toString()));
      return;
    }
    say('Continuing to ImmunoVerse Chat…');
    var r = await authFetch('/api/portal/auth/sso/chat-code', { method: 'POST', credentials: 'include',
      headers: Object.assign({ 'Content-Type': 'application/json' }, bearer()),
      body: JSON.stringify({ state: state, next: p.get('next') || null }) });
    var d = await r.json().catch(function () { return {}; });
    //  The server returns a FIXED callback on auth.immunoverse-chat.com; check it anyway.
    if (r.ok && d.redirect && d.redirect.indexOf(CHAT_CALLBACK + '#') === 0) { location.replace(d.redirect); return; }
    say(d.detail || 'Could not continue to ImmunoVerse Chat.', true);
  };

  // ---- login.html button: Portal asks Chat "who is signed in there?" ---------------------------
  window.ivPortalSsoFromChat = function () {
    var s = newState();
    try { sessionStorage.setItem(KEY, s); } catch (e) { say('This browser blocks session storage; sign in with your password instead.', true); return; }
    location.href = CHAT_AUTHORIZE + '?client=portal&state=' + encodeURIComponent(s);
  };

  // ---- sso-callback.html#code=…&state=…: finish Chat → Portal -------------------------------
  window.ivPortalSsoCallback = async function () {
    var h = new URLSearchParams(location.hash.replace(/^#/, ''));
    history.replaceState(null, '', location.pathname);
    var expected = null;
    try { expected = sessionStorage.getItem(KEY); sessionStorage.removeItem(KEY); } catch (e) {}
    var code = h.get('code'), state = h.get('state');
    if (!code || !state || !expected || state !== expected) {
      say('This sign-in link did not start in this browser, so it was ignored. Sign in again.', true);
      document.getElementById('sso-login').hidden = false; return;
    }
    say('Signing you in…');
    var r = await authFetch('/api/portal/auth/sso/exchange', { method: 'POST', credentials: 'include',
      headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ code: code, state: state }) });
    var d = await r.json().catch(function () { return {}; });
    if (!r.ok) { say(d.detail || 'Sign-in failed.', true); document.getElementById('sso-login').hidden = false; return; }
    store(d.tokens || {});
    location.replace('account.html');
  };

  window.ivChatStartUrl = CHAT_START;
})();
