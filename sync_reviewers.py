"""Mirror root runtime assets into reviewers/ so /reviewers/ is fully self-contained.

Run this AFTER integrate_data.py finishes its daily rebuild. The /reviewers/ folder
holds an independent copy of all the data the portal loads at runtime, so it keeps
working even if the root domain ever gets gated behind a login.

reviewers/ is a FROZEN, INDEPENDENT copy of the portal — it must keep working,
login-free, for paper reviewers regardless of what changes on the main site
(gating, the Welcome modal, auth, etc.). So only the *data* is kept current here;
the reviewers UI (index.html + chatbot widget) is NEVER overwritten.

What gets mirrored (DATA only; read-only copies; root is never modified):
  - data_js/                 (per-cancer .js files + _summary.js + _search_index.js)
  - data/                    (per-cancer .json files for the download buttons)
  - pancancer_image.png      (the body map illustration)

NOT mirrored (frozen so main-site UI changes can't leak into reviewers):
  - reviewers/index.html     (COPY_INDEX = False)
  - reviewers/chatbot/       (its own pinned copy)
To intentionally push a UI change into reviewers, copy the file(s) by hand.
"""
import shutil
import sys
from pathlib import Path

ROOT = Path(__file__).parent
REVIEWERS = ROOT / "reviewers"

# (source, destination) pairs. Sources are relative to ROOT; destinations to REVIEWERS.
MIRRORS = [
    ("data_js",            "data_js"),
    ("data",               "data"),
    ("pancancer_image.png", "pancancer_image.png"),
    # NOTE: chatbot/ is intentionally NOT mirrored — reviewers keeps its own
    # pinned widget so main-site changes never alter the reviewers UI.
]

# Keep False. reviewers/index.html is a frozen, independent page (no login/gating);
# it must NOT be overwritten with the root index.html. (See module docstring.)
COPY_INDEX = False


def mirror(src_rel: str, dst_rel: str) -> None:
    src = ROOT / src_rel
    dst = REVIEWERS / dst_rel
    if not src.exists():
        print(f"  skip (missing): {src_rel}")
        return
    if src.is_dir():
        if dst.exists():
            shutil.rmtree(dst)
        shutil.copytree(src, dst)
        n = sum(1 for _ in dst.rglob("*") if _.is_file())
        print(f"  dir : {src_rel:<22s} -> reviewers/{dst_rel}  ({n} files)")
    else:
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(src, dst)
        print(f"  file: {src_rel:<22s} -> reviewers/{dst_rel}  ({dst.stat().st_size:,} bytes)")


def main() -> int:
    if not REVIEWERS.exists():
        REVIEWERS.mkdir(parents=True)
        print(f"created reviewers/")

    print("Mirroring runtime assets into reviewers/ ...")
    for src_rel, dst_rel in MIRRORS:
        mirror(src_rel, dst_rel)

    if COPY_INDEX:
        src_index = ROOT / "index.html"
        dst_index = REVIEWERS / "index.html"
        if src_index.exists():
            shutil.copyfile(src_index, dst_index)
            print(f"  file: index.html             -> reviewers/index.html  ({dst_index.stat().st_size:,} bytes)")

    # Sanity: reviewers/ should be self-contained — every relative path referenced
    # from reviewers/index.html should resolve inside reviewers/.
    required = ["data_js/_summary.js", "chatbot/chatbot.js", "pancancer_image.png"]
    missing = [p for p in required if not (REVIEWERS / p).exists()]
    if missing:
        print(f"WARNING: reviewers/ is missing required files: {missing}")
        return 1

    print("\nreviewers/ is self-contained and ready to serve at immuno-verse.com/reviewers")
    return 0


if __name__ == "__main__":
    sys.exit(main())
