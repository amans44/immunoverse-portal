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

# PXD038273
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/09/PXD038273/Jacopo_Mesothelioma_Ligandome_H28_20210325_10ul_21-05-03_3881.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/09/PXD038273/Jacopo_Mesothelioma_Ligandome_H28_20210408_10ul_21-05-04_3884.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/09/PXD038273/Jacopo_Gabriella_Ligandome_H2452_20210519_21-07-15_4627.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/09/PXD038273/Jacopo_Gabriella_Ligandome_H2452_20210616_21-07-16_4631.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/09/PXD038273/Jacopo_Gabriella_Ligandome_JL1_20210519_21-07-15_4625.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/09/PXD038273/Jacopo_Gabriella_Ligandome_JL1_20210616_21-07-16_4629.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/09/PXD038273/Jacopo_Mesothelioma_Ligandome_MSTO211H_20210325_10ul_21-05-04_3887.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/09/PXD038273/Jacopo_Mesothelioma_Ligandome_MSTO211H_20210408_10ul_21-05-04_3890.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/09/PXD038273/Mesothelioma_Ligandome_2022may_Meso1_001_22-05-30_5920.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/09/PXD038273/Mesothelioma_Ligandome_2022may_Meso2_002pellet1_22-05-30_5922.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/09/PXD038273/Mesothelioma_Ligandome_2022may_Meso3_002pellet3_22-05-30_5924.d.zip
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/09/PXD038273/Mesothelioma_Ligandome_2022may_Meso4_002benign_22-05-30_5926.d.zip
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD038273 {}"
