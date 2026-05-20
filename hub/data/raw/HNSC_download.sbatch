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


# PXD033383_OPSCC
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_01_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_01_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_01_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_02_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_02_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_02_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_03_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_03_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_03_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_04_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_04_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_04_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_05_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_05_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_05_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_06_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_06_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_06_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_07_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_07_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_07_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_08_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_08_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_08_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_09_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_09_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_09_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_10_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_10_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_10_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_11_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_11_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_11_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_12_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_12_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_12_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_13_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_13_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_13_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_14_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_14_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_14_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_15_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_15_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_15_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_16_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_16_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_16_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_17_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_17_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_17_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_18_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_18_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_18_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_19_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_19_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_19_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_20_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_20_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_20_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_21_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_21_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_21_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_22_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_22_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_22_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_23_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_23_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_23_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_24_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_24_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_24_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_25_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_25_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_25_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_26-1_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_26-1_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_26-1_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_26-2_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_26-2_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_26-2_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_27-1_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_27-1_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_27-1_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_27-2_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_27-2_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_27-2_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_28_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_28_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_28_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_29_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_29_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_29_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_30_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_30_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_30_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_31_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_31_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_31_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_32_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_32_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_32_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_33_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_33_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_33_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_34_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_34_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_34_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_35_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_35_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_35_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_36_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_36_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_36_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_37_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_37_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_37_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_38_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_38_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_38_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_39_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_39_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_39_ClassI_Rep-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_40_ClassI_Rep-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_40_ClassI_Rep-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD033383/OPSCC_40_ClassI_Rep-3.raw
)



for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD033383_OPSCC {}"

# PXD016060
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq47405_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq48139_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq46722_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq46723_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq48523_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq48517_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq48518_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq63721_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq63722_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq63723_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq63724_QE3.raw
)


for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD016060 {}"


# PXD036856
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-008-2906_100min_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-008-2906_100min_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-008INF_100min_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-008INF_100min_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-008_100min_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-008_100min_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-009INF_100min_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-009INF_100min_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-009_100min_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3112_ML_360RIO-009_100min_02.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD036856 {}"

# PXD038782_raw
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/210628_SS_malignant_HNSCC_W6-32_20__orbitrap_DDA_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/210628_SS_malignant_HNSCC_W6-32_20__orbitrap_DDA_Rep2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD038782_raw {}"

# PXD038782_d
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/211113_SS_malignant_HNSCC_W6-32_20__DDA_Rep1.d.tar.gz
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/211113_SS_malignant_HNSCC_W6-32_20__DDA_Rep2.d.tar.gz
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD038782_d {}"
for f in *.tar.gz; do tar -xzvf $f; done


