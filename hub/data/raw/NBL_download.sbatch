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

# PXD027182
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB-1691_PDX_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB-1691_PDX_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB-1691_PDX_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB-1771_PDX_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB-1771_PDX_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB-1771_PDX_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB1_PALVKK-0BUDIX_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB1_PALVKK-0BUDIX_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB1_PALVKK-0BUDIX_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB2_PANXJL-0BUDH3_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB2_PANXJL-0BUDH3_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB2_PANXJL-0BUDH3_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB3_PAPBJE-0BUDVH_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB3_PAPBJE-0BUDVH_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB3_PAPBJE-0BUDVH_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB4_PAPCTS-0BUDWZ_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB4_PAPCTS-0BUDWZ_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB4_PAPCTS-0BUDWZ_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB5_PAPVRN-0BUDPP_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB5_PAPVRN-0BUDPP_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB5_PAPVRN-0BUDPP_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB6_PARKGJ-0BUDLX_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB6_PARKGJ-0BUDLX_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB6_PARKGJ-0BUDLX_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB7_PARZCJ-0BUDZC_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB7_PARZCJ-0BUDZC_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB7_PARZCJ-0BUDZC_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB8_PASEGA-0BUDQN_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB8_PASEGA-0BUDQN_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB8_PASEGA-0BUDQN_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB-Ebc1_PDX_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB-Ebc1_PDX_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB-Ebc1_PDX_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB_PDX_COG-N-415x_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB_PDX_COG-N-415x_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB_PDX_COG-N-415x_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB_PDX_COG-N-440x_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB_PDX_COG-N-440x_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB_PDX_COG-N-440x_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB_PDX_COG-N-471x_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB_PDX_COG-N-471x_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB_PDX_COG-N-471x_W632_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB_PDX_NB-SD_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/NB_PDX_NB-SD_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/SK-N-AS_PDX_W632_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/SK-N-AS_PDX_W632_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD027182/SK-N-AS_PDX_W632_3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD027182 {}"
