#!/bin/bash
#SBATCH --partition=a100_short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=1-00:00:00
#SBATCH --mem=100Gb
#SBATCH --job-name="colondata_transfer-short"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1

# # PXD028309
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD028309/CRC_026019T_TMT_200720_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD028309/CRC_026075T_TMT_200720_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD028309/CRC_026214T_TMT_200720_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD028309/CRC_026240T_TMT_200720_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD028309/CRC_026241T_TMT_200720_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD028309/CRC_026250T_TMT_200720_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD028309/Colo208_TMT_10M_040920_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD028309/HCT116_TMT_10M_040920_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD028309/RKO_TMT_10M_040920_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD028309/SW620_TMT_10M_040920_1.raw

# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 6 -I {} bash -c "wget -P ./PXD028309 {}"


# # PXD000394
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120515_EXQ3_MiBa_SA_HCT116_mHLA-1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120518_EXQ0_MiBa_SA_HCT116_mHLA-2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120617_EXQ0_MiBa_SA_HCT116_1_mHLA_2hr.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120619_EXQ6_MiBa_SA_HCT116_2_mHLA_2hr.raw

# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 6 -I {} bash -c "wget -P ./PXD000394 {}"


# # MSV000087927
# declare -a samples=(
# ftp://massive.ucsd.edu/v03/MSV000087927/raw/HCT116MG_D190212_S1.raw
# ftp://massive.ucsd.edu/v03/MSV000087927/raw/HCT116MG_D190212_S2.raw
# ftp://massive.ucsd.edu/v03/MSV000087927/raw/HCT116MG_D190212_S3.raw
# ftp://massive.ucsd.edu/v03/MSV000087927/raw/HCT116MG_D190212_S4.raw

# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./MSV000087927  {}"

# # PXD014017
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20170708_QEh1_LC1_ChCh_SA_HLAIp_CRC-01_1_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20170708_QEh1_LC1_ChCh_SA_HLAIp_CRC-01_1_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20170708_QEh1_LC1_ChCh_SA_HLAIp_CRC-05_1_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20170708_QEh1_LC1_ChCh_SA_HLAIp_CRC-05_1_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20170708_QEh1_LC1_ChCh_SA_HLAIp_CRC-08_1_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20170708_QEh1_LC1_ChCh_SA_HLAIp_CRC-08_1_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-01_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-01_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-04_1_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-04_1_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-04_2_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-04_2_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-04_3_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-04_3_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-05_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-05_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-08_1_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-08_1_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-08_2_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171107_QEh1_LC1_HLApI_SA_JMI_CRC-08_2_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171109_QEh1_LC1_HLApI_SA_JMI_CRC-03_1_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171109_QEh1_LC1_HLApI_SA_JMI_CRC-03_1_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171109_QEh1_LC1_HLApI_SA_JMI_CRC-03_2_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171109_QEh1_LC1_HLApI_SA_JMI_CRC-03_2_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171109_QEh1_LC1_HLApI_SA_JMI_CRC-03_3_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171109_QEh1_LC1_HLApI_SA_JMI_CRC-03_3_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171109_QEh1_LC1_HLApI_SA_JMI_PDX146_1_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171109_QEh1_LC1_HLApI_SA_JMI_PDX146_1_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171109_QEh1_LC1_HLApI_SA_JMI_PDX146_2_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171109_QEh1_LC1_HLApI_SA_JMI_PDX146_2_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171109_QEh1_LC1_HLApI_SA_JMI_PDX146_3_R1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20171109_QEh1_LC1_HLApI_SA_JMI_PDX146_3_R2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_IFN1_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_IFN1_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_IFN2_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_IFN2_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_IFN3_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_IFN3_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_IFN4_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_IFN4_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_IFN5_2ndC-18_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_IFN5_2ndC-18_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_TRAM1_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_TRAM1_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_TRAM2_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_TRAM2_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_TRAM3_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_TRAM3_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_TRAM4_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180821_QE_HFX_LC2_SA_JMI_HLAIp_CRC-01_TRAM4_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_IFN1_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_IFN1_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_IFN2_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_IFN2_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_IFN3_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_IFN3_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_IFN4_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_IFN4_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_IFN5_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_IFN5_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_IFN6_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_IFN6_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_TRAM1_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_TRAM1_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_TRAM2_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_TRAM2_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_TRAM3_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_TRAM3_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_TRAM4_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180824_QEh1_LC1_SA_JMI_HLAIp_CRC-08_TRAM4_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180831_QEh1_LC1_SA_JMI_HLAIp_CRC-04_IFN1_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180831_QEh1_LC1_SA_JMI_HLAIp_CRC-04_IFN1_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180831_QEh1_LC1_SA_JMI_HLAIp_CRC-04_IFN2_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180831_QEh1_LC1_SA_JMI_HLAIp_CRC-04_IFN2_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180831_QEh1_LC1_SA_JMI_HLAIp_CRC-04_IFN3_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180831_QEh1_LC1_SA_JMI_HLAIp_CRC-04_IFN3_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180831_QEh1_LC1_SA_JMI_HLAIp_CRC-04_IFN4_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180831_QEh1_LC1_SA_JMI_HLAIp_CRC-04_IFN4_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180906_QEh1_LC1_SA_JMI_HLAIp_CRC-04_TRAM1_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180906_QEh1_LC1_SA_JMI_HLAIp_CRC-04_TRAM1_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180906_QEh1_LC1_SA_JMI_HLAIp_CRC-04_TRAM2_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180906_QEh1_LC1_SA_JMI_HLAIp_CRC-04_TRAM2_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180906_QEh1_LC1_SA_JMI_HLAIp_CRC-04_TRAM3_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180906_QEh1_LC1_SA_JMI_HLAIp_CRC-04_TRAM3_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180906_QEh1_LC1_SA_JMI_HLAIp_CRC-04_TRAM4_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180906_QEh1_LC1_SA_JMI_HLAIp_CRC-04_TRAM4_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_IFN1_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_IFN1_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_IFN2_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_IFN2_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_IFN3_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_IFN3_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_TRAM1_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_TRAM1_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_TRAM2_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_TRAM2_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_TRAM3_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_TRAM3_R02.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_TRAM4_R01.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/11/PXD014017/20180911_QEh1_LC1_SA_JMI_HLAIp_CRC-05_TRAM4_R02.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD014017 {}"

# PXD021755
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lara_190212_P0814_MR_JB_HA1_HCD_R1.raw 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lara_190212_P0814_MR_JB_HA2_HCD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lara_190212_P0814_MR_JB_HA3_HCD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lara_190212_P0814_MR_JB_HD1_HCD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lara_190212_P0814_MR_JB_HD2_HCD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lara_190212_P0814_MR_JB_HD3_HCD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190208_P0814_MR_JB_HA1_HCD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190208_P0814_MR_JB_HA2_HCD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190208_P0814_MR_JB_HA3_HCD_R1.raw 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190208_P0814_MR_JB_HD1_HCD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190208_P0814_MR_JB_HD2_HCD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190208_P0814_MR_JB_HD3_HCD_R1.raw 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190217_P0814_MR_JB_HA1_EThcD_R1.raw 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190217_P0814_MR_JB_HD1_EThcD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190217_P0814_MR_JB_HD2_EThcD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190217_P0814_MR_JB_HD3_EThcD_R2.raw 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190225_P0814_MR_JB_HA1_lowEThcD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190225_P0814_MR_JB_HA2_EThcD_R2.raw 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190225_P0814_MR_JB_HA2_lowEThcD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190225_P0814_MR_JB_HA3_EThcD_R2.raw 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190225_P0814_MR_JB_HA3_lowEThcD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190225_P0814_MR_JB_HD1_lowEThcD_R1.raw	 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190225_P0814_MR_JB_HD2_lowEThcD_R1.raw 
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/04/PXD021755/Lumos_190225_P0814_MR_JB_HD3_lowEThcD_R1.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD021755 {}"

# phase2_PXD037587
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC113_IFNy_W6_DDA_Rep1_400-650mz_msms36.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC113_IFNy_W6_DDA_Rep2_400-650mz_msms37.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC113_IFNy_W6_DDA_Rep3_400-650mz_msms38.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC113_untreated_W6_DDA_Rep1_400-650mz_msms23.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC113_untreated_W6_DDA_Rep1new_400-650mz_msms28.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC113_untreated_W6_DDA_Rep2_400-650mz_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC113_untreated_W6_DDA_Rep3_400-650mz_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC285_IFNy_W6_DDA_Rep1_400-650mz_msms15.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC285_IFNy_W6_DDA_Rep2_400-650mz_msms16.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC285_IFNy_W6_DDA_Rep3_400-650mz_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC285_untreated_W6_DDA_Rep1_400-650mz_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC285_untreated_W6_DDA_Rep2_400-650mz_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD037587/171219_MG_HROC285_untreated_W6_DDA_Rep3_400-650mz_msms9.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD037587 {}"

# phase2_PXD026573_JPST001211
declare -a samples=(
https://storage.jpostdb.org/JPST001211/ST239_CRC09_A24.raw
https://storage.jpostdb.org/JPST001211/ST467_CRC54_A24.raw
https://storage.jpostdb.org/JPST001211/ST468_CRC57_A24.raw
https://storage.jpostdb.org/JPST001211/ST469_CRC59_A24.raw
https://storage.jpostdb.org/JPST001211/ST547_CRC111_1_A24.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD026573_JPST001211 {}"

# phase2_PXD024533_JPST001104
declare -a samples=(
https://storage.jpostdb.org/JPST001104/ST503_Colo320_A24.raw
https://storage.jpostdb.org/JPST001104/ST419_CRC71_A24.raw
https://storage.jpostdb.org/JPST001104/ST544_CRC117_A24.raw
https://storage.jpostdb.org/JPST001104/ST545_CRC113_A24.raw
https://storage.jpostdb.org/JPST001104/ST546_CRC114_A24.raw
https://storage.jpostdb.org/JPST001104/ST600_CRC123_A24.raw
https://storage.jpostdb.org/JPST001104/ST594_CRC125_A24.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD024533_JPST001104 {}"

# phase2_PXD016582, remove N41 normal
wget ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/10/PXD016582/Ligandome_Raw.7z
module load 7zip
7zz x Ligandome_Raw.7z

# phase2_PXD015947
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS01_Tumor_HLAclassIW6-32_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS01_Tumor_HLAclassIW6-32_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS01_Tumor_HLAclassIW6-32_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS01_Tumor_HLAclassIW6-32_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS01_Tumor_HLAclassIW6-32_Rep5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS05_Tumor_HLAclassIW6-32_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS05_Tumor_HLAclassIW6-32_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS05_Tumor_HLAclassIW6-32_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS06_Tumor_HLAclassIW6-32_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS06_Tumor_HLAclassIW6-32_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS06_Tumor_HLAclassIW6-32_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS08_Tumor_HLAclassIW6-32_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS08_Tumor_HLAclassIW6-32_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS08_Tumor_HLAclassIW6-32_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS09_Tumor_HLAclassIW6-32_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS12_Tumor_HLAclassIW6-32_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS12_Tumor_HLAclassIW6-32_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS12_Tumor_HLAclassIW6-32_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS12_Tumor_HLAclassIW6-32_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS12_Tumor_HLAclassIW6-32_Rep5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD015947/IRISS12_Tumor_HLAclassIW6-32_Rep6.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD015947 {}"

# phase2_PXD023770_JPST001072
declare -a samples=(
https://storage.jpostdb.org/JPST001072/191206_HCT116_HLAp_1ul_Replicate1.raw
https://storage.jpostdb.org/JPST001072/191206_HCT116_HLAp_1ul_Replicate2.raw
https://storage.jpostdb.org/JPST001072/191206_HCT116_HLAp_1ul_Replicate3.raw
https://storage.jpostdb.org/JPST001072/191206_HCT116_HLAp_2ul_Raplicate3.raw
https://storage.jpostdb.org/JPST001072/191206_HCT116_HLAp_2ul_Replicate1.raw
https://storage.jpostdb.org/JPST001072/191206_HCT116_HLAp_2ul_Replicate2.raw
https://storage.jpostdb.org/JPST001072/191206_HCT116_HLAp_3ul_Replicate1.raw 
https://storage.jpostdb.org/JPST001072/191206_HCT116_HLAp_3ul_Replicate2.raw
https://storage.jpostdb.org/JPST001072/191206_HCT116_HLAp_3ul_Replicate3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD023770_JPST001072 {}"

# phase2_PXD023771_JPST001066_faims
declare -a samples=(
https://storage.jpostdb.org/JPST001066/191216_HCT116_HLAp_1ul_CVSet1.raw
https://storage.jpostdb.org/JPST001066/191216_HCT116_HLAp_1ul_CVSet2.raw
https://storage.jpostdb.org/JPST001066/191216_HCT116_HLAp_1ul_CVSet3.raw
https://storage.jpostdb.org/JPST001066/191216_HCT116_HLAp_2ul_CVSet1.raw
https://storage.jpostdb.org/JPST001066/191216_HCT116_HLAp_2ul_CVSet2.raw
https://storage.jpostdb.org/JPST001066/191216_HCT116_HLAp_2ul_CVSet3.raw	
https://storage.jpostdb.org/JPST001066/191216_HCT116_HLAp_3ul_CVSet1.raw	
https://storage.jpostdb.org/JPST001066/191216_HCT116_HLAp_3ul_CVSet2.raw	
https://storage.jpostdb.org/JPST001066/191216_HCT116_HLAp_3ul_CVSet3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD023771_JPST001066_faims {}"

# phase2_PXD023773_JPST001068_faims
declare -a samples=(
https://storage.jpostdb.org/JPST001068/200205_HCT116_5ul_CVSet1.raw
https://storage.jpostdb.org/JPST001068/200205_HCT116_5ul_CVSet2.raw
https://storage.jpostdb.org/JPST001068/200205_HCT116_5ul_CVSet3.raw
https://storage.jpostdb.org/JPST001068/200714_HCT116_1ul_CVSet1.raw
https://storage.jpostdb.org/JPST001068/200714_HCT116_1ul_CVSet2.raw
https://storage.jpostdb.org/JPST001068/200714_HCT116_1ul_CVSet3.raw
https://storage.jpostdb.org/JPST001068/200715_HCT116_5ul_CVSet1.raw
https://storage.jpostdb.org/JPST001068/200715_HCT116_5ul_CVSet2.raw
https://storage.jpostdb.org/JPST001068/200715_HCT116_5ul_CVSet3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD023773_JPST001068_faims {}"

# PXD023805_JPST001069_faims
declare -a samples=(
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_51T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_51T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_51T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_60T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_51T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_78T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_78T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_60T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_60T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_78T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_51T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_60T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_78T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_84T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_84T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_84T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_84T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_60T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_84T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_103T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_51T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_103T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_78T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_60T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_103T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_107T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_84T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_107T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_78T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_107T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_107T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_103T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_103T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_Approx4ul_112T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_107T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_112T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_112T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_103T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_119T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_Approx4ul_112T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_119T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_119T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_119T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_119T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_112T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_172T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_172T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_172T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_172T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_Approx4ul_112T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_172T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_229T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_229T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_229T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_107T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_241T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_229T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_241T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_229T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_241T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_119T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_241T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_229T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_241T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_256T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_256T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_172T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_256T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_256T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_256T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_256T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_258T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_258T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_257T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_258T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_257T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_258T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_241T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_258T.raw
https://storage.jpostdb.org/JPST001069/200714_Lumos_FAIMS_CID_IT_CVSet1_1ul_259HT1.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_257T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_258T.raw
https://storage.jpostdb.org/JPST001069/200715_Lumos_FAIMS_CID_IT_CVSet2_5ul_259HT1.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_257T.raw
https://storage.jpostdb.org/JPST001069/200714_Lumos_FAIMS_CID_IT_CVSet2_1ul_259HT1.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_257T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_5ul_260T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_260T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_1ul_260T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet3_5ul_260T.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_5ul_257T.raw
https://storage.jpostdb.org/JPST001069/200715_Lumos_FAIMS_CID_IT_CVSet1_5ul_259HT1.raw
https://storage.jpostdb.org/JPST001069/200714_Lumos_FAIMS_CID_IT_CVSet3_1ul_261HT.raw
https://storage.jpostdb.org/JPST001069/200715_Lumos_FAIMS_CID_IT_CVSet3_5ul_259HT1.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet2_1ul_260T.raw
https://storage.jpostdb.org/JPST001069/200714_Lumos_FAIMS_CID_IT_CVSet3_1ul_259HT1.raw
https://storage.jpostdb.org/JPST001069/200714_Lumos_FAIMS_CID_IT_CVSet1_1ul_261HT.raw
https://storage.jpostdb.org/JPST001069/200714_Lumos_FAIMS_CID_IT_CVSet2_1ul_261HT.raw
https://storage.jpostdb.org/JPST001069/200715_Lumos_FAIMS_CID_IT_CVSet2_5ul_261HT.raw
https://storage.jpostdb.org/JPST001069/200715_Lumos_FAIMS_CID_IT_CVSet3_5ul_261HT.raw
https://storage.jpostdb.org/JPST001069/200715_Lumos_FAIMS_CID_IT_CVSet1_5ul_261HT.raw
https://storage.jpostdb.org/JPST001069/200727_Lumos_FAIMS_CID_IT_CVSet1_1ul_260T.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD023805_JPST001069_faims {}"

# phase2_PXD033351
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/H716.massspec.MHC1pulldown.R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/H716.massspec.MHC1pulldown.R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/H716.massspec.MHC1pulldown.R3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/H716.massspec.MHC1pulldown.R4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/H716.massspec.MHC1pulldown.R5.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD033351 {}"

# phase2_PXD038165
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/10/PXD038165/0520_6_1_Slot1-24_1_4039.d.7z
)
for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD038165 {}"
cd ./phase2_PXD038165
module load 7zip
7zz x 0520_6_1_Slot1-24_1_4039.d.7z
rm 0520_6_1_Slot1-24_1_4039.d.7z

# phase2_29789417
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_10_HLA-class_I_CRC_(malignant)_Rep#1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_10_HLA-class_I_CRC_(malignant)_Rep#2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_10_HLA-class_I_CRC_(malignant)_Rep#3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_10_HLA-class_I_CRC_(malignant)_Rep#4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_10_HLA-class_I_CRC_(malignant)_Rep#5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_11_HLA-class_I_CRC_(malignant)_PA#1_(pre-adjustment).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_11_HLA-class_I_CRC_(malignant)_PA#2_(pre-adjustment).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_11_HLA-class_I_CRC_(malignant)_Rep#1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_11_HLA-class_I_CRC_(malignant)_Rep#2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_11_HLA-class_I_CRC_(malignant)_Rep#3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_11_HLA-class_I_CRC_(malignant)_Rep#4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_11_HLA-class_I_CRC_(malignant)_Rep#5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_11_HLA-class_I_CRC_(malignant)_R_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_12_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_12_HLA-class_I_CRC_(malignant)_R#1_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_12_HLA-class_I_CRC_(malignant)_R#2_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_12_HLA-class_I_CRC_(malignant)_Rep#1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_12_HLA-class_I_CRC_(malignant)_Rep#2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_12_HLA-class_I_CRC_(malignant)_Rep#3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_12_HLA-class_I_CRC_(malignant)_Rep#4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_12_HLA-class_I_CRC_(malignant)_Rep#5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_13_HLA-class_I_CRC_(malignant)_Rep#1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_13_HLA-class_I_CRC_(malignant)_Rep#2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_13_HLA-class_I_CRC_(malignant)_Rep#3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_13_HLA-class_I_CRC_(malignant)_Rep#4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_13_HLA-class_I_CRC_(malignant)_Rep#5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_14_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_14_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_14_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_14_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_14_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_14_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_15_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_15_HLA-class_I_CRC_(malignant)_R#1_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_15_HLA-class_I_CRC_(malignant)_R#2_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_15_HLA-class_I_CRC_(malignant)_R#3_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_15_HLA-class_I_CRC_(malignant)_Rep#1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_15_HLA-class_I_CRC_(malignant)_Rep#2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_15_HLA-class_I_CRC_(malignant)_Rep#3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_15_HLA-class_I_CRC_(malignant)_Rep#4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_15_HLA-class_I_CRC_(malignant)_Rep#5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_16_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_16_HLA-class_I_CRC_(malignant)_R#1_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_16_HLA-class_I_CRC_(malignant)_R#2_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_16_HLA-class_I_CRC_(malignant)_Rep#1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_16_HLA-class_I_CRC_(malignant)_Rep#2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_16_HLA-class_I_CRC_(malignant)_Rep#3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_16_HLA-class_I_CRC_(malignant)_Rep#4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_16_HLA-class_I_CRC_(malignant)_Rep#5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_17_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_17_HLA-class_I_CRC_(malignant)_R#1_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_17_HLA-class_I_CRC_(malignant)_R#2_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_17_HLA-class_I_CRC_(malignant)_R#3_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_17_HLA-class_I_CRC_(malignant)_Rep#1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_17_HLA-class_I_CRC_(malignant)_Rep#2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_17_HLA-class_I_CRC_(malignant)_Rep#3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_17_HLA-class_I_CRC_(malignant)_Rep#4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_17_HLA-class_I_CRC_(malignant)_Rep#5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_18_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_18_HLA-class_I_CRC_(malignant)_Rep#1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_18_HLA-class_I_CRC_(malignant)_Rep#2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_18_HLA-class_I_CRC_(malignant)_Rep#3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_18_HLA-class_I_CRC_(malignant)_Rep#4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_18_HLA-class_I_CRC_(malignant)_Rep#5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_18_HLA-class_I_CRC_(malignant)_R_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_19_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_19_HLA-class_I_CRC_(malignant)_R#1_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_19_HLA-class_I_CRC_(malignant)_R#2_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_19_HLA-class_I_CRC_(malignant)_R#3_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_19_HLA-class_I_CRC_(malignant)_Rep#1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_19_HLA-class_I_CRC_(malignant)_Rep#2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_19_HLA-class_I_CRC_(malignant)_Rep#3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_19_HLA-class_I_CRC_(malignant)_Rep#4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_19_HLA-class_I_CRC_(malignant)_Rep#5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_1_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_1_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_1_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_1_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_1_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_1_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_20_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_20_HLA-class_I_CRC_(malignant)_Rep#1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_20_HLA-class_I_CRC_(malignant)_Rep#2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_20_HLA-class_I_CRC_(malignant)_Rep#3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_20_HLA-class_I_CRC_(malignant)_Rep#4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_20_HLA-class_I_CRC_(malignant)_Rep#5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_20_HLA-class_I_CRC_(malignant)_R_(remnant).raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_21_HLA-class_I_CRC_(malignant)_Rep#1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_21_HLA-class_I_CRC_(malignant)_Rep#2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_21_HLA-class_I_CRC_(malignant)_Rep#3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_21_HLA-class_I_CRC_(malignant)_Rep#4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_21_HLA-class_I_CRC_(malignant)_Rep#5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_22_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_22_HLA-class_I_CRC_(malignant)_R#1_(remnant).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_22_HLA-class_I_CRC_(malignant)_R#2_(remnant).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_22_HLA-class_I_CRC_(malignant)_R#3_(remnant).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_22_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_22_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_22_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_22_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_22_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_23_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_23_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_23_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_23_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_23_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_24_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_24_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_24_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_24_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_24_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_25_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_25_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_25_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_26_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_26_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_26_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_27_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_27_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_27_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_27_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_27_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_28_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_28_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_28_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_28_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_28_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_29_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_29_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_29_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_29_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_29_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_29_HLA-class_I_CRC_(malignant)_R_(remnant).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_2_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_2_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_2_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_2_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_2_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_2_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_30_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_30_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_30_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_30_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_30_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_3_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_3_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_3_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_3_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_3_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_3_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_3_HLA-class_I_CRC_(malignant)_R_(remnant).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_4_HLA-class_I_CRC_(malignant)_PA_(pre-adjustment).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_4_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_4_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_4_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_4_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_4_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_4_HLA-class_I_CRC_(malignant)_Rep#6.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_4_HLA-class_I_CRC_(malignant)_Rep#7.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_5_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_5_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_5_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_5_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_6_HLA-class_I_CRC_(malignant)_Rep#1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_6_HLA-class_I_CRC_(malignant)_Rep#2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_6_HLA-class_I_CRC_(malignant)_Rep#3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_6_HLA-class_I_CRC_(malignant)_Rep#4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_6_HLA-class_I_CRC_(malignant)_Rep#5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_7_HLA-class_I_CRC_(malignant)_R#1_(remnant).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_7_HLA-class_I_CRC_(malignant)_R#2_(remnant).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_7_HLA-class_I_CRC_(malignant)_R#3_(remnant).RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_7_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_7_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_7_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_7_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_7_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_8_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_8_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_8_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_8_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_8_HLA-class_I_CRC_(malignant)_Rep#5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_9_HLA-class_I_CRC_(malignant)_Rep#1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_9_HLA-class_I_CRC_(malignant)_Rep#2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_9_HLA-class_I_CRC_(malignant)_Rep#3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_9_HLA-class_I_CRC_(malignant)_Rep#4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/03/PXD009602/UPN_9_HLA-class_I_CRC_(malignant)_Rep#5.RAW
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_29789417 {}"