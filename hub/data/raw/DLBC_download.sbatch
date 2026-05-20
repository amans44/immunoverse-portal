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


# PXD020620_cell_line
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/11/PXD020620/DOHH2_400M_050219_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/11/PXD020620/DOHH2_400M_050219_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/11/PXD020620/HBL1_DMSO_200M_050219_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/11/PXD020620/HBL1_DMSO_200M_050219_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/11/PXD020620/SUDHL4_400M_050219_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/11/PXD020620/SUDHL4_400M_050219_2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 6 -I {} bash -c "wget -P ./PXD020620_cell_line {}"

