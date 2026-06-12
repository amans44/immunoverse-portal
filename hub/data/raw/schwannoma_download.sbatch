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


# PXD013831
declare -a samples=(
https://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD013831/20171206_QE_HFX_LC2_JMI_HLApI_3989-HT_R01.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./PXD013831 {}"

