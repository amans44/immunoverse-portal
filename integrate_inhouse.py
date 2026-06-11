"""Transform an IN-HOUSE private cohort's final_enhanced.txt into the explorer's
data_js JSON (window.__PD__["CODE"]) — the same format integrate_data.py produces
for the 21 public cancers, so private cancers render in the SAME explorer.

Reuses integrate_data.py's helpers (column parsing, bind/atlas/gene/expression,
homogeneity) and only overrides the in-house specifics:

  * Folder layout is <cohort>/final_enhanced.txt + <cohort>/<CODE>_metadata.txt
    (no CODE_ prefix on the data file), e.g. the GCS bucket immunoverse-private-
    datasets, downloaded locally for processing.
  * Assets carry NO "CODE_" prefix (they live in the cohort's own assets/ folder):
        {pep}_percentile.png, {pep}_rank_abundance.png, spectrum_{pep}.png
        self_gene -> {ensg}_{symbol}_expr_boxplot+boxplot.png
        splicing  -> {coords}_splicing.png
        ERV       -> {erv}_expr.png            (erv = source|[0].split(':')[0])
        TE_chimeric_transcript -> {coords}_splicing.png + {erv}_expr.png
                                  (erv = source|[4].split(',')[1] — NEW index)
  * No sc_pert/homogeneity column -> homo is None -> explorer shows "-".

Output marks the dataset `"inhouse": true` so the frontend uses the no-prefix
asset names + the private signed-URL base instead of the public NYU base.

Usage (local test):
    python integrate_inhouse.py --source _inhouse_test/medulloblastoma \
        --code MB --name "Medulloblastoma (in-house)" --group "Pediatric" \
        --out _inhouse_test/out
"""

from __future__ import annotations

import argparse
import csv
import json
import os
import re
from pathlib import Path

import integrate_data as I  # reuse the public pipeline's tested helpers


def compute_diff_plot_inhouse(cls, source):
    """In-house differential-plot filename(s) — NO code prefix, NEW TE index.
    Mirrors Frank's medulloblastoma draw_differential_and_intensity."""
    if not source:
        return None
    src = I.modify_source_string(source)
    if not src or src == 'not_unique':
        return None
    parts = src.split('|')
    try:
        if cls == 'self_gene':
            if len(parts) >= 3 and parts[0].startswith('ENSG'):
                ensg, _enst, symbol = parts[0], parts[1], parts[2]
                return {'kind': 'gene', 'gene': f'{ensg}_{symbol}_expr_boxplot+boxplot.png'}
            return None
        if cls == 'splicing':
            coords = parts[0]
            if not re.match(r'^chr[\dXYM]+:\d+-\d+$', coords):
                return None
            # Splicing assets name the junction chr{N}_{start}-{end} (the chrom
            # colon becomes an underscore), e.g. chr10_93416859-93434697_splicing.png
            return {'kind': 'splicing', 'splicing': f"{coords.replace(':', '_')}_splicing.png"}
        if cls == 'ERV':
            erv = parts[0].split(':')[0]
            if not erv:
                return None
            return {'kind': 'erv', 'erv': f'{erv}_expr.png'}
        if cls == 'TE_chimeric_transcript':
            coords = parts[0]
            te_info = parts[4] if len(parts) > 4 else ''
            te_pieces = te_info.split(',')
            if not re.match(r'^chr[\dXYM]+:\d+-\d+$', coords) or len(te_pieces) < 2:
                return None
            return {'kind': 'both',
                    'splicing': f"{coords.replace(':', '_')}_splicing.png",
                    'erv': f'{te_pieces[1]}_expr.png'}
    except (IndexError, AttributeError):
        return None
    return None


# In-house sources append a sample/run identifier as the LAST pipe field
# (e.g. base_HDMB03_ERR4880042, add_MED411-2_SRR21548774). The public pipeline's
# clean_gene() suffix-regex grabs that token as the "gene" for non-canonical rows
# (their gene_symbol column is empty), so the drawer showed the run ID instead of
# the real source. Detect those tokens so we never mistake them for a gene.
_SAMPLE_RE = re.compile(r'^(base|add)_|_(ERR|SRR|DRR)\d+$')


def _is_sample(tok):
    return bool(tok and _SAMPLE_RE.search(tok))


_GENE_TOK = re.compile(r'^[A-Za-z][\w\-.]*$')


def _first_gene(field):
    """From a comma list ('HES6,None' / 'None,LINC02802' / 'HES6,HES6') -> first real gene."""
    for g in (field or '').split(','):
        g = g.strip()
        if g and g != 'None':
            return g
    return ''


def _gene_from_record(cls, parts):
    """Extract the real source gene/identifier from ONE '|'-split source record,
    per class. Handles BOTH the medulloblastoma and osteosarcoma source layouts.
    Never returns a sample/run token."""
    try:
        if cls in ('self_gene', 'variant', 'rna_edit'):
            # MB layout: ENSG|ENST|SYMBOL|tpm:..|...   -> symbol at index 2
            if parts[0].startswith('ENSG') and len(parts) >= 3:
                g = (parts[2] or '').strip()
                if g and g != 'None':
                    return g
            # OS layout: SYMBOL|p.change|count|AF|ENSG|coords|...  -> symbol at index 0
            p0 = (parts[0] or '').strip()
            if (p0 and not p0.startswith('ENS') and not p0.startswith('chr')
                    and not _is_sample(p0) and _GENE_TOK.match(p0)):
                return p0
        elif cls == 'splicing':
            # chr:..|..|[ENST]|GENE,GENE|.. (gene may be 1st OR 2nd: 'None,GENE')
            for p in parts[1:]:
                if _is_sample(p) or p.startswith('chr') or p.startswith('ENST') or p.startswith('TE_info'):
                    continue
                if ',' in p:
                    g = _first_gene(p)
                    if g:
                        return g
        elif cls == 'TE_chimeric_transcript':
            # ..|TE_info:...|HOSTGENE,None| OR |None,HOSTGENE| -> the non-None host gene
            for i, p in enumerate(parts):
                if p.startswith('TE_info') and i + 1 < len(parts):
                    g = _first_gene(parts[i + 1])
                    if g:
                        return g
        elif cls == 'ERV':
            # TEFAM_dupN|score|chr:..|.. -> the TE family (drop the _dupN instance id)
            head = (parts[0] or '').split(':')[0]
            fam = head.split('_dup')[0]
            if fam and not _is_sample(fam):
                return fam
        elif cls == 'nuORF':
            # ENST....._N_chr:..|nuORF|sample -> the transcript id
            m = re.match(r'(ENST\d+)', parts[0] or '')
            if m:
                return m.group(1)
        elif cls == 'fusion':
            # GENEA-GENEB|count|coords|.. -> the fusion gene pair
            p0 = (parts[0] or '').strip()
            if p0 and not p0.startswith('chr') and not _is_sample(p0):
                return p0
        elif cls == 'intron_retention':
            # ENSG..,SYMBOL,chr,strand,..|.. -> the symbol (first gene-like, non-ENSG/chr token)
            for tok in (parts[0] or '').split(','):
                tok = tok.strip()
                if (tok and tok != 'None' and not tok.startswith('ENS')
                        and not tok.startswith('chr') and _GENE_TOK.match(tok)):
                    return tok
        # circRNA: coordinate-only, no gene (the hero shows the coordinate instead).
    except (IndexError, AttributeError):
        pass
    return ''


def clean_gene_inhouse(r):
    """In-house gene/source label. Uses the gene_symbol column when present
    (canonical rows), else a class-aware structured parse of `source` that
    skips sample/run IDs — so non-canonical rows show the real source."""
    gsym = (r.get('gene_symbol') or '').strip()
    if gsym and gsym not in ('nan', 'None', ''):
        val = I.safe_eval(gsym)
        if isinstance(val, (list, tuple)):
            names = [str(x).strip() for x in val if str(x).strip() not in ('nan', 'None', '')]
            if names:
                return '/'.join(dict.fromkeys(names))
        else:
            return gsym
    cls = (r.get('typ') or '').strip() or 'self_gene'
    src = (r.get('source') or '').strip()
    if not src or src == 'nan':
        return ''
    for rec in src.split(';'):
        g = _gene_from_record(cls, rec.split('|'))
        if g:
            return g
    return ''


def process_inhouse(source_dir: Path, code: str, name: str, group: str):
    source_dir = Path(source_dir)
    enhanced_file = source_dir / 'final_enhanced.txt'
    if not enhanced_file.exists():
        raise SystemExit(f'No final_enhanced.txt in {source_dir}')
    # metadata is <CODE>_metadata.txt (e.g. MB_metadata.txt)
    # MB ships MB_metadata.txt; OS ships metadata.txt — match both.
    metadata_file = next(iter(source_dir.glob('*metadata.txt')), None)

    total_patients = 0
    hla_patient_count = {}
    if metadata_file and metadata_file.exists():
        _, total_patients, hla_patient_count = I.load_metadata(metadata_file)

    expr_by_gene, expr_by_ensg = I.build_gene_expression_map(enhanced_file)

    immuno_lookup = {}   # no in-house immunogenicity table — bind immuno scores stay None
    rows, detail, class_count, gene_set = [], {}, {}, set()

    with open(enhanced_file, 'r', encoding='utf-8') as f:
        for r in csv.DictReader(f, delimiter='\t'):
            pep = (r.get('pep') or '').strip()
            if not pep:
                continue
            cls = (r.get('typ') or '').strip() or 'self_gene'
            psm = I.safe_int(r.get('n_psm'))
            score = I.safe_float(r.get('highest_score'))
            abund = I.safe_float(r.get('relative_abundance')) or 0
            qval = I.safe_float(r.get('best_pep'))
            recurrence = I.safe_float(r.get('recurrence'))  # absent in-house -> None

            tumor_val = I.safe_eval(r.get('median_tumor', ''))
            normal_val = I.safe_eval(r.get('max_median_gtex', ''))
            tumor = (next((x for x in (I.safe_float(v) for v in tumor_val) if x is not None), None)
                     if isinstance(tumor_val, (list, tuple)) else I.safe_float(r.get('median_tumor', '')))
            normal = (next((x for x in (I.safe_float(v) for v in normal_val) if x is not None), None)
                      if isinstance(normal_val, (list, tuple)) else I.safe_float(r.get('max_median_gtex', '')))

            dep = I.safe_float(r.get('depmap_median'))
            homo = I.parse_sc_pert(r)   # None for in-house (no sc_pert col) -> "-"
            uniq = 1 if str(r.get('unique', '')).strip().lower() in ('true', '1') else 0
            gene = clean_gene_inhouse(r)
            ensg = I.extract_ensg(r)
            atlas = I.parse_atlas(r)
            nuorf_type = (r.get('nuorf_type') or '').strip()
            if nuorf_type in ('nan', 'None', ''):
                nuorf_type = ''

            expr_inherited = False
            if cls != 'self_gene' and tumor is None and normal is None:
                lookup = (expr_by_ensg.get(ensg) if ensg else None)
                if not lookup and gene:
                    for g_part in gene.split('/'):
                        if g_part in expr_by_gene:
                            lookup = expr_by_gene[g_part]; break
                if lookup:
                    tumor, normal, parent_ensg = lookup
                    if parent_ensg and not ensg:
                        ensg = parent_ensg
                    expr_inherited = True

            hlas, bind = I.parse_bind_data(r, immuno_lookup)
            for b in bind:
                n_total = hla_patient_count.get(b[0], 0)
                b.append(n_total)
                b.append(round(b[4] / n_total, 4) if n_total > 0 else None)

            addq_raw = I.safe_eval(r.get('additional_query', ''))
            addq = []
            if isinstance(addq_raw, (list, tuple)):
                for entry in addq_raw:
                    if isinstance(entry, (list, tuple)) and len(entry) >= 4:
                        allele = I.normalize_hla(str(entry[0]))
                        if allele:
                            addq.append([allele, round(I.safe_float(entry[1]) or 0, 3),
                                         round(I.safe_float(entry[2]) or 0, 1),
                                         str(entry[3]) if entry[3] else ''])

            intens_raw = I.safe_eval(r.get('detailed_intensity', ''))
            intens = [round(I.safe_float(v), 4) for v in intens_raw
                      if isinstance(intens_raw, (list, tuple)) and I.safe_float(v) is not None] \
                     if isinstance(intens_raw, (list, tuple)) else []

            extra = {}
            src_raw = r.get('source', '') or ''
            if cls == 'variant':
                muts = I.parse_variant_entries(src_raw)
                if muts:
                    extra['mutations'] = muts
            if cls == 'pathogen':
                pa = I.parse_pathogen_entry(src_raw)
                if pa:
                    extra['pathogen'] = pa
            if expr_inherited:
                extra['exprInherited'] = True
            diff_plot = compute_diff_plot_inhouse(cls, src_raw)
            if diff_plot:
                extra['diffPlot'] = diff_plot
            if src_raw and len(src_raw) < 2000:
                extra['source'] = src_raw.strip()
            if addq or intens or extra:
                detail[pep] = [addq, intens, extra]

            rows.append([
                pep, gene, cls, psm,
                round(score, 1) if score is not None else None,
                round(abund, 4) if abund is not None else None,
                qval,
                round(tumor, 2) if tumor is not None else None,
                round(normal, 2) if normal is not None else None,
                round(dep, 3) if dep is not None else None,
                homo, uniq, hlas, bind, atlas, ensg, nuorf_type,
                round(recurrence, 4) if recurrence is not None else None,
                total_patients,
            ])
            class_count[cls] = class_count.get(cls, 0) + 1
            for g in (gene.split('/') if gene else []):
                gene_set.add(g)

    rows.sort(key=lambda r: (-(r[5] or 0), -(r[4] or 0)))
    unique_count = sum(1 for r in rows if r[11] == 1)
    safe_count = sum(1 for r in rows if r[11] == 1 and len(r[14]) == 0)

    out = {
        'code': code, 'name': name, 'group': group,
        'count': len(rows), 'unique': unique_count, 'safe': safe_count,
        'classes': class_count, 'genes': len(gene_set), 'totalSamples': total_patients,
        'inhouse': True,   # frontend flag: no-prefix assets + private signed-URL base
        'cols': ['pep', 'gene', 'class', 'psm', 'score', 'abund', 'qval',
                 'tumorExp', 'normalExp', 'depmap', 'homo', 'unique', 'hlas',
                 'bind', 'atlas', 'ensg', 'nuorf', 'recurrence', 'totalSamples'],
        'rows': rows,
    }
    return out, detail


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument('--source', required=True, help='cohort folder (final_enhanced.txt + *_metadata.txt)')
    ap.add_argument('--code', required=True, help='cancer code, e.g. MB')
    ap.add_argument('--name', required=True)
    ap.add_argument('--group', default='In-house')
    ap.add_argument('--out', default='_inhouse_test/out')
    args = ap.parse_args(argv)

    out, detail = process_inhouse(Path(args.source), args.code, args.name, args.group)
    out_dir = Path(args.out); out_dir.mkdir(parents=True, exist_ok=True)
    (out_dir / f'{args.code}.js').write_text(
        f'window.__PD__=window.__PD__||{{}};window.__PD__["{args.code}"]={json.dumps(out, separators=(",", ":"))};',
        encoding='utf-8')
    (out_dir / f'{args.code}_detail.js').write_text(
        f'window.__PD__=window.__PD__||{{}};window.__PD__["{args.code}_detail"]={json.dumps(detail, separators=(",", ":"))};',
        encoding='utf-8')

    cc = ', '.join(f'{k}={v}' for k, v in sorted(out['classes'].items(), key=lambda x: -x[1]))
    n_diff = sum(1 for d in detail.values() if 'diffPlot' in d[2])
    print(f"{args.code}: {out['count']} peptides, {out['unique']} unique, {out['genes']} genes, "
          f"{out['totalSamples']} samples")
    print(f"  classes: {cc}")
    print(f"  detail entries: {len(detail)} ({n_diff} with diff plots)")
    print(f"  wrote {out_dir / (args.code + '.js')}")


if __name__ == '__main__':
    main()
