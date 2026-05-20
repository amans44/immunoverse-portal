#!/bin/bash
#SBATCH --partition=a100_short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --mem=100Gb
#SBATCH --job-name="brest-cancer_transfer-short"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1


# PXD031108
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_181t_even_a_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_181t_even_b_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_181t_odd_a_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_181t_odd_b_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_216t_even_a_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_216t_even_b_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_216t_odd_a_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_216t_odd_b_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_430t_even_a_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_430t_even_b_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_430t_odd_a_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_430t_odd_b_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_454t_even_a_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_454t_even_b_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_454t_odd_a_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_454t_odd_b_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_489t_even_a_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_489t_even_b_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_489t_odd_a_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/ben_220818_tu_489t_odd_b_mhc1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/bln_130519_mhc1ipunder_711-16_t_even1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/bln_130519_mhc1ipunder_711-16_t_even2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/bln_130519_mhc1ipunder_711-16_t_odd1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/bln_130519_mhc1ipunder_711-16_t_odd2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/bln_130519_mhc1ipunder_716-16_t_even1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/bln_130519_mhc1ipunder_716-16_t_even2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/bln_130519_mhc1ipunder_716-16_t_odd1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD031108/bln_130519_mhc1ipunder_716-16_t_odd2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD031108 {}"

