#!/bin/bash
#SBATCH --partition=a100_short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=1-00:00:00
#SBATCH --mem=50Gb
#SBATCH --job-name="data_transfer"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Frakn/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1


# PXD006939
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170320_QEh1_LC2_FaMaChCh_SA_HLApI_3830-NJF_1_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170320_QEh1_LC2_FaMaChCh_SA_HLApI_3830-NJF_2_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170320_QEh1_LC2_FaMaChCh_SA_HLApI_3830-NJF_3_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170311_QEh1_LC2_FaMaChCh_SA_HLApI_3849-BR_2_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170311_QEh1_LC2_FaMaChCh_SA_HLApI_3849-BR_3_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170311_QEh1_LC2_FaMaChCh_SA_HLApI_3912-BAM_1_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/201703011_QEh1_LC2_FaMaChCh_SA_HLApI_3865-DM_1_R1.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD006939 {}"

# PXD009925
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171130_QEh1_LC1_HLAIp_SA_JMI_3779-AMM_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171130_QEh1_LC1_HLAIp_SA_JMI_3779-AMM_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171130_QEh1_LC1_HLAIp_SA_JMI_3795-BMT_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171130_QEh1_LC1_HLAIp_SA_JMI_3795-BMT_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171130_QEh1_LC1_HLAIp_SA_JMI_3803-RE_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171130_QEh1_LC1_HLAIp_SA_JMI_3803-RE_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171130_QEh1_LC1_HLAIp_SA_JMI_3805-RV_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171130_QEh1_LC1_HLAIp_SA_JMI_3805-RV_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_3808-HMC_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_3808-HMC_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_3869-GA_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_3869-GA_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_3911-ME_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_3911-ME_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_3947-GA_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_3947-GA_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_3971-ORA_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_3971-ORA_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_4001_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_4001_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_4021_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171201_QEh1_LC1_HLAIp_SA_JMI_4037-DC_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171211_QEh1_LC1_HLAIp_SA_JMI_4021_R3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171211_QEh1_LC1_HLAIp_SA_JMI_4037-DC_R3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171212_QEh1_LC1_HLAIp_SA_JMI_4021_R4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD009925/20171212_QEh1_LC1_HLAIp_SA_JMI_4037-DC_R4.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD009925 {}"

# PXD013831
declare -a samples=(
https://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD013831/20171201_QEh1_LC1_HLAIp_SA_JMI_3993_R1.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD013831/20171201_QEh1_LC1_HLAIp_SA_JMI_3993_R2.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD013831/20171211_QEh1_LC1_HLAIp_SA_JMI_4052-BA_R2.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD013831/20171212_QEh1_LC1_HLAIp_SA_JMI_4052-BA_R3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD013831 {}"



