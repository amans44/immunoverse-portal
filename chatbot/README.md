# ImmunoVerse Portal Chatbot

A small floating chat widget for the ImmunoVerse portal. It sits in the
bottom-right corner of every page and helps visitors navigate the atlas, find
data, and answer questions about the project.

The widget is a stripped-down adaptation of the full chat UI in
`immunoVerse_agent/web/` (which was **not** modified). It talks to the same
FastAPI `/chat` endpoint exposed by `immunoVerse_agent/api_server.py`.

## Files

- `chatbot.js` — self-contained widget. Injects all CSS + HTML at load time.
  Dependencies are loaded lazily from CDN (`marked` for markdown).

That's it — no build step, no framework.

## Wiring

A single `<script src="chatbot/chatbot.js" defer></script>` tag is added at
the bottom of `index.html`. Nothing else in the portal was changed.

## Pointing at the agent backend

The widget POSTs to `/chat`. By default it uses the **same origin** as the
portal, which only works if you serve the agent on the same host.

To point at a different host (typical for a deployed portal), add this line
in `index.html` **before** the chatbot script tag:

```html
<script>window.IMMUNOVERSE_AGENT_BASE = "https://your-agent-host.example.com";</script>
<script src="chatbot/chatbot.js" defer></script>
```

You'll also need the agent's FastAPI server to allow the portal's origin in
its CORS config (`CORS_ORIGINS` env var or equivalent in `api_server.py`).

## Local development

1. Start the agent backend:
   ```
   cd immunoVerse_agent
   python api_server.py
   ```
2. Serve the portal (any static server works):
   ```
   cd immuno-verse-portal/immuno-verse-portal
   python -m http.server 8080
   ```
3. In `index.html`, set the agent base URL right before the chatbot script:
   ```html
   <script>window.IMMUNOVERSE_AGENT_BASE = "http://localhost:8000";</script>
   ```
4. Open `http://localhost:8080` and click the chat bubble.

## What it does NOT do

The portal chatbot is intentionally minimal. It does **not** include:

- File uploads (TSV/CSV/PDB)
- PDB 3D viewer
- Tool result tables / CSV download
- Session sidebar / persistent history
- Trace drawer

If a user needs any of that, point them at the full chat app
(`immunoVerse_agent/web/index.html`).
