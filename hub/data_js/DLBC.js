window.IMMUNOVERSE_HUB = window.IMMUNOVERSE_HUB || {};
window.IMMUNOVERSE_HUB["DLBC"] = {
  "code": "DLBC",
  "display": "Diffuse Large B-cell Lymphoma",
  "category": "Lymphoma",
  "sample_count": 6,
  "sample_included": 6,
  "cohort_count": 1,
  "biology_count": 3,
  "hla_count": 12,
  "studies": [
    "PXD020620_cell_line"
  ],
  "biology": [
    "DOHH2",
    "HBL1",
    "SUDHL4"
  ],
  "files": {
    "metadata": "data/raw/DLBC_metadata.txt",
    "sbatch": "data/raw/DLBC_download.sbatch"
  },
  "rows": [
    {
      "study": "PXD020620_cell_line",
      "batch": "",
      "sample": "DOHH2_400M_050219_1.raw",
      "biology": "DOHH2",
      "HLA": "A*01:01,B*08:01,B*44:02,C*07:01,C*07:04",
      "special_note": "",
      "acquisition": "DDA"
    },
    {
      "study": "PXD020620_cell_line",
      "batch": "",
      "sample": "DOHH2_400M_050219_2.raw",
      "biology": "DOHH2",
      "HLA": "A*01:01,B*08:01,B*44:02,C*07:01,C*07:04",
      "special_note": "",
      "acquisition": "DDA"
    },
    {
      "study": "PXD020620_cell_line",
      "batch": "",
      "sample": "HBL1_DMSO_200M_050219_1.raw",
      "biology": "HBL1",
      "HLA": "A*02:06,B*51:01,C*14:02",
      "special_note": "",
      "acquisition": "DDA"
    },
    {
      "study": "PXD020620_cell_line",
      "batch": "",
      "sample": "HBL1_DMSO_200M_050219_2.raw",
      "biology": "HBL1",
      "HLA": "A*02:06,B*51:01,C*14:02",
      "special_note": "",
      "acquisition": "DDA"
    },
    {
      "study": "PXD020620_cell_line",
      "batch": "",
      "sample": "SUDHL4_400M_050219_1.raw",
      "biology": "SUDHL4",
      "HLA": "A*02:01,A*31:01,B*15:01,C*03:04",
      "special_note": "",
      "acquisition": "DDA"
    },
    {
      "study": "PXD020620_cell_line",
      "batch": "",
      "sample": "SUDHL4_400M_050219_2.raw",
      "biology": "SUDHL4",
      "HLA": "A*02:01,A*31:01,B*15:01,C*03:04",
      "special_note": "",
      "acquisition": "DDA"
    }
  ],
  "hla": [
    "A*01:01",
    "A*02:01",
    "A*02:06",
    "A*31:01",
    "B*08:01",
    "B*15:01",
    "B*44:02",
    "B*51:01",
    "C*03:04",
    "C*07:01",
    "C*07:04",
    "C*14:02"
  ]
};
