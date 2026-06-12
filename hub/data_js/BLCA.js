window.IMMUNOVERSE_HUB = window.IMMUNOVERSE_HUB || {};
window.IMMUNOVERSE_HUB["BLCA"] = {
  "code": "BLCA",
  "display": "Bladder Urothelial Carcinoma",
  "category": "Solid",
  "sample_count": 2,
  "sample_included": 2,
  "cohort_count": 1,
  "biology_count": 2,
  "hla_count": 4,
  "studies": [
    "PXD016060"
  ],
  "biology": [
    "P7-PDX",
    "P7-human-biopsy"
  ],
  "files": {
    "metadata": "data/raw/BLCA_metadata.txt",
    "sbatch": "data/raw/BLCA_download.sbatch"
  },
  "rows": [
    {
      "study": "PXD016060",
      "batch": "",
      "sample": "Seq48519_QE2.raw",
      "biology": "P7-human-biopsy",
      "HLA": "A*25:01,B*18:01,B*38:01,C*12:03",
      "special_note": "",
      "acquisition": "DDA"
    },
    {
      "study": "PXD016060",
      "batch": "",
      "sample": "Seq48520_QE2.raw",
      "biology": "P7-PDX",
      "HLA": "A*25:01,B*18:01,B*38:01,C*12:03",
      "special_note": "",
      "acquisition": "DDA"
    }
  ],
  "hla": [
    "A*25:01",
    "B*18:01",
    "B*38:01",
    "C*12:03"
  ]
};
