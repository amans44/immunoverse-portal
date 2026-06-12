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


# PXD013831
declare -a samples=(
https://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD013831/20171206_QE_HFX_LC2_JMI_HLApI_OVZW-1P_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2019/12/PXD013831/20171206_QE_HFX_LC2_JMI_HLApI_OVZW-1P_R02.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD013831 {}"
