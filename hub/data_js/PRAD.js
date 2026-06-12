window.IMMUNOVERSE_HUB = window.IMMUNOVERSE_HUB || {};
window.IMMUNOVERSE_HUB["PRAD"] = {
  "code": "PRAD",
  "display": "Prostate Adenocarcinoma",
  "category": "Solid",
  "sample_count": 5,
  "sample_included": 5,
  "cohort_count": 2,
  "biology_count": 3,
  "hla_count": 11,
  "studies": [
    "PXD022020",
    "PXD055544"
  ],
  "biology": [
    "LNCaP_add_B1501_AR_H875Y",
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
      "HLA": "A*01:01,A*24:02,B*13:02,B*55:01,C*01:02,C*06:02",
      "special_note": "",
      "acquisition": "DDA"
    },
    {
      "study": "PXD022020",
      "batch": "",
      "sample": "LNCaP_clone_FGC-nzuh000302a19101xms1.raw",
      "biology": "LNCaP_clone_FGC",
      "HLA": "",
      "special_note": "",
      "acquisition": "DDA"
    },
    {
      "study": "PXD055544",
      "batch": "",
      "sample": "TTP_YS_20031_1776_05122023_06-Dec-23_16-38-15_4709.d",
      "biology": "LNCaP_add_B1501_AR_H875Y",
      "HLA": "A*01:01,A*02:01,B*08:01,B*37:04,B*15:01,C*06:02,C*07:01",
      "special_note": "",
      "acquisition": "DDA"
    },
    {
      "study": "PXD055544",
      "batch": "",
      "sample": "TTP_YS_20031_1777_05122023_06-Dec-23_18-36-18_4710.d",
      "biology": "LNCaP_add_B1501_AR_H875Y",
      "HLA": "A*01:01,A*02:01,B*08:01,B*37:04,B*15:01,C*06:02,C*07:01",
      "special_note": "",
      "acquisition": "DDA"
    },
    {
      "study": "PXD055544",
      "batch": "",
      "sample": "TTP_YS_20031_1778_05122023_06-Dec-23_20-34-23_4711.d",
      "biology": "LNCaP_add_B1501_AR_H875Y",
      "HLA": "A*01:01,A*02:01,B*08:01,B*37:04,B*15:01,C*06:02,C*07:01",
      "special_note": "",
      "acquisition": "DDA"
    }
  ],
  "hla": [
    "A*01:01",
    "A*02:01",
    "A*24:02",
    "B*08:01",
    "B*13:02",
    "B*15:01",
    "B*37:04",
    "B*55:01",
    "C*01:02",
    "C*06:02",
    "C*07:01"
  ]
};
