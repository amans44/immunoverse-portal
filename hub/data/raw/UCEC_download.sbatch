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

# PXD036856
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_4_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_4_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_4_03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_5_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_5_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_5_03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_6_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_6_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_6_03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_7_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_7_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3704_ML_7_03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3530_ML_35035TC_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3530_ML_35035TC_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3530_ML_35035TC_03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3530_ML_35035TC_04.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD036856 {}"

