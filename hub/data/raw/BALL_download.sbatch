#!/bin/bash
#SBATCH --partition=a100_dev
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=04:00:00
#SBATCH --mem=20Gb
#SBATCH --job-name="BALLdata_transfer"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Aman/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1
#SBATCH --mail-user=aman.sharma@nyulangone.org
#SBATCH --mail-type=END


# PXD009749
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009749/MHC_07H103_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009749/MHC_07H103_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009749/MHC_07H103_Rep3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD009749 {}"


# PXD009750

declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009750/MHC_10H118_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009750/MHC_10H118_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009750/MHC_10H118_Rep3.raw
)
for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD009750 {}"


# PXD009751
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009751/MHC_12H018_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009751/MHC_12H018_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009751/MHC_12H018_Rep3.raw

)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD009751 {}"



# PXD009753
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009753/10H080_MAE_500M_180417_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009753/10H080_MAE_500M_180417_3.raw

)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./PXD009753 {}"

# PXD000394
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120726_EXQ1_MiBa_SA_SupB15-RT_mHLA-1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120726_EXQ1_MiBa_SA_SupB15-RT_mHLA-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120726_EXQ1_MiBa_SA_SupB15-RT_mHLA-4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120726_EXQ1_MiBa_SA_SupB15-RT_mHLA-5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120726_EXQ1_MiBa_SA_SupB15-WT_mHLA-2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120726_EXQ1_MiBa_SA_SupB15-WT_mHLA-3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120726_EXQ1_MiBa_SA_SupB15-WT_mHLA-4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/01/PXD000394/20120726_EXQ1_MiBa_SA_SupB15-WT_mHLA-5.raw

)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./PXD000394 {}"

# PXD007935
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_IP_fresh_100M_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_IP_fresh_100M_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_IP_fresh_100M_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_IP_frozen_100M_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_IP_frozen_100M_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_IP_frozen_100M_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_IP_frozen_20M_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_IP_frozen_20M_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_IP_frozen_20M_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_IP_frozen_2M_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_IP_frozen_2M_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_IP_frozen_2M_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_MAE_fresh_100M_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_MAE_fresh_100M_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_MAE_fresh_100M_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_MAE_fresh_20M_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_MAE_fresh_20M_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_MAE_fresh_20M_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_MAE_fresh_2M_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_MAE_fresh_2M_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_MAE_fresh_2M_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_MAE_frozen_100M_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_MAE_frozen_100M_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/03/PXD007935/B-ALL_MAE_frozen_100M_3.raw

)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./PXD007935 {}"