"""
Integrate all ImmunoVerse data from Dropbox into the portal's data_js/ files.

Data sources (live from the shared Dropbox folder — downloaded automatically):
  - {CANCER}_final_enhanced.txt  — per-cancer peptide tables with full annotations
  - {CANCER}_metadata.txt        — per-sample HLA types for computing recurrency
  - all_deepimmuno_immunogenicity.txt — DeepImmuno immunogenicity predictions
  - US_HLA_frequency.csv         — US population HLA allele frequencies

On every run this script checks the local cache (default: ~24h). If the cache is
missing or stale, it re-downloads the Dropbox folder as a ZIP and extracts it.
Point IMMUNOVERSE_DROPBOX_URL at a different share to swap data sources.
"""

import ast
import csv
import io
import json
import os
import re
import shutil
import sys
import time
import urllib.request
import zipfile
from collections import defaultdict
from pathlib import Path

# === CONFIGURATION ===
DROPBOX_URL = os.environ.get(
    'IMMUNOVERSE_DROPBOX_URL',
    'https://www.dropbox.com/scl/fo/2we0ndqepjbrc9dgrl4om/AFWgxeokcbxOkA4CFTTxJeA?rlkey=lre6rtqqkcjeglo2ylwtny3ea&dl=1',
)
# Where the extracted Dropbox files are cached between runs.
EXTRACTED_DIR = Path(os.environ.get('IMMUNOVERSE_DATA', Path.home() / '.cache' / 'immunoverse' / 'extracted'))
CACHE_ZIP = EXTRACTED_DIR.parent / 'dropbox.zip'
CACHE_TTL_SECONDS = int(os.environ.get('IMMUNOVERSE_CACHE_TTL', 60 * 60 * 24))  # 24h default
FORCE_REFRESH = os.environ.get('IMMUNOVERSE_FORCE_REFRESH', '0') == '1'
OUT_DIR = Path(os.path.dirname(os.path.abspath(__file__))) / 'data_js'


def ensure_raw_data():
    """Download+extract Dropbox folder if local cache is missing or stale.

    Honors IMMUNOVERSE_DATA for pre-extracted local runs (skip download if
    the folder already contains the expected index file)."""
    sentinel = EXTRACTED_DIR / 'all_deepimmuno_immunogenicity.txt'
    fresh = sentinel.exists() and (time.time() - sentinel.stat().st_mtime) < CACHE_TTL_SECONDS
    if fresh and not FORCE_REFRESH:
        age_h = (time.time() - sentinel.stat().st_mtime) / 3600
        print(f'Using cached Dropbox data at {EXTRACTED_DIR} ({age_h:.1f}h old)')
        return

    EXTRACTED_DIR.parent.mkdir(parents=True, exist_ok=True)
    print(f'Downloading Dropbox folder -> {CACHE_ZIP}')
    url = DROPBOX_URL
    # Force dl=1 so we get the zip instead of the HTML viewer page.
    if 'dl=0' in url:
        url = url.replace('dl=0', 'dl=1')
    elif 'dl=1' not in url:
        sep = '&' if '?' in url else '?'
        url = f'{url}{sep}dl=1'

    req = urllib.request.Request(url, headers={'User-Agent': 'ImmunoVerse-Portal/1.0'})
    with urllib.request.urlopen(req, timeout=600) as resp, open(CACHE_ZIP, 'wb') as f:
        shutil.copyfileobj(resp, f)

    if EXTRACTED_DIR.exists():
        shutil.rmtree(EXTRACTED_DIR)
    EXTRACTED_DIR.mkdir(parents=True, exist_ok=True)

    print(f'Extracting -> {EXTRACTED_DIR}')
    with zipfile.ZipFile(CACHE_ZIP) as zf:
        for member in zf.namelist():
            # Flatten structure and drop absolute paths Dropbox sometimes injects.
            name = os.path.basename(member)
            if not name:
                continue
            with zf.open(member) as src, open(EXTRACTED_DIR / name, 'wb') as dst:
                shutil.copyfileobj(src, dst)
    # Touch sentinel so TTL kicks in.
    sentinel.touch(exist_ok=True)
    print(f'Downloaded and extracted {sum(1 for _ in EXTRACTED_DIR.iterdir())} files.')

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


TRANSCRIPT_CACHE_FILE = EXTRACTED_DIR.parent / 'transcript_genes.json'


def resolve_transcript_genes(extracted_dir):
    """Collect unique ENSTs from rows missing gene_symbol, then batch-lookup
    their parent gene via Ensembl REST. Cached on disk between runs so we
    only ever hit the API for new transcripts.

    This rescues nuORF, splicing, and ERV rows where the raw tables only
    carry a transcript ID (e.g. "ENST00000254051.10_1_17:..._|nuORF" ->
    resolves to TNS4). Failures are tolerated — we just return an empty
    mapping and let the UI fall back to "unknown gene"."""
    import json as _json
    cache = {}
    if TRANSCRIPT_CACHE_FILE.exists():
        try:
            cache = _json.loads(TRANSCRIPT_CACHE_FILE.read_text())
        except Exception:
            cache = {}

    wanted = set()
    for fn in extracted_dir.glob('*_final_enhanced.txt'):
        with open(fn, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f, delimiter='\t')
            for r in reader:
                g = (r.get('gene_symbol') or '').strip()
                if g and g not in ('nan', 'None'):
                    continue
                src = r.get('source') or ''
                for m in re.findall(r'ENST\d+', src):
                    if m not in cache:
                        wanted.add(m)
    if not wanted:
        print(f'  Transcript-gene cache: {len(cache)} resolved (no new lookups needed)')
        return cache

    print(f'  Transcript-gene cache: resolving {len(wanted)} new ENSTs from Ensembl REST...')
    ids = list(wanted)
    batch_size = 1000
    for start in range(0, len(ids), batch_size):
        chunk = ids[start:start + batch_size]
        payload = _json.dumps({'ids': chunk}).encode('utf-8')
        req = urllib.request.Request(
            'https://rest.ensembl.org/lookup/id?expand=0',
            data=payload,
            headers={'Content-Type': 'application/json', 'Accept': 'application/json'},
            method='POST',
        )
        try:
            with urllib.request.urlopen(req, timeout=120) as resp:
                data = _json.loads(resp.read().decode('utf-8'))
            for enst, info in data.items():
                if not info:
                    cache[enst] = None
                    continue
                cache[enst] = {
                    'gene_symbol': (info.get('display_name') or '').split('-')[0],  # TNS4-201 -> TNS4
                    'ensg': info.get('Parent') or '',
                    'biotype': info.get('biotype') or '',
                    # GRCh38 coordinates — needed to build the robust
                    # useast.ensembl.org Gene/Summary URL with r= param.
                    'chrom': info.get('seq_region_name') or '',
                    'start': info.get('start') or 0,
                    'end': info.get('end') or 0,
                    'strand': info.get('strand') or 0,
                    'display_name': info.get('display_name') or '',
                }
        except Exception as e:
            print(f'  [warn] Ensembl REST batch {start}-{start+len(chunk)} failed: {e}')
            # Mark batch so we don't re-try every run.
            for enst in chunk:
                cache.setdefault(enst, None)
    try:
        TRANSCRIPT_CACHE_FILE.parent.mkdir(parents=True, exist_ok=True)
        TRANSCRIPT_CACHE_FILE.write_text(_json.dumps(cache))
    except Exception as e:
        print(f'  [warn] Could not persist transcript cache: {e}')
    resolved = sum(1 for v in cache.values() if v and v.get('gene_symbol'))
    print(f'  Transcript-gene cache: {resolved}/{len(cache)} resolved total')
    return cache


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
    """Normalize HLA allele to standard format: A*01:01

    Handles three input shapes used across the raw files:
      - HLA-A*02:01    (final_enhanced presented_by_each_sample_hla)
      - HLA-A*0201     (DeepImmuno immunogenicity file — no colon)
      - HLA-A0201 / A0201 (metadata sometimes)
    """
    if not allele:
        return None
    a = str(allele).replace('HLA-', '').strip()
    # A*0201 -> A*02:01 (DeepImmuno format — critical: prior bug was dropping these)
    m = re.match(r'^([ABC])\*(\d{2})(\d{2,3})$', a)
    if m:
        a = f'{m.group(1)}*{m.group(2)}:{m.group(3)}'
    else:
        # A0101 -> A*01:01
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


# Canonical tokens that must never be treated as "the gene" — variant_type values
# and format markers that used to sneak through the old suffix regex.
_NOT_GENE_TOKENS = {
    'missense_variant', 'frameshift_variant', 'stop_gained', 'stop_lost',
    'start_lost', 'inframe_insertion', 'inframe_deletion', 'splice_donor_variant',
    'splice_acceptor_variant', 'synonymous_variant', 'nuORF', 'nuorf',
    'anti-sense', 'sense', 'True', 'False', 'None', 'none', 'nan',
}

# Gene aliases — maps raw forms to a canonical display name. Used both for clean
# display and (mirrored in the frontend) for alias-aware search.
GENE_ALIASES = {
    'L1_ORF2': 'LINE1 ORF2',
    'L1-ORF2': 'LINE1 ORF2',
    'L1-orf2': 'LINE1 ORF2',
    'L1_orf2': 'LINE1 ORF2',
    'LINE-1': 'LINE1',
    'LINE_1': 'LINE1',
}


def canonicalize_gene(name):
    """Map raw gene tokens to canonical display form using GENE_ALIASES."""
    if not name:
        return name
    return GENE_ALIASES.get(name, name)


def parse_variant_entries(src):
    """Parse the variant-format sub-records from a `source` string.

    Each variant entry has the shape:
      GENE|p.PROTEIN_CHANGE|N|FLOAT|ENSG|chr:start-end|REF/ALT|variant_type

    Returns a list of dicts — may be multiple (e.g. KRAS/NRAS double-hit).
    """
    if not src:
        return []
    out = []
    for piece in re.split(r';', src):
        parts = piece.split('|')
        if len(parts) < 8:
            continue
        # Heuristic: a variant record starts with a gene symbol and has p.XXX in slot 1
        if not re.match(r'^p\.', parts[1] or ''):
            continue
        vt = parts[-1].strip()
        if vt not in _NOT_GENE_TOKENS and not vt.endswith('_variant'):
            # Allow e.g. "frameshift_variant" but reject non-variant tails.
            continue
        out.append({
            'gene': parts[0].strip(),
            'protein_change': parts[1].strip(),
            'af_count': parts[2].strip(),
            'af_ratio': parts[3].strip(),
            'ensg': parts[4].strip(),
            'location': parts[5].strip(),
            'ref_alt': parts[6].strip(),
            'variant_type': vt,
        })
    return out


# UniProt mnemonic organism-code suffixes seen in this dataset. Most rows lack an
# OS= field, so we map the name-stem suffix to a human-readable label.
ORGANISM_CODES = {
    'FUSNU': 'Fusobacterium nucleatum',
    'HELPY': 'Helicobacter pylori',
    'NEIMU': 'Neisseria mucosa',
    'NEIMA': 'Neisseria meningitidis',
    'NIACI': 'Neisseria cinerea',
    'HCMV':  'Human cytomegalovirus',
    'HCMVM': 'Human cytomegalovirus (Merlin)',
    'HCMVA': 'Human cytomegalovirus (AD169)',
    'HHV1':  'Human herpesvirus 1',
    'HHV4':  'Epstein-Barr virus',
    'HHV5':  'Human cytomegalovirus',
    'HPV16': 'Human papillomavirus 16',
    'HPV18': 'Human papillomavirus 18',
    'HBV':   'Hepatitis B virus',
    'HCV':   'Hepatitis C virus',
    '9BACT': 'Unclassified Bacteria',
    '9CLOT': 'Unclassified Clostridium',
    '9VIRU': 'Unclassified Virus',
    '9FIRM': 'Unclassified Firmicutes',
    '9GAMM': 'Unclassified Gammaproteobacteria',
}


def parse_pathogen_entry(src):
    """Parse UniProt-style pathogen source.

    Two shapes exist in the raw data:
      - minimal:  tr|U7T4X1|U7T4X1_FUSNU
      - full:     tr|ACC|NAME Long protein desc OS=Fuso... OX=123 GN=... PE=4 SV=1
    Returns a dict the drawer can render (organism, protein, accession, gene).
    """
    if not src:
        return None
    head = src.split(';', 1)[0]  # primary entry
    pipe_parts = head.split('|')
    accession = pipe_parts[1] if len(pipe_parts) > 1 else ''
    rest = pipe_parts[2] if len(pipe_parts) > 2 else head

    def grab(tag):
        m = re.search(rf'{tag}=([^=]+?)(?=[A-Z]{{2}}=|$)', rest)
        return m.group(1).strip() if m else ''

    organism = grab('OS')
    gene = grab('GN')
    protein = rest
    # Strip away the TAG= trailers so the protein name is readable.
    protein = re.sub(r'(OS|OX|GN|PE|SV)=.*$', '', protein).strip()

    # Fallback: most rows lack OS=. The name stem (e.g. U7T4X1_FUSNU) encodes
    # the organism via a UniProt mnemonic suffix.
    # UniProt organism codes are 3-5 chars — cap at 5 so we don't eat into
    # the protein description (e.g. "FUSNU" + "DUF4132..." would greedy-match).
    code = ''
    m = re.match(r'^([A-Z0-9]+)_([A-Z0-9]{3,5})', protein)
    if m:
        code = m.group(2)
        if not organism:
            organism = ORGANISM_CODES.get(code, code)
        # Strip the accession_code prefix so `protein` reads as a description,
        # or stays empty for the minimal form (name==stem).
        if protein == m.group(0):
            protein = ''
        else:
            protein = protein[len(m.group(0)):].lstrip(' _')

    # Heuristic re-spacing for the squashed description/organism fields.
    # Break before capitals, before digits after letters, and after digits.
    def _respace(s):
        s = re.sub(r'(?<=[a-z])(?=[A-Z])', ' ', s)
        s = re.sub(r'(?<=[A-Za-z])(?=\d)', ' ', s)
        s = re.sub(r'(?<=\d)(?=[A-Za-z])', ' ', s)
        return s
    if protein:
        protein = _respace(protein)
    if organism:
        organism = _respace(organism)
    return {
        'accession': accession,
        'protein': protein,
        'organism': organism,
        'code': code,
        'gene': gene,
    }


def clean_gene(row, transcript_map=None):
    """Extract clean gene symbol from source/gene_symbol fields.

    Class-aware: variant rows use the structured GENE|p.X|... block;
    pathogen rows fall back to the organism name; other classes use
    gene_symbol first, a suffix-regex on `source`, and finally resolve
    any ENST in the source via `transcript_map` (pre-computed Ensembl
    REST lookup) so nuORF / splicing rows show the real parent gene
    instead of "—".
    """
    cls = (row.get('typ') or '').strip()
    src = row.get('source', '') or ''

    # Variant class: always prefer the structured record (fixes "missense_variant" bug).
    if cls == 'variant':
        variants = parse_variant_entries(src)
        genes = []
        for v in variants:
            g = canonicalize_gene(v['gene'])
            if g and g not in genes:
                genes.append(g)
        if genes:
            return '/'.join(genes[:3])

    # Pathogen class: organism is a better label than the opaque accession.
    if cls == 'pathogen':
        pa = parse_pathogen_entry(src)
        if pa:
            if pa['organism']:
                return pa['organism']
            if pa['protein']:
                return pa['protein'][:60]
            if pa['accession']:
                return pa['accession']

    g = row.get('gene_symbol', '')
    if g and g != 'nan' and g != 'None':
        # May be a Python list repr
        val = safe_eval(g)
        if isinstance(val, (list, tuple)):
            names = [canonicalize_gene(str(x).strip()) for x in val
                     if x and str(x).strip() not in ('nan', 'None', '')]
            return '/'.join(dict.fromkeys(names).keys())  # dedup preserving order
        return canonicalize_gene(str(g).strip())

    # Fallback suffix-regex parse on source (guarded against variant_type tails
    # and purely-numeric trailers that slipped through before).
    if src and src != 'nan':
        found = []
        for piece in re.split(r'[;,]', src):
            m = re.findall(r'\|([A-Za-z0-9\-_.]+)\s*$', piece)
            for hit in m:
                if (hit and not hit.startswith('ENS')
                        and hit not in found
                        and hit not in _NOT_GENE_TOKENS
                        and not hit.endswith('_variant')
                        and not re.fullmatch(r'-?\d+(?:\.\d+)?', hit)):
                    found.append(canonicalize_gene(hit))
        if found:
            return '/'.join(found[:3])

    # Last resort: resolve any ENST in the source to its parent gene via the
    # pre-built transcript_map (Ensembl REST batch lookup). Keeps nuORF and
    # splicing rows from showing an empty gene when all we have is ENST.
    if transcript_map and src:
        for enst in re.findall(r'ENST\d+', src):
            info = transcript_map.get(enst)
            if info and info.get('gene_symbol'):
                return canonicalize_gene(info['gene_symbol'])
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


def build_gene_expression_map(enhanced_file):
    """Pre-pass: collect median_tumor/max_median_gtex from self_gene rows,
    keyed by gene symbol AND ENSG so non-self classes can fall back to
    parent-gene expression (e.g. splicing peptides inheriting PMEL's TCGA/GTEx).

    Each value is (tumor, normal, ensg) — we propagate the parent's ENSG so the
    NYU boxplot URL (which needs ENSG + gene) can render for inherited rows."""
    by_gene = {}
    by_ensg = {}
    with open(enhanced_file, 'r', encoding='utf-8') as f:
        for r in csv.DictReader(f, delimiter='\t'):
            if (r.get('typ') or '').strip() != 'self_gene':
                continue
            t = safe_float(r.get('median_tumor'))
            n = safe_float(r.get('max_median_gtex'))
            if t is None and n is None:
                continue
            ensg_raw = (r.get('ensgs') or '').strip()
            ensg = ensg_raw.split(';')[0].split(',')[0] if ensg_raw.startswith('ENSG') else ''
            g = (r.get('gene_symbol') or '').strip()
            if g and g not in ('nan', 'None'):
                by_gene.setdefault(g, (t, n, ensg))
            if ensg:
                by_ensg.setdefault(ensg, (t, n, ensg))
    return by_gene, by_ensg


def process_cancer(code, immuno_lookup, immuno_stats, transcript_map=None):
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

    # Pre-scan for parent-gene expression so non-self classes get a sensible value.
    expr_by_gene, expr_by_ensg = build_gene_expression_map(enhanced_file)

    rows = []
    detail = {}  # peptide -> [addq, intens, extra_dict]
    class_count = {}
    gene_set = set()

    with open(enhanced_file, 'r', encoding='utf-8') as f:
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
            gene = clean_gene(r, transcript_map)
            ensg = extract_ensg(r)
            atlas = parse_atlas(r)
            nuorf_type = r.get('nuorf_type', '').strip()
            if nuorf_type in ('nan', 'None', ''):
                nuorf_type = ''

            # Parent-gene expression fallback for non-self classes (splicing,
            # variant, ERV, etc.). Also backfill ENSG so the NYU boxplot URL
            # (which needs ENSG + gene) can resolve. Mark inherited for the UI.
            expr_inherited = False
            if cls != 'self_gene' and tumor is None and normal is None:
                lookup = None
                if ensg:
                    lookup = expr_by_ensg.get(ensg)
                if not lookup and gene:
                    for g_part in gene.split('/'):
                        if g_part in expr_by_gene:
                            lookup = expr_by_gene[g_part]
                            break
                if lookup:
                    tumor, normal, parent_ensg = lookup
                    if parent_ensg and not ensg:
                        ensg = parent_ensg
                    expr_inherited = True

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

            # Track immunogenicity lookup stats (diagnostic only).
            for b in bind:
                immuno_stats['total'] += 1
                if b[5] is not None:
                    immuno_stats['hits'] += 1

            # Class-specific extras (mutation, pathogen) surfaced in the drawer.
            extra = {}
            src_raw = r.get('source', '') or ''
            if cls == 'variant':
                muts = parse_variant_entries(src_raw)
                if muts:
                    extra['mutations'] = muts
            if cls == 'pathogen':
                pa = parse_pathogen_entry(src_raw)
                if pa:
                    extra['pathogen'] = pa
            if expr_inherited:
                extra['exprInherited'] = True
            # If we resolved this row's gene via Ensembl REST (nuORF / splicing
            # fallback), surface the transcript metadata so the hero card can
            # build the robust useast.ensembl.org Gene/Summary URL with
            # ?g=ENSG;r=chr:start-end;t=ENST params.
            if transcript_map:
                for enst in re.findall(r'ENST\d+(?:\.\d+)?', src_raw):
                    info = transcript_map.get(enst.split('.')[0])
                    if info and info.get('ensg'):
                        extra['transcriptMeta'] = {
                            'enst': enst,
                            'ensg': info.get('ensg'),
                            'chrom': info.get('chrom'),
                            'start': info.get('start'),
                            'end': info.get('end'),
                            'strand': info.get('strand'),
                            'gene': info.get('gene_symbol'),
                            'biotype': info.get('biotype'),
                            'displayName': info.get('display_name'),
                        }
                        break  # first resolvable transcript is enough
            # Always include a trimmed source string so power users can see
            # the raw annotation (especially for splicing / ERV / nuORF).
            if src_raw and len(src_raw) < 2000:
                extra['source'] = src_raw.strip()

            # Store detail data keyed by peptide. Use a 3-slot list so the
            # drawer can pull [addq, intens, extra] with simple indexing.
            if addq or intens or extra:
                detail[pep] = [addq, intens, extra]

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
    ensure_raw_data()

    print('Loading immunogenicity data...')
    immuno_file = EXTRACTED_DIR / 'all_deepimmuno_immunogenicity.txt'
    immuno_lookup = load_immunogenicity(immuno_file) if immuno_file.exists() else {}

    print('Resolving transcript -> gene via Ensembl REST (cached)...')
    transcript_map = resolve_transcript_genes(EXTRACTED_DIR)

    immuno_stats = {'hits': 0, 'total': 0}
    print('\nProcessing cancers...')
    cancers = []
    for code in sorted(CANCER_META.keys()):
        print(f'\n--- {code} ---')
        meta = process_cancer(code, immuno_lookup, immuno_stats, transcript_map)
        if meta:
            cancers.append(meta)

    build_summary(cancers)
    total = immuno_stats['total'] or 1
    pct = 100 * immuno_stats['hits'] / total
    print(f"\nImmunogenicity coverage: {immuno_stats['hits']:,}/{immuno_stats['total']:,} per-HLA binds ({pct:.1f}%)")
    print('Done! Updated data_js/ and data/ directories.')


if __name__ == '__main__':
    main()
