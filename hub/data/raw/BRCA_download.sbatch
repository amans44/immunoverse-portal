#!/bin/bash
#SBATCH --partition=a100_short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=1-00:00:00
#SBATCH --mem=50Gb
#SBATCH --job-name="brest-cancer_transfer-short"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1

# # PXD023038
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep1_pool1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep1_pool2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep1_pool3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep1_pool4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep1_pool5.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep1_pool6.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep2_pool1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep2_pool2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep2_pool3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep2_pool4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep2_pool5.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep2_pool6.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep3_pool1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep3_pool2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep3_pool3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep3_pool4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep3_pool5.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-negative_DDA_rep3_pool6.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep1_pool1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep1_pool2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep1_pool3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep1_pool4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep1_pool5.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep1_pool6.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep2_pool1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep2_pool2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep2_pool3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep2_pool4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep2_pool5.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep2_pool6.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep3_pool2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep3_pool3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep3_pool4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep3_pool5.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023038/F120190510_PF_TNBC_IFN-positive_DDA_rep3_pool6.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD023038 {}"

# # PXD000394
# declare -a sample=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120321_EXQ1_MiBa_SA_HCC1937_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120321_EXQ1_MiBa_SA_HCC1937_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120322_EXQ1_MiBa_SA_HCC1937_1_A.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120322_EXQ1_MiBa_SA_HCC1937_2_A.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20130328_EXQ1_MiBa_SA_HCC1937.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120321_EXQ1_MiBa_SA_HCC1143_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120321_EXQ1_MiBa_SA_HCC1143_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120322_EXQ1_MiBa_SA_HCC1143_1_A.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20130328_EXQ1_MiBa_SA_HCC1143.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD000394 {}"

# # PXD009738
# declare -a sample=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0180_MON_0267T_even.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0180_MON_0267T_odd.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0180b_MON_0267T_even.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0180b_MON_0267T_odd.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0180c_MON_0267T_even_1h.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0180c_MON_0267T_odd_1h.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0182_MON_0237T_even.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0182_MON_0237T_odd.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0182b_MON_0237T_even.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0182b_MON_0237T_odd.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0182c_MON_0237T_even_1h.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0182c_MON_0237T_odd_1h.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0184_MON_0014T_even.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0184_MON_0014T_odd.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0184b_MON_0014T_even.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0184b_MON_0014T_odd.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0184c_MON_0014T_even_1h.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0184c_MON_0014T_odd_1h.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0186_MON_0025T_even.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0186_MON_0025T_odd.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0186b_MON_0025T_even.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0186b_MON_0025T_odd.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0186c_MON_0025T_even_1h.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0186c_MON_0025T_odd_1h.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0188_MON_0230T_even.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0188_MON_0230T_odd.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0188b_MON_0230T_even.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0188b_MON_0230T_odd.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0188c_MON_0230T_even_1h.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0188c_MON_0230T_odd_1h.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0189_MON_0224T_even.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0189_MON_0224T_odd.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0189b_MON_0224T_even.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0189b_MON_0224T_odd.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0189c_MON_0224T_even_1h.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/06/PXD009738/generated/FL0189c_MON_0224T_odd_1h.raw
# )

# phase2_PXD025345
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK6_1395III_EV_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK5_1395III_CL_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK4_1395II_EV_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK3_1395II_CL_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK2_1806_III_EV_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK2_1395I_CL_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK1_1806_III_CL_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK1_1395I_EV_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_MCF7_II_EV_all_rpt.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_MCF7_II_CL_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_453_III_EV_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_453_III_CL_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_415_EV_III_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_415_EV_II_all_.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_415_EV_I_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_415_CL_III_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_415_CL_II_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_415_CL_I_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_1806_II_EV_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_1806_II_CL_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK__MCF7_III_CL_all.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/MDAMB231_I_EV.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/MDAMB231_I_CL.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/MCF7_I_EV.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/MCF7_I_CL.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/453_II_EV.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/453_II_CL.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/231-II_EV.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/231-II_CL.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191219_PK_361EV_II.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191218PK_361_EV_I.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191218PK_361_CL_II.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191218PK_361_CL_I.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191216PK_1954_EV_III.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191216PK_1954_EV_II.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191216PK_1954_EV_I.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191216PK_1954_CL_III.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191216PK_1954_CL_II.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191216_PK_1954_CL_I.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/190823_Pankaj_453EV.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/190823_Pankaj_453CL.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/190823_Pankaj_1806EV.wiff
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/190823_Pankaj_1806CL.wiff
)

# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK6_1395III_EV_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK5_1395III_CL_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK4_1395II_EV_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK3_1395II_CL_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK2_1806_III_EV_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK2_1395I_CL_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK1_1806_III_CL_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK1_1395I_EV_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_MCF7_II_EV_all_rpt.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_MCF7_II_CL_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_453_III_EV_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_453_III_CL_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_415_EV_III_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_415_EV_II_all_.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_415_EV_I_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_415_CL_III_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_415_CL_II_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_415_CL_I_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_1806_II_EV_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK_1806_II_CL_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/PK__MCF7_III_CL_all.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/MDAMB231_I_EV.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/MDAMB231_I_CL.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/MCF7_I_EV.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/MCF7_I_CL.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/453_II_EV.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/453_II_CL.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/231-II_EV.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/231-II_CL.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191219_PK_361EV_II.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191218PK_361_EV_I.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191218PK_361_CL_II.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191218PK_361_CL_I.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191216PK_1954_EV_III.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191216PK_1954_EV_II.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191216PK_1954_EV_I.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191216PK_1954_CL_III.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191216PK_1954_CL_II.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/191216_PK_1954_CL_I.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/190823_Pankaj_453EV.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/190823_Pankaj_453CL.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/190823_Pankaj_1806EV.wiff.scan
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025345/190823_Pankaj_1806CL.wiff.scan
# )
# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD025345 {}"

# module load singularity/3.1
# cd phase2_PXD025345 
# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c \
#   "singularity run -B $PWD:/data --writable /gpfs/data/yarmarkovichlab/Frank/immunopeptidome_project/fasta/pwiz wine msconvert /data/{} --mzML --filter \"peakPicking true 1-\""

# phase2_PXD034818
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_231_18T_TMT0_060720_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_231_18T_TMT0_060720_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_333_18T_TMT0_050721_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_333_18T_TMT0_050721_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_346_18T_TMT0_060720_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_346_18T_TMT0_060720_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_513_20T_TMT0_050721_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_513_20T_TMT0_050721_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_684_19T_TMT0_050721_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_684_19T_TMT0_050721_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_790_18T_TMT0_260521_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_790_18T_TMT0_260521_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_820_19T_TMT0_260521_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_820_19T_TMT0_260521_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_928_19T_TMT0_260521_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_928_19T_TMT0_260521_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1029_17T_TMT0_060720_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1029_17T_TMT0_060720_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1137_18T_TMT0_060720_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1137_18T_TMT0_060720_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1192_17T_TMT0_060720_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1192_17T_TMT0_060720_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1208_18T_TMT0_260521_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1208_18T_TMT0_260521_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1305_19T_TMT0_050721_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1305_19T_TMT0_050721_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1478_18T_TMT0_060720_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1478_18T_TMT0_060720_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1945_18T_TMT0_260521_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1945_18T_TMT0_260521_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1949_16T_TMT0_060720_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1949_16T_TMT0_060720_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_2049_18T_TMT0_060720_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_2049_18T_TMT0_060720_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_2179_18T_TMT0_260521_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_2179_18T_TMT0_260521_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_2189_18T_TMT0_050721_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_2189_18T_TMT0_050721_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_2339_19T_TMT0_050721_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_2339_19T_TMT0_050721_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_825_19T_240321_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_825_19T_240321_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_977_19T_240321_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_977_19T_240321_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1097_19T_240321_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_1097_19T_240321_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_2060_19T_240321_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD034818/Breast_2060_19T_240321_2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD034818 {}"

# PXD023044
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190510_PF_MDA_MB231_Rep1_IFN_positive_pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190510_PF_MDA_MB231_Rep1_IFN_positive_pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190510_PF_MDA_MB231_Rep1_IFN_positive_pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190510_PF_MDA_MB231_Rep1_IFN_positive_pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190510_PF_MDA_MB231_Rep1_IFN_positive_pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190510_PF_MDA_MB231_Rep1_IFN_positive_pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190510_PF_MDA_MB231_Rep1_IFN_positive_pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190510_PF_MDA_MB231_Rep1_IFN_positive_pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190510_PF_MDA_MB231_Rep1_IFN_positive_pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190517_PF_MDA_MB231_Rep2_IFN_negative_Rep2pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190517_PF_MDA_MB231_Rep2_IFN_negative_Rep2pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190517_PF_MDA_MB231_Rep2_IFN_negative_Rep2pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190517_PF_MDA_MB231_Rep2_IFN_negative_Rep2pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190517_PF_MDA_MB231_Rep2_IFN_negative_Rep2pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190517_PF_MDA_MB231_Rep2_IFN_negative_Rep2pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190517_PF_MDA_MB231_Rep2_IFN_negative_Rep2pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190517_PF_MDA_MB231_Rep2_IFN_negative_Rep2pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190517_PF_MDA_MB231_Rep2_IFN_negative_Rep2pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep4_pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep4_pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep4_pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep4_pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep4_pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep4_pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep4_pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep4_pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep4_pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep5_pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep5_pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep5_pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep5_pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep5_pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep5_pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep5_pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep5_pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190823_PF_TNBC_IFN_negative_Rep5_pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190906_PF_TNBC_IFN_positive_Rep4_pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190906_PF_TNBC_IFN_positive_Rep4_pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190906_PF_TNBC_IFN_positive_Rep4_pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190906_PF_TNBC_IFN_positive_Rep4_pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190906_PF_TNBC_IFN_positive_Rep4_pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190906_PF_TNBC_IFN_positive_Rep4_pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190906_PF_TNBC_IFN_positive_Rep4_pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190906_PF_TNBC_IFN_positive_Rep4_pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F120190906_PF_TNBC_IFN_positive_Rep4_pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F1202000304_PF_MDAMB231_IFN-positive_replicate_5_pool_1_Immunopeptidomics-I.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F1202000304_PF_MDAMB231_IFN-positive_replicate_5_pool_2_Immunopeptidomics-I.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F1202000304_PF_MDAMB231_IFN-positive_replicate_5_pool_3_Immunopeptidomics-I.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F1202000304_PF_MDAMB231_IFN-positive_replicate_5_pool_4_Immunopeptidomics-I.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F1202000304_PF_MDAMB231_IFN-positive_replicate_5_pool_5_Immunopeptidomics-I.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F1202000304_PF_MDAMB231_IFN-positive_replicate_5_pool_6_Immunopeptidomics-I.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F1202000304_PF_MDAMB231_IFN-positive_replicate_5_pool_7_Immunopeptidomics-I.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F1202000304_PF_MDAMB231_IFN-positive_replicate_5_pool_8_Immunopeptidomics-I.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/05/PXD023044/F1202000304_PF_MDAMB231_IFN-positive_replicate_5_pool_9_Immunopeptidomics-I.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD023044 {}"

# phase2_PXD038165
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/10/PXD038165/0520_7_1_Slot1-25_1_4042.d.7z
)
for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD038165 {}"
cd ./phase2_PXD038165
module load 7zip
7zz x 0520_7_1_Slot1-25_1_4042.d.7z
rm 0520_7_1_Slot1-25_1_4042.d.7z

# phase2_PXD022020
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD022020/MCF7-nzuh000102a19101xms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD022020/SW527-bzwj001219g19101xms1.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD022020 {}"

# phase2_PXD024965
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024965/MS195454LUM_martin_scheinberg_MCF7_Abemaciclib.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024965/MS195454LUM_martin_scheinberg_MCF7_DMSO.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024965/MS195454LUM_martin_scheinberg_MCF_Palbociclib.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024965/MS205868LUM_martin_scheinberg_MCF7_Abemaciclib_b.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024965/MS205868LUM_martin_scheinberg_T47D_DMSO_a.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024965/MS205868LUM_martin_scheinberg_T47D_Palbociclib_a.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024965/MS206194_LUM_martin_scheinberg_MCF7_Abemaciclib.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024965/MS206194_LUM_martin_scheinberg_MCF7_DMSO.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024965/MS206194_LUM_martin_scheinberg_MCF7_palbociclib.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024965/MS206194_LUM_martin_scheinberg_T47D_Abemciclib.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024965/MS206194_LUM_martin_scheinberg_T47D_DMSO.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024965/MS206194_LUM_martin_scheinberg_T47D_Palbociclib.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD024965 {}"