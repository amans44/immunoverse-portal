#!/bin/bash
#SBATCH --partition=a100_dev
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=04:00:00
#SBATCH --mem=20Gb
#SBATCH --job-name="T_ALL Data Transfer"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1
#SBATCH --mail-user=aman.sharma@nyulangone.org
#SBATCH --mail-type=END


# PXD011723
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL605_IPP75_AN_Jurkat_C076_1BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL605_IPP75_AN_Jurkat_C076_1BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL605b_IPP75_AN_Jurkat_C076_1BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL605b_IPP75_AN_Jurkat_C076_1BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL607_IPP75_AN_Jurkat_Ig01_1BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL607_IPP75_AN_Jurkat_Ig01_1BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL607b_IPP75_AN_Jurkat_Ig01_1BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL607b_IPP75_AN_Jurkat_Ig01_1BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL609_IPP75_AN_Jurkat_Triton01_1BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL609_IPP75_AN_Jurkat_Triton01_1BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL609b_IPP75_AN_Jurkat_Triton01_1BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL609b_IPP75_AN_Jurkat_Triton01_1BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL610_IPP75_AN_Jurkat_NaD025_1BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL610_IPP75_AN_Jurkat_NaD025_1BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL610b_IPP75_AN_Jurkat_NaD025_1BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL610b_IPP75_AN_Jurkat_NaD025_1BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL613_IPP75_AN_Jurkat_C076_2BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL613_IPP75_AN_Jurkat_C076_2BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL613b_IPP75_AN_Jurkat_C076_2BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL613b_IPP75_AN_Jurkat_C076_2BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL615_IPP75_AN_Jurkat_Ig01_2BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL615b_IPP75_AN_Jurkat_Ig01_2BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL615b_IPP75_AN_Jurkat_Ig01_2BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL617_IPP75_AN_Jurkat_Triton01_2BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL617_IPP75_AN_Jurkat_Triton01_2BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL617b_IPP75_AN_Jurkat_Triton01_2BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL617b_IPP75_AN_Jurkat_Triton01_2BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL618_IPP75_AN_Jurkat_NaD025_2BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL618_IPP75_AN_Jurkat_NaD025_2BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL618b_IPP75_AN_Jurkat_NaD025_2BR_Even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL618b_IPP75_AN_Jurkat_NaD025_2BR_Odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011723/FL615_IPP75_AN_Jurkat_Ig01_2BR_Even.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD011723 {}"


# PXD024562
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/06/PXD024562/LOUCY_MHC_IP_5e8_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/06/PXD024562/LOUCY_MHC_IP_5e8_R2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD024562 {}"


