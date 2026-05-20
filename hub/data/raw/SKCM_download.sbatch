#!/bin/bash
#SBATCH --partition=a100_short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=20:00:00
#SBATCH --mem=50Gb
#SBATCH --job-name="data_transfer"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1


# # MSV000084442_hlathena
# declare -a samples=(
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-002/YJ20180306_SK_HLA_Melanoma_Pat2_2IPs_R1_01.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-002/YJ20180306_SK_HLA_Melanoma_Pat2_2IPs_R1_02.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-002/YJ20180306_SK_HLA_Melanoma_Pat2_2IPs_R2_01.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-002/YJ20180306_SK_HLA_Melanoma_Pat2_2IPs_R2_02.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-005/YY_20180828_SK_HLA_Pat5_Mel_3x5Mio_R1_01.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-005/YY_20180828_SK_HLA_Pat5_Mel_3x5Mio_R1_02.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-005_IFN/YY_20180828_SK_HLA_Pat5_Mel_withIFNy_3x7Mio_R1_01.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-005_IFN/YY_20180828_SK_HLA_Pat5_Mel_withIFNy_3x7Mio_R1_02.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-006/YE_20180622_SK_HLA_Melanoma_P006_2IPsx0p15g_01.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-006/YE_20180622_SK_HLA_Melanoma_P006_2IPsx0p15g_02.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-006_IFN/YE_20180622_SK_HLA_Melanoma_P006_2IPsx0p15g_wIFNy_01.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-006_IFN/YE_20180622_SK_HLA_Melanoma_P006_2IPsx0p15g_wIFNy_02.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-015/GG20160930_CRH_HLA_Patient15_250mlnCells_01.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-015/GG20160930_CRH_HLA_Patient15_250mlnCells_02.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-015/YE_20180726_SK_HLA_Mel_Pat15_6Mio_01.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-015/YE_20180726_SK_HLA_Mel_Pat15_6Mio_02.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-015_IFN/YE_20180726_SK_HLA_Mel_Pat15_6Mio_IFNy_01.raw	
# ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Melanoma/MEL_13240-015_IFN/YE_20180726_SK_HLA_Mel_Pat15_6Mio_IFNy_02.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./MSV000084442_hlathena {}"

# # PXD008937_CD74KD
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD008937/160121_DK_CoOp-PH_H1_CD74siRNA_W_20_DoseFinding_msms2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD008937/160122_DK_CoOp-PH_H1_CD74siRNA_W_Adjusted_20_Rep2_msms6.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD008937/160122_DK_CoOp-PH_H1_CD74siRNA_W_Adjusted_20_Rep3_msms7.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD008937/160122_DK_CoOp-PH_H1_CD74siRNA_W_Adjusted_20_Rep4_msms8.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD008937/160122_DK_CoOp-PH_H1_CD74siRNA_W_Adjusted_20_Rep5_msms9.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD008937/160122_DK_CoOp-PH_H1_CTRLsiRNA_W_Adjusted_20_Rep1_msms1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD008937/160122_DK_CoOp-PH_H1_CTRLsiRNA_W_Adjusted_20_Rep2_msms2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD008937/160122_DK_CoOp-PH_H1_CTRLsiRNA_W_Adjusted_20_Rep3_msms3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD008937/160122_DK_CoOp-PH_H1_CTRLsiRNA_W_Adjusted_20_Rep4_msms4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD008937/160122_DK_CoOp-PH_H1_CTRLsiRNA_W_Adjusted_20_Rep5_msms5.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD008937_CD74KD {}"

# # PXD011766_ERAP1_inhibitor
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD011766/Seq57555_QE3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD011766/Seq57556_QE3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD011766/Seq57557_QE3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD011766/Seq57558_QE3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD011766/Seq57559_QE3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD011766/Seq57560_QE3.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 6 -I {} bash -c "wget -P ./PXD011766_ERAP1_inhibitor {}"


# # PXD013649_Bassani_Sternberg_2020_NC
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170913_QEh1_LC1_CHC_SA_HLAIp_OD5P_ctrl_1_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170913_QEh1_LC1_CHC_SA_HLAIp_OD5P_ctrl_1_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170913_QEh1_LC1_CHC_SA_HLAIp_OD5P_ctrl_2_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170913_QEh1_LC1_CHC_SA_HLAIp_OD5P_ctrl_2_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170913_QEh1_LC1_CHC_SA_HLAIp_OD5P_ctrl_3_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170913_QEh1_LC1_CHC_SA_HLAIp_OD5P_ctrl_3_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170913_QEh1_LC1_CHC_SA_HLAIp_OD5P_ctrl_4_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170913_QEh1_LC1_CHC_SA_HLAIp_OD5P_ctrl_4_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170903_QEh1_LC1_ChC_SA_HLAIp_OMM475_ctrl_1_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170903_QEh1_LC1_ChC_SA_HLAIp_OMM475_ctrl_2_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170903_QEh1_LC1_ChC_SA_HLAIp_OMM475_ctrl_3_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170901_QEh1_LC1_ChC_SA_HLAIp_ONVC_ctrl_1_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170901_QEh1_LC1_ChC_SA_HLAIp_ONVC_ctrl_1_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170901_QEh1_LC1_ChC_SA_HLAIp_ONVC_ctrl_2_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170901_QEh1_LC1_ChC_SA_HLAIp_ONVC_ctrl_2_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170901_QEh1_LC1_ChC_SA_HLAIp_ONVC_ctrl_3_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170901_QEh1_LC1_ChC_SA_HLAIp_ONVC_ctrl_3_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170901_QEh1_LC1_ChC_SA_HLAIp_ONVC_ctrl_4_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20170901_QEh1_LC1_ChC_SA_HLAIp_ONVC_ctrl_4_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180222_QE_HFX_LC2_HLAIp_JMI_SA_Me275_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180222_QE_HFX_LC2_HLAIp_JMI_SA_Me275_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180222_QE_HFX_LC2_HLAIp_JMI_SA_Me290_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180222_QE_HFX_LC2_HLAIp_JMI_SA_Me290_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180721_QEh1_LC1_SA_JMI_HLAIp_T1015A_1_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180721_QEh1_LC1_SA_JMI_HLAIp_T1015A_1_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180721_QEh1_LC1_SA_JMI_HLAIp_T1015A_2_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180721_QEh1_LC1_SA_JMI_HLAIp_T1015A_2_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180721_QEh1_LC1_SA_JMI_HLAIp_T1185B_C1_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180721_QEh1_LC1_SA_JMI_HLAIp_T1185B_C1_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180721_QEh1_LC1_SA_JMI_HLAIp_T1185B_C2_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180721_QEh1_LC1_SA_JMI_HLAIp_T1185B_C3_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180721_QEh1_LC1_SA_JMI_HLAIp_T1185B_C3_R02.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD013649_Bassani_Sternberg_2020_NC {}"

# # PXD015957_PSMB8_PSMB9_immunoproteasome
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/12T_IFN1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/12T_IFN2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/12T_IFN3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/12T_NT1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/12T_NT2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/12T_NT3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/12T_EV1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/12T_EV2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/12T_EV3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/12T_OE1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/12T_OE2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/12T_OE3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/108T_IFN1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/108T_IFN2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/108T_IFN3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/108T_NT1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/108T_NT2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/108T_NT3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/108T_EV1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/108T_EV2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/108T_EV3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/108T_OE1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/108T_OE2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/108T_OE3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/A375_EV1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/A375_EV2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/A375_EV3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/A375_OE1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/A375_OE2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD015957/A375_OE3.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD015957_PSMB8_PSMB9_immunoproteasome {}"


# # PXD024562_PTM
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/06/PXD024562/A375_MHC_IP_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/06/PXD024562/A375_MHC_IP_R2.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 2 -I {} bash -c "wget -P ./PXD024562_PTM {}"


# # PXD020224_w_bumps
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/QEP2_10348_YSA_MD55A3-IFN-1-500-HLA-I_1_311019.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/QEP2_10348_YSA_MD55A3-IFN-2-500-HLA-I_1_311019.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/QEP2_10348_YSA_MD55A3-NT1-HLA-I_1_311019.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/QEP2_10348_YSA_MD55A3-NT2-HLA-I_1_311019.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/QEP2_10348_YSA_MD55A3-W-1-HLA-I_1_311019.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/QEP2_10348_YSA_MD55A3-W-2-HLA-I_1_311019.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/QEP2_11290_YSA_412_1_060520.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/QEP2_11290_YSA_413_1_060520.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/QEP2_11290_YSA_414_1_060520.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/QEP2_11290_YSA_415_1_060520.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/QEP2_11290_YSA_416_1_060520.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/QEP2_11290_YSA_417_1_060520.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD020224/Seq48570_QE3.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD020224_w_bumps {}"

# # MSV000087743_FAIMS_fraction
# declare -a samples=(
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-002_FAIMS/YN20190329_AA_PT2_1p5sec_2CV_10secDE_01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-002_FAIMS/YN20190329_AA_PT2_1p5sec_3CV_10secDE_02.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-002_frx/YY20190422_AA_Pat2_SDB_fxn1_01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-002_frx/YY20190422_AA_Pat2_SDB_fxn1_02.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-002_frx/YY20190422_AA_Pat2_SDB_fxn2_01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-002_frx/YY20190422_AA_Pat2_SDB_fxn2_02.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-002_frx/YY20190422_AA_Pat2_SDB_fxn3_01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-002_frx/YY20190422_AA_Pat2_SDB_fxn3_02.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_Exploris/AG20210511_SR_HLA_2IPs_MEL_13240_011_NAIVE_01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_Exploris/AG20210511_SR_HLA_2IPs_MEL_13240_011_NAIVE_02.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FAIMS_Exploris/AG20210513_SR_FAIMS_HLA_2IPs_MEL_13240_011_NAIVE_01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FAIMS_Exploris/AG20210513_SR_FAIMS_HLA_2IPs_MEL_13240_011_NAIVE_02.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FRX_Exploris/AG20210511_SR_HLA_2IPs_MEL_13240_011_NAIVE_Fxn01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FRX_Exploris/AG20210511_SR_HLA_2IPs_MEL_13240_011_NAIVE_Fxn02.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FRX_Exploris/AG20210511_SR_HLA_2IPs_MEL_13240_011_NAIVE_Fxn03.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FRX_FAIMS_Exploris/AG20210513_SR_FAIMS_HLA_2IPs_MEL_13240_011_NAIVE_Fxn01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FRX_FAIMS_Exploris/AG20210513_SR_FAIMS_HLA_2IPs_MEL_13240_011_NAIVE_Fxn02.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FRX_FAIMS_Exploris/AG20210513_SR_FAIMS_HLA_2IPs_MEL_13240_011_NAIVE_Fxn03.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FRX_FAIMS_Lumos/YY20190516_FAIMS_HLA_Mel_pt11_2IPs_fxn1_01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FRX_FAIMS_Lumos/YY20190516_FAIMS_HLA_Mel_pt11_2IPs_fxn2_01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FRX_FAIMS_Lumos/YY20190516_FAIMS_HLA_Mel_pt11_2IPs_fxn3_01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FRX_Lumos/YY20190515_HLA_Mel_pt11_2IPs_fxn1_01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FRX_Lumos/YY20190515_HLA_Mel_pt11_2IPs_fxn2_01.raw
# ftp://massive.ucsd.edu/v03/MSV000087743/raw/RawMS/Patients/MEL_13240-011_FRX_Lumos/YY20190515_HLA_Mel_pt11_2IPs_fxn3_01.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./MSV000087743_FAIMS_fraction {}"

# # PXD004894_Bassani_Sternberg_native_2016_NC
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140304_EXQ6_MiBa_SA_MM12-HLAp-1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140304_EXQ6_MiBa_SA_MM12-HLAp-2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140306_EXQ6_MiBa_SA_MM12-HLAp-1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140306_EXQ6_MiBa_SA_MM12-HLAp-2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141218_QEp7_MiBa_SA_HLA-I-p_MM_12_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141218_QEp7_MiBa_SA_HLA-I-p_MM_12_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141208_QEp7_MiBa_SA_HLA-I-p_MM15_1_A.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141208_QEp7_MiBa_SA_HLA-I-p_MM15_1_B.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141208_QEp7_MiBa_SA_HLA-I-p_MM15_2_A.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141208_QEp7_MiBa_SA_HLA-I-p_MM15_2_B.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141208_QEp7_MiBa_SA_HLA-I-p_MM15_3_A.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141208_QEp7_MiBa_SA_HLA-I-p_MM15_3_B.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141208_QEp7_MiBa_SA_HLA-I-p_MM15_4_A.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141208_QEp7_MiBa_SA_HLA-I-p_MM15_4_B.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141210_QEp7_MiBa_SA_HLA-I-p_MM15_1_A_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141210_QEp7_MiBa_SA_HLA-I-p_MM15_1_B_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141210_QEp7_MiBa_SA_HLA-I-p_MM15_2_A_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141210_QEp7_MiBa_SA_HLA-I-p_MM15_2_B_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141210_QEp7_MiBa_SA_HLA-I-p_MM15_3_A_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141210_QEp7_MiBa_SA_HLA-I-p_MM15_3_B_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141210_QEp7_MiBa_SA_HLA-I-p_MM15_4_A_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141210_QEp7_MiBa_SA_HLA-I-p_MM15_4_B_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141212_QEp7_MiBa_SA_HLA-I-p_MM16_1_A.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141212_QEp7_MiBa_SA_HLA-I-p_MM16_1_B.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141212_QEp7_MiBa_SA_HLA-I-p_MM16_2_A.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141212_QEp7_MiBa_SA_HLA-I-p_MM16_2_B.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141212_QEp7_MiBa_SA_HLA-I-p_MM16_3_A.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141212_QEp7_MiBa_SA_HLA-I-p_MM16_3_B.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141213_QEp7_MiBa_SA_HLA-I-p_MM16_1_A_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141213_QEp7_MiBa_SA_HLA-I-p_MM16_2_A_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141213_QEp7_MiBa_SA_HLA-I-p_MM16_2_B_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141213_QEp7_MiBa_SA_HLA-I-p_MM16_3_A_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141213_QEp7_MiBa_SA_HLA-I-p_MM16_3_B_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141218_QEp7_MiBa_SA_HLA-I-p_MM_20_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141218_QEp7_MiBa_SA_HLA-I-p_MM_20_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141214_QEp7_MiBa_SA_HLA-I-p_MM21_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141214_QEp7_MiBa_SA_HLA-I-p_MM21_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141214_QEp7_MiBa_SA_HLA-I-p_MM21_3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141215_QEp7_MiBa_SA_HLA-I-p_MMf_1_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141215_QEp7_MiBa_SA_HLA-I-p_MMf_1_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141216_QEp7_MiBa_SA_HLA-I-p_MMf_2_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141216_QEp7_MiBa_SA_HLA-I-p_MMf_2_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141216_QEp7_MiBa_SA_HLA-I-p_MMf_3_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141216_QEp7_MiBa_SA_HLA-I-p_MMf_3_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141214_QEp7_MiBa_SA_HLA-I-p_MMf_4_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141214_QEp7_MiBa_SA_HLA-I-p_MMf_4_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141214_QEp7_MiBa_SA_HLA-I-p_MMf_4_3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141214_QEp7_MiBa_SA_HLA-I-p_MMf_5-2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141214_QEp7_MiBa_SA_HLA-I-p_MMf_5_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141216_QEp7_MiBa_SA_HLA-I-p_MMf_6_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141216_QEp7_MiBa_SA_HLA-I-p_MMf_6_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140304_EXQ6_MiBa_SA_MM3-HLAp-1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140304_EXQ6_MiBa_SA_MM3-HLAp-2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140306_EXQ6_MiBa_SA_MM3-HLAp-1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140306_EXQ6_MiBa_SA_MM3-HLAp-2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141215_QEp7_MiBa_SA_HLA-I-p_MMf_7-2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141215_QEp7_MiBa_SA_HLA-I-p_MMf_7_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141216_QEp7_MiBa_SA_HLA-I-p_MMf_10_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141216_QEp7_MiBa_SA_HLA-I-p_MMf_10_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141218_QEp7_MiBa_SA_HLA-I-p_MMf_11_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141218_QEp7_MiBa_SA_HLA-I-p_MMf_11_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141218_QEp7_MiBa_SA_HLA-I-p_MMf_12_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141218_QEp7_MiBa_SA_HLA-I-p_MMf_12_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141217_QEp7_MiBa_SA_HLA-I-p_MMf_13_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141217_QEp7_MiBa_SA_HLA-I-p_MMf_13_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141215_QEp7_MiBa_SA_HLA-I-p_MMf_15_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141215_QEp7_MiBa_SA_HLA-I-p_MMf_16_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141215_QEp7_MiBa_SA_HLA-I-p_MMf_16_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140304_EXQ6_MiBa_SA_MM4-HLAp-1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140304_EXQ6_MiBa_SA_MM4-HLAp-2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140306_EXQ6_MiBa_SA_MM4-HLAp-1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140306_EXQ6_MiBa_SA_MM4-HLAp-2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141217_QEp7_MiBa_SA_HLA-I-p_MMf_17_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141217_QEp7_MiBa_SA_HLA-I-p_MMf_17_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141214_QEp7_MiBa_SA_HLA-I-p_MMf_18_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141214_QEp7_MiBa_SA_HLA-I-p_MMf_18_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141214_QEp7_MiBa_SA_HLA-I-p_MMf_18_3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141218_QEp7_MiBa_SA_HLA-I-p_MMf_19_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20141218_QEp7_MiBa_SA_HLA-I-p_MMf_19_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140305_EXQ6_MiBa_SA_MM5-HLAp-1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140305_EXQ6_MiBa_SA_MM5-HLAp-2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140306_EXQ6_MiBa_SA_MM5-HLAp-1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140306_EXQ6_MiBa_SA_MM5-HLAp-2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140305_EXQ6_MiBa_SA_MM8-HLAp-1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140305_EXQ6_MiBa_SA_MM8-HLAp-2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140306_EXQ6_MiBa_SA_MM8-HLAp-1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/04/PXD004894/20140306_EXQ6_MiBa_SA_MM8-HLAp-2.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD004894_Bassani_Sternberg_native_2016_NC {}"

# # MSV000084787_nuORF
# declare -a samples=(
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel02_13240-002_20190108_MEL_sel/YG20190108_AA_MEL_sel_Pat2_01.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel02_13240-002_20190108_MEL_sel/YG20190108_AA_MEL_sel_Pat2_02.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel02_13240-002_20190108_MEL_sel_IFN/YG20190108_AA_MEL_sel_Pat2_IFNy_01.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel02_13240-002_20190108_MEL_sel_IFN/YG20190108_AA_MEL_sel_Pat2_IFNy_02.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel02_13240-002_20190419_10IPs/YY20190418_SK_HLA_Mel_Pat002_10x0p17g_pooled_01.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel11_13240-011_2018_2016/GG20160819_CRH_HLA_Patient11_08092016_discoveryTest.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel11_13240-011_2018_2016/GG20160819_CRH_HLA_Patient11_08182016_discoveryTest.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel11_13240-011_2018_2016/GG20160819_CRH_HLA_Patient11_olderSample_discoveryTest.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel11_13240-011_2018_2016/YJ20180308_SK_HLA_Melanoma_Pat11_3IPs_R1_01.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel11_13240-011_2018_2016/YJ20180308_SK_HLA_Melanoma_Pat11_3IPs_R1_02.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel11_13240-011_2018_2016/YJ20180308_SK_HLA_Melanoma_Pat11_3IPs_R2_01.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel11_13240-011_2018_2016/YJ20180308_SK_HLA_Melanoma_Pat11_3IPs_R2_02.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel11_13240-011_20180308_IFN/YJ20180308_SK_HLA_Melanoma_Pat11_withIFNy_3IPs_R1_01.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel11_13240-011_20180308_IFN/YJ20180308_SK_HLA_Melanoma_Pat11_withIFNy_3IPs_R1_02.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel11_13240-011_20180308_IFN/YJ20180308_SK_HLA_Melanoma_Pat11_withIFNy_3IPs_R2_01.raw
# ftp://massive.ucsd.edu/v02/MSV000084787/raw/RAW_patients/Melanoma_HLA/Mel11_13240-011_20180308_IFN/YJ20180308_SK_HLA_Melanoma_Pat11_withIFNy_3IPs_R2_02.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./MSV000084787_nuORF {}"


# PXD022150
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_9649_YSA_62_1_280519.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/Seq48586_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/Seq48584_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/Seq48578_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/Seq48576_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_9649_YSA_56_1_280519.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/Seq48568_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/Seq47091_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/Seq48572_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_9649_YSA_60_1_280519.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_9649_YSA_35_1_280519.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_9649_YSA_39_1_280519.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/Seq47093_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/Seq48582_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_9649_YSA_58_1_280519.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_9649_YSA_45_1_280519.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_10980_YSA_325_1_160220.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_10980_YSA_326_1_160220.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_11483_YSA_449_2_220620.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_11483_YSA_450_2_220620.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_11483_YSA_451_2_220620.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_12247_YSA_526_2_090920.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_11483_YSA_526_1_220620.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD022150/QEP2_11483_YSA_527_1_220620.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD022150 {}"

# phase2_PXD014397
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep3_pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep3_pool10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep3_pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep3_pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep3_pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep3_pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep3_pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep3_pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep3_pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep3_pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_positive_pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_positive_pool10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_positive_pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_positive_pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_positive_pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_positive_pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_positive_pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_positive_pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_positive_pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_positive_pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_negative_pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_negative_pool10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_negative_pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_negative_pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_negative_pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_negative_pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_negative_pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_negative_pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_negative_pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_33_IFN_negative_pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep2_pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep2_pool10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep2_pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep2_pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep2_pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep2_pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep2_pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep2_pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep2_pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190619_PF_Mel_44_IFN_negative_Rep2_pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_DT9_A2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_DT9_A3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_DT9_A4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_DT9_A5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_DT9_A6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_DT9_A7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_DT9_B11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_W632_A2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_W632_A3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_W632_A4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_W632_A5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_W632_A6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_W632_A7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_noIFN_W632_B11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_DT9_A2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_DT9_A3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_DT9_A4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_DT9_A5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_DT9_A6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_DT9_A7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_DT9_B11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_W632_A2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_W632_A3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_W632_A4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_W632_A5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_W632_A6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_W632_A7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/LM44_wIFN_W632_B11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190911_PF_Mel44_IFN_positive_ClassI_Rep1_pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190911_PF_Mel44_IFN_positive_ClassI_Rep1_pool10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190911_PF_Mel44_IFN_positive_ClassI_Rep1_pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190911_PF_Mel44_IFN_positive_ClassI_Rep1_pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190911_PF_Mel44_IFN_positive_ClassI_Rep1_pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190911_PF_Mel44_IFN_positive_ClassI_Rep1_pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190911_PF_Mel44_IFN_positive_ClassI_Rep1_pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190911_PF_Mel44_IFN_positive_ClassI_Rep1_pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190911_PF_Mel44_IFN_positive_ClassI_Rep1_pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190911_PF_Mel44_IFN_positive_ClassI_Rep1_pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120191004_PF_Mel44_IFN_positive_ClassI_Rep2_2_pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120191004_PF_Mel44_IFN_positive_ClassI_Rep2_2_pool10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120191004_PF_Mel44_IFN_positive_ClassI_Rep2_2_pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120191004_PF_Mel44_IFN_positive_ClassI_Rep2_2_pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120191004_PF_Mel44_IFN_positive_ClassI_Rep2_2_pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120191004_PF_Mel44_IFN_positive_ClassI_Rep2_2_pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120191004_PF_Mel44_IFN_positive_ClassI_Rep2_2_pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120191004_PF_Mel44_IFN_positive_ClassI_Rep2_2_pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120191004_PF_Mel44_IFN_positive_ClassI_Rep2_2_pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120191004_PF_Mel44_IFN_positive_ClassI_Rep2_2_pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_53_IFN_negative_pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_53_IFN_negative_pool10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_53_IFN_negative_pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_53_IFN_negative_pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_53_IFN_negative_pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_53_IFN_negative_pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_53_IFN_negative_pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_53_IFN_negative_pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_53_IFN_negative_pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190129_PF_Mel_53_IFN_negative_pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190409_PF_Mel_53_IFN_positive_pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190409_PF_Mel_53_IFN_positive_pool10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190409_PF_Mel_53_IFN_positive_pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190409_PF_Mel_53_IFN_positive_pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190409_PF_Mel_53_IFN_positive_pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190409_PF_Mel_53_IFN_positive_pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190409_PF_Mel_53_IFN_positive_pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190409_PF_Mel_53_IFN_positive_pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190409_PF_Mel_53_IFN_positive_pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/09/PXD014397/F120190409_PF_Mel_53_IFN_positive_pool9.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD014397 {}"

# phase2_PXD036856
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/2900_ML_1913_grd2_130min.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_TC1913-1e8_100min.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/2900_ML_1913_100min.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/2900_ML_1913IFN_190min.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/2900_ML_1913IFN_100min.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/2900_ML_1913_190min.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/2900_ML_1913IFN_grd2_130min.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_TC1913-5e7_100min.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_3998mel_100min_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_3_03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_3998mel_100min_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_3_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_3_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_2_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_2_03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_2_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-029INF_100min_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-029INF_100min_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-029_100min_FAIL.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-029_100min_01.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD036856 {}"

# phase2_PXD043989
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20180222_QE_HFX_LC2_HLAIp_JMI_SA_T1185B_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20180222_QE_HFX_LC2_HLAIp_JMI_SA_T1185B_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20211128_INT001-00616-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20211128_INT001-00616-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20220221_INT001-00654-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20220221_INT001-00654-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20220710_INT001-01471-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20220710_INT001-01471-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20220710_INT001-01182-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20220710_INT001-01182-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20210115_CTE-BIO-00753-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20210115_CTE-BIO-00753-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20210205_CTE-BIO-00752-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20210205_CTE-BIO-00752-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20210205_CTE-BIO-00756-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD043989/20210205_CTE-BIO-00756-HLAIp_R02.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD043989 {}"

# phase2_PXD034017
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2021-04-17_Fusion_26048.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2021-04-17_Fusion_26049.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2021-04-17_Fusion_26054.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2021-04-17_Fusion_26055.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2021-04-17_Fusion_26060.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2021-04-17_Fusion_26061.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2021-04-17_Fusion_26045.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2021-04-17_Fusion_26046.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2021-04-17_Fusion_26051.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2021-04-17_Fusion_26052.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2021-04-17_Fusion_26057.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2021-04-17_Fusion_26058.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-16_Fusion_33085.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-16_Fusion_33086.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-16_Fusion_33097.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-16_Fusion_33098.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-16_Fusion_33109.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-16_Fusion_33110.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-16_Fusion_33091.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-16_Fusion_33092.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-16_Fusion_33103.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-16_Fusion_33104.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-20_Fusion_33174.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-20_Fusion_33175.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-20_Fusion_33214.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-20_Fusion_33215.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-20_Fusion_33226.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-20_Fusion_33227.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-20_Fusion_33208.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-20_Fusion_33209.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-20_Fusion_33220.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-20_Fusion_33221.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-25_Fusion_33285.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-25_Fusion_33286.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-25_Fusion_33291.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/11/PXD034017/2022-07-25_Fusion_33292.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD034017 {}"

# phase2_PXD022949
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_3784Mel_Epitope_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_3784Mel_Epitope_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_3784Mel_Epitope_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_3784Mel_Epitope_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_3784Mel_Epitope_Rep5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_3795Mel_Epitope_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_3795Mel_Epitope_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_3795Mel_Epitope_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_3795Mel_Epitope_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_3795Mel_Epitope_Rep5.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD022949 {}"

# phase2_PXD056367_JPST003393
declare -a samples=(
https://storage.jpostdb.org/JPST003393/MEL02_HLA_I_1.raw
https://storage.jpostdb.org/JPST003393/MEL02_HLA_I_2.raw
https://storage.jpostdb.org/JPST003393/MEL02_HLA_I_3.raw
https://storage.jpostdb.org/JPST003393/MEL03_HLA_I_1.raw
https://storage.jpostdb.org/JPST003393/MEL03_HLA_I_2.raw
https://storage.jpostdb.org/JPST003393/MEL03_HLA_I_3.raw
https://storage.jpostdb.org/JPST003393/MEL04_HLA_I_1.raw
https://storage.jpostdb.org/JPST003393/MEL04_HLA_I_2.raw	
https://storage.jpostdb.org/JPST003393/MEL04_HLA_I_3.raw
https://storage.jpostdb.org/JPST003393/MELC3_HLA_I_1.raw
https://storage.jpostdb.org/JPST003393/MELC3_HLA_I_2.raw	
https://storage.jpostdb.org/JPST003393/MELC3_HLA_I_3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD056367_JPST003393 {}"

# phase2_PXD022020
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD022020/A375-nzuh000402a19101xms1.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD022020 {}"
