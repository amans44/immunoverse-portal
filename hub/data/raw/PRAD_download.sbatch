#!/bin/bash
#SBATCH --partition=a100_dev
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=04:00:00
#SBATCH --mem=20Gb
#SBATCH --job-name="lymphoma Data Transfer"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1
#SBATCH --mail-user=aman.sharma@nyulangone.org
#SBATCH --mail-type=END


# PXD022020

declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD022020/PC3-nzuh000502a19101xms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD022020/LNCaP_clone_FGC-nzuh000302a19101xms1.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD022020 {}"

# PXD055544

declare -a samples=(
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/10/PXD055544/TTP_YS_20031_1776_05122023_06-Dec-23_16-38-15_4709.d.zip
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/10/PXD055544/TTP_YS_20031_1777_05122023_06-Dec-23_18-36-18_4710.d.zip
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/10/PXD055544/TTP_YS_20031_1778_05122023_06-Dec-23_20-34-23_4711.d.zip
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD055544 {}"
cd ./PXD055544
for f in *.zip; do unzip $f; done

