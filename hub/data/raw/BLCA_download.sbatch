#!/bin/bash
#SBATCH --partition=gpu8_medium
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --time=1-00:00:00
#SBATCH --mem=100Gb
#SBATCH --job-name="transfer"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.err
#SBATCH --gres=gpu:v100:1


# PXD016060
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq48519_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq48520_QE2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 2 -I {} bash -c "wget -P ./PXD016060 {}"

