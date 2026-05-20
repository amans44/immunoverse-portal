#!/bin/bash
#SBATCH --partition=a100_short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --mem=100Gb
#SBATCH --job-name="brest-cancer_transfer-short"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Aman/job_dump/_j__x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Aman/job_dump/_j__x.err
#SBATCH --gres=gpu:a100:1


# PXD033935
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT1_W632_20__Rep1_25cm90min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT1_W632_20__Rep2_25cm90min3s_msms13.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT1_W632_20__Rep3_25cm90min3s_msms14.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT2_W632_20__Rep1_25cm90min3s_msms3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT2_W632_20__Rep2_25cm90min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT2_W632_20__Rep3_25cm90min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT3_W632_20__Rep1_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT3_W632_20__Rep2_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT3_W632_20__Rep3_25cm90min3s_msms32.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT4_W632_20__Rep1_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT4_W632_20__Rep2_25cm90min3s_msms36.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT4_W632_20__Rep3_25cm90min3s_msms37.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT5_W632_20__Rep1_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT5_W632_20__Rep2_25cm90min3s_msms41.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160607_NT_ATRT5_W632_20__Rep3_25cm90min3s_msms42.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT10_W632_20__Rep1_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT10_W632_20__Rep2_25cm90min3s_msms24.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT10_W632_20__Rep3_25cm90min3s_msms25.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT11_W632_20__Rep1_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT11_W632_20__Rep2_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT11_W632_20__Rep3_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT12_W632_20__Rep1_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT12_W632_20__Rep2_25cm90min3s_msms34.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT12_W632_20__Rep3_25cm90min3s_msms35.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT13_W632_20__Rep1_25cm90min3s_msms38.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT14_W632_20__Rep1_25cm90min3s_msms41.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT15_W632_20__Rep1_25cm90min3s_msms43.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT16_W632_20__Rep1_25cm90min3s_msms45.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT18_W632_20__Rep1_25cm90min3s_msms50.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT19_W632_20__Rep1_25cm90min3s_msms52.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT8_W632_20__Rep1_25cm90min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT8_W632_20__Rep2_25cm90min3s_msms13.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT8_W632_20__Rep3_25cm90min3s_msms14.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT8_W632_20__Rep4_25cm90min3s_msms15.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT8_W632_20__Rep5_25cm90min3s_msms16.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT9_W632_20__Rep1_25cm90min3s_msms3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT9_W632_20__Rep2_25cm90min3s_msms20.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160610_NT_ATRT9_W632_20__Rep3_25cm90min3s_msms21.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160617_NT_ATRT13_W632_20__Rep2_25cm90min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160617_NT_ATRT13_W632_20__Rep3_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160617_NT_ATRT13_W632_20__Rep5_25cm90min3s_msms5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160617_NT_ATRT14_W632_20__Rep2_25cm90min3s_msms11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160617_NT_ATRT14_W632_20__Rep3_25cm90min3s_msms12.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160617_NT_ATRT15_W632_20__Rep2_25cm90min3s_msms15.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160617_NT_ATRT15_W632_20__Rep3_25cm90min3s_msms16.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160719_NT_ATRT14_W632_20__Rep2_25cm90min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160719_NT_ATRT14_W632_20__Rep3_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160719_NT_ATRT15_W632_20__Rep2_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160719_NT_ATRT15_W632_20__Rep3_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160719_NT_ATRT16_W632_20__Rep2_25cm90min3s_msms11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160719_NT_ATRT16_W632_20__Rep3_25cm90min3s_msms12.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160719_NT_ATRT16_W632_20__Rep4_25cm90min3s_msms13.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160719_NT_ATRT16_W632_20__Rep5_25cm90min3s_msms14.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160719_NT_ATRT18_W632_20__Rep2_25cm90min3s_msms22.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160719_NT_ATRT18_W632_20__Rep3_25cm90min3s_msms23.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160719_NT_ATRT19_W632_20__Rep2_25cm90min3s_msms34.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/160719_NT_ATRT19_W632_20__Rep3_25cm90min3s_msms35.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT17_W632_20__Rep1_25cm90min3s_msms24.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT17_W632_20__Rep2_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT17_W632_20__Rep3_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT17_W632_20__Rep4_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT17_W632_20__Rep5_25cm90min3s_msms32.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT23_W632_20__Rep1_25cm90min3s_msms45.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT23_W632_20__Rep2_25cm90min3s_msms46.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT23_W632_20__Rep3_25cm90min3s_msms47.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT6_W632_20__Rep1_25cm90min3s_msms26.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT6_W632_20__Rep2_25cm90min3s_msms37.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT6_W632_20__Rep3_25cm90min3s_msms38.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT6_W632_20__Rep4_25cm90min3s_msms39.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT6_W632_20__Rep5_25cm90min3s_msms40.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT7_Aszites_W632_20__Rep1_25cm90min3s_msms53.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT7_Aszites_W632_20__Rep2_25cm90min3s_msms54.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT7_Aszites_W632_20__Rep3_25cm90min3s_msms55.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT7_Primary_Tumor_W632_20__Rep1_25cm90min3s_msms58.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT7_Primary_Tumor_W632_20__Rep2_25cm90min3s_msms64.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT7_Primary_Tumor_W632_20__Rep3_25cm90min3s_msms65.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT7_Primary_Tumor_W632_20__Rep4_25cm90min3s_msms66.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170116_AM_ATRT7_Primary_Tumor_W632_20__Rep5_25cm90min3s_msms67.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170121_AM_ATRT20_W632_20__Rep1_25cm90min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170121_AM_ATRT20_W632_20__Rep2_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170121_AM_ATRT20_W632_20__Rep3_25cm90min3s_msms3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170121_AM_ATRT21_W632_20__Rep1_25cm90min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170121_AM_ATRT21_W632_20__Rep2_25cm90min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170121_AM_ATRT21_W632_20__Rep3_25cm90min3s_msms19.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170121_AM_ATRT22_W632_20__Rep1_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170121_AM_ATRT22_W632_20__Rep2_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170121_AM_ATRT22_W632_20__Rep3_25cm90min3s_msms11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170121_AM_ATRT7_Aszites_W632_20__Rep4_25cm90min3s_msms25.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/05/PXD033935/170121_AM_ATRT7_Aszites_W632_20__Rep5_25cm90min3s_msms26.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD033935 {}"

