window.IMMUNOVERSE_HUB = window.IMMUNOVERSE_HUB || {};
window.IMMUNOVERSE_HUB["PRAD"] = {
  "code": "PRAD",
  "display": "Prostate Adenocarcinoma",
  "category": "Solid",
  "sample_count": 2,
  "sample_included": 2,
  "cohort_count": 1,
  "biology_count": 2,
  "hla_count": 6,
  "studies": [
    "PXD022020"
  ],
  "biology": [
    "LNCaP_clone_FGC",
    "PC3"
  ],
  "files": {
    "metadata": "data/raw/PRAD_metadata.txt",
    "sbatch": "data/raw/PRAD_download.sbatch"
  },
  "rows": [
    {
      "study": "PXD022020",
      "batch": "",
      "sample": "PC3-nzuh000502a19101xms1.raw",
      "biology": "PC3",
      "HLA": "A*01:01,A*24:02,B*13:02,B*55:01,C*01:02,C*06:02"
    },
    {
      "study": "PXD022020",
      "batch": "",
      "sample": "LNCaP_clone_FGC-nzuh000302a19101xms1.raw",
      "biology": "LNCaP_clone_FGC",
      "HLA": ""
    }
  ],
  "hla": [
    "A*01:01",
    "A*24:02",
    "B*13:02",
    "B*55:01",
    "C*01:02",
    "C*06:02"
  ]
};
