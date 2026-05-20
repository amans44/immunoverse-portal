#!/bin/bash
#SBATCH --partition=a100_short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=1-00:00:00
#SBATCH --mem=100Gb
#SBATCH --job-name="transfer"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1


# PXD016060
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq48142_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq58386_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq58387_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq58388_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq58389_QE3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./PXD016060 {}"

