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


# # MSV000086567
# declare -a samples=(
# ftp://massive.ucsd.edu/v03/MSV000086567/raw/K562-A1101_D180912_S1.raw
# ftp://massive.ucsd.edu/v03/MSV000086567/raw/K562-A1101_D180912_S2.raw
# ftp://massive.ucsd.edu/v03/MSV000086567/raw/K562-A1101_D180912_S3.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./MSV000086567 {}"

# PXD010450
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN01_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN01_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN01_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN01_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN01_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN02_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN02_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN02_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN02_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN02_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN03_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN03_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN03_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN03_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN03_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN04_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN04_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN04_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN04_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN04_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN05_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN05_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN05_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN05_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN05_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN06_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN06_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN07_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN07_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN07_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN07_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN07_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN08_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN08_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN08_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN08_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN08_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN09_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN09_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN09_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN09_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN09_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN10_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN10_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN10_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN10_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN10_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN11_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN11_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN11_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN11_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN11_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN12_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN12_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN12_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN12_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN12_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN13_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN13_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN13_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN13_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN13_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN14_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN14_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN14_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN14_classI_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN14_classI_Rep5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN15_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN15_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN15_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN16_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN16_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN16_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN17_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN17_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN17_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN18_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN18_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN18_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN18_classI_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN18_classI_Rep5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN18_classI_Rep6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN18_classI_Rep7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN18_classI_Rep8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN18_classI_Rep9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN19_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN19_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN19_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN19_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN19_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN20_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN20_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN20_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN21_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN21_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/12/PXD010450/UPN21_classI_Rep3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD010450 {}"


