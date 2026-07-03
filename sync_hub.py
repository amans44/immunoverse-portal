"""
Sync ImmunoVerse Hub data from the NYU public share into hub/data_js/.

Source: https://genome.med.nyu.edu/public/yarmarkovichlab/ImmunoVerse/ImmunoVerse_Hub/
  - {CANCER}_metadata.txt    — TSV: study, batch, sample, biology, HLA, special_note
  - {CANCER}_download.sbatch — SLURM script with raw-file source URLs

Why this exists: the Hub holds *curated but unprocessed* immunopeptidomic
datasets — separate from the main Atlas. Fran adds new cancers/cohorts
periodically; this script picks those up automatically on a daily cron.

The page at /hub loads the per-cancer JSON written here. The raw .txt and
.sbatch files are also mirrored into hub/data/raw/ so the download buttons
on each card can serve them straight from GitHub Pages (no NYU CORS needed).
"""

from __future__ import annotations

import io
import json
import os
import re
import sys
import time
import urllib.error
import urllib.request
from http.client import HTTPException
from pathlib import Path

HUB_URL = 'https://genome.med.nyu.edu/public/yarmarkovichlab/ImmunoVerse/ImmunoVerse_Hub/'

ROOT = Path(os.path.dirname(os.path.abspath(__file__)))
OUT_DIR = ROOT / 'hub' / 'data_js'
RAW_DIR = ROOT / 'hub' / 'data' / 'raw'

# TCGA-style codes → display names used on the Hub cards.
# Codes not in this map fall back to the code itself.
CANCER_DISPLAY = {
    'AML':  'Acute Myeloid Leukemia',
    'BALL': 'B-cell Acute Lymphoblastic Leukemia',
    'BLCA': 'Bladder Urothelial Carcinoma',
    'BRCA': 'Breast Invasive Carcinoma',
    'CESC': 'Cervical Squamous Cell Carcinoma',
    'CHOL': 'Cholangiocarcinoma',
    'CLL':  'Chronic Lymphocytic Leukemia',
    'CML':  'Chronic Myelogenous Leukemia',
    'COAD': 'Colon Adenocarcinoma',
    'DLBC': 'Diffuse Large B-cell Lymphoma',
    'ESCA': 'Esophageal Carcinoma',
    'EWS':  'Ewing Sarcoma',
    'FL':   'Follicular Lymphoma',
    'GBM':  'Glioblastoma Multiforme',
    'HNSC': 'Head and Neck Squamous Cell',
    'KIRC': 'Kidney Renal Clear Cell',
    'LIHC': 'Liver Hepatocellular Carcinoma',
    'LUAD': 'Lung Adenocarcinoma',
    'LUSC': 'Lung Squamous Cell Carcinoma',
    'MCL':  'Mantle Cell Lymphoma',
    'MESO': 'Mesothelioma',
    'MM':   'Multiple Myeloma',
    'NBL':  'Neuroblastoma',
    'OV':   'Ovarian Serous Cystadenocarcinoma',
    'PAAD': 'Pancreatic Adenocarcinoma',
    'PRAD': 'Prostate Adenocarcinoma',
    'RT':   'Rhabdoid Tumor',
    'SKCM': 'Skin Cutaneous Melanoma',
    'STAD': 'Stomach Adenocarcinoma',
    'TALL': 'T-cell Acute Lymphoblastic Leukemia',
    'UCEC': 'Uterine Corpus Endometrial Carcinoma',
    'ependymoma': 'Ependymoma',
    'meningioma': 'Meningioma',
}

# Coarse grouping for the filter chips on the Hub. Codes not listed land in "Solid".
CANCER_CATEGORY = {
    'AML': 'Leukemia', 'BALL': 'Leukemia', 'CLL': 'Leukemia', 'CML': 'Leukemia', 'TALL': 'Leukemia',
    'DLBC': 'Lymphoma', 'FL': 'Lymphoma', 'MCL': 'Lymphoma', 'MM': 'Lymphoma',
    'EWS': 'Sarcoma', 'MESO': 'Sarcoma', 'RT': 'Pediatric', 'NBL': 'Pediatric',
    'GBM': 'CNS', 'ependymoma': 'CNS', 'meningioma': 'CNS',
}

# Match mixed-case filenames (TCGA codes are uppercase, but ependymoma/meningioma
# arrive lowercase from NYU). Keep the original case in the code so paths line up
# with the actual file URLs.
METADATA_RE = re.compile(r'href="([A-Za-z0-9]+)_metadata\.txt"')


# NYU's public share intermittently hangs and then drops the connection
# (http.client.RemoteDisconnected) or 5xx's under load. A single blip used to
# fail the whole daily refresh even though the Dropbox data had already synced,
# so retry transient network/server errors with exponential backoff before
# giving up. 4xx (except 429) is treated as permanent and not retried.
_FETCH_RETRIES = 4
_FETCH_BACKOFF = 5  # seconds; doubles each attempt (5, 10, 20, ...)


def _fetch_text(url: str) -> str:
    req = urllib.request.Request(url, headers={'User-Agent': 'immunoverse-hub-sync/1.0'})
    last_err = None
    for attempt in range(1, _FETCH_RETRIES + 1):
        try:
            with urllib.request.urlopen(req, timeout=60) as resp:
                return resp.read().decode('utf-8', errors='replace')
        except urllib.error.HTTPError as e:
            # NYU's flaky server intermittently answers with a 302 redirect
            # chain that dead-ends in a spurious 404 while it's degraded (seen
            # 2026-07-03: the same URL served 200 minutes later). So 404 is
            # treated as transient here alongside 408/429/5xx. Genuine client
            # errors (400/401/403/405…) won't self-heal — fail fast on those.
            if e.code not in (404, 408, 429) and e.code < 500:
                raise
            last_err = e
        except (urllib.error.URLError, HTTPException, TimeoutError, OSError) as e:
            # Covers RemoteDisconnected, connection resets, DNS/timeout blips.
            last_err = e
        if attempt < _FETCH_RETRIES:
            wait = _FETCH_BACKOFF * (2 ** (attempt - 1))
            print(f'  fetch failed ({last_err}); retry {attempt}/{_FETCH_RETRIES - 1} '
                  f'in {wait}s -> {url}', file=sys.stderr)
            time.sleep(wait)
    raise RuntimeError(f'Failed to fetch {url} after {_FETCH_RETRIES} attempts: {last_err}')


class HubUnreachable(Exception):
    """The NYU listing couldn't be fetched at all (transient infra outage).

    Distinct from a *reachable* listing that has no metadata files, which is a
    genuine layout change and stays fatal.
    """


def list_cancers() -> list[str]:
    """Scrape the NYU directory listing for every CANCER_metadata.txt filename."""
    try:
        html = _fetch_text(HUB_URL)
    except Exception as exc:
        # Couldn't reach NYU even after retries — a transient outage, not a
        # structural change. Bubble up as HubUnreachable so main() can keep the
        # existing hub data and let the (already-succeeded) Atlas refresh commit.
        raise HubUnreachable(exc) from exc
    codes = sorted(set(METADATA_RE.findall(html)))
    if not codes:
        # The listing loaded but has no metadata files — the layout really
        # changed. Fail loudly so it surfaces as a failure email.
        sys.exit('No metadata files found at the NYU Hub URL — has the layout changed?')
    return codes


def parse_metadata(tsv_text: str) -> dict:
    """Parse a Hub metadata.txt into row dicts and aggregate stats."""
    lines = [ln for ln in tsv_text.splitlines() if ln.strip()]
    if not lines:
        return {'rows': [], 'studies': [], 'biology': [], 'hla': [], 'sample_count': 0}

    header = [h.strip() for h in lines[0].split('\t')]
    rows = []
    for line in lines[1:]:
        # Some HLA cells are quoted because they contain commas — split by tab first
        # and strip surrounding quotes after.
        cells = line.split('\t')
        if len(cells) < len(header):
            cells += [''] * (len(header) - len(cells))
        elif len(cells) > len(header):
            cells = cells[:len(header)]
        row = {h: cells[i].strip().strip('"') for i, h in enumerate(header)}
        rows.append(row)

    studies = sorted({r.get('study', '') for r in rows if r.get('study')})
    biology = sorted({r.get('biology', '') for r in rows if r.get('biology')})
    hla_alleles = set()
    for r in rows:
        for a in (r.get('HLA') or '').split(','):
            a = a.strip().strip('"')
            if a:
                hla_alleles.add(a)
    included = sum(1 for r in rows if (r.get('special_note') or '').lower() != 'excluded')

    return {
        'rows': rows,
        'studies': studies,
        'biology': biology,
        'hla': sorted(hla_alleles),
        'sample_count': len(rows),
        'sample_included': included,
    }


def write_outputs(code: str, metadata_text: str, sbatch_text: str, parsed: dict) -> dict:
    """Write per-cancer raw files + JS module. Return summary stats for the index."""
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    RAW_DIR.mkdir(parents=True, exist_ok=True)

    (RAW_DIR / f'{code}_metadata.txt').write_text(metadata_text, encoding='utf-8')
    (RAW_DIR / f'{code}_download.sbatch').write_text(sbatch_text, encoding='utf-8')

    display = CANCER_DISPLAY.get(code, code)
    category = CANCER_CATEGORY.get(code, 'Solid')

    summary = {
        'code': code,
        'display': display,
        'category': category,
        'sample_count': parsed['sample_count'],
        'sample_included': parsed['sample_included'],
        'cohort_count': len(parsed['studies']),
        'biology_count': len(parsed['biology']),
        'hla_count': len(parsed['hla']),
        'studies': parsed['studies'],
        'biology': parsed['biology'][:10],  # cap for UI
        'files': {
            'metadata': f'data/raw/{code}_metadata.txt',
            'sbatch':   f'data/raw/{code}_download.sbatch',
        },
    }

    payload = dict(summary)
    payload['rows'] = parsed['rows']
    payload['hla'] = parsed['hla']

    js_module = f'window.IMMUNOVERSE_HUB = window.IMMUNOVERSE_HUB || {{}};\n' \
                f'window.IMMUNOVERSE_HUB[{json.dumps(code)}] = {json.dumps(payload, indent=2)};\n'
    (OUT_DIR / f'{code}.js').write_text(js_module, encoding='utf-8')
    return summary


def main() -> None:
    try:
        codes = list_cancers()
    except HubUnreachable as exc:
        # NYU is down/flaky right now. Don't fail the whole daily refresh over a
        # transient outage of this *secondary* data source — the primary Atlas
        # sync already ran, and the commit step needs to proceed so those
        # changes go live. Leave the existing hub/data_js/ in place; it will
        # refresh on the next run once NYU recovers.
        print(f'[warn] NYU Hub unreachable ({exc}); keeping the existing '
              f'hub/data_js/ and skipping hub sync this run.', file=sys.stderr)
        return
    print(f'Found {len(codes)} cancers at the Hub.')

    summaries = []
    for code in codes:
        meta_url   = f'{HUB_URL}{code}_metadata.txt'
        sbatch_url = f'{HUB_URL}{code}_download.sbatch'
        try:
            metadata_text = _fetch_text(meta_url)
        except Exception as exc:
            print(f'  [skip] {code}: metadata fetch failed ({exc})')
            continue
        try:
            sbatch_text = _fetch_text(sbatch_url)
        except Exception as exc:
            print(f'  [warn] {code}: missing sbatch ({exc}), continuing without it')
            sbatch_text = ''

        parsed = parse_metadata(metadata_text)
        summary = write_outputs(code, metadata_text, sbatch_text, parsed)
        summaries.append(summary)
        print(f'  [ok]   {code}: {parsed["sample_count"]} samples, '
              f'{len(parsed["studies"])} cohorts, {len(parsed["hla"])} HLAs')

    summaries.sort(key=lambda s: s['display'].lower())
    index = {
        'generated_at_utc': None,  # GitHub Actions can stamp this if desired
        'source_url': HUB_URL,
        'totals': {
            'cancers': len(summaries),
            'samples': sum(s['sample_count'] for s in summaries),
            'cohorts': sum(s['cohort_count'] for s in summaries),
        },
        'cancers': summaries,
    }
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    (OUT_DIR / '_index.js').write_text(
        f'window.IMMUNOVERSE_HUB_INDEX = {json.dumps(index, indent=2)};\n',
        encoding='utf-8',
    )
    print(f'Wrote {len(summaries)} per-cancer JS modules + _index.js to {OUT_DIR}')
    print(f"Totals: {index['totals']}")


if __name__ == '__main__':
    main()
