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


# PXD057839
declare -a samples=(
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/06/PXD057839/OE2-20240223_002_DIA.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/06/PXD057839/OE2-20240223_004_DIA.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/06/PXD057839/OE2-20240223_006_DIA.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/06/PXD057839/OE2-20240223_008_DIA.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/06/PXD057839/OE2-20240520_006_DIA.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/06/PXD057839/OE2-20240520_008_DIA.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/06/PXD057839/OE2-20240520_010_DIA.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/06/PXD057839/OE2-20240520_012_DIA.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/06/PXD057839/OE2-20240520_018_DIA.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/06/PXD057839/OE2-20240520_020_DIA.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/06/PXD057839/OE2-20240520_022_DIA.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/06/PXD057839/OE2-20240520_024_DIA.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./PXD057839 {}"

