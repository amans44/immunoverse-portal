window.IMMUNOVERSE_HUB = window.IMMUNOVERSE_HUB || {};
window.IMMUNOVERSE_HUB["STAD"] = {
  "code": "STAD",
  "display": "Stomach Adenocarcinoma",
  "category": "Solid",
  "sample_count": 2,
  "sample_included": 2,
  "cohort_count": 1,
  "biology_count": 2,
  "hla_count": 6,
  "studies": [
    "PXD016060"
  ],
  "biology": [
    "P4-PDX",
    "P4-human biopsy"
  ],
  "files": {
    "metadata": "data/raw/STAD_metadata.txt",
    "sbatch": "data/raw/STAD_download.sbatch"
  },
  "rows": [
    {
      "study": "PXD016060",
      "batch": "",
      "sample": "Seq48144_QE2.raw",
      "biology": "P4-human biopsy",
      "HLA": "A*02:01,A*23:01,B*38:01,B*44:03,C*04:01,C*12:03",
      "special_note": ""
    },
    {
      "study": "PXD016060",
      "batch": "",
      "sample": "Seq48145_QE2.raw",
      "biology": "P4-PDX",
      "HLA": "A*02:01,A*23:01,B*38:01,B*44:03,C*04:01,C*12:03",
      "special_note": ""
    }
  ],
  "hla": [
    "A*02:01",
    "A*23:01",
    "B*38:01",
    "B*44:03",
    "C*04:01",
    "C*12:03"
  ]
};
