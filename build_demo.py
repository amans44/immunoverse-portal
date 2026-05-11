"""Build demo/data_js and demo/data with NBL+SKCM+AML unlocked, others as locked teasers.

This script READ-ONLY consumes root data_js/ and data/, then writes demo/data_js/ and demo/data/.
The root portal is never modified.
"""
import json
import re
import shutil
from pathlib import Path

ROOT = Path(__file__).parent
SRC_DATA_JS = ROOT / "data_js"
SRC_DATA = ROOT / "data"
OUT_DATA_JS = ROOT / "demo" / "data_js"
OUT_DATA = ROOT / "demo" / "data"

UNLOCKED = {"NBL", "SKCM", "AML"}

OUT_DATA_JS.mkdir(parents=True, exist_ok=True)
OUT_DATA.mkdir(parents=True, exist_ok=True)

# --- 1. _summary.js : keep all 21 cancers, but mark 18 as locked ----------------
# Format on disk: window.__PD__=window.__PD__||{};window.__PD__["_summary"]={...};
src_summary = (SRC_DATA_JS / "_summary.js").read_text(encoding="utf-8")
m = re.search(r'window\.__PD__\["_summary"\]=(.*);?\s*$', src_summary, re.DOTALL)
if not m:
    raise SystemExit("could not parse _summary.js")
summary_blob = m.group(1).rstrip().rstrip(";")
summary = json.loads(summary_blob)
for c in summary["cancers"]:
    c["locked"] = c["code"] not in UNLOCKED
demo_summary_js = (
    'window.__PD__=window.__PD__||{};'
    f'window.__PD__["_summary"]={json.dumps(summary, separators=(",", ":"))};'
)
(OUT_DATA_JS / "_summary.js").write_text(demo_summary_js, encoding="utf-8")
print(f"wrote demo/data_js/_summary.js  ({len(summary['cancers'])} cancers, {sum(c['locked'] for c in summary['cancers'])} locked)")

# --- 2. Per-cancer .js + _detail.js : copy unlocked only ------------------------
copied = 0
for code in sorted(UNLOCKED):
    for suffix in ("", "_detail"):
        src = SRC_DATA_JS / f"{code}{suffix}.js"
        dst = OUT_DATA_JS / f"{code}{suffix}.js"
        if src.exists():
            shutil.copyfile(src, dst)
            copied += 1
print(f"copied {copied} per-cancer .js files into demo/data_js/")

# --- 3. _search_index.js : filter rows to unlocked cancers ----------------------
src_idx = (SRC_DATA_JS / "_search_index.js").read_text(encoding="utf-8")
m = re.search(r'window\.__IDX__=(.*);?\s*$', src_idx, re.DOTALL)
if not m:
    raise SystemExit("could not parse _search_index.js")
idx_blob = m.group(1).rstrip().rstrip(";")
idx = json.loads(idx_blob)
before = len(idx["rows"])
idx["rows"] = [r for r in idx["rows"] if r.get("ca") in UNLOCKED]
after = len(idx["rows"])
demo_idx_js = f'window.__IDX__={json.dumps(idx, separators=(",", ":"))};'
(OUT_DATA_JS / "_search_index.js").write_text(demo_idx_js, encoding="utf-8")
print(f"filtered _search_index.js : {before} rows -> {after} rows")

# --- 4. demo/data/*.json : copy unlocked JSONs for the download buttons ---------
copied = 0
for code in sorted(UNLOCKED):
    for suffix in ("", "_detail"):
        src = SRC_DATA / f"{code}{suffix}.json"
        dst = OUT_DATA / f"{code}{suffix}.json"
        if src.exists():
            shutil.copyfile(src, dst)
            copied += 1
# Also copy _summary.json and _search_index.json for download completeness
for fname in ("_summary.json", "_search_index.json"):
    src = SRC_DATA / fname
    if src.exists():
        shutil.copyfile(src, OUT_DATA / fname)
        copied += 1
print(f"copied {copied} JSON files into demo/data/")

# --- 5. Static assets : copy chatbot/ and pancancer_image.png ------------------
# demo/index.html references these via relative paths (chatbot/chatbot.js,
# pancancer_image.png), so they must sit inside demo/ alongside index.html.
DEMO_ROOT = ROOT / "demo"
img_src = ROOT / "pancancer_image.png"
if img_src.exists():
    shutil.copyfile(img_src, DEMO_ROOT / "pancancer_image.png")
    print(f"copied pancancer_image.png into demo/")
chatbot_src = ROOT / "chatbot"
chatbot_dst = DEMO_ROOT / "chatbot"
if chatbot_src.exists():
    if chatbot_dst.exists():
        shutil.rmtree(chatbot_dst)
    shutil.copytree(chatbot_src, chatbot_dst)
    print(f"copied chatbot/ into demo/")

print("\ndemo data layer built.")
