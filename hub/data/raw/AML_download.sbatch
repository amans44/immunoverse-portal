#!/bin/bash
#SBATCH --partition=a100_short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=1-00:00:00
#SBATCH --mem=100Gb
#SBATCH --job-name="data_transfer"
#SBATCH --output=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.out
#SBATCH --error=/gpfs/data/yarmarkovichlab/Frank/job_dump/%j_%x.err
#SBATCH --gres=gpu:a100:1


# # PXD018542_perreault_atypical
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/05H143_131118_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/05H143_131118_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/Patient3_210618_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/07H060_141118_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/07H060_141118_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/07H063_131118_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/07H063_131118_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/07H122_141118_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/07H141_221118_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/07H141_221118_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/08H039_191118_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/08H039_191118_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/08H053_161118_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/08H053_161118_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/AML_050418_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/11H008_221118_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/11H008_221118_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/11H035_201118_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/11H035_201118_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/12H172_191118_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/12H172_191118_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/14H124_260619_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/14H124_260619_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/15H013_161118_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/15H013_161118_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/Patient1_210618_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/Patient4_210618_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/Patient2_210618_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/16H123_201118_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/16H123_201118_2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/16H145_141118_1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/03/PXD018542/16H145_141118_2.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./PXD018542_perreault_atypical {}"

# # PXD012083_plos_one_npm1_neoantigen
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e002235.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e002236.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e002237.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e002245.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e002246.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e002247.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005632.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005633.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005634.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005638.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005639.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005640.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005643.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005644.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005645.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005649.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005650.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005651.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005655.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005656.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005657.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005661.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005662.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005663.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005667.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005668.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005669.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005673.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005674.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005675.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005679.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005680.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005681.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005685.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005686.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005687.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005691.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005692.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/e005693.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/FL0012563.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/FL0012567.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/FL0012549.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/07/PXD012083/FL0012553.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD012083_plos_one_npm1_neoantigen {}"

# # PXD015039_THP1_protocol_optimization
# declare -a samples=(
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_BB72_Filter.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_BB72_P1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_BB72_P10.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_BB72_P2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_BB72_P3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_BB72_P4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_BB72_P5.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_BB72_P6.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_BB72_P7.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_BB72_P8.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_BB72_P9.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_W632_Filter.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_W632_P1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_W632_P10.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_W632_P2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_W632_P3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_W632_P4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_W632_P5.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_W632_P6.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_W632_P7.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_W632_P8.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180817_KP_THP1_W632_P9.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_BB72_Filter.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_BB72_P1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_BB72_P10new.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_BB72_P2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_BB72_P3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_BB72_P4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_BB72_P5.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_BB72_P6.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_BB72_P7.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_BB72_P8.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_BB72_P9new.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_w632_Filter.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_w632_P1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_w632_P10.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_w632_P2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_w632_P3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_w632_P4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_w632_P5.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_w632_P6.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_w632_P7.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_w632_P8.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F120180713_KP_THP1_w632_P9.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_P1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_P10.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_P2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_P3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_P4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_P5.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_P6.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_P7.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_P8.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_P9.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_filter_TR1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_filter_TR2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_w632_filter_TR3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_Filter_TR1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_Filter_TR2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_Filter_TR3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_P1.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_P10.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_P2.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_P3.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_P4.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_P5.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_P6.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_P7.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_P8.raw
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD015039/F20180830_KP_THP1_BB72_P9.raw
# )

# for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD015039_THP1_protocol_optimization {}"


# PXD038691
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN01_CD34posCD38neg_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN01_CD34posCD38neg_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN01_CD34posCD38neg_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN01_CD34posCD38neg_class_I_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN02_CD34posCD38neg_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN02_CD34posCD38neg_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN02_CD34posCD38neg_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN03_CD34posCD38neg_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN03_CD34posCD38neg_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN03_CD34posCD38neg_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN03_bulk_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN03_bulk_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN03_bulk_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN03_bulk_class_I_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN03_bulk_class_I_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN03_bulk_class_I_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN03_bulk_class_I_Rep_7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN04_CD34posCD38neg_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN04_CD34posCD38neg_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN04_CD34posCD38neg_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN04_CD34posCD38neg_class_I_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN04_bulk_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN04_bulk_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN04_bulk_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN05_CD34posCD38neg_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN05_CD34posCD38neg_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN05_CD34posCD38neg_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN05_bulk_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN05_bulk_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN05_bulk_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN05_bulk_class_I_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN05_bulk_class_I_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN05_bulk_class_I_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN05_bulk_class_I_Rep_7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN06_CD34posCD38neg_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN06_CD34posCD38neg_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN06_CD34posCD38neg_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN06_bulk_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN06_bulk_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN06_bulk_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN06_bulk_class_I_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN06_bulk_class_I_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN06_bulk_class_I_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_CD34posCD38neg_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_CD34posCD38neg_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_CD34posCD38neg_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_CD34posCD38neg_class_I_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_CD34posCD38neg_class_I_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_bulk_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_bulk_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_bulk_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_bulk_class_I_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_bulk_class_I_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_bulk_class_I_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_bulk_class_I_Rep_7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_bulk_class_I_Rep_8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN07_bulk_class_I_Rep_9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN08_CD34posCD38neg_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN08_CD34posCD38neg_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN08_CD34posCD38neg_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN08_CD34posCD38neg_class_I_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN08_bulk_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN08_bulk_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN08_bulk_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN08_bulk_class_I_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN08_bulk_class_I_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN08_bulk_class_I_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN09_CD34posCD38neg_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN09_CD34posCD38neg_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN09_CD34posCD38neg_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN10_CD34posCD38neg_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN10_CD34posCD38neg_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN10_CD34posCD38neg_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN12_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN12_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN12_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN12_relapse_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN12_relapse_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN12_relapse_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN13_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN13_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN13_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN14_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN14_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN14_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN15_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN15_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN15_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN16_BM_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN16_BM_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN16_BM_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN16_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN16_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN16_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN17_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN17_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN17_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN17_class_I_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN17_class_I_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN17_class_I_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN17_class_I_Rep_7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN17_class_I_Rep_8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN17_class_I_Rep_9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN17_class_I_Rep_10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN17_class_I_Rep_11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN18_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN18_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN18_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN19_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN19_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN19_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN20_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN20_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN20_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN21_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN21_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN21_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN22_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN22_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN22_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN23_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN23_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN23_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN24_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN24_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN24_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN25_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN25_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN25_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN26_BM_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN26_BM_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN26_BM_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN26_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN26_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN26_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN27_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN27_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN27_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN28_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN28_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN28_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN28_class_I_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN28_class_I_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN29_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN29_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN29_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN30_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN30_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN30_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN30_relapse_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN30_relapse_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN30_relapse_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN31_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN31_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN31_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN32_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN32_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN32_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN33_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN33_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN33_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN34_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN34_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN34_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN35_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN35_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN35_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN36_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN36_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN36_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN37_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN37_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN37_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN38_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN38_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN38_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN39_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN39_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN39_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN40_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN40_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN40_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN41_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN41_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN41_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN42_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN42_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN42_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN43_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN43_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN43_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN43_class_I_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN44_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN44_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN44_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN45_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN45_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN45_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN46_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN46_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN46_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN47_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN47_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN47_class_I_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN48_class_I_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN48_class_I_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/08/PXD038691/UPN48_class_I_Rep_3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD038691 {}"

# phase2_PXD025716
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_01_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_01_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_01_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_01_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_01_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_01_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_02_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_02_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_02_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_02_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_02_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_02_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_02_Rep_7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_02_Rep_8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_02_Rep_9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_03_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_03_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_03_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_04_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_04_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_04_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_05_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_05_Rep_10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_05_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_05_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_05_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_05_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_05_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_05_Rep_7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_05_Rep_8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_05_Rep_9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_06_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_06_Rep_10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_06_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_06_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_06_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_06_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_06_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_06_Rep_7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_06_Rep_8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_06_Rep_9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_07_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_07_Rep_10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_07_Rep_11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_07_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_07_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_07_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_07_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_07_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_07_Rep_7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_07_Rep_8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_07_Rep_9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_08_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_08_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_08_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_08_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_08_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_08_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_09_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_09_Rep_10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_09_Rep_11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_09_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_09_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_09_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_09_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_09_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_09_Rep_7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_09_Rep_8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_09_Rep_9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_10_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_10_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_10_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_11_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_11_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_11_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_11_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_11_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_11_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_11_Rep_7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_11_Rep_8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_11_Rep_9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_12_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_12_Rep_10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_12_Rep_11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_12_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_12_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_12_Rep_4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_12_Rep_5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_12_Rep_6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_12_Rep_7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_12_Rep_8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_12_Rep_9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_13_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_13_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_13_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_14_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_14_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_14_Rep_3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_15_Rep_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_15_Rep_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/04/PXD025716/AML_15_Rep_3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD025716 {}"

# phase2_PXD015748
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN11_class_I_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN11_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN11_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN11_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN11_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN12_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN12_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN12_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN13_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN13_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN13_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN13_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN13_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN14_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN14_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN14_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN14_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN14_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN15_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN15_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN15_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN15_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN15_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN16_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN16_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN16_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN16_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN16_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN17_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN17_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN17_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN17_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN17_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN1_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN1_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN1_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN1_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN1_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN3_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN3_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN3_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN3_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN3_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN4_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN4_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN4_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN4_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN4_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN5_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN5_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN5_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN5_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN5_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN6_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN6_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN6_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN6_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN6_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN7_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN7_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN7_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN7_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN7_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN8_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN8_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN8_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN8_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN8_class_I_Rep5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN9_class_I_Rep1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN9_class_I_Rep2.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN9_class_I_Rep3.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN9_class_I_Rep4.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/10/PXD015748/UPN9_class_I_Rep5.RAW
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD015748 {}"