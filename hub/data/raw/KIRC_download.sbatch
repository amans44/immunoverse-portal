#!/bin/bash
#SBATCH --partition=a100_short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --mem=100Gb
#SBATCH --job-name="download"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1

# MSV000084442
declare -a samples=(
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/ccRCC/RCC_Pat9/YJ20180316_SK_HLA_RCC_Pat9_4Ips_noAPD_R1_01.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/ccRCC/RCC_Pat9/YJ20180316_SK_HLA_RCC_Pat9_4Ips_noAPD_R1_02.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/ccRCC/RCC_Pat9_IFN/YJ20180316_SK_HLA_RCC_Pat9_IFNy_4Ips_noAPD_R1_01.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/ccRCC/RCC_Pat9_IFN/YJ20180316_SK_HLA_RCC_Pat9_IFNy_4Ips_noAPD_R1_02.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./MSV000084442 {}"

# MSV000087743
declare -a samples=(
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097-104_tumorprimary_frx/AQ20191025_SK_HLA_16097_104_tumorprimary_RCC_2IPsa0p1g_fxn1.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097-104_tumorprimary_frx/AQ20191025_SK_HLA_16097_104_tumorprimary_RCC_2IPsa0p1g_fxn2.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097-104_tumorprimary_frx/AQ20191025_SK_HLA_16097_104_tumorprimary_RCC_2IPsa0p1g_fxn3.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097-105_tumor_frx/AQ20191025_SK_HLA_16097_105_tumor_RCC_2IPsa0p1g_fxn1.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097-105_tumor_frx/AQ20191025_SK_HLA_16097_105_tumor_RCC_2IPsa0p1g_fxn2.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097-105_tumor_frx/AQ20191025_SK_HLA_16097_105_tumor_RCC_2IPsa0p1g_fxn3.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_101_tumor/YY20190424_HLA_16097_101_RCC_2IPsa0p12g_01.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_101_tumor/YY20190425_HLA_16097_101_RCC_2IPsa0p12g_01.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_101_tumor_frx/YY20190426_HLA_16097_101_RCC_2IPsa0p12g_fxn1_01.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_101_tumor_frx/YY20190426_HLA_16097_101_RCC_2IPsa0p12g_fxn1_02.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_101_tumor_frx/YY20190426_HLA_16097_101_RCC_2IPsa0p12g_fxn2_01.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_101_tumor_frx/YY20190426_HLA_16097_101_RCC_2IPsa0p12g_fxn2_02.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_101_tumor_frx/YY20190426_HLA_16097_101_RCC_2IPsa0p12g_fxn3_01.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_101_tumor_frx/YY20190426_HLA_16097_101_RCC_2IPsa0p12g_fxn3_02.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_101_tumor_frx/YY20190426_HLA_16097_101_RCC_2IPsa0p12g_fxnFT_01.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_102_tumor/BD20190726_HLA_16097_102_RCC_2IPs_01.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_102_tumor/BD20190726_HLA_16097_102_RCC_2IPs_02.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_102_tumor_FRX/BD20190726_HLA_16097_102_RCC_2IPs_fxn1_01.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_102_tumor_FRX/BD20190726_HLA_16097_102_RCC_2IPs_fxn1_02.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_102_tumor_FRX/BD20190726_HLA_16097_102_RCC_2IPs_fxn2_01.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_102_tumor_FRX/BD20190726_HLA_16097_102_RCC_2IPs_fxn3_01.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_104_metastasis/AQ20191023_SK_HLA_16097_104_tumormetastasis_RCC_2IPsa0p1g_01.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_104_metastasis/AQ20191023_SK_HLA_16097_104_tumormetastasis_RCC_2IPsa0p1g_02.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_104_Metastasis_frx/AQ20191025_SK_HLA_16097_104_tumormetastasis_RCC_2IPsa0p1g_fxn1.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_104_Metastasis_frx/AQ20191025_SK_HLA_16097_104_tumormetastasis_RCC_2IPsa0p1g_fxn2.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_104_Metastasis_frx/AQ20191025_SK_HLA_16097_104_tumormetastasis_RCC_2IPsa0p1g_fxn3.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_104_tumorprimary/AQ20191023_SK_HLA_16097_104_tumorprimary_RCC_2IPsa0p1g_01.raw
ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/RCC_16097_104_tumorprimary/AQ20191023_SK_HLA_16097_104_tumorprimary_RCC_2IPsa0p1g_02.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./MSV000087743 {}"

# MSV000096406
declare -a samples=(
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/Cell_lines/786O_labelFree/7860_EV_IFN_W632/AL20210722_SR_ccRCC_CL786O_EG_EV_IFN_W632_Fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/Cell_lines/786O_labelFree/7860_EV_IFN_W632/AL20210722_SR_ccRCC_CL786O_EG_EV_IFN_W632_Fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/Cell_lines/786O_labelFree/7860_EV_IFN_W632/AL20210722_SR_ccRCC_CL786O_EG_EV_IFN_W632_Fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/Cell_lines/786O_labelFree/7860_VT_IFN_W632/AL20210722__SR_ccRCC_CL786O_VT_VHL_IFN_W632_Fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/Cell_lines/786O_labelFree/7860_VT_IFN_W632/AL20210722__SR_ccRCC_CL786O_VT_VHL_IFN_W632_Fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/Cell_lines/786O_labelFree/7860_VT_IFN_W632/AL20210722__SR_ccRCC_CL786O_VT_VHL_IFN__W632_Fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/Cell_lines/A498_labelFree/A498_EV_IFN/AQ20220527_MKP_HLAclass1_A458_ERV_IFN_EV_fr1.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/Cell_lines/A498_labelFree/A498_EV_IFN/AQ20220527_MKP_HLAclass1_A458_ERV_IFN_EV_fr2.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/Cell_lines/A498_labelFree/A498_EV_IFN/AQ20220527_MKP_HLAclass1_A458_ERV_IFN_EV_fr3.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/Cell_lines/A498_labelFree/A498_VT_IFN/AQ20220527_MKP_HLAclass1_A458_ERV_IFN_VT_fr1.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/Cell_lines/A498_labelFree/A498_VT_IFN/AQ20220527_MKP_HLAclass1_A458_ERV_IFN_VT_fr2.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/Cell_lines/A498_labelFree/A498_VT_IFN/AQ20220527_MKP_HLAclass1_A458_ERV_IFN_VT_fr3.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_106/RCC_16097_106_tumor_FRX/AA20200205_SK_HLA_16097_106_tumor_RCC_2IPsa0p06g_fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_106/RCC_16097_106_tumor_FRX/AA20200205_SK_HLA_16097_106_tumor_RCC_2IPsa0p06g_fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_106/RCC_16097_106_tumor_FRX/AA20200205_SK_HLA_16097_106_tumor_RCC_2IPsa0p06g_fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_107/RCC_16097_107_tumor_W632_frx/AG20201022_SR_HLA_16097_107_tumor_RCC_W632_2IPsa0p08g_Fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_107/RCC_16097_107_tumor_W632_frx/AG20201022_SR_HLA_16097_107_tumor_RCC_W632_2IPsa0p08g_Fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_107/RCC_16097_107_tumor_W632_frx/AG20201022_SR_HLA_16097_107_tumor_RCC_W632_2IPsa0p08g_Fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_108/RCC_16097_108_tumor_W632_fxn/AG20201114_SR_HLA_16097_108_tumor_primary_RCC_W632_2IPsa0p1g_Fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_108/RCC_16097_108_tumor_W632_fxn/AG20201114_SR_HLA_16097_108_tumor_primary_RCC_W632_2IPsa0p1g_Fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_108/RCC_16097_108_tumor_W632_fxn/AG20201114_SR_HLA_16097_108_tumor_primary_RCC_W632_2IPsa0p1g_Fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_110/RCC_16097_110_tumor_W632_fxn/AD20210127_SR_RCC110_Tumor_W632_Fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_110/RCC_16097_110_tumor_W632_fxn/AD20210127_SR_RCC110_Tumor_W632_Fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_110/RCC_16097_110_tumor_W632_fxn/AD20210127_SR_RCC110_Tumor_W632_Fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_111/RCC_16097_111_tumor_W632_fxn/AG20211005_RCC_16097_111_Tumor_W632_Fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_111/RCC_16097_111_tumor_W632_fxn/AG20211005_RCC_16097_111_Tumor_W632_Fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_111/RCC_16097_111_tumor_W632_fxn/AG20211005_RCC_16097_111_Tumor_W632_Fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_112/RCC_16097_112_tumor_W632_fxn/AG20211005_RCC_16097_112_Tumor_W632_Fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_112/RCC_16097_112_tumor_W632_fxn/AG20211005_RCC_16097_112_Tumor_W632_Fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_112/RCC_16097_112_tumor_W632_fxn/AG20211005_RCC_16097_112_Tumor_W632_Fxn03.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./MSV000096406 {}"

# MSV000096406_faims
declare -a samples=(
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_106/RCC_16097_106_tumor_FRXFAIMS/PC20200211_FAIMS_SK_HLA_16097_106_tumor_2IPs_0p066g_fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_106/RCC_16097_106_tumor_FRXFAIMS/PC20200211_FAIMS_SK_HLA_16097_106_tumor_2IPs_0p066g_fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_106/RCC_16097_106_tumor_FRXFAIMS/PC20200211_FAIMS_SK_HLA_16097_106_tumor_2IPs_0p066g_fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_107/RCC_16097_107_tumor_W632_FAIMS/AG20201020_FAIMS_SR_HLA_16097_107_tumor_RCC_W632_2IPsa0p105g_01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_107/RCC_16097_107_tumor_W632_FAIMS/AG20201020_FAIMS_SR_HLA_16097_107_tumor_RCC_W632_2IPsa0p105g_02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_107/RCC_16097_107_tumor_W632_FAIMS_frx/AG20201021_FAIMS_SR_HLA_16097_107_tumor_RCC_W632_2IPsa0p08g_Fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_107/RCC_16097_107_tumor_W632_FAIMS_frx/AG20201021_FAIMS_SR_HLA_16097_107_tumor_RCC_W632_2IPsa0p08g_Fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_107/RCC_16097_107_tumor_W632_FAIMS_frx/AG20201021_FAIMS_SR_HLA_16097_107_tumor_RCC_W632_2IPsa0p08g_Fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_108/RCC_16097_108_tumor_W632_FAIMS/AG20201110_FAIMS_SR_HLA_16097_108_tumor_primary_RCC_W632_2IPsa0p1g_01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_108/RCC_16097_108_tumor_W632_FAIMS/AG20201110_FAIMS_SR_HLA_16097_108_tumor_primary_RCC_W632_2IPsa0p1g_02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_108/RCC_16097_108_tumor_W632_FAIMS_fxn/AG20201110_FAIMS_SR_HLA_16097_108_tumor_primary_RCC_W632_2IPsa0p1g_Fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_108/RCC_16097_108_tumor_W632_FAIMS_fxn/AG20201110_FAIMS_SR_HLA_16097_108_tumor_primary_RCC_W632_2IPsa0p1g_Fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_108/RCC_16097_108_tumor_W632_FAIMS_fxn/AG20201110_FAIMS_SR_HLA_16097_108_tumor_primary_RCC_W632_2IPsa0p1g_Fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_109/RCC_16097_109_tumor_W632_FAIMS/AG20201216_FAIMS_SR_HLA_16097_109_tumor_RCC_W632_2IPsa0p1g_CV204060_01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_109/RCC_16097_109_tumor_W632_FAIMS/AG20201216_FAIMS_SR_HLA_16097_109_tumor_RCC_W632_2IPsa0p1g_CV5070_01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_109/RCC_16097_109_tumor_W632_FAIMS_frx/AG20201221_FAIMS_SR_HLA_16097_109_tumor_RCC_W632_2IPsa0p1g_CV5070_fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_109/RCC_16097_109_tumor_W632_FAIMS_frx/AG20201221_FAIMS_SR_HLA_16097_109_tumor_RCC_W632_2IPsa0p1g_CV5070_fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_109/RCC_16097_109_tumor_W632_FAIMS_frx/AG20201221_FAIMS_SR_HLA_16097_109_tumor_RCC_W632_2IPsa0p1g_CV5070_fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_110/RCC_16097_110_tumor_W632_FAIMS/AD20210120_FAIMS_SR_RCC110_Tumor_W632_01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_110/RCC_16097_110_tumor_W632_FAIMS/AD20210120_FAIMS_SR_RCC110_Tumor_W632_02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_110/RCC_16097_110_tumor_W632_FAIMS_fxn/AD20210121_FAIMS_SR_RCC110_Tumor_W632_Fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_110/RCC_16097_110_tumor_W632_FAIMS_fxn/AD20210121_FAIMS_SR_RCC110_Tumor_W632_Fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_110/RCC_16097_110_tumor_W632_FAIMS_fxn/AD20210121_FAIMS_SR_RCC110_Tumor_W632_Fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_111/RCC_16097_111_tumor_W632_FAIMS/VL20210930_FAIMS_SR_16097_RCC111_Tumor_W632_01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_111/RCC_16097_111_tumor_W632_FAIMS/VL20210930_FAIMS_SR_16097_RCC111_Tumor_W632_02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_111/RCC_16097_111_tumor_W632_FAIMS_fxn/VL20210928_FAIMS_SR_RCC111_Tumor_W632_Fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_111/RCC_16097_111_tumor_W632_FAIMS_fxn/VL20210928_FAIMS_SR_RCC111_Tumor_W632_Fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_111/RCC_16097_111_tumor_W632_FAIMS_fxn/VL20210928_FAIMS_SR_RCC111_Tumor_W632_Fxn03.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_112/RCC_16097_112_tumor_W632_FAIMS/VL20210930_FAIMS_SR_16097_RCC112_Tumor_W632_01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_112/RCC_16097_112_tumor_W632_FAIMS/VL20210930_FAIMS_SR_16097_RCC112_Tumor_W632_02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_112/RCC_16097_112_tumor_W632_FAIMS_fxn/VL20210928_FAIMS_SR_RCC112_Tumor_W632_Fxn01.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_112/RCC_16097_112_tumor_W632_FAIMS_fxn/VL20210928_FAIMS_SR_RCC112_Tumor_W632_Fxn02.raw
ftp://massive-ftp.ucsd.edu/v07/MSV000096406/raw/Raw/RCC_patient_tumor/RCC_16097_112/RCC_16097_112_tumor_W632_FAIMS_fxn/VL20210928_FAIMS_SR_RCC112_Tumor_W632_Fxn03.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./MSV000096406_faims {}"

# phase2_PXD017149
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/120608_ARDK_RCC792_Tumor_W_10_1sDynExl_Rep1_msms1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/120608_ARDK_RCC792_Tumor_W_10_1sDynExl_Rep2_msms2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/120608_ARDK_RCC792_Tumor_W_10_1sDynExl_Rep3_msms3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/120608_ARDK_RCC792_Tumor_W_10_1sDynExl_Rep4_msms4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/120608_ARDK_RCC792_Tumor_W_10_1sDynExl_Rep5_msms5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/120731_DKAR_RCC318_Tumor_W_20_Rep1_msms1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/120809_DKAR_RCC318_Tumor_W_20_Rep2_msms1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/120809_DKAR_RCC318_Tumor_W_20_Rep3_msms2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/121221_AR_RCC301_Tumor_W_20_Rep1_msms5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/121227_AR_RCC301_Tumor_W_20_Rep2_msms1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/121227_AR_RCC301_Tumor_W_20_Rep3_msms19.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/121227_AR_RCC301_Tumor_W_20_Rep4_msms27.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/121227_AR_RCC301_Tumor_W_20_Rep5_msms35.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/130326_AR_RCC302_Tumor_W_20_Rep1_msms6.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/130326_AR_RCC302_Tumor_W_20_Rep2_msms7.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/130326_AR_RCC302_Tumor_W_20_Rep3_msms8.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/130326_AR_RCC302_Tumor_W_20_Rep4_msms9.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/130326_AR_RCC302_Tumor_W_20_Rep5_msms10.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/131016_AR_RCC1148_Tumor_W_Adjusted_20_Rep1_25cm90min3s_msms5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/131016_AR_RCC1148_Tumor_W_Adjusted_20_Rep2_25cm90min3s_msms7.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/131016_AR_RCC1148_Tumor_W_Adjusted_20_Rep3_25cm90min3s_msms9.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/131016_AR_RCC1148_Tumor_W_Adjusted_20_Rep4_25cm90min3s_msms11.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/131017_AR_RCC1148_Tumor_W_Adjusted_20_Rep5_25cm90min3s_msms2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/131209_AR_RCC247_Tumor_W_20_Rep1_25cm90min3s_msms.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/131217_AR_RCC247_Tumor_W_20_Rep2_25cm90min3s_msms5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/131217_AR_RCC247_Tumor_W_20_Rep3_25cm90min3s_msms6.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/131217_AR_RCC247_Tumor_W_20_Rep4_25cm90min3s_msms7.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/131217_AR_RCC247_Tumor_W_20_Rep5_25cm90min3s_msms8.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140616_AR_RCC1154_Tumor_W_Adjusted_20_Rep1_25cm90min3s_msmsx3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140616_AR_RCC1154_Tumor_W_Adjusted_20_Rep2_25cm90min3s_msms5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140616_AR_RCC1154_Tumor_W_Adjusted_20_Rep3_25cm90min3s_msms7.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140616_AR_RCC1154_Tumor_W_Adjusted_20_Rep4_25cm90min3s_msms9.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140616_AR_RCC1154_Tumor_W_Adjusted_20_Rep5_25cm90min3s_msms11.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140707_AR_RCC1187_Tumor_W_Adjusted_Rep1_25cm90min3s_msms4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140707_AR_RCC1187_Tumor_W_Adjusted_Rep2_25cm90min3s_msms6.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140707_AR_RCC1187_Tumor_W_Adjusted_Rep3_25cm90min3s_msms8.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140707_AR_RCC1187_Tumor_W_Adjusted_Rep4_25cm90min3s_msms10.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140707_AR_RCC1187_Tumor_W_Adjusted_Rep5_25cm90min3s_msms11.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140707_AR_RCC1188_Tumor_W_Adjusted_Rep1_25cm90min3s_msms13.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140707_AR_RCC1188_Tumor_W_Adjusted_Rep2_25cm90min3s_msms15.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140707_AR_RCC1188_Tumor_W_Adjusted_Rep3_25cm90min3s_msms17.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140707_AR_RCC1188_Tumor_W_Adjusted_Rep4_25cm90min3s_msms19.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140707_AR_RCC1188_Tumor_W_Adjusted_Rep5_25cm90min3s_msms20.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140821_AR_RCC1203_Tumor_Mixer_W_20_Rep1_25cm90min3s_msms25.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140821_RCC1223_Tumor_W_Adjusted_20_Rep1_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140821_RCC1223_Tumor_W_Adjusted_20_Rep2_25cm90min3s_msms4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140821_RCC1223_Tumor_W_Adjusted_20_Rep3_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140821_RCC1223_Tumor_W_Adjusted_20_Rep4_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140821_RCC1223_Tumor_W_Adjusted_20_Rep5_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140904_AR_RCC1203_Tumor_Mixer_W_20_Rep2_25cm90min3s_msms34.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140904_AR_RCC1203_Tumor_Mixer_W_20_Rep3_25cm90min3s_msms37.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140904_AR_RCC1203_Tumor_Mixer_W_20_Rep4_25cm90min3s_msms40.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/140904_AR_RCC1203_Tumor_Mixer_W_20_Rep5_25cm90min3s_msms43.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141009_AR_RCC1238_Tumor_W_Adjusted_20_Rep1_25cm90min3s_msms38.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141009_AR_RCC1238_Tumor_W_Adjusted_20_Rep2_25cm90min3s_msms40.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141009_AR_RCC1238_Tumor_W_Adjusted_20_Rep3_25cm90min3s_msms42.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141009_AR_RCC1238_Tumor_W_Adjusted_20_Rep4_25cm90min3s_msms44.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141009_AR_RCC1238_Tumor_W_Adjusted_20_Rep5_25cm90min3s_msms45.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141024_AR_RCC1192_Tumor_W_20_DoseFinding_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141031_AR_RCC1192_Tumor_W_Adjusted_20_Rep2_25cm90min3s_msms11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141031_AR_RCC1192_Tumor_W_Adjusted_20_Rep3_25cm90min3s_msms13.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141031_AR_RCC1192_Tumor_W_Adjusted_20_Rep4_25cm90min3s_msms15.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141031_AR_RCC1192_Tumor_W_Adjusted_20_Rep5_25cm90min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141222_RCC1152_TumorCentre_W_20_DoseFinding_25cm90min3s_msms50.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141228_RCC1170_Tumor_W_Adjusted_20_Rep1_25cm90min3s_msms4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141228_RCC1170_Tumor_W_Adjusted_20_Rep2_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141228_RCC1170_Tumor_W_Adjusted_20_Rep3_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141228_RCC1170_Tumor_W_Adjusted_20_Rep4_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/141228_RCC1170_Tumor_W_Adjusted_20_Rep5_25cm90min3s_msms11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150109_AR_RCC1152_TumorCentre_W_Adjusted_20_Rep2_25cm90min3s_msms40.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150109_AR_RCC1152_TumorCentre_W_Adjusted_20_Rep3_25cm90min3s_msms43.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150109_AR_RCC1152_TumorCentre_W_Adjusted_20_Rep4_25cm90min3s_msms46.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150109_AR_RCC1152_TumorCentre_W_Adjusted_20_Rep5_25cm90min3s_msms49.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150120_MDM_RCC433_Tumor_W_Adjusted_20_Rep1_50cm195min3s_msms5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150120_MDM_RCC433_Tumor_W_Adjusted_20_Rep2_50cm195min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150120_MDM_RCC433_Tumor_W_Adjusted_20_Rep3_50cm195min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150120_MDM_RCC433_Tumor_W_Adjusted_20_Rep4_50cm195min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150120_MDM_RCC433_Tumor_W_Adjusted_20_Rep5_50cm195min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150120_MDM_RCC467_Tumor_W_Adjusted_20_Rep1_50cm195min3s_msms14.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150120_MDM_RCC467_Tumor_W_Adjusted_20_Rep2_50cm195min3s_msms15.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150120_MDM_RCC467_Tumor_W_Adjusted_20_Rep3_50cm195min3s_msms16.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150120_MDM_RCC467_Tumor_W_Adjusted_20_Rep4_50cm195min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150120_MDM_RCC467_Tumor_W_Adjusted_20_Rep5_50cm195min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150210_MDM_RCC246_Tumor_W_12_DoseFinding_50cm195min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150212_MDM_RCC246_Tumor_W_20_Adjusted_Rep2_50cm195min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150212_MDM_RCC246_Tumor_W_20_Adjusted_Rep3_50cm195min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150212_MDM_RCC246_Tumor_W_20_Adjusted_Rep4_50cm195min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150212_MDM_RCC246_Tumor_W_20_Adjusted_Rep5_50cm195min3s_msms11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150212_MDM_RCC451_Tumor_W_20_Adjusted_Rep1_50cm195min3s_msms16.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150212_MDM_RCC451_Tumor_W_20_Adjusted_Rep2_50cm195min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150212_MDM_RCC451_Tumor_W_20_Adjusted_Rep3_50cm195min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150212_MDM_RCC451_Tumor_W_20_Adjusted_Rep4_50cm195min3s_msms19.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150212_MDM_RCC451_Tumor_W_20_Adjusted_Rep5_50cm195min3s_msms20.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150830_MDM_RCC432_Tumor_W_12_DoseFinding_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150904_MDM_RCC432_Tumor_W_20_Adjusted_2_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150904_MDM_RCC432_Tumor_W_20_Adjusted_3_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150904_MDM_RCC432_Tumor_W_20_Adjusted_4_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150904_MDM_RCC432_Tumor_W_20_Adjusted_5_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150911_MDM_RCC456_Tumor_W_12_DoseFinding_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150918_MDM_RCC449_Tumor_W_20_Adjusted_1_25cm90min3s_msms15.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150918_MDM_RCC449_Tumor_W_20_Adjusted_2_25cm90min3s_msms16.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150918_MDM_RCC449_Tumor_W_20_Adjusted_3_25cm90min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150918_MDM_RCC449_Tumor_W_20_Adjusted_4_25cm90min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150918_MDM_RCC449_Tumor_W_20_Adjusted_5_25cm90min3s_msms19.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150925_MDM_RCC455_Tumor_W_20_Adjusted_1_25cm90min3s_msms33.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150925_MDM_RCC455_Tumor_W_20_Adjusted_2_25cm90min3s_msms34.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150925_MDM_RCC455_Tumor_W_20_Adjusted_3_25cm90min3s_msms35.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150925_MDM_RCC455_Tumor_W_20_Adjusted_4_25cm90min3s_msms36.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150925_MDM_RCC455_Tumor_W_20_Adjusted_5_25cm90min3s_msms37.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150925_MDM_RCC456_Tumor_W_12_NonAdjusted_2_25cm90min3s_msms44.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150925_MDM_RCC456_Tumor_W_12_NonAdjusted_3_25cm90min3s_msms45.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150925_MDM_RCC456_Tumor_W_12_NonAdjusted_4_25cm90min3s_msms46.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/150925_MDM_RCC456_Tumor_W_12_NonAdjusted_5_25cm90min3s_msms47.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151009_MDM_RCC245_Tumor_W_20_Adjusted_1_25cm90min3s_msms5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151009_MDM_RCC245_Tumor_W_20_Adjusted_2_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151009_MDM_RCC245_Tumor_W_20_Adjusted_3_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151009_MDM_RCC245_Tumor_W_20_Adjusted_4_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151009_MDM_RCC245_Tumor_W_20_Adjusted_5_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151009_MDM_RCC296_Tumor_W_20_Adjusted_1_25cm90min3s_msms23.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151009_MDM_RCC296_Tumor_W_20_Adjusted_2_25cm90min3s_msms24.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151009_MDM_RCC296_Tumor_W_20_Adjusted_3_25cm90min3s_msms25.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151009_MDM_RCC296_Tumor_W_20_Adjusted_4_25cm90min3s_msms26.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151009_MDM_RCC296_Tumor_W_20_Adjusted_5_25cm90min3s_msms27.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151103_MDM_RCC440_Tumor_W_12_Adjusted1to14_25cm90min_400-650mz_TS3sHCD@25_7s_msms4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151104_MDM_RCC440_Tumor_W_12_Adjusted_Rep2_25cm90min_400-650mz_TS3sHCD@25_7s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151104_MDM_RCC440_Tumor_W_12_Adjusted_Rep3_25cm90min_400-650mz_TS3sHCD@25_7s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151104_MDM_RCC440_Tumor_W_12_Adjusted_Rep4_25cm90min_400-650mz_TS3sHCD@25_7s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151104_MDM_RCC440_Tumor_W_12_Adjusted_Rep5_25cm90min_400-650mz_TS3sHCD@25_7s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151206_MDM_RCC1409_Tumor_W_12_DoseFinding_25cm90min_400-650mz_TS3sCIDqisOT@35_7s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151206_MDM_RCC1438_Tumor_W_12_DoseFinding_25cm90min_400-650mz_TS3sCIDqisOT@25_7s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151209_MDM_RCC1409_Tumor_W_20_Adjusted_1_25cm90min_400-650mz_TS3sCIDqisOT@35_7s_msms5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151209_MDM_RCC1409_Tumor_W_20_Adjusted_2_25cm90min_400-650mz_TS3sCIDqisOT@35_7s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151209_MDM_RCC1409_Tumor_W_20_Adjusted_4_25cm90min_400-650mz_TS3sCIDqisOT@35_7s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151209_MDM_RCC1409_Tumor_W_20_Adjusted_5_25cm90min_400-650mz_TS3sCIDqisOT@35_7s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151213_MDM_RCC1438_Tumor_W_75_NonAdjusted_2_25cm90min_400-650mz_TS3sCIDqisOT@35_7s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151219_MDM_RCC225_Tumor_W_12p5_DoseFinding_25cm90min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC1083_Tumor_W_12p5_DoseFinding_25cm90min3s_msms75.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC160_Tumor_W_20_Adjusted_1_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC160_Tumor_W_20_Adjusted_2_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC160_Tumor_W_20_Adjusted_3_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC160_Tumor_W_20_Adjusted_4_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC160_Tumor_W_20_Adjusted_5_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC168_Tumor_W_20_Adjusted_1_25cm90min3s_msms33.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC168_Tumor_W_20_Adjusted_2_25cm90min3s_msms34.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC168_Tumor_W_20_Adjusted_3_25cm90min3s_msms35.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC168_Tumor_W_20_Adjusted_4_25cm90min3s_msms36.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC168_Tumor_W_20_Adjusted_5_25cm90min3s_msms37.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC224_Tumor_W_20_Adjusted_1_25cm90min3s_msms51.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC224_Tumor_W_20_Adjusted_2_25cm90min3s_msms52.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC224_Tumor_W_20_Adjusted_3_25cm90min3s_msms53.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC224_Tumor_W_20_Adjusted_4_25cm90min3s_msms54.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC224_Tumor_W_20_Adjusted_5_25cm90min3s_msms55.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC225_Tumor_W_12p5_NonAdjusted_2_25cm90min3s_msms21.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC225_Tumor_W_12p5_NonAdjusted_3_25cm90min3s_msms26.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151221_MDM_RCC225_Tumor_W_12p5_NonAdjusted_4_25cm90min3s_msms27.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/151521_MDM_RCC1438_Tumor_W_ReZip_25cm90min3s_msms20.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160105_MDM_RCC1083_Tumor_W_12p5_NonAdjusted_3_25cm90min3s_msm52.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160105_MDM_RCC1083_Tumor_W_12p5_NonAdjusted_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160105_MDM_RCC1086_Tumor_W_20_Adjusted_1_25cm90min3s_msms16.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160105_MDM_RCC1086_Tumor_W_20_Adjusted_2_25cm90min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160105_MDM_RCC1086_Tumor_W_20_Adjusted_3_25cm90min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160105_MDM_RCC1086_Tumor_W_20_Adjusted_4_25cm90min3s_msms19.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160105_MDM_RCC1086_Tumor_W_20_Adjusted_5_25cm90min3s_msms20.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160105_MDM_RCC1444_Tumor_W_20_Adjusted_1_25cm90min3s_msms34.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160105_MDM_RCC1444_Tumor_W_20_Adjusted_2_25cm90min3s_msms35.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160105_MDM_RCC1444_Tumor_W_20_Adjusted_3_25cm90min3s_msms36.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160105_MDM_RCC1444_Tumor_W_20_Adjusted_4_25cm90min3s_msms37.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160105_MDM_RCC1444_Tumor_W_20_Adjusted_5_25cm90min3s_msms38.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160128_MDM_RCC1479_Tumor_W_20_Adjusted_1_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160128_MDM_RCC1479_Tumor_W_20_Adjusted_2_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160128_MDM_RCC1479_Tumor_W_20_Adjusted_3_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160128_MDM_RCC1479_Tumor_W_20_Adjusted_4_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160128_MDM_RCC1479_Tumor_W_20_Adjusted_5_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160128_MDM_RCC1491_Tumor_W_20_Adjusted_1_25cm90min3s_msms24.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160128_MDM_RCC1491_Tumor_W_20_Adjusted_2_25cm90min3s_msms25.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160128_MDM_RCC1491_Tumor_W_20_Adjusted_3_25cm90min3s_msms26.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160128_MDM_RCC1491_Tumor_W_20_Adjusted_4_25cm90min3s_msms27.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160128_MDM_RCC1491_Tumor_W_20_Adjusted_5_25cm90min3s_msms28.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160311_MDM_RCC990_Tumor_W_12p5_DoseFinding_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160314_MDM_RCC1502_Tumor_W_20_1_Adjusted_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160314_MDM_RCC1502_Tumor_W_20_2_Adjusted_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160314_MDM_RCC1502_Tumor_W_20_3_Adjusted_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160314_MDM_RCC1502_Tumor_W_20_4_Adjusted_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160314_MDM_RCC1502_Tumor_W_20_5_Adjusted_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160318_MDM_RCC990_Tumor_W_12p5_NonAdjusted_2_25cm90min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160318_MDM_RCC990_Tumor_W_12p5_NonAdjusted_3_25cm90min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160318_MDM_RCC990_Tumor_W_12p5_NonAdjusted_4_25cm90min3s_msms19.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160318_MDM_RCC990_Tumor_W_12p5_NonAdjusted_5_25cm90min3s_msms20.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160324_MDM_RCC1483_Tumor_W_20_Adjusted_1_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160324_MDM_RCC1483_Tumor_W_20_Adjusted_2_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160324_MDM_RCC1483_Tumor_W_20_Adjusted_3_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160324_MDM_RCC1483_Tumor_W_20_Adjusted_4_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160324_MDM_RCC1483_Tumor_W_20_Adjusted_5_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160324_MDM_RCC1493_Tumor_W_20_Adjusted_1_25cm90min3s_msms28.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160324_MDM_RCC1493_Tumor_W_20_Adjusted_2_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160324_MDM_RCC1493_Tumor_W_20_Adjusted_3_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160324_MDM_RCC1493_Tumor_W_20_Adjusted_4_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160324_MDM_RCC1493_Tumor_W_20_Adjusted_5_25cm90min3s_msms32.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160412_MDM_RCC1005_Tumor_W_12p5_DoseFinding_25cm90min3s_msms13.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160416_MDM_RCC1005_Tumor_W_12p5_NonAdjusted_2_25cm90min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160416_MDM_RCC1005_Tumor_W_12p5_NonAdjusted_3_25cm90min3s_msms19.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160416_MDM_RCC1005_Tumor_W_12p5_NonAdjusted_4_25cm90min3s_msms20.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160416_MDM_RCC1005_Tumor_W_12p5_NonAdjusted_5_25cm90min3s_msms21.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160416_MDM_RCC1405_Tumor_W_20_Adjusted_1_25cm90min3s_msms49.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160416_MDM_RCC1405_Tumor_W_20_Adjusted_2_25cm90min3s_msms50.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160416_MDM_RCC1405_Tumor_W_20_Adjusted_3_25cm90min3s_msms51.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160416_MDM_RCC1405_Tumor_W_20_Adjusted_4_25cm90min3s_msms52.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160416_MDM_RCC1405_Tumor_W_20_Adjusted_5_25cm90min3s_msms53.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160425_MDM_RCC1117_Tumor_W_20_Adjusted_1_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160425_MDM_RCC1117_Tumor_W_20_Adjusted_2_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160425_MDM_RCC1117_Tumor_W_20_Adjusted_3_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160425_MDM_RCC1117_Tumor_W_20_Adjusted_4_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160425_MDM_RCC1117_Tumor_W_20_Adjusted_5_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160425_MDM_RCC1157_Tumor_W_20_Adjusted_1_25cm90min3s_msms28.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160425_MDM_RCC1157_Tumor_W_20_Adjusted_2_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160425_MDM_RCC1157_Tumor_W_20_Adjusted_3_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160425_MDM_RCC1157_Tumor_W_20_Adjusted_4_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160425_MDM_RCC1157_Tumor_W_20_Adjusted_5_25cm90min3s_msms32.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160515_MDM_RCC1060_Tumor_W_12p5_DoseFinding_25cm90min3s_msms34.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC1056_Tumor_W_20_Adjusted_1_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC1056_Tumor_W_20_Adjusted_2_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC1056_Tumor_W_20_Adjusted_3_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC1056_Tumor_W_20_Adjusted_4_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC1056_Tumor_W_20_Adjusted_5_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC1060_Tumor_W_20_Adjusted_2_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC1060_Tumor_W_20_Adjusted_3_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC1060_Tumor_W_20_Adjusted_4_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC1060_Tumor_W_20_Adjusted_5_25cm90min3s_msms32.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC986_Tumor_W_20_Adjusted_1_25cm90min3s_msms60.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC986_Tumor_W_20_Adjusted_2_25cm90min3s_msms61.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC986_Tumor_W_20_Adjusted_3_25cm90min3s_msms62.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC986_Tumor_W_20_Adjusted_4_25cm90min3s_msms63.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160520_MDM_RCC986_Tumor_W_20_Adjusted_5_25cm90min3s_msms64.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160526_MDM_RCC203_Tumor_W_20_Adjusted_1_25cm90min3s_msms28.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160526_MDM_RCC203_Tumor_W_20_Adjusted_2_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160526_MDM_RCC203_Tumor_W_20_Adjusted_3_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160526_MDM_RCC203_Tumor_W_20_Adjusted_4_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160526_MDM_RCC203_Tumor_W_20_Adjusted_5_25cm90min3s_msms32.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160723_MDM_RCC1397_Tumor_W_12p5_DoseFinding_25cm90min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160727_MDM_RCC1355_Tumor_W_20_Adjusted_1_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160727_MDM_RCC1355_Tumor_W_20_Adjusted_2_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160727_MDM_RCC1355_Tumor_W_20_Adjusted_3_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160727_MDM_RCC1355_Tumor_W_20_Adjusted_4_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160727_MDM_RCC1355_Tumor_W_20_Adjusted_5_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160802_MDM_RCC1397_Tumor_W_20_Adjusted_2_25cm90min3s_msms27.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160802_MDM_RCC1397_Tumor_W_20_Adjusted_3_25cm90min3s_msms28.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160802_MDM_RCC1397_Tumor_W_20_Adjusted_4_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160802_MDM_RCC1397_Tumor_W_20_Adjusted_5_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC137_Tumor_W_20_Adjusted_1_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC137_Tumor_W_20_Adjusted_2_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC137_Tumor_W_20_Adjusted_3_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC137_Tumor_W_20_Adjusted_4_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC137_Tumor_W_20_Adjusted_5_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC243_Tumor_W_20_Adjusted_1_25cm90min3s_msms28.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC243_Tumor_W_20_Adjusted_2_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC243_Tumor_W_20_Adjusted_3_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC243_Tumor_W_20_Adjusted_4_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC243_Tumor_W_20_Adjusted_5_25cm90min3s_msms32.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC345_Tumor_W_20_Adjusted_1_25cm90min3s_msms50.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC345_Tumor_W_20_Adjusted_2_25cm90min3s_msms51.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC345_Tumor_W_20_Adjusted_3_25cm90min3s_msms52.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC345_Tumor_W_20_Adjusted_4_25cm90min3s_msms53.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/04/PXD017149/160807_MDM_RCC345_Tumor_W_20_Adjusted_5_25cm90min3s_msms54.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD017149 {}"


# PXD038782_raw
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220329_NHG_malignant_RCC_W6-32_17__orbitrap_DDA_Rep1.raw 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220329_NHG_malignant_RCC_W6-32_17__orbitrap_DDA_Rep2.raw 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220329_NHG_malignant_RCC_W6-32_17__orbitrap_DDA_Rep3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./PXD038782_raw {}"

# PXD038782_d
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220404_NHG_malignant_RCC_W6-32_17__DDA_Rep1.d.tar.gz
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220404_NHG_malignant_RCC_W6-32_17__DDA_Rep2.d.tar.gz	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220404_NHG_malignant_RCC_W6-32_17__DDA_Rep3.d.tar.gz
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./PXD038782_d {}"
for f in *.tar.gz; do tar -xzvf $f; done

# phase2_PXD051880
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD051880/Sara_Feola_human-RCC_s1_786-0-r1-30pc_30min_CEO-truck-MHC_Slot2-10_2023-05-17_1217.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD051880/Sara_Feola_human-RCC_s2_786-0-r1-40pc_30min_CEO-truck-MHC_Slot2-11_2023-05-17_1220.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD051880/Sara_Feola_human-RCC_s3_786-0-r2-30pc_30min_CEO-truck-MHC_Slot2-12_2023-05-17_1223.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD051880/Sara_Feola_human-RCC_s4_786-0-r2-40pc_30min_CEO-truck-MHC_Slot2-13_2023-05-17_1226.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD051880/Sara_Feola_human-RCC_s5_786-0-r3-30pc_30min_CEO-truck-MHC_Slot2-14_2023-05-17_1229.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD051880/Sara_Feola_human-RCC_s6_786-0-r3-40pc_30min_CEO-truck-MHC_Slot2-15_2023-05-17_1232.d.zip
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD051880 {}"

