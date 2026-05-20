#!/bin/bash
#SBATCH --partition=a100_dev
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=04:00:00
#SBATCH --mem=20Gb
#SBATCH --job-name="data_transfer"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1


# MSV000084442_hlathena
declare -a samples=(
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4198_BT187/YE_20180622_SK_HLA_GBM_H4198BT187_6IPs_40Mio_01.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4198_BT187/YE_20180622_SK_HLA_GBM_H4198BT187_6IPs_40Mio_02.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4198_BT187/YE_20180622_SK_HLA_GBM_H4198BT187_6IPs_40Mio_03.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4198_BT187/YE_20180622_SK_HLA_GBM_H4198BT187_6IPs_40Mio_04.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4198_BT187_IFN/YE_20180622_SK_HLA_GBM_H4198BT187_IFNy_6IPs_40Mio_01.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4198_BT187_IFN/YE_20180622_SK_HLA_GBM_H4198BT187_IFNy_6IPs_40Mio_02.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4198_BT187_IFN/YE_20180622_SK_HLA_GBM_H4198BT187_IFNy_6IPs_40Mio_03.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4198_BT187_IFN/YE_20180622_SK_HLA_GBM_H4198BT187_IFNy_6IPs_40Mio_04.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4512_BT145/YE_20180622_SK_HLA_GBM_H4512BT145_4IPs_50Mio_01.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4512_BT145/YE_20180622_SK_HLA_GBM_H4512BT145_4IPs_50Mio_02.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4512_BT145/YE_20180622_SK_HLA_GBM_H4512BT145_4IPs_50Mio_03.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4512_BT145_IFN/YE_20180622_SK_HLA_GBM_H4512BT145_IFNy_4IPs_50Mio_01.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4512_BT145_IFN/YE_20180622_SK_HLA_GBM_H4512BT145_IFNy_4IPs_50Mio_02.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_H4512_BT145_IFN/YE_20180622_SK_HLA_GBM_H4512BT145_IFNy_4IPs_50Mio_03.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_Pat7/FE20170912_SK_HLA_GBM7_01.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_Pat7/FE20170912_SK_HLA_GBM7_02.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_Pat7_IFN/FE20170912_SK_HLA_GBM7_INFy_01.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/GBM/GBM_Pat7_IFN/FE20170912_SK_HLA_GBM7_INFy_02.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./MSV000084442_hlathena {}"

# PXD003790_inhibit_dna_methylation
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44762_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44763_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44764_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44765_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44766_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44767_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44768_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44769_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44770_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44771_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44772_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44773_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44774_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44775_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44776_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44777_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44778_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/07/PXD003790/Seq44779_QE2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD003790_inhibit_dna_methylation {}"

# PXD008127_plasma_and_tumor
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD008127/Seq47973_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD008127/Seq47941_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD008127/Seq43476_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD008127/Seq43478_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD008127/Seq43459_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD008127/Seq43462_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD008127/Seq43465_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD008127/Seq43468_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD008127/Seq43471_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/06/PXD008127/Seq43474_QE2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD008127_plasma_and_tumor {}"


# PXD008984_LNZ308_VT
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT_class1_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT_class1_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT_class1_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT_class1_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT_class1_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT-VT_class1_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT-VT_class1_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT-VT_class1_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT-VT_class1_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT-VT_class1_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT-VT-RT_class1_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT-VT-RT_class1_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT-VT-RT_class1_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT-VT-RT_class1_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_CT-VT-RT_class1_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_RT_class1_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_RT_class1_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_RT_class1_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_RT_class1_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_RT_class1_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_VT_class1_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_VT_class1_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_VT_class1_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_VT_class1_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/02/PXD008984/LNZ308_VT_class1_5.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD008984_LNZ308_VT {}"


# PXD020186_hla_ligand_atlas_gbm
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD020186/QJWMX154AE_MS1_170220_AM_KK_GBMZH616_20_W_DDA1_450650mz_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD020186/QJWMX154AE_MS2_170620_AM_KK_GBMZH616_20_W_DDA1_450650mz_msms4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD020186/QJWMX154AE_MS3_170620_AM_KK_GBMZH616_20_W_DDA1_450650mz_msms5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD020186/QJWMX161AV_MS1_170703_LF_KK_GBMZH654_20_W_DDA1new_400650mz_msms16.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD020186/QJWMX161AV_MS2_170703_LF_KK_GBMZH654_20_W_DDA2_400650mz_msms14.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD020186/QJWMX161AV_MS3_170703_LF_KK_GBMZH654_20_W_DDA3_400650mz_msms15.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD020186/QJWMX177AI_MS1_180602_LF_KK_GBMZH753_W_20_DDA_1_400650mz_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD020186/QJWMX177AI_MS2_180602_LF_KK_GBMZH753_W_20_DDA_2_400650mz_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD020186/QJWMX177AI_MS3_180602_LF_KK_GBMZH753_W_20_DDA_3_400650mz_msms3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD020186_hla_ligand_atlas_gbm {}"

# phase2_PXD020079
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180504_QEh1_LC1_QC_JMI_HLAIp_HROG17_2_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180504_QEh1_LC1_QC_JMI_HLAIp_HROG17_2_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180504_QEh1_LC1_QC_JMI_HLAIp_HROG17_1_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180504_QEh1_LC1_QC_JMI_HLAIp_HROG17_1_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180504_QEh1_LC1_QC_JMI_HLAIp_HROG02_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180504_QEh1_LC1_QC_JMI_HLAIp_HROG02_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180205_QEh1_LC1_HLAIp_SA_JMI_RA_1_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180205_QEh1_LC1_HLAIp_SA_JMI_RA_1_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180205_QEh1_LC1_HLAIp_SA_JMI_RA_2_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180205_QEh1_LC1_HLAIp_SA_JMI_RA_2_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180205_QEh1_LC1_HLAIp_SA_JMI_RA_3_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180205_QEh1_LC1_HLAIp_SA_JMI_RA_3_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180206_QEh1_LC1_HLAIp_SA_JMI_RAx_1_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180206_QEh1_LC1_HLAIp_SA_JMI_RAx_1_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180206_QEh1_LC1_HLAIp_SA_JMI_RAx_2_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180206_QEh1_LC1_HLAIp_SA_JMI_RAx_2_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180206_QEh1_LC1_HLAIp_SA_JMI_RAx_3_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/02/PXD020079/20180206_QEh1_LC1_HLAIp_SA_JMI_RAx_3_R2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD020079 {}"



