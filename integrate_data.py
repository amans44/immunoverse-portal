"""
Integrate all ImmunoVerse data from Dropbox into the portal's data_js/ files.

Data sources (from Dropbox shared folder):
  - {CANCER}_final_enhanced.txt  — per-cancer peptide tables with full annotations
  - {CANCER}_metadata.txt        — per-sample HLA types for computing recurrency
  - all_deepimmuno_immunogenicity.txt — DeepImmuno immunogenicity predictions
  - US_HLA_frequency.csv         — US population HLA allele frequencies

This script reads the extracted Dropbox data and regenerates the data_js/*.js files
with additional columns: immunogenicity, per-HLA recurrency, total samples.
"""

import ast
import csv
import json
import os
import re
import sys
from collections import defaultdict
from pathlib import Path

# === CONFIGURATION ===
EXTRACTED_DIR = Path(os.environ.get('IMMUNOVERSE_DATA', r'C:\Users\itsam\AppData\Local\Temp\immunoverse_extracted'))
OUT_DIR = Path(os.path.dirname(os.path.abspath(__file__))) / 'data_js'

CANCER_META = {
    'AML':  ('Acute Myeloid Leukemia',           'Heme'),
    'BLCA': ('Bladder Urothelial Carcinoma',      'GU'),
    'BRCA': ('Breast Invasive Carcinoma',         'Breast'),
    'CESC': ('Cervical Squamous Cell Carcinoma',  'Gyn'),
    'CHOL': ('Cholangiocarcinoma',                'GI'),
    'COAD': ('Colon Adenocarcinoma',              'GI'),
    'DLBC': ('Diffuse Large B-cell Lymphoma',     'Heme'),
    'ESCA': ('Esophageal Carcinoma',              'GI'),
    'GBM':  ('Glioblastoma Multiforme',           'CNS'),
    'HNSC': ('Head & Neck Squamous Cell Carc.',   'H&N'),
    'KIRC': ('Kidney Renal Clear Cell Carc.',     'GU'),
    'LIHC': ('Liver Hepatocellular Carcinoma',    'GI'),
    'LUAD': ('Lung Adenocarcinoma',               'Lung'),
    'LUSC': ('Lung Squamous Cell Carcinoma',      'Lung'),
    'MESO': ('Mesothelioma',                      'Thoracic'),
    'NBL':  ('Neuroblastoma',                     'Pediatric'),
    'OV':   ('Ovarian Serous Cystadenocarc.',     'Gyn'),
    'PAAD': ('Pancreatic Adenocarcinoma',         'GI'),
    'RT':   ('Rhabdoid Tumor',                    'Pediatric'),
    'SKCM': ('Skin Cutaneous Melanoma',           'Skin'),
    'STAD': ('Stomach Adenocarcinoma',            'GI'),
}

CLASS_LABELS = {
    'self_gene': 'Canonical self-antigen',
    'splicing': 'Alternative splicing',
    'variant': 'Variant / neoantigen',
    'nuORF': 'Cryptic / non-canonical ORF',
    'ERV': 'Endogenous retrovirus',
    'TE_chimeric_transcript': 'TE chimeric transcript',
    'intron_retention': 'Intron retention',
    'fusion': 'Gene fusion',
    'pathogen': 'Pathogen-derived',
}


def safe_float(v):
    if v is None or v == '' or v == 'nan' or v == 'None':
        return None
    try:
        f = float(v)
        if f != f:  # NaN check
            return None
        return f
    except (ValueError, TypeError):
        return None


def safe_int(v):
    f = safe_float(v)
    return int(f) if f is not None else 0


def safe_eval(s):
    """Safely evaluate Python literal strings (dicts, lists, tuples)."""
    if not s or s == 'nan' or s == 'None' or s == '':
        return None
    try:
        return ast.literal_eval(s)
    except Exception:
        return None


def normalize_hla(allele):
    """Normalize HLA allele to standard format: A*01:01"""
    if not allele:
        return None
    a = str(allele).replace('HLA-', '').strip()
    # Convert 4-digit format like A0101 to A*01:01
    m = re.match(r'^([ABC])(\d{2})(\d{2,3})$', a)
    if m:
        a = f'{m.group(1)}*{m.group(2)}:{m.group(3)}'
    return a if '*' in a else None


def load_immunogenicity(filepath):
    """Load all_deepimmuno_immunogenicity.txt into a lookup dict: {(peptide, hla): score}"""
    immuno = {}
    with open(filepath, 'r') as f:
        reader = csv.DictReader(f, delimiter='\t')
        for row in reader:
            pep = row.get('peptide', '').strip()
            hla_raw = row.get('HLA', '').strip()
            score = safe_float(row.get('immunogenicity'))
            if pep and hla_raw and score is not None:
                hla = normalize_hla(hla_raw)
                if hla:
                    immuno[(pep, hla)] = round(score, 4)
    print(f'  Loaded {len(immuno)} immunogenicity scores')
    return immuno


def load_metadata(filepath):
    """Load metadata.txt to get per-patient HLA types.
    Returns: {sample_name: set_of_hla_alleles}, total_unique_patients, per_hla_patient_count
    """
    sample_hlas = {}
    patient_hlas = defaultdict(set)  # patient -> set of alleles
    patients = set()

    with open(filepath, 'r') as f:
        reader = csv.DictReader(f, delimiter='\t')
        for row in reader:
            sample = row.get('sample', '').strip()
            biology = row.get('biology', '').strip()
            hla_str = row.get('HLA', '').strip().strip('"')
            if not sample:
                continue
            patients.add(biology or sample)
            alleles = set()
            if hla_str:
                for a in hla_str.split(','):
                    norm = normalize_hla(a.strip())
                    if norm:
                        alleles.add(norm)
            sample_hlas[sample] = alleles
            patient_hlas[biology or sample] |= alleles

    # Count how many unique patients carry each allele
    hla_patient_count = defaultdict(int)
    for pat, alleles in patient_hlas.items():
        for a in alleles:
            hla_patient_count[a] += 1

    return sample_hlas, len(patients), dict(hla_patient_count)


def clean_gene(row):
    """Extract clean gene symbol from source/gene_symbol fields."""
    g = row.get('gene_symbol', '')
    if g and g != 'nan' and g != 'None':
        # May be a Python list repr
        val = safe_eval(g)
        if isinstance(val, (list, tuple)):
            names = [str(x).strip() for x in val if x and str(x).strip() not in ('nan', 'None', '')]
            return '/'.join(dict.fromkeys(names).keys())  # dedup preserving order
        return str(g).strip()

    # Parse from source
    src = row.get('source', '')
    if src and src != 'nan':
        found = []
        for piece in re.split(r'[;,]', src):
            m = re.findall(r'\|([A-Za-z0-9\-_.]+)\s*$', piece)
            for hit in m:
                if hit and not hit.startswith('ENS') and hit not in found:
                    found.append(hit)
        if found:
            return '/'.join(found[:3])
    return ''


def extract_ensg(row):
    """Extract first ENSG ID from ensgs or source fields."""
    ensgs = row.get('ensgs', '')
    if ensgs and ensgs != 'nan':
        val = safe_eval(ensgs)
        if isinstance(val, (list, tuple)):
            for e in val:
                e = str(e).strip()
                if e.startswith('ENSG'):
                    return e
        elif isinstance(ensgs, str) and ensgs.startswith('ENSG'):
            return ensgs.split(';')[0].split(',')[0].strip()

    src = row.get('source', '')
    if src:
        m = re.search(r'(ENSG\d+)', src)
        if m:
            return m.group(1)
    return ''


def parse_bind_data(row, immuno_lookup):
    """Parse presented_by_each_sample_hla to build per-HLA binding data.
    Returns: hlas list, bind list [[allele, rank%, nM, category, nSamples, immunogenicity], ...]
    """
    pep = row.get('pep', '').strip()
    raw = row.get('presented_by_each_sample_hla', '')
    d = safe_eval(raw)
    if not isinstance(d, dict):
        return [], []

    # Aggregate across samples: for each allele, collect best rank/affinity and count samples
    allele_data = defaultdict(lambda: {'rank': None, 'nm': None, 'cat': None, 'samples': 0})

    for sample_name, hits in d.items():
        if not isinstance(hits, (list, tuple)):
            continue
        seen_alleles = set()
        for h in hits:
            if not isinstance(h, (list, tuple)) or len(h) < 4:
                continue
            allele_raw, rank, nm, cat = h[0], h[1], h[2], h[3]
            if allele_raw is None:
                continue
            allele = normalize_hla(str(allele_raw))
            if not allele:
                continue
            if allele not in seen_alleles:
                seen_alleles.add(allele)
                ad = allele_data[allele]
                ad['samples'] += 1
                r = safe_float(rank)
                n = safe_float(nm)
                c = str(cat).strip() if cat else None
                if r is not None and (ad['rank'] is None or r < ad['rank']):
                    ad['rank'] = r
                    ad['nm'] = n
                    ad['cat'] = c

    hlas = sorted(allele_data.keys(), key=lambda a: (a[:1], a))
    bind = []
    for allele in hlas:
        ad = allele_data[allele]
        cat = ad['cat'] or ''
        immuno_score = immuno_lookup.get((pep, allele))
        bind.append([
            allele,
            round(ad['rank'], 3) if ad['rank'] is not None else None,
            round(ad['nm'], 1) if ad['nm'] is not None else None,
            cat,
            ad['samples'],
            round(immuno_score, 4) if immuno_score is not None else None
        ])

    return hlas, bind


def parse_atlas(row):
    """Parse hla_ligand_atlas field — list of normal tissues where peptide was detected."""
    raw = row.get('hla_ligand_atlas', '')
    val = safe_eval(raw)
    if isinstance(val, (list, tuple)):
        return [str(t).strip() for t in val if t and str(t).strip() not in ('nan', 'None', '')]
    return []


def parse_sc_pert(row):
    """Compute homogeneity from sc_pert field."""
    raw = row.get('sc_pert', '')
    val = safe_eval(raw)
    if isinstance(val, (list, tuple)):
        nums = [safe_float(x) for x in val]
        nums = [n for n in nums if n is not None]
        if nums:
            return round(sum(nums) / len(nums), 3)
    return None


def process_cancer(code, immuno_lookup):
    enhanced_file = EXTRACTED_DIR / f'{code}_final_enhanced.txt'
    metadata_file = EXTRACTED_DIR / f'{code}_metadata.txt'

    if not enhanced_file.exists():
        print(f'  [skip] {code}: no _final_enhanced.txt')
        return None

    # Load metadata for per-HLA sample totals
    total_patients = 0
    hla_patient_count = {}
    if metadata_file.exists():
        _, total_patients, hla_patient_count = load_metadata(metadata_file)
        print(f'  {code}: {total_patients} patients, {len(hla_patient_count)} unique HLA alleles in metadata')

    rows = []
    detail = {}  # peptide -> [addq, intens]
    class_count = {}
    gene_set = set()

    with open(enhanced_file, 'r') as f:
        reader = csv.DictReader(f, delimiter='\t')
        for r in reader:
            pep = r.get('pep', '').strip()
            if not pep:
                continue

            cls = r.get('typ', '').strip() or 'self_gene'
            psm = safe_int(r.get('n_psm'))
            score = safe_float(r.get('highest_score'))
            abund = safe_float(r.get('relative_abundance')) or 0
            qval = safe_float(r.get('best_pep'))
            recurrence = safe_float(r.get('recurrence'))

            # Expression data
            tumor_raw = r.get('median_tumor', '')
            normal_raw = r.get('max_median_gtex', '')
            tumor_val = safe_eval(tumor_raw)
            normal_val = safe_eval(normal_raw)
            if isinstance(tumor_val, (list, tuple)):
                nums = [safe_float(x) for x in tumor_val if safe_float(x) is not None]
                tumor = nums[0] if nums else None
            else:
                tumor = safe_float(tumor_raw)
            if isinstance(normal_val, (list, tuple)):
                nums = [safe_float(x) for x in normal_val if safe_float(x) is not None]
                normal = nums[0] if nums else None
            else:
                normal = safe_float(normal_raw)

            dep = safe_float(r.get('depmap_median'))
            homo = parse_sc_pert(r)
            uniq = 1 if str(r.get('unique', '')).strip().lower() in ('true', '1') else 0
            gene = clean_gene(r)
            ensg = extract_ensg(r)
            atlas = parse_atlas(r)
            nuorf_type = r.get('nuorf_type', '').strip()
            if nuorf_type in ('nan', 'None', ''):
                nuorf_type = ''

            # Per-HLA binding data with immunogenicity
            hlas, bind = parse_bind_data(r, immuno_lookup)

            # Compute per-HLA recurrency (#detected / #total)
            for b in bind:
                allele = b[0]
                n_detected = b[4]
                n_total = hla_patient_count.get(allele, 0)
                # Append total and recurrency to each bind entry
                b.append(n_total)  # index 6: #Total patients with this HLA
                hla_rec = round(n_detected / n_total, 4) if n_total > 0 else None
                b.append(hla_rec)  # index 7: per-HLA recurrence

            # Parse additional_query for extended binding predictions
            addq_raw = safe_eval(r.get('additional_query', ''))
            addq = []
            if isinstance(addq_raw, (list, tuple)):
                for entry in addq_raw:
                    if isinstance(entry, (list, tuple)) and len(entry) >= 4:
                        allele = normalize_hla(str(entry[0]))
                        if allele:
                            immuno_score = immuno_lookup.get((pep, allele))
                            addq.append([
                                allele,
                                round(safe_float(entry[1]) or 0, 3),
                                round(safe_float(entry[2]) or 0, 1),
                                str(entry[3]) if entry[3] else ''
                            ])

            # Parse detailed_intensity
            intens_raw = safe_eval(r.get('detailed_intensity', ''))
            intens = []
            if isinstance(intens_raw, (list, tuple)):
                for val in intens_raw:
                    f = safe_float(val)
                    if f is not None:
                        intens.append(round(f, 4))

            # Store detail data (addq + intens) keyed by peptide
            if addq or intens:
                detail[pep] = [addq, intens]

            # Build the row: 18 columns matching the COL indices in index.html
            # + 2 new fields: recurrence (overall) and totalSamples
            row_data = [
                pep,                                                    # 0: pep
                gene,                                                   # 1: gene
                cls,                                                    # 2: cls
                psm,                                                    # 3: psm
                round(score, 1) if score is not None else None,         # 4: score
                round(abund, 4) if abund is not None else None,         # 5: abund
                qval,                                                   # 6: qval
                round(tumor, 2) if tumor is not None else None,         # 7: tumorExp
                round(normal, 2) if normal is not None else None,       # 8: normalExp
                round(dep, 3) if dep is not None else None,             # 9: depmap
                homo,                                                   # 10: homo
                uniq,                                                   # 11: unique
                hlas,                                                   # 12: hlas
                bind,                                                   # 13: bind (now with immunogenicity, #total, recurrence per HLA)
                atlas,                                                  # 14: atlas
                ensg,                                                   # 15: ensg
                nuorf_type,                                             # 16: nuorf
                # New fields:
                round(recurrence, 4) if recurrence is not None else None,  # 17: recurrence (overall)
                total_patients,                                            # 18: totalSamples
            ]

            rows.append(row_data)
            class_count[cls] = class_count.get(cls, 0) + 1
            if gene:
                for g in gene.split('/'):
                    gene_set.add(g)

    # Sort by abundance desc, then score desc
    rows.sort(key=lambda r: (-(r[5] or 0), -(r[4] or 0)))

    # Count safe/unique
    unique_count = sum(1 for r in rows if r[11] == 1)
    safe_count = sum(1 for r in rows if r[11] == 1 and len(r[14]) == 0)

    name, group = CANCER_META.get(code, (code, ''))
    out = {
        'code': code,
        'name': name,
        'group': group,
        'count': len(rows),
        'unique': unique_count,
        'safe': safe_count,
        'classes': class_count,
        'genes': len(gene_set),
        'totalSamples': total_patients,
        'cols': ['pep', 'gene', 'class', 'psm', 'score', 'abund', 'qval',
                 'tumorExp', 'normalExp', 'depmap', 'homo', 'unique', 'hlas',
                 'bind', 'atlas', 'ensg', 'nuorf', 'recurrence', 'totalSamples'],
        'rows': rows,
    }

    # Write main data file
    js_content = f'window.__PD__=window.__PD__||{{}};window.__PD__["{code}"]={json.dumps(out, separators=(",", ":"))};'
    with open(OUT_DIR / f'{code}.js', 'w') as f:
        f.write(js_content)

    # Write detail file (addq + intens per peptide)
    detail_js = f'window.__PD__=window.__PD__||{{}};window.__PD__["{code}_detail"]={json.dumps(detail, separators=(",", ":"))};'
    with open(OUT_DIR / f'{code}_detail.js', 'w') as f:
        f.write(detail_js)

    # Also write JSON versions
    json_dir = Path(os.path.dirname(os.path.abspath(__file__))) / 'data'
    json_dir.mkdir(exist_ok=True)
    with open(json_dir / f'{code}.json', 'w') as f:
        json.dump(out, separators=(',', ':'), fp=f)
    with open(json_dir / f'{code}_detail.json', 'w') as f:
        json.dump(detail, separators=(',', ':'), fp=f)

    print(f'  {code}: {len(rows):>6,} rows, {len(gene_set):>5} genes, {len(detail)} detail entries, {total_patients} patients')
    return {
        'code': code, 'name': name, 'group': group,
        'count': len(rows), 'unique': unique_count, 'safe': safe_count,
        'classes': class_count, 'genes': len(gene_set),
        'totalSamples': total_patients,
    }


def build_summary(cancers):
    total = sum(c['count'] for c in cancers)
    total_unique = sum(c.get('unique', 0) for c in cancers)
    total_safe = sum(c.get('safe', 0) for c in cancers)
    class_tot = {}
    for c in cancers:
        for k, v in c['classes'].items():
            class_tot[k] = class_tot.get(k, 0) + v

    summary = {
        'cancers': cancers,
        'stats': {
            'tumorSpecific': total_unique,
            'totalEntries': total,
            'cancers': len(cancers),
            'molecularSources': len(class_tot),
            'immunopeptidomes': 1823,
            'rnaSeq': 7188,
            'normalControls': 17384,
            'scRNA': 594,
        },
        'classes': class_tot,
        'totals': {
            'targets': total,
            'tumorSpecific': total_unique,
            'genes': sum(c['genes'] for c in cancers),
        },
        'labels': CLASS_LABELS,
    }

    js_content = f'window.__PD__=window.__PD__||{{}};window.__PD__["_summary"]={json.dumps(summary, separators=(",", ":"))};'
    with open(OUT_DIR / '_summary.js', 'w') as f:
        f.write(js_content)

    json_dir = Path(os.path.dirname(os.path.abspath(__file__))) / 'data'
    with open(json_dir / '_summary.json', 'w') as f:
        json.dump(summary, indent=2, fp=f)

    print(f'\nSUMMARY: {total:,} rows across {len(cancers)} cancers')
    print(f'  Tumor-specific: {total_unique:,}')
    print(f'  Safe (unique + no atlas): {total_safe:,}')
    print(f'  Classes: {class_tot}')


def main():
    print('Loading immunogenicity data...')
    immuno_file = EXTRACTED_DIR / 'all_deepimmuno_immunogenicity.txt'
    immuno_lookup = load_immunogenicity(immuno_file) if immuno_file.exists() else {}

    print('\nProcessing cancers...')
    cancers = []
    for code in sorted(CANCER_META.keys()):
        print(f'\n--- {code} ---')
        meta = process_cancer(code, immuno_lookup)
        if meta:
            cancers.append(meta)

    build_summary(cancers)
    print('\nDone! Updated data_js/ and data/ directories.')


if __name__ == '__main__':
    main()
