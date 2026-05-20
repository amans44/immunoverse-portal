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


# PXD035324

declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140103_SW_U266_preTherapy1_W_Adjusted_20__Rep1_25cm90min3s_msms1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140103_SW_U266_preTherapy1_W_Adjusted_20__Rep2_25cm90min3s_msms4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140103_SW_U266_preTherapy1_W_Adjusted_20__Rep3_25cm90min3s_msms7.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140103_SW_U266_preTherapy1_W_Adjusted_20__Rep4_25cm90min3s_msms10.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140103_SW_U266_preTherapy1_W_Adjusted_20__Rep5_25cm90min3s_msms13.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140108_SW_U266_preTherapy2_W_Adjusted_20__Rep1_25cm90min3s_msms5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140108_SW_U266_preTherapy2_W_Adjusted_20__Rep2_25cm90min3s_msms8.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140108_SW_U266_preTherapy2_W_Adjusted_20__Rep3_25cm90min3s_msms11.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140108_SW_U266_preTherapy2_W_Adjusted_20__Rep4_25cm90min3s_msms14.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140108_SW_U266_preTherapy2_W_Adjusted_20__Rep5_25cm90min3s_msms17.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140117_SW_U266_preTherapy_W_Rest_50__Rep1_25cm90min3s_msms1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140117_SW_U266_preTherapy_W_Rest_50__Rep2_25cm90min3s_msms7.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre1_W_Adjusted2_20__Rep1_25cm90min3s_msms1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre1_W_Adjusted2_20__Rep2_25cm90min3s_msms16.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre1_W_Adjusted2_20__Rep3_25cm90min3s_msms31.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre1_W_Adjusted2_20__Rep4_25cm90min3s_msms46.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre1_W_Adjusted2_20__Rep5_25cm90min3s_msms61.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre2_W_Adjusted2_20__Rep1_25cm90min3s_msms6.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre2_W_Adjusted2_20__Rep2_25cm90min3s_msms21.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre2_W_Adjusted2_20__Rep3_25cm90min3s_msms36.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre2_W_Adjusted2_20__Rep4_25cm90min3s_msms51.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre2_W_Adjusted2_20__Rep5_25cm90min3s_msms65.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre3_W_Adjusted2_20__Rep1_25cm90min3s_msms11.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre3_W_Adjusted2_20__Rep2_25cm90min3s_msms26.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre3_W_Adjusted2_20__Rep3_25cm90min3s_msms41.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre3_W_Adjusted2_20__Rep4_25cm90min3s_msms56.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140606_SW_MM1S_Pre3_W_Adjusted2_20__Rep5_25cm90min3s_msms70.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140806_SW_JJN3_W_20__Rep1_50cm195min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140806_SW_JJN3_W_20__Rep2_50cm195min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140806_SW_JJN3_W_20__Rep3_50cm195min3s_msms3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140806_SW_JJN3_W_20__Rep4_50cm195min3s_msms4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140806_SW_JJN3_W_20__Rep5_50cm195min3s_msms5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140807_SW_LP1_W_20__Rep1_50cm195min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140807_SW_LP1_W_20__Rep2_50cm195min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140807_SW_LP1_W_20__Rep3_50cm195min3s_msms3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140807_SW_LP1_W_20__Rep4_50cm195min3s_msms4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140807_SW_LP1_W_20__Rep5_50cm195min3s_msms5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141017_SW_MM1S_Pre1_W_20__DoseFinding_25cm90min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141017_SW_MM1S_Pre2_W_20__DoseFinding_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141017_SW_MM1S_Pre3_W_20__DoseFinding_25cm90min3s_msms11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141020_SW_MM1S_Pre1_W_20__DoseFinding2_25cm90min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141020_SW_MM1S_Pre2_W_20__DoseFinding2_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141020_SW_MM1S_Pre3_W_20__DoseFinding2_25cm90min3s_msms11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre1_W_Adjusted24_20__Rep1_25cm90min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre1_W_Adjusted24_20__Rep2_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre1_W_Adjusted24_20__Rep3_25cm90min3s_msms19.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre1_W_Adjusted24_20__Rep4_25cm90min3s_msms28.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre1_W_Adjusted24_20__Rep5_25cm90min3s_msms37.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre2_W_Adjusted24_20__Rep1_25cm90min3s_msms4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre2_W_Adjusted24_20__Rep2_25cm90min3s_msms13.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre2_W_Adjusted24_20__Rep3_25cm90min3s_msms22.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre2_W_Adjusted24_20__Rep4_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre2_W_Adjusted24_20__Rep5_25cm90min3s_msms40.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre3_W_Adjusted24_20__Rep1_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre3_W_Adjusted24_20__Rep2_25cm90min3s_msms16.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre3_W_Adjusted24_20__Rep3_25cm90min3s_msms25.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre3_W_Adjusted24_20__Rep4_25cm90min3s_msms34.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/141027_SW_MM1S_Pre3_W_Adjusted24_20__Rep5_25cm90min3s_msms43.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140425_SW_RPMI8226_W_20__Rep1_50cm195min3s_msms11.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140425_SW_RPMI8226_W_20__Rep2_50cm195min3s_msms17.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140514_SW_RPMI8226_W_20__3_50cm195min3s_msms5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140514_SW_RPMI8226_W_20__4_50cm195min3s3-50_B_msms6.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/07/PXD035324/140514_SW_RPMI8226_W_20__5_50cm195min3s3-63_B_msms7.RAW
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD035324 {}"

