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


# PXD028738
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL704b_IPP85_Xu_Hela_MHCI_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL704b_IPP85_Xu_Hela_MHCI_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL704_IPP85_Xu_Hela_MHCI_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL704_IPP85_Xu_Hela_MHCI_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL705b_IPP85_Xu_C33_MHCI_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL705b_IPP85_Xu_C33_MHCI_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL705_IPP85_Xu_C33_MHCI_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL705_IPP85_Xu_C33_MHCI_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL706b_IPP85_Xu_SIHA_MHCI_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL706b_IPP85_Xu_SIHA_MHCI_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL706_IPP85_Xu_SIHA_MHCI_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL706_IPP85_Xu_SIHA_MHCI_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL707b_IPP85_Xu_DOTC2_MHCI_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL707b_IPP85_Xu_DOTC2_MHCI_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL707_IPP85_Xu_DOTC2_MHCI_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL707_IPP85_Xu_DOTC2_MHCI_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL708b_IPP85_Xu_CASKI_MHCI_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL708b_IPP85_Xu_CASKI_MHCI_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL708_IPP85_Xu_CASKI_MHCI_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD028738/FL708_IPP85_Xu_CASKI_MHCI_odd.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD028738 {}"

# PXD046182
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_1-2_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_1-2_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_1_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_1_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_2-2_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_2-2_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_2_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_2_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_3-2_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_3-2_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_3_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_3_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_4-2_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_4-2_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_4_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_4_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_5-2_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_5-2_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_5_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_5_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_6-2_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_6-2_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_6_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_6_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_7-2_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_7-2_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_7_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_7_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_8-2_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_8-2_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_8_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_8_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_9-2_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_9-2_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_9_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_9_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_10-2_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_10-2_odd.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_10_even.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/01/PXD046182/HFX0063_IPP180_Xu_CT_10_odd.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD046182 {}"

# phase2_PXD022020
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD022020/CaSki_spike-bzwj000219g19101xms1.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD022020 {}"
