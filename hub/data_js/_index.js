window.IMMUNOVERSE_HUB_INDEX = {
  "generated_at_utc": null,
  "source_url": "https://genome.med.nyu.edu/public/yarmarkovichlab/ImmunoVerse/ImmunoVerse_Hub/",
  "totals": {
    "cancers": 36,
    "samples": 4673,
    "cohorts": 164
  },
  "cancers": [
    {
      "code": "AML",
      "display": "Acute Myeloid Leukemia",
      "category": "Leukemia",
      "sample_count": 526,
      "sample_included": 526,
      "cohort_count": 6,
      "biology_count": 125,
      "hla_count": 87,
      "studies": [
        "PXD012083_plos_one_npm1_neoantigen",
        "PXD015039_THP1_protocol_optimization",
        "PXD018542_perreault_atypical",
        "PXD038691",
        "phase2_PXD015748",
        "phase2_PXD025716"
      ],
      "biology": [
        "05H143_NPM1fs_FLT3-ITD_DNMT3Amut_IDH1R132",
        "05H149_DNMT3Amut_IDH2R140_RUNX1mut",
        "07H060_NPM1fs_DNMT3Amut_TET2mut",
        "07H063_NPM1fs_FLT3-TKD",
        "07H122_RUNX1mut",
        "07H141_NPM1fs_FLT3-ITD",
        "08H039_ASXL1mut_RUNX1mut",
        "08H053_NPM1fs_FLT3-ITD",
        "10H005_TET2mut",
        "11H008_FLT3-ITD_FLT3-TKD"
      ],
      "files": {
        "metadata": "data/raw/AML_metadata.txt",
        "sbatch": "data/raw/AML_download.sbatch"
      }
    },
    {
      "code": "BALL",
      "display": "B-cell Acute Lymphoblastic Leukemia",
      "category": "Leukemia",
      "sample_count": 43,
      "sample_included": 43,
      "cohort_count": 6,
      "biology_count": 6,
      "hla_count": 21,
      "studies": [
        "PXD000394",
        "PXD007935",
        "PXD009749",
        "PXD009750",
        "PXD009751",
        "PXD009753"
      ],
      "biology": [
        "07H103",
        "10H080",
        "10H118",
        "12H018",
        "SupB15",
        "SupB15_RT_imatinib"
      ],
      "files": {
        "metadata": "data/raw/BALL_metadata.txt",
        "sbatch": "data/raw/BALL_download.sbatch"
      }
    },
    {
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
      }
    },
    {
      "code": "BRCA",
      "display": "Breast Invasive Carcinoma",
      "category": "Solid",
      "sample_count": 264,
      "sample_included": 229,
      "cohort_count": 10,
      "biology_count": 58,
      "hla_count": 44,
      "studies": [
        "PXD000394",
        "PXD009738",
        "PXD023038",
        "PXD023044",
        "phase2_PXD022020",
        "phase2_PXD024965",
        "phase2_PXD025345",
        "phase2_PXD034818",
        "phase2_PXD038165",
        "phase2_PXD057839_FAIMS_DIA"
      ],
      "biology": [
        "1029/17T/ER+/PR+/Her2neg",
        "1097/19T/ER-/PR-/HER-2/neu-neg",
        "1137/18/ER-/PR-/Her2neg",
        "1192/17T/ER+/PR+/Her2neg",
        "1208/18/ER+/PR+/HER-2/neu-neg",
        "1305/19T/ER+/PR+/Her2neg",
        "1478/18/ER-/PR-/Her2neg",
        "1945/18T/ER+/PR+/HER-2/neu-neg",
        "1949/16T/ER-/PR-/HER-2neg",
        "2049/18T/ER-/PR-/HER-2neg"
      ],
      "files": {
        "metadata": "data/raw/BRCA_metadata.txt",
        "sbatch": "data/raw/BRCA_download.sbatch"
      }
    },
    {
      "code": "CESC",
      "display": "Cervical Squamous Cell Carcinoma",
      "category": "Solid",
      "sample_count": 61,
      "sample_included": 61,
      "cohort_count": 3,
      "biology_count": 15,
      "hla_count": 37,
      "studies": [
        "PXD028738",
        "PXD046182",
        "phase2_PXD022020"
      ],
      "biology": [
        "C33",
        "CASKI_HPV16",
        "CT1",
        "CT10",
        "CT2",
        "CT3",
        "CT4",
        "CT5",
        "CT6",
        "CT7"
      ],
      "files": {
        "metadata": "data/raw/CESC_metadata.txt",
        "sbatch": "data/raw/CESC_download.sbatch"
      }
    },
    {
      "code": "CHOL",
      "display": "Cholangiocarcinoma",
      "category": "Solid",
      "sample_count": 5,
      "sample_included": 5,
      "cohort_count": 1,
      "biology_count": 4,
      "hla_count": 3,
      "studies": [
        "PXD016060"
      ],
      "biology": [
        "P2-PDX-p0-1",
        "P2-PDX-p0-2",
        "P2-PDX-p3-1",
        "P2-human biopsy"
      ],
      "files": {
        "metadata": "data/raw/CHOL_metadata.txt",
        "sbatch": "data/raw/CHOL_download.sbatch"
      }
    },
    {
      "code": "CLL",
      "display": "Chronic Lymphocytic Leukemia",
      "category": "Leukemia",
      "sample_count": 348,
      "sample_included": 348,
      "cohort_count": 6,
      "biology_count": 92,
      "hla_count": 49,
      "studies": [
        "MSV000084442",
        "PXD010808",
        "PXD024871",
        "PXD025716",
        "PXD038782_d",
        "PXD038782_raw"
      ],
      "biology": [
        "CLL002",
        "CLL003",
        "CLL_01",
        "CLL_02",
        "CLL_03",
        "CLL_04",
        "CLL_05",
        "CLL_06",
        "CLL_07",
        "CLL_08"
      ],
      "files": {
        "metadata": "data/raw/CLL_metadata.txt",
        "sbatch": "data/raw/CLL_download.sbatch"
      }
    },
    {
      "code": "CML",
      "display": "Chronic Myelogenous Leukemia",
      "category": "Leukemia",
      "sample_count": 111,
      "sample_included": 111,
      "cohort_count": 3,
      "biology_count": 26,
      "hla_count": 40,
      "studies": [
        "MSV000086567",
        "PXD010450",
        "PXD076608"
      ],
      "biology": [
        "BV173",
        "BV173_PP2",
        "BV173_SP600125",
        "BV173_imatinib",
        "K562_A11",
        "UPN01",
        "UPN02",
        "UPN03",
        "UPN04",
        "UPN05"
      ],
      "files": {
        "metadata": "data/raw/CML_metadata.txt",
        "sbatch": "data/raw/CML_download.sbatch"
      }
    },
    {
      "code": "COAD",
      "display": "Colon Adenocarcinoma",
      "category": "Solid",
      "sample_count": 587,
      "sample_included": 481,
      "cohort_count": 19,
      "biology_count": 120,
      "hla_count": 93,
      "studies": [
        "MSV000087927",
        "PXD000394",
        "PXD014017",
        "PXD021755",
        "PXD023805_JPST001069_faims",
        "PXD028309",
        "phase2_PXD009602",
        "phase2_PXD013831",
        "phase2_PXD015947",
        "phase2_PXD016582",
        "phase2_PXD023770_JPST001072",
        "phase2_PXD023771_JPST001066_faims",
        "phase2_PXD023773_JPST001068_faims",
        "phase2_PXD024533_JPST001104",
        "phase2_PXD026573_JPST001211",
        "phase2_PXD033351",
        "phase2_PXD037587",
        "phase2_PXD038165",
        "phase2_PXD071022"
      ],
      "biology": [
        "103T_KRAS_G12V",
        "1055698F_KRAS_G12V_MSI-H",
        "107T_KRAS_G12D",
        "108937A1_BRAF_V600E_MSS",
        "111209A1_KRAS_G12V_MSI-H",
        "1120113F_PIK3CA_Q546K_TP53_R273H_MSS",
        "112T_KRAS_G12D",
        "1136279F_KRAS_G12D_MSS",
        "1146020F_H1047R_MSS",
        "1160100F_KRAS_G12D_MSS"
      ],
      "files": {
        "metadata": "data/raw/COAD_metadata.txt",
        "sbatch": "data/raw/COAD_download.sbatch"
      }
    },
    {
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
      }
    },
    {
      "code": "ependymoma",
      "display": "Ependymoma",
      "category": "CNS",
      "sample_count": 66,
      "sample_included": 66,
      "cohort_count": 1,
      "biology_count": 22,
      "hla_count": 0,
      "studies": [
        "PXD052448"
      ],
      "biology": [
        "EPN-1052",
        "EPN-1085",
        "EPN-1092",
        "EPN-1134",
        "EPN-115",
        "EPN-1398",
        "EPN-1403",
        "EPN-186",
        "EPN-199",
        "EPN-256"
      ],
      "files": {
        "metadata": "data/raw/ependymoma_metadata.txt",
        "sbatch": "data/raw/ependymoma_download.sbatch"
      }
    },
    {
      "code": "ESCA",
      "display": "Esophageal Carcinoma",
      "category": "Solid",
      "sample_count": 28,
      "sample_included": 28,
      "cohort_count": 1,
      "biology_count": 7,
      "hla_count": 25,
      "studies": [
        "PXD031108"
      ],
      "biology": [
        "p181",
        "p216",
        "p430",
        "p454",
        "p489",
        "p711",
        "p716"
      ],
      "files": {
        "metadata": "data/raw/ESCA_metadata.txt",
        "sbatch": "data/raw/ESCA_download.sbatch"
      }
    },
    {
      "code": "EWS",
      "display": "Ewing Sarcoma",
      "category": "Sarcoma",
      "sample_count": 20,
      "sample_included": 20,
      "cohort_count": 1,
      "biology_count": 2,
      "hla_count": 1,
      "studies": [
        "PXD046803"
      ],
      "biology": [
        "SK-N-MC_engineered_A2",
        "SK-N-MC_engineered_A2_IFNr"
      ],
      "files": {
        "metadata": "data/raw/EWS_metadata.txt",
        "sbatch": "data/raw/EWS_download.sbatch"
      }
    },
    {
      "code": "FL",
      "display": "Follicular Lymphoma",
      "category": "Lymphoma",
      "sample_count": 8,
      "sample_included": 8,
      "cohort_count": 1,
      "biology_count": 4,
      "hla_count": 0,
      "studies": [
        "PXD010808"
      ],
      "biology": [
        "FLMS001",
        "FLMS002",
        "FLMS003",
        "FLMS004"
      ],
      "files": {
        "metadata": "data/raw/FL_metadata.txt",
        "sbatch": "data/raw/FL_download.sbatch"
      }
    },
    {
      "code": "GBM",
      "display": "Glioblastoma Multiforme",
      "category": "CNS",
      "sample_count": 98,
      "sample_included": 98,
      "cohort_count": 6,
      "biology_count": 33,
      "hla_count": 46,
      "studies": [
        "MSV000084442_hlathena",
        "PXD003790_inhibit_dna_methylation",
        "PXD008127_plasma_and_tumor",
        "PXD008984_LNZ308_VT",
        "PXD020186_hla_ligand_atlas_gbm",
        "phase2_PXD020079"
      ],
      "biology": [
        "10-002-S1-tissue",
        "11-002-S1-tissue",
        "29_14-tissue",
        "637_13-tissue",
        "BCN-018- tissue",
        "CPH-07- tissue",
        "CPH-08- tissue",
        "CPH-09- tissue",
        "GAPVAC-Leiden-004.1-tissue",
        "GAPVAC-Leiden-005.1-tissue"
      ],
      "files": {
        "metadata": "data/raw/GBM_metadata.txt",
        "sbatch": "data/raw/GBM_download.sbatch"
      }
    },
    {
      "code": "HNSC",
      "display": "Head and Neck Squamous Cell",
      "category": "Solid",
      "sample_count": 151,
      "sample_included": 151,
      "cohort_count": 5,
      "biology_count": 56,
      "hla_count": 26,
      "studies": [
        "PXD016060",
        "PXD033383_OPSCC",
        "PXD036856",
        "PXD038782_d",
        "PXD038782_raw"
      ],
      "biology": [
        "HN1_A03mut_B07mut_B18mut_LOH",
        "HN1_A03mut_B07mut_B18mut_LOH_IFN",
        "HN2",
        "HN2_IFN",
        "HNSCC_TOF",
        "P1-adnexcal-PDX-1",
        "P1-adnexcal-PDX-2",
        "P1-adnexcal-PDX-3",
        "P1-adnexcal-human biopsy-1",
        "P1-adnexcal-human biopsy-2"
      ],
      "files": {
        "metadata": "data/raw/HNSC_metadata.txt",
        "sbatch": "data/raw/HNSC_download.sbatch"
      }
    },
    {
      "code": "KIRC",
      "display": "Kidney Renal Clear Cell",
      "category": "Solid",
      "sample_count": 370,
      "sample_included": 337,
      "cohort_count": 8,
      "biology_count": 72,
      "hla_count": 22,
      "studies": [
        "MSV000084442",
        "MSV000087743",
        "MSV000096406",
        "MSV000096406_faims",
        "PXD038782_d",
        "PXD038782_raw",
        "phase2_PXD017149",
        "phase2_PXD051880"
      ],
      "biology": [
        "786O",
        "786O_VHL_rescue",
        "A498",
        "A498_VHL_rescue",
        "RCC1005",
        "RCC1056",
        "RCC1060",
        "RCC1083",
        "RCC1086",
        "RCC1117"
      ],
      "files": {
        "metadata": "data/raw/KIRC_metadata.txt",
        "sbatch": "data/raw/KIRC_download.sbatch"
      }
    },
    {
      "code": "LIHC",
      "display": "Liver Hepatocellular Carcinoma",
      "category": "Solid",
      "sample_count": 220,
      "sample_included": 220,
      "cohort_count": 5,
      "biology_count": 75,
      "hla_count": 98,
      "studies": [
        "PXD023143",
        "PXD037270",
        "phase2_PXD013057",
        "phase2_PXD029882",
        "phase2_PXD033351"
      ],
      "biology": [
        "HCC023",
        "HCC024",
        "HCC025",
        "HCC026",
        "HCC027",
        "HCC028",
        "HCC030",
        "HCC034",
        "HCC035",
        "HCC036"
      ],
      "files": {
        "metadata": "data/raw/LIHC_metadata.txt",
        "sbatch": "data/raw/LIHC_download.sbatch"
      }
    },
    {
      "code": "LUAD",
      "display": "Lung Adenocarcinoma",
      "category": "Solid",
      "sample_count": 257,
      "sample_included": 257,
      "cohort_count": 14,
      "biology_count": 56,
      "hla_count": 79,
      "studies": [
        "PXD009752_54_55_stm_Perreault",
        "PXD009935_Yifet_tnf_ifn",
        "PXD016060",
        "PXD022949",
        "phase2_PXD022020",
        "phase2_PXD033351",
        "phase2_PXD034772_DIA",
        "phase2_PXD034820",
        "phase2_PXD038165",
        "phase2_PXD043057",
        "phase2_PXD044794",
        "phase2_PXD058303_IPX0010347000",
        "sternberg_2020_nc",
        "sternberg_2023_lung_nc"
      ],
      "biology": [
        "042464T2_LUAD",
        "042512T2_LUSC",
        "042520T2_LUAD",
        "042544T2_LUSC",
        "042908T2_LUAD",
        "045656T2_LUSC",
        "045722T2_LUSC",
        "045770T2_LUAD",
        "045903T2_LUSC",
        "045961T2_LUSC"
      ],
      "files": {
        "metadata": "data/raw/LUAD_metadata.txt",
        "sbatch": "data/raw/LUAD_download.sbatch"
      }
    },
    {
      "code": "LUSC",
      "display": "Lung Squamous Cell Carcinoma",
      "category": "Solid",
      "sample_count": 257,
      "sample_included": 257,
      "cohort_count": 14,
      "biology_count": 56,
      "hla_count": 79,
      "studies": [
        "PXD009752_54_55_stm_Perreault",
        "PXD009935_Yifet_tnf_ifn",
        "PXD016060",
        "PXD022949",
        "phase2_PXD022020",
        "phase2_PXD033351",
        "phase2_PXD034772_DIA",
        "phase2_PXD034820",
        "phase2_PXD038165",
        "phase2_PXD043057",
        "phase2_PXD044794",
        "phase2_PXD058303_IPX0010347000",
        "sternberg_2020_nc",
        "sternberg_2023_lung_nc"
      ],
      "biology": [
        "042464T2_LUAD",
        "042512T2_LUSC",
        "042520T2_LUAD",
        "042544T2_LUSC",
        "042908T2_LUAD",
        "045656T2_LUSC",
        "045722T2_LUSC",
        "045770T2_LUAD",
        "045903T2_LUSC",
        "045961T2_LUSC"
      ],
      "files": {
        "metadata": "data/raw/LUSC_metadata.txt",
        "sbatch": "data/raw/LUSC_download.sbatch"
      }
    },
    {
      "code": "MCL",
      "display": "Mantle Cell Lymphoma",
      "category": "Lymphoma",
      "sample_count": 111,
      "sample_included": 111,
      "cohort_count": 4,
      "biology_count": 26,
      "hla_count": 13,
      "studies": [
        "PXD004746",
        "PXD005704",
        "PXD010808",
        "PXD020750"
      ],
      "biology": [
        "GRANTA_IFN_gamma",
        "GRANTA_control",
        "Human_Jeko",
        "Human_L128",
        "MCL001",
        "MCL005",
        "MCL007",
        "MCL008",
        "MCL012",
        "MCL014"
      ],
      "files": {
        "metadata": "data/raw/MCL_metadata.txt",
        "sbatch": "data/raw/MCL_download.sbatch"
      }
    },
    {
      "code": "meningioma",
      "display": "Meningioma",
      "category": "CNS",
      "sample_count": 37,
      "sample_included": 37,
      "cohort_count": 3,
      "biology_count": 18,
      "hla_count": 45,
      "studies": [
        "PXD006939",
        "PXD009925",
        "PXD013831"
      ],
      "biology": [
        "3779-AMM",
        "3795-BMT",
        "3803-RE",
        "3805-RV",
        "3808-HMC",
        "3830-NJF",
        "3849-BR",
        "3865-DM",
        "3869-GA",
        "3911-ME"
      ],
      "files": {
        "metadata": "data/raw/meningioma_metadata.txt",
        "sbatch": "data/raw/meningioma_download.sbatch"
      }
    },
    {
      "code": "MESO",
      "display": "Mesothelioma",
      "category": "Sarcoma",
      "sample_count": 12,
      "sample_included": 12,
      "cohort_count": 1,
      "biology_count": 7,
      "hla_count": 23,
      "studies": [
        "PXD038273"
      ],
      "biology": [
        "H2452",
        "H28",
        "JL1",
        "MSTO211H",
        "Meso_001",
        "Meso_002",
        "Meso_002_benign"
      ],
      "files": {
        "metadata": "data/raw/MESO_metadata.txt",
        "sbatch": "data/raw/MESO_download.sbatch"
      }
    },
    {
      "code": "MM",
      "display": "Multiple Myeloma",
      "category": "Lymphoma",
      "sample_count": 63,
      "sample_included": 63,
      "cohort_count": 1,
      "biology_count": 5,
      "hla_count": 23,
      "studies": [
        "PXD035324"
      ],
      "biology": [
        "JJN3",
        "LP1",
        "MM1S",
        "RPMI8226",
        "U266"
      ],
      "files": {
        "metadata": "data/raw/MM_metadata.txt",
        "sbatch": "data/raw/MM_download.sbatch"
      }
    },
    {
      "code": "NBL",
      "display": "Neuroblastoma",
      "category": "Pediatric",
      "sample_count": 47,
      "sample_included": 47,
      "cohort_count": 1,
      "biology_count": 16,
      "hla_count": 42,
      "studies": [
        "PXD027182"
      ],
      "biology": [
        "COG-N-415x",
        "COG-N-440x",
        "COG-N-471x",
        "NB-Ebc1",
        "NB-SD",
        "NB_1691",
        "NB_1771",
        "PALVKK",
        "PANXJL",
        "PAPBJE"
      ],
      "files": {
        "metadata": "data/raw/NBL_metadata.txt",
        "sbatch": "data/raw/NBL_download.sbatch"
      }
    },
    {
      "code": "OS",
      "display": "OS",
      "category": "Solid",
      "sample_count": 12,
      "sample_included": 12,
      "cohort_count": 1,
      "biology_count": 2,
      "hla_count": 5,
      "studies": [
        "PXD057839_FAIMS_DIA"
      ],
      "biology": [
        "U2OS",
        "U2OS_ptx"
      ],
      "files": {
        "metadata": "data/raw/OS_metadata.txt",
        "sbatch": "data/raw/OS_download.sbatch"
      }
    },
    {
      "code": "OV",
      "display": "Ovarian Serous Cystadenocarcinoma",
      "category": "Solid",
      "sample_count": 221,
      "sample_included": 221,
      "cohort_count": 7,
      "biology_count": 62,
      "hla_count": 66,
      "studies": [
        "MSV000084442_HLAthena_OV",
        "PXD006939_sternberg_cl",
        "PXD007635_schuster",
        "PXD014062_HGSC",
        "phase2_PXD013831",
        "phase2_PXD036856",
        "phase2_PXD055609"
      ],
      "biology": [
        "Gyn4_OV",
        "Gyn4_OV_IFN",
        "HGSC1",
        "HGSC2",
        "HGSC3",
        "HGSC4",
        "HGSC5",
        "HGSC6",
        "OV1",
        "OVA606"
      ],
      "files": {
        "metadata": "data/raw/OV_metadata.txt",
        "sbatch": "data/raw/OV_download.sbatch"
      }
    },
    {
      "code": "PAAD",
      "display": "Pancreatic Adenocarcinoma",
      "category": "Solid",
      "sample_count": 106,
      "sample_included": 106,
      "cohort_count": 6,
      "biology_count": 22,
      "hla_count": 39,
      "studies": [
        "MSV000091456",
        "MSV000096853",
        "PXD016060",
        "phase2_PXD022020",
        "phase2_PXD054360",
        "phase2_PXD054417"
      ],
      "biology": [
        "C3L-00625",
        "C3L-01031",
        "C3L-01051",
        "P8-PDX-p1",
        "P8-PDX-p2",
        "P8-PDX-p3",
        "P8-human biopsy-1",
        "P8-human biopsy-2",
        "PANC1",
        "PANC1_IFNr"
      ],
      "files": {
        "metadata": "data/raw/PAAD_metadata.txt",
        "sbatch": "data/raw/PAAD_download.sbatch"
      }
    },
    {
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
      }
    },
    {
      "code": "RT",
      "display": "Rhabdoid Tumor",
      "category": "Pediatric",
      "sample_count": 89,
      "sample_included": 89,
      "cohort_count": 1,
      "biology_count": 23,
      "hla_count": 0,
      "studies": [
        "PXD033935"
      ],
      "biology": [
        "ATRT1",
        "ATRT10",
        "ATRT11",
        "ATRT12",
        "ATRT13",
        "ATRT14",
        "ATRT15",
        "ATRT16",
        "ATRT17",
        "ATRT18"
      ],
      "files": {
        "metadata": "data/raw/RT_metadata.txt",
        "sbatch": "data/raw/RT_download.sbatch"
      }
    },
    {
      "code": "schwannoma",
      "display": "schwannoma",
      "category": "Solid",
      "sample_count": 1,
      "sample_included": 1,
      "cohort_count": 1,
      "biology_count": 1,
      "hla_count": 5,
      "studies": [
        "PXD013831"
      ],
      "biology": [
        "3989-HT"
      ],
      "files": {
        "metadata": "data/raw/schwannoma_metadata.txt",
        "sbatch": "data/raw/schwannoma_download.sbatch"
      }
    },
    {
      "code": "SKCM",
      "display": "Skin Cutaneous Melanoma",
      "category": "Solid",
      "sample_count": 487,
      "sample_included": 487,
      "cohort_count": 19,
      "biology_count": 103,
      "hla_count": 65,
      "studies": [
        "MSV000084442_hlathena",
        "MSV000084787_nuORF",
        "MSV000087743_FAIMS_fraction_standard",
        "PXD004894_Bassani_Sternberg_native_2016_NC",
        "PXD008937_CD74KD",
        "PXD011766_ERAP1_inhibitor",
        "PXD013649_Bassani_Sternberg_2020_NC",
        "PXD015957_PSMB8_PSMB9_immunoproteasome",
        "PXD020224_w_bumps",
        "PXD022150",
        "PXD024562_PTM",
        "phase2_PXD014397",
        "phase2_PXD022020",
        "phase2_PXD022949",
        "phase2_PXD034017",
        "phase2_PXD036856",
        "phase2_PXD043989",
        "phase2_PXD043989_DIA",
        "phase2_PXD056367_JPST003393"
      ],
      "biology": [
        "108T_EV",
        "108T_IFN",
        "108T_NT",
        "108T_OE",
        "112 HLA-I",
        "12T_EV",
        "12T_IFN",
        "12T_NT",
        "12T_OE",
        "152A2 HLA-I"
      ],
      "files": {
        "metadata": "data/raw/SKCM_metadata.txt",
        "sbatch": "data/raw/SKCM_download.sbatch"
      }
    },
    {
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
      }
    },
    {
      "code": "TALL",
      "display": "T-cell Acute Lymphoblastic Leukemia",
      "category": "Leukemia",
      "sample_count": 34,
      "sample_included": 34,
      "cohort_count": 2,
      "biology_count": 2,
      "hla_count": 5,
      "studies": [
        "PXD011723",
        "PXD024562"
      ],
      "biology": [
        "Jurkat",
        "Loucy"
      ],
      "files": {
        "metadata": "data/raw/TALL_metadata.txt",
        "sbatch": "data/raw/TALL_download.sbatch"
      }
    },
    {
      "code": "UCS",
      "display": "UCS",
      "category": "Solid",
      "sample_count": 2,
      "sample_included": 2,
      "cohort_count": 1,
      "biology_count": 1,
      "hla_count": 6,
      "studies": [
        "PXD013831"
      ],
      "biology": [
        "OVZW-1P"
      ],
      "files": {
        "metadata": "data/raw/UCS_metadata.txt",
        "sbatch": "data/raw/UCS_download.sbatch"
      }
    },
    {
      "code": "UCEC",
      "display": "Uterine Corpus Endometrial Carcinoma",
      "category": "Solid",
      "sample_count": 16,
      "sample_included": 16,
      "cohort_count": 1,
      "biology_count": 5,
      "hla_count": 11,
      "studies": [
        "PXD036856"
      ],
      "biology": [
        "Gyn-1-UCEC-CNL",
        "Gyn-1-UCEC-CNL-IFNr",
        "Gyn-2-UCEC-POLE",
        "Gyn-2-UCEC-POLE-IFNr",
        "Gyn-3-UCEC-POLE-Amut-Bloh"
      ],
      "files": {
        "metadata": "data/raw/UCEC_metadata.txt",
        "sbatch": "data/raw/UCEC_download.sbatch"
      }
    }
  ]
};
