"""
Backfill the PRIME %rank (bind index 8) into already-built data_js/*.js files.

`integrate_data.py` emits index 8 on every full rebuild. This script exists for
the case where a rebuild is not wanted: the Dropbox cache can be months older
than the live data_js/, so re-running the full pipeline would quietly roll the
portal's peptide tables back to whatever the cache holds. This touches only the
per-HLA bind arrays and leaves every other field — and every antigen and cohort
record — byte-identical.

It shares `load_dual_immunogenicity` and `normalize_hla` with the pipeline, so
the join here and the join on a real rebuild cannot drift apart.

Idempotent: a bind row that already carries index 8 is overwritten with the
freshly looked-up value, never appended to twice.

Usage:
    python augment_immunogenicity.py --source ../final_immunogenicity.txt
    python augment_immunogenicity.py --source ../final_immunogenicity.txt --check
    python augment_immunogenicity.py --source ../final_immunogenicity.txt --restore

`--check` reports coverage and writes nothing. `--restore` puts the .bak copies
back. Every run without those flags writes a .bak.preprime beside each file it
changes, unless one is already there (so the first, pre-feature state is kept).
"""

import argparse
import collections
import json
import os
import shutil
import sys
from pathlib import Path

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import integrate_data as I  # noqa: E402  — reuse the pipeline's tested helpers

HERE = Path(os.path.dirname(os.path.abspath(__file__)))
DATA_JS = HERE / 'data_js'
BAK_SUFFIX = '.bak.preprime'

# `window.__PD__["AML"]={...};` — the payload starts after the first `]=`.
PREFIX_SPLIT = ']='


def load_pd(path):
    text = path.read_text(encoding='utf-8')
    i = text.index(PREFIX_SPLIT) + len(PREFIX_SPLIT)
    head, body = text[:i], text[i:].rstrip()
    trailing = ''
    while body.endswith(';'):
        body = body[:-1]
        trailing = ';' + trailing
    return head, json.loads(body), trailing


def dump_pd(path, head, obj, trailing):
    # `separators` matches what integrate_data.py writes, so the diff stays
    # limited to the bind arrays we actually touched.
    path.write_text(head + json.dumps(obj, separators=(',', ':')) + trailing,
                    encoding='utf-8')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--source', default=str(HERE.parent / 'final_immunogenicity.txt'),
                    help='combined two-model immunogenicity table')
    ap.add_argument('--deep-source', default=str(HERE.parent / 'all_deepimmuno_immunogenicity.txt'),
                    help='standalone DeepImmuno file, used only for the consistency check')
    ap.add_argument('--check', action='store_true', help='report only, write nothing')
    ap.add_argument('--restore', action='store_true', help='restore the .bak.preprime copies')
    args = ap.parse_args()

    targets = sorted(p for p in DATA_JS.glob('*.js')
                     if not p.name.startswith('_') and not p.name.endswith('_detail.js'))

    if args.restore:
        n = 0
        for p in targets:
            bak = p.with_suffix(p.suffix + BAK_SUFFIX)
            if bak.exists():
                shutil.copyfile(bak, p)
                n += 1
        print(f'Restored {n} file(s) from {BAK_SUFFIX}')
        return

    deep, prime, stats = I.load_dual_immunogenicity(Path(args.source), Path(args.deep_source))

    # Consistency check against the standalone DeepImmuno file. The combined
    # table is the primary source; this only confirms the two agree before we
    # let the combined one drive the portal.
    dpath = Path(args.deep_source)
    if dpath.exists():
        standalone = I.load_immunogenicity(dpath)
        agree = sum(1 for k, v in standalone.items() if k in deep and abs(deep[k] - v) < 1e-4)
        disagree = sum(1 for k, v in standalone.items() if k in deep and abs(deep[k] - v) >= 1e-4)
        absent = sum(1 for k in standalone if k not in deep)
        print(f'  Cross-check vs standalone DeepImmuno: {agree:,} agree, '
              f'{disagree:,} disagree, {absent:,} present only in the standalone file')
        if disagree:
            print('  REFUSING to continue: the two files disagree on DeepImmuno values.')
            sys.exit(1)

    tot = hit_d = hit_p = 0
    per_state = collections.Counter()
    unmatched = []
    changed = []

    for path in targets:
        head, obj, trailing = load_pd(path)
        touched = 0
        for row in obj.get('rows', []):
            pep = row[0]
            for b in (row[13] or []):
                allele = b[0]
                key = (pep, allele)
                tot += 1
                d = deep.get(key)
                p = prime.get(key)
                if d is not None:
                    hit_d += 1
                if p is not None:
                    hit_p += 1
                if d is None and p is None:
                    if len(unmatched) < 10:
                        unmatched.append((path.stem, pep, allele, len(pep)))
                # Grow to 9 slots, then set index 8. Never append twice.
                while len(b) < 9:
                    b.append(None)
                if b[8] != p:
                    touched += 1
                b[8] = p
                # index 5 (DeepImmuno) is left exactly as the pipeline wrote it;
                # the cross-check above already proved the two sources agree.
                per_state[state(b[5], p)] += 1
        if touched and not args.check:
            bak = path.with_suffix(path.suffix + BAK_SUFFIX)
            if not bak.exists():
                shutil.copyfile(path, bak)
            dump_pd(path, head, obj, trailing)
            changed.append((path.name, touched))

    print(f'\nper-HLA bind rows scanned: {tot:,}')
    print(f'  DeepImmuno present: {hit_d:,} ({100*hit_d/tot:.1f}%)')
    print(f'  PRIME present:      {hit_p:,} ({100*hit_p/tot:.1f}%)')
    print('\nInterpretation state distribution at the configured thresholds '
          f'(DeepImmuno >= {DEEP_T}, PRIME <= {PRIME_T}):')
    for k in ('concordant-favorable', 'discordant', 'neither', 'single', 'unavailable'):
        print(f'  {k:22s} {per_state[k]:7,d}  {100*per_state[k]/tot:5.1f}%')
    if unmatched:
        print('\nPairs with neither model (first 10):')
        for u in unmatched:
            print(f'  {u[0]:6s} {u[1]:16s} {u[2]:10s} len={u[3]}')
    if args.check:
        print('\n--check: nothing written.')
    else:
        print(f'\nUpdated {len(changed)} file(s); .bak{BAK_SUFFIX} kept for the pre-feature state.')


# Mirrors IMMUNO_CFG in index.html. Kept here so the build-time report and the
# UI cannot disagree about what the thresholds are.
DEEP_T = 0.5
PRIME_T = 0.5


def state(d, p):
    df = None if d is None else d >= DEEP_T
    pf = None if p is None else p <= PRIME_T
    if df is None and pf is None:
        return 'unavailable'
    if df is None or pf is None:
        return 'single'
    if df and pf:
        return 'concordant-favorable'
    if df != pf:
        return 'discordant'
    return 'neither'


if __name__ == '__main__':
    main()
