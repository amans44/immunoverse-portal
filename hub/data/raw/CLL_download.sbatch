#!/bin/bash
#SBATCH --partition=a100_dev
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=04:00:00
#SBATCH --mem=20Gb
#SBATCH --job-name="CLL Data Transfer"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1
#SBATCH --mail-user=aman.sharma@nyulangone.org
#SBATCH --mail-type=END


# MSV000084442
declare -a samples=(
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/CLL/CLL_DFCI-5283_2018/G20141113_JGA_3rdCML_HLA_combinedIP_hybridmethod.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/CLL/CLL_DFCI-5283_2018/G20141113_JGA_3rd_w632IP_HLA_dda_top12.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/CLL/CLL_DFCI-5283_2018/YJ20180319_SK_HLA_DFCI-5283_08_CD19_1IPs_noAPD_R1_01.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/CLL/CLL_DFCI-5283_2018/YJ20180319_SK_HLA_DFCI-5283_08_CD19_1IPs_noAPD_R1_02.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/CLL/CLL_DFCI-5283_2018/YJ20180319_SK_HLA_DFCI-5283_97_Tumor_CD19_1IPs_noAPD_R1_01.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./MSV000084442 {}"


# PXD024871
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN01_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN01_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN01_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN01_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN01_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN02_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN02_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN02_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN02_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN02_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN03_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN03_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN03_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN04_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN04_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN04_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN05_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN05_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN05_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN05_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN05_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN06_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN06_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN06_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN06_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN06_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN07_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN07_class_I_Rep10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN07_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN07_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN07_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN07_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN07_class_I_Rep6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN07_class_I_Rep7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN07_class_I_Rep8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN07_class_I_Rep9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN08_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN08_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN08_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN08_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN08_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN09_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN09_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN09_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN09_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN09_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN10_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN10_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN10_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN10_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN10_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN11_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN11_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN11_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN11_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN12_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN12_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN12_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN12_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN12_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN13_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN13_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN13_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN13_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN13_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN14_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN14_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN14_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN14_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN14_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN15_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN15_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN15_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN15_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN15_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN16_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN16_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN16_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN16_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN16_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN17_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN17_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN17_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN17_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN18_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN18_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN18_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN18_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN18_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN19_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN19_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN19_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN19_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN19_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN19_class_I_Rep6.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN19_class_I_Rep7.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN19_class_I_Rep8.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN20_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN20_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN20_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN20_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN20_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN20_class_I_Rep6.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN20_class_I_Rep7.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN20_class_I_Rep8.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN20_class_I_Rep9.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN21_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN21_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN21_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN21_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN21_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN22_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN22_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN22_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN23_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN23_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN23_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN23_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN23_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN24_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN24_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN24_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN24_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN24_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN25_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN25_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN25_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep12.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep13.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep14.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep15.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN26_class_I_Rep9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN27_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN27_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN27_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN28_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN28_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN28_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN29_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN29_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN29_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN30_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN30_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN30_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN31_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN31_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN31_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN32_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN32_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN32_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN33_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN33_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN33_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN34_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN34_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN34_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN35_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN35_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN35_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN36_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN36_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN36_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN37_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN37_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN37_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN38_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN38_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN38_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN39_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN39_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN39_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN40_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN40_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN40_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN41_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN41_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN41_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN42_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN42_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN42_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN43_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN43_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN43_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN44_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN44_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN44_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN45_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN45_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN45_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN46_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN46_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN46_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN47_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN47_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN47_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN48_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN48_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN48_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN49_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN49_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN49_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN50_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN50_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN50_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN51_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN51_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN51_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN52_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN52_class_I_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN52_class_I_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN52_class_I_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD024871/UPN52_class_I_Rep5.raw
)
for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD024871 {}"


# PXD010808
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/FL0014370.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/FL0014374.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/FL0014386.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/FL0014390.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD010808 {}"

# PXD025716
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_01_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_01_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_01_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_02_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_02_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_02_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_03_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_03_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_03_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_04_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_04_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_04_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_05_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_05_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_05_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_06_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_06_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_06_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_07_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_07_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_07_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_08_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_08_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_08_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_09_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_09_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_09_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_10_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_10_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_10_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_11_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_11_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_11_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_12_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_12_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_12_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_13_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_13_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_13_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_14_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_14_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_14_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_15_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_15_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/CLL_15_Rep_3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD025716 {}"

# PXD038782_d
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220315_NHG_malignant_CLL_22_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220315_NHG_malignant_CLL_22_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220315_NHG_malignant_CLL_22_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220331_NHG_malignant_CLL_02_W6-32_17__DDA_Rep1.d.tar.gz
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220331_NHG_malignant_CLL_02_W6-32_17__DDA_Rep2.d.tar.gz
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220331_NHG_malignant_CLL_02_W6-32_17__DDA_Rep3.d.tar.gz
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220331_NHG_malignant_CLL_19_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220331_NHG_malignant_CLL_19_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220331_NHG_malignant_CLL_19_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220404_NHG_malignant_CLL_01_W6-32_17__DDA_Rep1.d.tar.gz
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220404_NHG_malignant_CLL_01_W6-32_17__DDA_Rep2.d.tar.gz
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220404_NHG_malignant_CLL_01_W6-32_17__DDA_Rep3.d.tar.gz
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220404_NHG_malignant_CLL_20_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220404_NHG_malignant_CLL_20_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220404_NHG_malignant_CLL_20_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220404_NHG_malignant_CLL_21_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220404_NHG_malignant_CLL_21_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220404_NHG_malignant_CLL_21_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230706_NHG_malignant_CLL_13_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230706_NHG_malignant_CLL_13_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230706_NHG_malignant_CLL_13_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_07_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_07_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_07_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_08_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_08_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_08_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_09_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_09_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_09_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_10_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_10_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_10_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_15_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_15_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_15_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_17_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_17_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230713_NHG_malignant_CLL_17_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_03_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_03_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_03_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_04_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_04_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_04_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_05_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_05_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_05_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_06_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_06_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_06_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_11_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_11_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_11_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_12_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_12_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_12_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_14_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_14_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_14_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_16_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_16_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_16_W632_Rep3.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_18_W632_Rep1.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_18_W632_Rep2.d.tar
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/230717_NHG_malignant_CLL_18_W632_Rep3.d.tar
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD038782_d {}"

# PXD038782_raw
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220329_NHG_malignant_CLL_01_W6-32_17__orbitrap_DDA_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220329_NHG_malignant_CLL_01_W6-32_17__orbitrap_DDA_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220329_NHG_malignant_CLL_01_W6-32_17__orbitrap_DDA_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220329_NHG_malignant_CLL_02_W6-32_17__orbitrap_DDA_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220329_NHG_malignant_CLL_02_W6-32_17__orbitrap_DDA_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/11/PXD038782/220329_NHG_malignant_CLL_02_W6-32_17__orbitrap_DDA_Rep3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD038782_raw {}"
