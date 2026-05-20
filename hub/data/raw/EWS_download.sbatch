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

# PXD046803
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-IFN-pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-IFN-pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-IFN-pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-IFN-pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-IFN-pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-IFN-pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-IFN-pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-IFN-pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-IFN-pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-IFN-pool10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-control-pool1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-control-pool2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-control-pool3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-control-pool4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-control-pool5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-control-pool6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-control-pool7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-control-pool8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-control-pool9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/05/PXD046803/F20201104_PF_SK-N-MC_Rep3_bb72-control-pool10.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD046803 {}"
