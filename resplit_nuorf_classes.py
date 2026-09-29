"""
Reclassify built nuORF rows into nuORF / lncRNA / pseudogene, in place.

`integrate_data.py` does this on every full rebuild (see `refine_nuorf_class`).
This script applies the same split to already-built artifacts, for the same
reason `augment_immunogenicity.py` exists: the Dropbox cache can be months older
than the committed data_js/, so a full rebuild would roll the atlas back to
whatever the cache holds. It imports the pipeline's own mapping, so the two can
never disagree about which subtype becomes which class.

It rewrites, consistently, every artifact that carries a class value:
    data_js/{CODE}.js        row[2] + the per-cancer `classes` counts
    data_js/_summary.js      per-cancer `classes`, global `classes`, `labels`
    data_js/_search_index.js row `c`, `classLabels`, class `meta` entries
    data/*.json              the JSON mirrors of all of the above

Idempotent: a row already carrying lncRNA/pseudogene is left alone, and counts
are always recomputed from the rows rather than adjusted incrementally.

Usage:
    python resplit_nuorf_classes.py --check      # report only, write nothing
    python resplit_nuorf_classes.py
    python resplit_nuorf_classes.py --restore    # undo from .bak.presplit
"""

import argparse
import collections
import json
import os
import shutil
import sys
from pathlib import Path

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import integrate_data as I  # noqa: E402  — one source of truth for the mapping

HERE = Path(os.path.dirname(os.path.abspath(__file__)))
DATA_JS = HERE / 'data_js'
DATA_JSON = HERE / 'data'
BAK = '.bak.presplit'

CLS = 2       # row index of the class
NUORF = 16    # row index of the nuORF subtype


def load_js(path):
    """data_js files are `window.__PD__["X"]={...};` — split on the first `]=`."""
    text = path.read_text(encoding='utf-8')
    i = text.index(']=') + 2
    body = text[i:].rstrip()
    trail = ''
    while body.endswith(';'):
        body, trail = body[:-1], ';' + trail
    return text[:i], json.loads(body), trail


def save_js(path, head, obj, trail, backup):
    if backup:
        b = path.with_suffix(path.suffix + BAK)
        if not b.exists():
            shutil.copyfile(path, b)
    path.write_text(head + json.dumps(obj, separators=(',', ':')) + trail, encoding='utf-8')


def save_json(path, obj, backup):
    if not path.exists():
        return
    if backup:
        b = path.with_suffix(path.suffix + BAK)
        if not b.exists():
            shutil.copyfile(path, b)
    path.write_text(json.dumps(obj, separators=(',', ':')), encoding='utf-8')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--check', action='store_true', help='report only, write nothing')
    ap.add_argument('--restore', action='store_true', help='restore from ' + BAK)
    args = ap.parse_args()

    targets = sorted(p for p in DATA_JS.glob('*.js')
                     if not p.name.startswith('_') and not p.name.endswith('_detail.js'))

    if args.restore:
        n = 0
        for d in (DATA_JS, DATA_JSON):
            for b in d.glob('*' + BAK):
                shutil.copyfile(b, b.with_suffix(''))
                n += 1
        print(f'Restored {n} file(s) from {BAK}')
        return

    write = not args.check
    moved = collections.Counter()
    unmapped = collections.Counter()
    per_cancer = {}
    # (cancer, peptide) -> set of classes seen. Built in memory during the pass
    # below rather than by re-reading the files afterwards, so --check reports
    # the same numbers a real run produces. A peptide can legitimately appear
    # twice in one cancer, so this tracks a set and refuses to guess when the
    # duplicates disagree.
    lookup = collections.defaultdict(set)

    for path in targets:
        head, obj, trail = load_js(path)
        code = path.stem
        counts = collections.Counter()
        for r in obj['rows']:
            # Re-derive from the CURRENT class + subtype. Already-split rows have
            # cls lncRNA/pseudogene, which refine_nuorf_class passes straight
            # through, so re-running changes nothing.
            before = r[CLS]
            after = I.refine_nuorf_class(before, r[NUORF] if len(r) > NUORF else '')
            if after != before:
                moved[after] += 1
                r[CLS] = after
            if after == 'nuORF':
                unmapped[(r[NUORF] or '(blank)') if len(r) > NUORF else '(blank)'] += 1
            counts[after] += 1
            lookup[(code, r[0])].add(after)
        obj['classes'] = dict(counts)
        per_cancer[code] = dict(counts)
        if write:
            save_js(path, head, obj, trail, backup=True)
            jp = DATA_JSON / (code + '.json')
            if jp.exists():
                save_json(jp, obj, backup=True)

    # ---- _summary: per-cancer classes, global rollup, labels -----------------
    sp = DATA_JS / '_summary.js'
    head, summary, trail = load_js(sp)
    for c in summary.get('cancers', []):
        if c['code'] in per_cancer:
            c['classes'] = per_cancer[c['code']]
    total = collections.Counter()
    for c in summary.get('cancers', []):
        total.update(c.get('classes', {}))
    summary['classes'] = dict(total)
    summary['labels'] = dict(I.CLASS_LABELS)
    if write:
        save_js(sp, head, summary, trail, backup=True)
        save_json(DATA_JSON / '_summary.json', summary, backup=True)

    # ---- _search_index: per-row class, labels, class meta --------------------
    ip = DATA_JS / '_search_index.js'
    text = ip.read_text(encoding='utf-8')
    eq = text.index('=') + 1
    ihead, ibody = text[:eq], text[eq:].rstrip()
    itrail = ''
    while ibody.endswith(';'):
        ibody, itrail = ibody[:-1], ';' + itrail
    idx = json.loads(ibody)

    # The index has no subtype column, so take each row's class from the
    # authoritative data_js rows, keyed on (cancer, peptide).
    fixed = ambiguous = 0
    for r in idx.get('rows', []):
        want = lookup.get((r.get('ca'), r.get('p')))
        if not want:
            continue
        if len(want) > 1:
            ambiguous += 1          # duplicate peptide with conflicting classes
            continue
        w = next(iter(want))
        if w != r.get('c'):
            r['c'] = w
            fixed += 1
    idx['classLabels'] = dict(I.CLASS_LABELS)
    others = [m for m in idx.get('meta', []) if m.get('k') != 'class']
    idx['meta'] = others + [{'k': 'class', 'code': k, 'label': v}
                            for k, v in I.CLASS_LABELS.items()]
    if write:
        if not ip.with_suffix(ip.suffix + BAK).exists():
            shutil.copyfile(ip, ip.with_suffix(ip.suffix + BAK))
        ip.write_text(ihead + json.dumps(idx, separators=(',', ':')) + itrail, encoding='utf-8')
        save_json(DATA_JSON / '_search_index.json', idx, backup=True)

    # ---- report --------------------------------------------------------------
    print('Reclassified out of the nuORF bucket:')
    for k, v in moved.most_common():
        print(f'  {v:6,d} -> {k}')
    print(f'  {fixed:6,d} search-index rows re-keyed'
          + (f'  ({ambiguous} left alone: duplicate peptide, conflicting class)' if ambiguous else ''))
    print('\nSubtypes remaining under nuORF:')
    for k, v in unmapped.most_common():
        print(f'  {v:6,d}  {k}')
    print('\nGlobal class totals now:')
    for k in I.CLASS_LABELS:
        print(f'  {total.get(k, 0):7,d}  {k}')
    print(f'\n  TOTAL {sum(total.values()):,}')
    missing = [k for k in total if k not in I.CLASS_LABELS]
    if missing:
        print('  WARNING: classes with no label:', missing)
    print('\n--check: nothing written.' if args.check
          else f'\nWrote {len(targets)} cancer file(s) + summary + search index; {BAK} kept.')


if __name__ == '__main__':
    main()
