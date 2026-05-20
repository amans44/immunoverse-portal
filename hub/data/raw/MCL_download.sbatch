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


# PXD005704

declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD005704/e000366_Raji_wt.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD005704/e000486_Raji_wt.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD005704/e000487_Raji_wt.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD005704/e000528_Raji_wt.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD005704/e000529_Raji_wt.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD005704/e000534_Raji_wt.raw

)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD005704 {}"


# PXD004746
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e001318.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e001319.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e001320.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002487.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002488.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002489.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e004611.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e004612.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e004613.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e001454.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e001455.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e001456.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002497.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002498.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002499.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002341.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002342.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002343.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002351.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002352.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002353.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e001898.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e001899.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e001900.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002081.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002082.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002083.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002091.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002092.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002093.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e001908.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e001909.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e001910.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e004634.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e004635.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e004636.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002131.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002132.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002133.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e003475.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e003476.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e003477.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002115.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002116.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002117.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002307.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002308.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e002309.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e000552.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e000553.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e000607.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e000548.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e000549.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e000605.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e004760.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e004761.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e004769.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e004778.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e004779.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e004780.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e005108.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e005109.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e005110.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e005008.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e005009.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e005010.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e005002.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e005003.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/03/PXD004746/e005004.raw

)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD024562 {}"


# PXD020750
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e007194.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e007193.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e007192.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e007206.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e007205.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e007204.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e005186.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e005187.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e005188.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e007200.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e007199.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e007198.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e007216.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e007211.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e007210.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e005191.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e005192.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e005193.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e002553.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e002554.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e002545.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e002546.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e002557.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD020750/e002558.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD020750 {}"


# PXD010808


declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/e009096.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/e009098.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/e009100.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/e009104.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/e009106.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/e009108.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/e008495.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/e008496.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/e008498.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/e008502.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/e008630.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD010808/e008642.raw

)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD010808 {}"

