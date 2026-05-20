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


# PXD007635_schuster
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa100_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa100_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa100_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa103_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa103_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa103_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa103_classI_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa103_classI_Rep5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa104_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa104_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa104_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa104_classI_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa105_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa105_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa105_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa105_classI_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa105_classI_Rep5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa109_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa109_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa109_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa109_classI_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa10_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa10_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa10_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa10_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa10_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa111_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa111_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa111_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa111_classI_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa114_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa114_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa114_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa114_classI_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa12_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa12_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa13_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa13_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa13_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa13_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa13_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa15_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa15_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa16_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa16_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa16_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa16_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa16_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa23_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa23_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa23_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa28_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa28_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa28_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa28_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa28_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa39_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa39_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa41_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa41_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa41_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa43_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa43_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa43_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa45_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa45_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa45_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa45_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa45_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa48_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa48_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa48_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa48_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa48_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa48_classI_Rep6.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa53_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa53_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa53_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa53_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa53_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa54_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa54_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa54_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa54_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa54_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa57_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa57_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa57_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa57_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa57_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa58_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa58_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa58_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa58_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa58_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa59_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa59_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa59_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa59_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa59_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa60_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa60_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa60_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa60_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa60_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa64_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa64_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa64_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa64_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa64_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa65_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa65_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa65_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa65_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa65_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa66_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa66_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa66_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa66_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa66_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa68_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa68_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa68_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa68_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa68_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa69_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa69_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa69_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa70_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa70_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa70_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa70_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa70_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa72_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa72_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa72_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa73_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa73_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa73_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa73_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa73_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa74_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa74_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa74_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa74_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa74_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa79_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa79_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa79_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa79_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa79_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa80_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa80_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa80_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa80_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa81_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa81_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa81_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa81_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa81_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa82_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa82_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa82_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa82_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa82_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa83_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa83_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa83_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa83_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa83_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa83_classI_Rep6.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa84_classI_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa84_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa84_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa84_classI_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa84_classI_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa99_classI_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa99_classI_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa99_classI_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa99_classI_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa99_classI_Rep5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa9_classI_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa9_classI_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD007635/OvCa9_classI_Rep4_.RAW
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD007635_schuster {}"


# PXD014062_HGSC
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD014062/IP_ovarian_1T_280217_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD014062/IP_ovarian_1T_280217_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD014062/IP_ovarian_2T_270217.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD014062/IP_ovarian_2T_280217_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD014062/IP_ovarian_3T_280217_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD014062/IP_ovarian_3T_280217_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD014062/11326Vd1700_Ovarian_070918.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD014062/682_16T_Ovarian_070918.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD014062/678_17T_Ovarian_070918.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD014062/OVA606_140318_JL_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD014062/OVA633_140318_JL_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/02/PXD014062/OVA642_140318_JL_4.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD014062_HGSC {}"

# PXD006939_sternberg_cl
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170608_QEh1_LC1_ChCh_FAMA_SA_HLAIp_UWB1289_ctrl_1_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170608_QEh1_LC1_ChCh_FAMA_SA_HLAIp_UWB1289_ctrl_2_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170608_QEh1_LC1_ChCh_FAMA_SA_HLAIp_UWB1289_ctrl_3_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170608_QEh1_LC1_ChCh_FAMA_SA_HLAIp_UWB1289_ctrl_4_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170608_QEh1_LC1_ChCh_FAMA_SA_HLAIp_UWB1289_IFNg_1_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170608_QEh1_LC1_ChCh_FAMA_SA_HLAIp_UWB1289_IFNg_2_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170608_QEh1_LC1_ChCh_FAMA_SA_HLAIp_UWB1289_IFNg_3_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/12/PXD006939/20170608_QEh1_LC1_ChCh_FAMA_SA_HLAIp_UWB1289_IFNg_4_R2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD006939_sternberg_cl {}"

# MSV000084442_HLAthena_OV
declare -a samples=(
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Ovarian/CP-594_v1_20161007/GG20161007_CRH_Patient100_A02_01.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Ovarian/CP-594_v1_20161007/GG20161007_CRH_Patient100_A02_02.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Ovarian/CP-594_v1_20161007/GG20161007_CRH_Patient100_W632_01.raw
ftp://massive.ucsd.edu/v02/MSV000084442/raw/RAW/Ovarian/CP-594_v1_20161007/GG20161007_CRH_Patient100_W632_02.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./MSV000084442_HLAthena_OV {}"

# phase2_PXD055609
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/01/PXD055609/T1-6472_Ovarian_MHC_ClassI_082020.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/01/PXD055609/T2-5327_Ovarian_MHC_ClassI_091120.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/01/PXD055609/T3-4447_Ovarian_MHC_ClassI_040921.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/01/PXD055609/T4-6555_Ovarian_MHC_ClassI_040921.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/01/PXD055609/T5-1546_Ovarian_MHC_ClassI_101821.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD055609 {}"

# phase2_PXD036856
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3505_ML_SCCOTH-B189974_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3505_ML_SCCOTH-B189974_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3505_ML_SCCOTH-B189974_03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3505_ML_SCCOTH-B189974_IFN_01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3505_ML_SCCOTH-B189974_IFN_02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD036856/3505_ML_SCCOTH-B189974_IFN_03.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD036856 {}"

