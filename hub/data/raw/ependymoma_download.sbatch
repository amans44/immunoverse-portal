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

# PXD052448
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/171213_LM_Ependymoma_256-17_Tumor_W632_20_Rep1_25cm90min3s_msms28.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/171213_LM_Ependymoma_256-17_Tumor_W632_20_Rep2_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/171213_LM_Ependymoma_256-17_Tumor_W632_20_Rep3_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/171213_LM_Ependymoma_815-16_Tumor_W6-32_20_Rep1_25cm90min3s_msms20.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/171213_LM_Ependymoma_815-16_Tumor_W6-32_20_Rep2_25cm90min3s_msms21.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/171213_LM_Ependymoma_815-16_Tumor_W6-32_20_Rep3_25cm90min3s_msms22.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180121_LM_Ependymoma_1085-16_Tumor_W6-32_20_Rep1_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180121_LM_Ependymoma_1085-16_Tumor_W6-32_20_Rep2_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180121_LM_Ependymoma_1085-16_Tumor_W6-32_20_Rep3_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180121_LM_Ependymoma_1092-16_Tumor_W6-32_20_Rep1_25cm90min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180121_LM_Ependymoma_1092-16_Tumor_W6-32_20_Rep2_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180121_LM_Ependymoma_1092-16_Tumor_W6-32_20_Rep3_25cm90min3s_msms3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180130_LM_Ependymoma_349-17_Tumor_W6-32_20_Rep1_25cm90min3s_msms22.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180130_LM_Ependymoma_349-17_Tumor_W6-32_20_Rep2_25cm90min3s_msms23.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180130_LM_Ependymoma_349-17_Tumor_W6-32_20_Rep3_25cm90min3s_msms24.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180130_LM_Ependymoma_951-16_Tumor_W6-32_20_Rep1_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180130_LM_Ependymoma_951-16_Tumor_W6-32_20_Rep2_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180130_LM_Ependymoma_951-16_Tumor_W6-32_20_Rep3_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180416_LM_Ependymoma_115-16_Tumor_W6-32_20_Rep1_25cm90min3s_msms35.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180416_LM_Ependymoma_115-16_Tumor_W6-32_20_Rep2_25cm90min3s_msms36.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180416_LM_Ependymoma_115-16_Tumor_W6-32_20_Rep3_25cm90min3s_msms37.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180416_LM_Ependymoma_186-16_Tumor_W6-32_20_Rep1_25cm90min3s_msms21.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180416_LM_Ependymoma_186-16_Tumor_W6-32_20_Rep2_25cm90min3s_msms22.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180416_LM_Ependymoma_186-16_Tumor_W6-32_20_Rep3_25cm90min3s_msms23.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180416_LM_Ependymoma_261-14_Tumor_W6-32_20_Rep1_25cm90min3s_msms43.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180416_LM_Ependymoma_261-14_Tumor_W6-32_20_Rep2_25cm90min3s_msms44.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180416_LM_Ependymoma_261-14_Tumor_W6-32_20_Rep3_25cm90min3s_msms45.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180427_LM_Ependymoma_366-15_Tumor_W6-32_20_Rep1_25cm90min3s_msms44.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180427_LM_Ependymoma_366-15_Tumor_W6-32_20_Rep2_25cm90min3s_msms45.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180427_LM_Ependymoma_366-15_Tumor_W6-32_20_Rep3_25cm90min3s_msms46.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180427_LM_Ependymoma_624-15_Tumor_W6-32_20_Rep1_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180427_LM_Ependymoma_624-15_Tumor_W6-32_20_Rep2_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180427_LM_Ependymoma_624-15_Tumor_W6-32_20_Rep3_25cm90min3s_msms32.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180427_LM_Ependymoma_656-15_Tumor_W6-32_20_Rep1_25cm90min3s_msms22.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180427_LM_Ependymoma_656-15_Tumor_W6-32_20_Rep2_25cm90min3s_msms23.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180427_LM_Ependymoma_656-15_Tumor_W6-32_20_Rep3_25cm90min3s_msms24.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180427_LM_Ependymoma_763-16_Tumor_W6-32_20_Rep1_25cm90min3s_msms37.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180427_LM_Ependymoma_763-16_Tumor_W6-32_20_Rep2_25cm90min3s_msms38.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180427_LM_Ependymoma_763-16_Tumor_W6-32_20_Rep3_25cm90min3s_msms39.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180503_LM_Ependymoma_280-17_Tumor_W6-32_20_Rep1_25cm90min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180503_LM_Ependymoma_280-17_Tumor_W6-32_20_Rep2_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180503_LM_Ependymoma_280-17_Tumor_W6-32_20_Rep3_25cm90min3s_msms3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180503_LM_Ependymoma_974-16_Tumor_W6-32_20_Rep1_25cm90min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180503_LM_Ependymoma_974-16_Tumor_W6-32_20_Rep2_25cm90min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180503_LM_Ependymoma_974-16_Tumor_W6-32_20_Rep3_25cm90min3s_msms19.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180528_LM_Ependymoma_541-16_Tumor_W6-32_20_Rep1_25cm90min3s_msms4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180528_LM_Ependymoma_541-16_Tumor_W6-32_20_Rep2new_25cm90min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180528_LM_Ependymoma_541-16_Tumor_W6-32_20_Rep3_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180821_LM_Ependymom_199-18_Tumor_W6-32_20_Rep1_25cm90min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180821_LM_Ependymom_199-18_Tumor_W6-32_20_Rep2_25cm90min3s_msms19.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180821_LM_Ependymom_199-18_Tumor_W6-32_20_Rep3_25cm90min3s_msms20.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180821_LM_Ependymom_1398-17_Tumor_W6-32_20_Rep1_25cm90min3s_msms25.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180821_LM_Ependymom_1398-17_Tumor_W6-32_20_Rep2_25cm90min3s_msms26.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180821_LM_Ependymom_1398-17_Tumor_W6-32_20_Rep3_25cm90min3s_msms27.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180916_LM_Ependymom_565-15_Tumor_W6-32_20_Rep1_25cm90min3s_msms15.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180916_LM_Ependymom_565-15_Tumor_W6-32_20_Rep2_25cm90min3s_msms16.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180916_LM_Ependymom_565-15_Tumor_W6-32_20_Rep3_25cm90min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180918_LM_Ependymom_1052-17_Tumor_W6-32_20_Rep1_reziptip_25cm90min3s_msms45.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180918_LM_Ependymom_1052-17_Tumor_W6-32_20_Rep2_reziptip_25cm90min3s_msms46.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180918_LM_Ependymom_1052-17_Tumor_W6-32_20_Rep3_reziptip_25cm90min3s_msms47.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180918_LM_Ependymom_1134-17_Tumor_W6-32_20_Rep1_reziptip_25cm90min3s_msms38.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180918_LM_Ependymom_1134-17_Tumor_W6-32_20_Rep2_reziptip_25cm90min3s_msms39.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180918_LM_Ependymom_1134-17_Tumor_W6-32_20_Rep3_reziptip_25cm90min3s_msms40.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180918_LM_Ependymom_1403-16_Tumor_W6-32_20_Rep1_reziptip_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180918_LM_Ependymom_1403-16_Tumor_W6-32_20_Rep2_reziptip_25cm90min3s_msms32.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD052448/180918_LM_Ependymom_1403-16_Tumor_W6-32_20_Rep3_reziptip_25cm90min3s_msms33.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD052448 {}"
