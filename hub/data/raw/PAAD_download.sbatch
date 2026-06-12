#!/bin/bash
#SBATCH --partition=a100_dev
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=04:00:00
#SBATCH --mem=20Gb
#SBATCH --job-name="data_transfer"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1


# MSV000091456
declare -a samples=(
ftp://massive.ucsd.edu/v05/MSV000091456/raw/RawData/PDAC/AL20210827_EV_HLA_PDAC_PANFRO413_2D_50e6_W632_classI_fxn1.raw
ftp://massive.ucsd.edu/v05/MSV000091456/raw/RawData/PDAC/AL20210827_EV_HLA_PDAC_PANFRO413_2D_50e6_W632_classI_fxn2.raw
ftp://massive.ucsd.edu/v05/MSV000091456/raw/RawData/PDAC/AL20210827_EV_HLA_PDAC_PANFRO413_2D_50e6_W632_classI_fxn3.raw
ftp://massive.ucsd.edu/v05/MSV000091456/raw/RawData/PDAC/AL20221201_MKP_PDAC_01.raw
)


for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 4 -I {} bash -c "wget -P ./MSV000091456 {}"

# PXD016060
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq48521_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq63718_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq63719_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq48522_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq63720_QE3.raw
)


for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./PXD016060 {}"

# MSV000096853
declare -a samples=(
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0049/AL20230207_EV_PDAC_PANFR0049_70e6_W632_f1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0049/AL20230207_EV_PDAC_PANFR0049_70e6_W632_f2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0049/AL20230207_EV_PDAC_PANFR0049_70e6_W632_f3.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0069/AP20230119_EV_PDAC_PANFR0069_HLAI_W632_72e6_fxn01.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0069/AP20230119_EV_PDAC_PANFR0069_HLAI_W632_72e6_fxn02.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0069/AP20230119_EV_PDAC_PANFR0069_HLAI_W632_72e6_fxn03.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0071/AG20211020_EV_PDAC_PANFR0071_60e6_W632_class1_fxn1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0071/AG20211020_EV_PDAC_PANFR0071_60e6_W632_class1_fxn2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0071/AG20211020_EV_PDAC_PANFR0071_60e6_W632_class1_fxn3.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0087/AL20230207_EV_PDAC_PANFR0087_70e6_W632_f1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0087/AL20230207_EV_PDAC_PANFR0087_70e6_W632_f2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0087/AL20230207_EV_PDAC_PANFR0087_70e6_W632_f3.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0123/AY20211201_EV_PDAC_PANFR0123_60e6_W632_classI_fxn1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0123/AY20211201_EV_PDAC_PANFR0123_60e6_W632_classI_fxn2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0123/AY20211201_EV_PDAC_PANFR0123_60e6_W632_classI_fxn3.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0151/AY20211201_EV_PDAC_PANFR0151_60e6_W632_classI_fxn1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0151/AY20211201_EV_PDAC_PANFR0151_60e6_W632_classI_fxn2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0151/AY20211201_EV_PDAC_PANFR0151_60e6_W632_classI_fxn3.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0177/AY20211112_EV_PDAC_PANFR0177_60e6_W632_classI_fxn1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0177/AY20211112_EV_PDAC_PANFR0177_60e6_W632_classI_fxn2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0177/AY20211112_EV_PDAC_PANFR0177_60e6_W632_classI_fxn3.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0290/AY20211112_EV_PDAC_PANFR0290_60e6_W632_classI_fxn1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0290/AY20211112_EV_PDAC_PANFR0290_60e6_W632_classI_fxn2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0290/AY20211112_EV_PDAC_PANFR0290_60e6_W632_classI_fxn3.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0359/AL20230207_EV_PDAC_PANFR0359_70e6_W632_f1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0359/AL20230207_EV_PDAC_PANFR0359_70e6_W632_f2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0359/AL20230207_EV_PDAC_PANFR0359_70e6_W632_f3.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0402/AY20211208_EV_PDAC_PANFR0402_60e6_W632_classI_fxn1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0402/AY20211208_EV_PDAC_PANFR0402_60e6_W632_classI_fxn2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0402/AY20211208_EV_PDAC_PANFR0402_60e6_W632_classI_fxn3.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0413/AL20210827_EV_HLA_PDAC_PANFRO413_2D_50e6_W632_classI_fxn3_20210828144744.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0413/AL20210827_EV_HLA_PDAC_PANFRO413_3D_50e6_W632_classI_fxn1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/organoid/PANFR0413/AL20210827_EV_HLA_PDAC_PANFRO413_3D_50e6_W632_classI_fxn2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/primary/C3L00625/KZ20220519_EV_C3L-00625_W632_34mg_fxn1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/primary/C3L00625/KZ20220519_EV_C3L-00625_W632_34mg_fxn2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/primary/C3L00625/KZ20220519_EV_C3L-00625_W632_34mg_fxn3.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/primary/C3L01031/KZ20220519_EV_C3L-01031_W632_fxn1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/primary/C3L01031/KZ20220519_EV_C3L-01031_W632_fxn2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/primary/C3L01031/KZ20220519_EV_C3L-01031_W632_fxn3.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/primary/C3L01051/KZ20220519_EV_C3L-01051_W632_68mg_fxn1.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/primary/C3L01051/KZ20220519_EV_C3L-01051_W632_68mg_fxn2.raw
ftp://massive-ftp.ucsd.edu/v06/MSV000096853/raw/RAW/primary/C3L01051/KZ20220519_EV_C3L-01051_W632_68mg_fxn3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./MSV000096853 {}"

# phase2_PXD022020
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD022020/PANC1-bzwj001319g19101xms1.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD022020 {}"

# phase2_PXD054360
declare -a samples=(
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e6_r1.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e6_r1.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e6_r1.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e6_r2.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e6_r2.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e6_r2.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e6_r3.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e6_r3.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e6_r3.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e7_r1.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e7_r1.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e7_r1.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e7_r2.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e7_r2.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e7_r2.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e7_r3.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e7_r3.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_1e7_r3.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_5e6_r1.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_5e6_r1.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_5e6_r1.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_5e6_r2.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_5e6_r2.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_5e6_r2.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_5e6_r3.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_5e6_r3.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_0h_5e6_r3.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e6_r1.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e6_r1.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e6_r1.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e6_r2.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e6_r2.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e6_r2.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e6_r3.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e6_r3.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e6_r3.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e7_r1.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e7_r1.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e7_r1.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e7_r2.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e7_r2.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e7_r2.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e7_r3.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e7_r3.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_1e7_r3.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_5e6_r1.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_5e6_r1.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_5e6_r1.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_5e6_r2.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_5e6_r2.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_5e6_r2.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_5e6_r3.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_5e6_r3.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221123_RD_Panc1_IFNg_HLA_Small_Pellets_7600_Nano_72h_5e6_r3.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_Control.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_Control.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_Control.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_5.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_5.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_5.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_7_5.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_7_5.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_7_5.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_10.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_10.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_10.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_12_5.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_12_5.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_12_5.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_15.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_15.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_15.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_17_5.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_17_5.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_17_5.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_20.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_20.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_20.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_50.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_50.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20221126_RD_Panc1_Unt_HLA_7600_Nano_HPH_50.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_5e7_control.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_5e7_control.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_5e7_control.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_5.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_5.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_5.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_7_5.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_7_5.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_7_5.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_10.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_10.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_10.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_12_5.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_12_5.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_12_5.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_15.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_15.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_15.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_17_5.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_17_5.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_17_5.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_20.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_20.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_20.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_50.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_50.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054360/20230706_RD_Panc1_72h_HLA_7600_Nano_HPH_50.wiff2
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD054360 {}"

# phase2_PXD054417
declare -a samples=(
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230421_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e6_r1.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230421_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e6_r1.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230421_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e6_r1.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230421_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e6_r1.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230421_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e6_r2.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230421_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e6_r2.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230421_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e6_r2.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230421_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e6_r2.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e6_r3.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e6_r3.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e6_r3.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e6_r3.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e7_r1.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e7_r1.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e7_r1.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e7_r1.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e7_r2.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e7_r2.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e7_r2.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e7_r2.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e7_r3.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e7_r3.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e7_r3.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_1e7_r3.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_5e6_r1.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_5e6_r1.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_5e6_r1.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_5e6_r1.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_5e6_r2.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_5e6_r2.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_5e6_r2.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_5e6_r2.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_5e6_r3.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_5e6_r3.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_5e6_r3.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_0h_5e6_r3.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e6_r1.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e6_r1.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e6_r1.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e6_r1.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e6_r2.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e6_r2.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e6_r2.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e6_r2.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e6_r3.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e6_r3.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e6_r3.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e6_r3.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e7_r1.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e7_r1.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e7_r1.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e7_r1.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e7_r2.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e7_r2.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e7_r2.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e7_r2.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e7_r3.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e7_r3.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e7_r3.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_1e7_r3.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_5e6_r1.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_5e6_r1.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_5e6_r1.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_5e6_r1.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_5e6_r2.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_5e6_r2.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_5e6_r2.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_5e6_r2.wiff2
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_5e6_r3.wiff
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_5e6_r3.wiff.scan
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_5e6_r3.wiff.dia
https://ftp.pride.ebi.ac.uk/pride/data/archive/2025/07/PXD054417/20230422_RD_Panc1_IFNg_HLA_Small_7600_Nano_ZSW_72h_5e6_r3.wiff2
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD054417 {}"