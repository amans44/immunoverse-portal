/* =============================================================================
 * ImmunoVerse Portal Chatbot Widget
 * -----------------------------------------------------------------------------
 * Self-contained floating chat widget for the ImmunoVerse portal.
 *
 * Adapted from immunoVerse_agent/web/app.js (the full chat UI). This is a
 * stripped-down "guide me through the site" chatbot — no file uploads, no
 * tool tables, no PDB viewer, no session sidebar. Just a small bubble in the
 * bottom-right corner that talks to the same /chat endpoint.
 *
 * Configure AGENT_API_BASE below to point at your running ImmunoVerse agent
 * backend (the FastAPI server in immunoVerse_agent/api_server.py). Leave it
 * empty if the portal and agent are served from the same origin.
 * ===========================================================================*/

(function () {
  "use strict";

  // ---------------------------------------------------------------------------
  // CONFIG — set this to your agent backend URL (FastAPI /chat endpoint host).
  // Examples:
  //   ""                                // same origin
  //   "http://localhost:8000"            // local dev
  //   "https://immunoverse-agent.example.com"
  // The window.IMMUNOVERSE_AGENT_BASE override (set before this script loads)
  // takes precedence so you can swap envs without editing this file.
  // ---------------------------------------------------------------------------
  const AGENT_API_BASE =
    (typeof window !== "undefined" && window.IMMUNOVERSE_AGENT_BASE) ||
    "";

  // System prompt that teaches the model about the portal layout so it can
  // guide users to the right section. This is appended to the agent's own
  // rules (include_agent_rules: true) — it does not replace them.
  const PORTAL_SYSTEM_PROMPT = [
    "You are the ImmunoVerse Portal guide — a small chatbot embedded in the",
    "bottom-right of the ImmunoVerse Atlas website (https://immunoverse).",
    "Your job is to help visitors navigate the site, understand what",
    "ImmunoVerse contains, and answer questions about the atlas.",
    "",
    "Site sections (anchor links the user can click):",
    "  • #atlas      — Pan-cancer overview of therapeutic T cell targets",
    "  • #explorer   — Search, filter, and rank the full atlas",
    "  • #cancers    — 21 cancer types · 340,000+ ranked candidate targets",
    "  • #highlights — Hero targets uncovered by ImmunoVerse",
    "  • #classes    — 11 molecular sources of tumor-specific antigens",
    "  • #methods    — How ImmunoVerse was built",
    "  • #downloads  — Download the full atlas (data files)",
    "  • #cite       — How to cite ImmunoVerse",
    "",
    "Headline numbers: 16,687 empirically detected HLA-presented antigens,",
    "21 cancer types, 11 antigen classes, 88% of analyzed tumors covered,",
    "1,823 immunopeptidomes, 7,188 RNA-Seq, 17,384 normal controls,",
    "594 single-cell datasets.",
    "",
    "When a user asks where to find something, point them to the right section",
    "with a markdown link like [Explorer](#explorer). Keep replies short",
    "(2–5 sentences) — this is a small popup, not a full chat. For deep",
    "scientific questions about peptides / HLA / genes, you may use your tools",
    "as you normally would.",
  ].join("\n");

  // Suggestion chips shown on first open.
  const STARTER_SUGGESTIONS = [
    "What is ImmunoVerse?",
    "How do I search for a target?",
    "Show me the cancer list",
    "How do I cite this work?",
  ];

  // ---------------------------------------------------------------------------
  // STATE
  // ---------------------------------------------------------------------------
  let chatHistory = [];
  let currentAbort = null;
  let isOpen = false;
  let didSeedSystem = false;

  // ---------------------------------------------------------------------------
  // STYLES — injected once on init.
  // ---------------------------------------------------------------------------
  const STYLE = `
  .ivp-chatbot, .ivp-chatbot * { box-sizing: border-box; }

  .ivp-chatbot-fab {
    position: fixed;
    right: 20px;
    bottom: 20px;
    width: 56px;
    height: 56px;
    border-radius: 50%;
    border: none;
    cursor: pointer;
    z-index: 9998;
    background: linear-gradient(135deg, #22d3ee 0%, #818cf8 50%, #c084fc 100%);
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 10px 30px rgba(34,211,238,0.35),
                0 4px 12px rgba(0,0,0,0.25);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }
  .ivp-chatbot-fab:hover {
    transform: translateY(-2px) scale(1.04);
    box-shadow: 0 14px 36px rgba(34,211,238,0.45),
                0 6px 16px rgba(0,0,0,0.3);
  }
  .ivp-chatbot-fab svg { width: 26px; height: 26px; }
  .ivp-chatbot-fab .ivp-fab-close { display: none; }
  .ivp-chatbot-fab.open .ivp-fab-open { display: none; }
  .ivp-chatbot-fab.open .ivp-fab-close { display: block; }

  .ivp-chatbot-panel {
    position: fixed;
    right: 20px;
    bottom: 88px;
    width: 380px;
    max-width: calc(100vw - 32px);
    height: 560px;
    max-height: calc(100vh - 120px);
    background: #0f1424;
    color: #f2f5ff;
    border: 1px solid rgba(120,150,220,0.22);
    border-radius: 16px;
    box-shadow: 0 24px 64px rgba(0,0,0,0.55), 0 4px 12px rgba(0,0,0,0.35);
    z-index: 9999;
    display: none;
    flex-direction: column;
    overflow: hidden;
    font-family: 'Inter', system-ui, -apple-system, sans-serif;
    font-size: 14px;
    line-height: 1.5;
    transform-origin: bottom right;
    animation: ivp-pop 0.18s ease-out;
  }
  .ivp-chatbot-panel.open { display: flex; }

  /* Light-theme override — match the portal's [data-theme="light"] toggle. */
  html[data-theme="light"] .ivp-chatbot-panel {
    background: #ffffff;
    color: #0b1220;
    border-color: rgba(60,80,140,0.18);
    box-shadow: 0 24px 64px rgba(15,23,42,0.18), 0 4px 12px rgba(15,23,42,0.10);
  }

  @keyframes ivp-pop {
    from { opacity: 0; transform: translateY(8px) scale(0.98); }
    to   { opacity: 1; transform: translateY(0) scale(1); }
  }

  .ivp-chatbot-header {
    padding: 12px 14px;
    background: linear-gradient(135deg, rgba(34,211,238,0.15), rgba(192,132,252,0.15));
    border-bottom: 1px solid rgba(120,150,220,0.18);
    display: flex;
    align-items: center;
    gap: 10px;
    flex-shrink: 0;
  }
  html[data-theme="light"] .ivp-chatbot-header {
    background: linear-gradient(135deg, rgba(8,145,178,0.10), rgba(147,51,234,0.10));
    border-bottom-color: rgba(60,80,140,0.14);
  }
  .ivp-chatbot-avatar {
    width: 32px; height: 32px;
    border-radius: 50%;
    background: linear-gradient(135deg, #22d3ee, #c084fc);
    display: flex; align-items: center; justify-content: center;
    color: #fff;
    flex-shrink: 0;
  }
  .ivp-chatbot-avatar svg { width: 18px; height: 18px; }
  .ivp-chatbot-titles { flex: 1; min-width: 0; }
  .ivp-chatbot-title {
    font-size: 14px;
    font-weight: 600;
    margin: 0;
    letter-spacing: -0.01em;
  }
  .ivp-chatbot-subtitle {
    font-size: 11px;
    opacity: 0.7;
    margin: 0;
    letter-spacing: 0.02em;
  }
  .ivp-chatbot-iconbtn {
    width: 28px; height: 28px;
    background: transparent;
    border: none;
    color: inherit;
    opacity: 0.6;
    cursor: pointer;
    border-radius: 6px;
    display: flex; align-items: center; justify-content: center;
    transition: opacity 0.15s, background 0.15s;
  }
  .ivp-chatbot-iconbtn:hover { opacity: 1; background: rgba(255,255,255,0.06); }
  html[data-theme="light"] .ivp-chatbot-iconbtn:hover { background: rgba(0,0,0,0.05); }
  .ivp-chatbot-iconbtn svg { width: 16px; height: 16px; }

  .ivp-chatbot-body {
    flex: 1;
    overflow-y: auto;
    padding: 14px;
    display: flex;
    flex-direction: column;
    gap: 12px;
  }
  .ivp-chatbot-body::-webkit-scrollbar { width: 6px; }
  .ivp-chatbot-body::-webkit-scrollbar-thumb {
    background: rgba(120,150,220,0.25);
    border-radius: 8px;
  }

  .ivp-msg { display: flex; gap: 8px; align-items: flex-start; }
  .ivp-msg-avatar {
    width: 26px; height: 26px;
    border-radius: 50%;
    flex-shrink: 0;
    display: flex; align-items: center; justify-content: center;
    font-size: 12px;
    font-weight: 600;
  }
  .ivp-msg.user .ivp-msg-avatar {
    background: rgba(120,150,220,0.18);
    color: inherit;
  }
  .ivp-msg.assistant .ivp-msg-avatar {
    background: linear-gradient(135deg, #22d3ee, #c084fc);
    color: #fff;
  }
  .ivp-msg-bubble {
    flex: 1;
    background: rgba(120,150,220,0.08);
    border: 1px solid rgba(120,150,220,0.12);
    border-radius: 12px;
    padding: 8px 12px;
    font-size: 13.5px;
    line-height: 1.55;
    word-wrap: break-word;
    overflow-wrap: anywhere;
  }
  html[data-theme="light"] .ivp-msg-bubble {
    background: rgba(60,80,140,0.06);
    border-color: rgba(60,80,140,0.12);
  }
  .ivp-msg.user .ivp-msg-bubble {
    background: linear-gradient(135deg, rgba(34,211,238,0.18), rgba(192,132,252,0.18));
    border-color: rgba(34,211,238,0.30);
  }
  .ivp-msg-bubble p { margin: 0 0 6px; }
  .ivp-msg-bubble p:last-child { margin-bottom: 0; }
  .ivp-msg-bubble a { color: #22d3ee; text-decoration: none; }
  .ivp-msg-bubble a:hover { text-decoration: underline; }
  html[data-theme="light"] .ivp-msg-bubble a { color: #0369a1; }
  .ivp-msg-bubble code {
    background: rgba(120,150,220,0.16);
    padding: 1px 5px;
    border-radius: 4px;
    font-family: 'JetBrains Mono', ui-monospace, monospace;
    font-size: 12px;
  }
  .ivp-msg-bubble pre {
    background: rgba(0,0,0,0.30);
    padding: 8px 10px;
    border-radius: 8px;
    overflow-x: auto;
    font-size: 12px;
    margin: 6px 0;
  }
  .ivp-msg-bubble ul, .ivp-msg-bubble ol { margin: 4px 0; padding-left: 20px; }
  .ivp-msg-bubble li { margin: 2px 0; }
  .ivp-msg-bubble table {
    border-collapse: collapse;
    margin: 6px 0;
    font-size: 12px;
    width: 100%;
  }
  .ivp-msg-bubble th, .ivp-msg-bubble td {
    border: 1px solid rgba(120,150,220,0.20);
    padding: 4px 8px;
    text-align: left;
  }

  .ivp-thinking { display: inline-flex; gap: 4px; align-items: center; }
  .ivp-thinking span {
    width: 6px; height: 6px; border-radius: 50%;
    background: currentColor;
    opacity: 0.4;
    animation: ivp-bounce 1.2s infinite ease-in-out;
  }
  .ivp-thinking span:nth-child(2) { animation-delay: 0.15s; }
  .ivp-thinking span:nth-child(3) { animation-delay: 0.30s; }
  @keyframes ivp-bounce {
    0%, 80%, 100% { transform: scale(0.6); opacity: 0.4; }
    40%           { transform: scale(1.0); opacity: 1.0; }
  }

  .ivp-suggestions {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
    padding: 0 14px 10px;
    flex-shrink: 0;
  }
  .ivp-suggestion-chip {
    background: rgba(120,150,220,0.10);
    border: 1px solid rgba(120,150,220,0.22);
    border-radius: 18px;
    padding: 5px 12px;
    font-size: 12px;
    color: inherit;
    cursor: pointer;
    transition: all 0.15s;
    font-family: inherit;
  }
  .ivp-suggestion-chip:hover {
    background: linear-gradient(135deg, rgba(34,211,238,0.20), rgba(192,132,252,0.20));
    border-color: rgba(34,211,238,0.40);
  }

  .ivp-chatbot-input {
    padding: 10px 12px;
    border-top: 1px solid rgba(120,150,220,0.18);
    flex-shrink: 0;
    display: flex;
    align-items: flex-end;
    gap: 8px;
    background: rgba(15,20,36,0.6);
  }
  html[data-theme="light"] .ivp-chatbot-input {
    border-top-color: rgba(60,80,140,0.14);
    background: rgba(240,243,250,0.6);
  }
  .ivp-chatbot-textarea {
    flex: 1;
    background: rgba(120,150,220,0.08);
    border: 1px solid rgba(120,150,220,0.20);
    border-radius: 10px;
    color: inherit;
    padding: 8px 10px;
    font-family: inherit;
    font-size: 13.5px;
    resize: none;
    outline: none;
    min-height: 36px;
    max-height: 120px;
    line-height: 1.4;
    transition: border-color 0.15s;
  }
  html[data-theme="light"] .ivp-chatbot-textarea {
    background: rgba(60,80,140,0.06);
    border-color: rgba(60,80,140,0.20);
  }
  .ivp-chatbot-textarea:focus { border-color: #22d3ee; }
  .ivp-chatbot-textarea::placeholder { opacity: 0.5; }
  .ivp-chatbot-send {
    width: 36px; height: 36px;
    border-radius: 10px;
    border: none;
    cursor: pointer;
    background: linear-gradient(135deg, #22d3ee, #818cf8);
    color: #fff;
    display: flex; align-items: center; justify-content: center;
    transition: transform 0.15s, opacity 0.15s;
    flex-shrink: 0;
  }
  .ivp-chatbot-send:hover { transform: translateY(-1px); }
  .ivp-chatbot-send:disabled { opacity: 0.5; cursor: not-allowed; }
  .ivp-chatbot-send svg { width: 16px; height: 16px; }

  .ivp-chatbot-footer {
    padding: 4px 12px 8px;
    text-align: center;
    font-size: 10px;
    opacity: 0.5;
    flex-shrink: 0;
  }

  @media (max-width: 480px) {
    .ivp-chatbot-panel {
      right: 8px; left: 8px;
      bottom: 80px;
      width: auto;
      height: 70vh;
    }
    .ivp-chatbot-fab { right: 16px; bottom: 16px; width: 52px; height: 52px; }
  }
  `;

  // ---------------------------------------------------------------------------
  // HTML — built once on init.
  // ---------------------------------------------------------------------------
  const HTML = `
  <button class="ivp-chatbot-fab" id="ivp-fab" aria-label="Open ImmunoVerse chatbot">
    <svg class="ivp-fab-open" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
    </svg>
    <svg class="ivp-fab-close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round">
      <path d="M18 6L6 18M6 6l12 12"/>
    </svg>
  </button>

  <div class="ivp-chatbot-panel" id="ivp-panel" role="dialog" aria-label="ImmunoVerse chatbot">
    <div class="ivp-chatbot-header">
      <div class="ivp-chatbot-avatar">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M13 2L3 14h7l-1 8 10-12h-7l1-8z"/>
        </svg>
      </div>
      <div class="ivp-chatbot-titles">
        <h3 class="ivp-chatbot-title">ImmunoVerse Guide</h3>
        <p class="ivp-chatbot-subtitle">Ask me about the atlas</p>
      </div>
      <button class="ivp-chatbot-iconbtn" id="ivp-reset" title="Reset conversation" aria-label="Reset">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="1 4 1 10 7 10"/>
          <path d="M3.51 15a9 9 0 1 0 2.13-9.36L1 10"/>
        </svg>
      </button>
      <button class="ivp-chatbot-iconbtn" id="ivp-close" title="Close" aria-label="Close">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M18 6L6 18M6 6l12 12"/>
        </svg>
      </button>
    </div>
    <div class="ivp-chatbot-body" id="ivp-body"></div>
    <div class="ivp-suggestions" id="ivp-suggestions"></div>
    <div class="ivp-chatbot-input">
      <textarea class="ivp-chatbot-textarea" id="ivp-input"
                placeholder="Ask about the atlas, cancers, methods..."
                rows="1" aria-label="Message"></textarea>
      <button class="ivp-chatbot-send" id="ivp-send" aria-label="Send">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="22" y1="2" x2="11" y2="13"/>
          <polygon points="22 2 15 22 11 13 2 9 22 2"/>
        </svg>
      </button>
    </div>
    <div class="ivp-chatbot-footer">Powered by ImmunoVerse Agent</div>
  </div>
  `;

  // ---------------------------------------------------------------------------
  // MARKDOWN — load marked from CDN once. Falls back to plain text if blocked.
  // ---------------------------------------------------------------------------
  function loadMarked() {
    return new Promise((resolve) => {
      if (window.marked) return resolve(window.marked);
      const s = document.createElement("script");
      s.src = "https://cdn.jsdelivr.net/npm/marked/marked.min.js";
      s.onload = () => resolve(window.marked);
      s.onerror = () => resolve(null);
      document.head.appendChild(s);
    });
  }

  function renderMarkdown(text) {
    if (window.marked && typeof window.marked.parse === "function") {
      try { return window.marked.parse(text || ""); } catch (e) { /* fall through */ }
    }
    // Minimal escape + paragraphs.
    const esc = String(text || "")
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;");
    return esc.split(/\n\n+/).map((p) => `<p>${p.replace(/\n/g, "<br>")}</p>`).join("");
  }

  // ---------------------------------------------------------------------------
  // RENDER HELPERS
  // ---------------------------------------------------------------------------
  function el(tag, attrs, ...children) {
    const node = document.createElement(tag);
    if (attrs) {
      for (const k in attrs) {
        if (k === "class") node.className = attrs[k];
        else if (k === "html") node.innerHTML = attrs[k];
        else node.setAttribute(k, attrs[k]);
      }
    }
    children.forEach((c) => {
      if (c == null) return;
      if (typeof c === "string") node.appendChild(document.createTextNode(c));
      else node.appendChild(c);
    });
    return node;
  }

  function appendBubble(role, text) {
    const body = document.getElementById("ivp-body");
    if (!body) return null;

    const wrap = el("div", { class: `ivp-msg ${role}` });
    const avatar = el("div", { class: "ivp-msg-avatar" });
    avatar.textContent = role === "user" ? "You" : "AI";
    const bubble = el("div", { class: "ivp-msg-bubble" });
    bubble.innerHTML = role === "assistant" ? renderMarkdown(text) : escapeHtml(text);

    wrap.appendChild(avatar);
    wrap.appendChild(bubble);
    body.appendChild(wrap);
    body.scrollTop = body.scrollHeight;
    return wrap;
  }

  function appendThinking() {
    const body = document.getElementById("ivp-body");
    if (!body) return null;
    const wrap = el("div", { class: "ivp-msg assistant" });
    const avatar = el("div", { class: "ivp-msg-avatar" });
    avatar.textContent = "AI";
    const bubble = el("div", { class: "ivp-msg-bubble" });
    bubble.innerHTML = '<span class="ivp-thinking"><span></span><span></span><span></span></span>';
    wrap.appendChild(avatar);
    wrap.appendChild(bubble);
    body.appendChild(wrap);
    body.scrollTop = body.scrollHeight;
    return wrap;
  }

  function escapeHtml(s) {
    return String(s || "")
      .replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")
      .replace(/\n/g, "<br>");
  }

  function renderSuggestions() {
    const wrap = document.getElementById("ivp-suggestions");
    if (!wrap) return;
    wrap.innerHTML = "";
    STARTER_SUGGESTIONS.forEach((q) => {
      const chip = el("button", { class: "ivp-suggestion-chip" }, q);
      chip.addEventListener("click", () => {
        const input = document.getElementById("ivp-input");
        if (input) input.value = q;
        send();
      });
      wrap.appendChild(chip);
    });
  }

  function hideSuggestions() {
    const wrap = document.getElementById("ivp-suggestions");
    if (wrap) wrap.style.display = "none";
  }

  // ---------------------------------------------------------------------------
  // BACKEND CALL — same /chat contract as immunoVerse_agent/api_server.py.
  // ---------------------------------------------------------------------------
  async function sendChat(messages, signal) {
    const r = await fetch(`${AGENT_API_BASE}/chat`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        messages,
        include_agent_rules: true,
        enable_tools: true,
        max_tool_rounds: 6,
        max_tokens: 1024,
        temperature: 0.0,
        timeout: 60,
      }),
      signal,
    });
    const raw = await r.text();
    if (!r.ok) throw new Error(`HTTP ${r.status}: ${raw}`);
    const data = JSON.parse(raw);
    if (!data.ok) throw new Error(data.error || "Unknown error");
    return data;
  }

  // ---------------------------------------------------------------------------
  // SEND FLOW
  // ---------------------------------------------------------------------------
  async function send() {
    const input = document.getElementById("ivp-input");
    const sendBtn = document.getElementById("ivp-send");
    if (!input || !sendBtn) return;

    const text = (input.value || "").trim();
    if (!text) return;

    if (!didSeedSystem) {
      chatHistory.push({ role: "system", content: PORTAL_SYSTEM_PROMPT, tool_call_id: null, tool_calls: null });
      didSeedSystem = true;
    }

    input.value = "";
    input.style.height = "auto";
    hideSuggestions();
    appendBubble("user", text);
    chatHistory.push({ role: "user", content: text, tool_call_id: null, tool_calls: null });

    const thinking = appendThinking();
    sendBtn.disabled = true;
    currentAbort = new AbortController();

    try {
      const out = await sendChat(chatHistory, currentAbort.signal);
      if (out.updated_messages?.length) {
        chatHistory = out.updated_messages.map((m) => ({
          role: m.role,
          content: m.content,
          tool_call_id: m.tool_call_id || null,
          tool_calls: m.tool_calls || null,
        }));
      }
      if (thinking) thinking.remove();
      const assistantText = out.assistant_message?.content || "(no content)";
      appendBubble("assistant", assistantText);
    } catch (e) {
      if (thinking) thinking.remove();
      if (e.name === "AbortError") {
        appendBubble("assistant", "_Stopped._");
      } else {
        appendBubble(
          "assistant",
          `**I couldn't reach the agent backend.** ${escapeHtml(String(e.message || e))}\n\n` +
            `If you're a developer, set \`window.IMMUNOVERSE_AGENT_BASE\` to the URL ` +
            `of your running agent server before \`chatbot.js\` loads.`
        );
      }
    } finally {
      sendBtn.disabled = false;
      currentAbort = null;
    }
  }

  function reset() {
    chatHistory = [];
    didSeedSystem = false;
    const body = document.getElementById("ivp-body");
    if (body) body.innerHTML = "";
    const sugg = document.getElementById("ivp-suggestions");
    if (sugg) sugg.style.display = "flex";
    appendBubble(
      "assistant",
      "Hi — I'm the **ImmunoVerse guide**. Ask me where to find data, what the atlas covers, or how to cite the work. Try one of the chips below."
    );
  }

  // ---------------------------------------------------------------------------
  // INIT
  // ---------------------------------------------------------------------------
  function init() {
    if (document.getElementById("ivp-fab")) return; // idempotent

    // Inject styles
    const style = document.createElement("style");
    style.id = "ivp-chatbot-style";
    style.textContent = STYLE;
    document.head.appendChild(style);

    // Inject HTML
    const root = document.createElement("div");
    root.className = "ivp-chatbot";
    root.innerHTML = HTML;
    document.body.appendChild(root);

    const fab = document.getElementById("ivp-fab");
    const panel = document.getElementById("ivp-panel");
    const closeBtn = document.getElementById("ivp-close");
    const resetBtn = document.getElementById("ivp-reset");
    const sendBtn = document.getElementById("ivp-send");
    const input = document.getElementById("ivp-input");

    function open() {
      isOpen = true;
      panel.classList.add("open");
      fab.classList.add("open");
      if (chatHistory.length === 0) reset();
      setTimeout(() => input?.focus(), 50);
    }
    function close() {
      isOpen = false;
      panel.classList.remove("open");
      fab.classList.remove("open");
      if (currentAbort) currentAbort.abort();
    }

    fab.addEventListener("click", () => (isOpen ? close() : open()));
    closeBtn.addEventListener("click", close);
    resetBtn.addEventListener("click", reset);
    sendBtn.addEventListener("click", send);

    input.addEventListener("keydown", (ev) => {
      if (ev.key === "Enter" && !ev.shiftKey) {
        ev.preventDefault();
        send();
      }
    });
    input.addEventListener("input", () => {
      input.style.height = "auto";
      input.style.height = Math.min(input.scrollHeight, 120) + "px";
    });

    renderSuggestions();
    loadMarked(); // best-effort, async — first message will use plain fallback if not yet loaded
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
