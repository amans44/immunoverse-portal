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


# PXD009752_54_55_stm_Perreault
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009752/IP_lung_1T_060317_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009752/IP_lung_1T_060317_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009754/IP_lung_2T_060317_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009754/IP_lung_2T_060317_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009755/IP_lung_3T_280217_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009755/IP_lung_3T_280217_2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./PXD009752_54_55_stm_Perreault {}"

# PXD009935_Yifet_tnf_ifn
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009935/Seq51734_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009935/Seq51735_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009935/Seq51736_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009935/Seq51737_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009935/Seq51738_QE3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2018/10/PXD009935/Seq51739_QE3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 6 -I {} bash -c "wget -P ./PXD009935_Yifet_tnf_ifn {}"


# sternberg_2020_nc
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180309_QE_HFX_LC2_HLAIp_CHC_SA_tumC3N02289_4_5_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180309_QE_HFX_LC2_HLAIp_CHC_SA_tumC3N02289_4_5_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180309_QE_HFX_LC2_HLAIp_CHC_SA_tumC3N02289_4_5_R3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180426_QE_HFX_LC2_HLAIp_CHC_SA_tumC3N02671_08_R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180426_QE_HFX_LC2_HLAIp_CHC_SA_tumC3N02671_08_R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/03/PXD013649/20180426_QE_HFX_LC2_HLAIp_CHC_SA_tumC3N02671_08_R3.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 6 -I {} bash -c "wget -P ./sternberg_2020_nc {}"


# sternberg_2023_lung_nc
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191029_COL011-00030a-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191029_COL011-00030a-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191029_COL011-00031a-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191029_COL011-00031a-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191029_COL011-00032a-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191029_COL011-00032a-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191101_COL011-00006a-HLAIp_R01.raw
2ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/0191101_COL011-00006a-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191101_COL011-00007a-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191101_COL011-00007a-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191101_COL011-00008a-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191101_COL011-00008a-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191101_COL011-00009a-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191101_COL011-00009a-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191101_COL011-00010a-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191101_COL011-00010a-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191212_COL011-00014-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191212_COL011-00014-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191212_COL011-00015-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191212_COL011-00015-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191212_COL011-00016-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191212_COL011-00016-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191212_COL011-00018-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191212_COL011-00018-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191212_COL011-00019-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20191212_COL011-00019-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200526_COL011-00046-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200526_COL011-00048-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200526_COL011-00049-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200526_COL011-00050-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200526_COL011-00051-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200526_COL011-00052-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200526_COL011-00053-HLAIp_R04.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200526_COL011-00054_00055-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200526_COL011-00054_00055-HLAIp_R04.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200717_COL011-00017-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200717_COL011-00021-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200717_COL011-00021-HLAIp_R04.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200723_COL011-00036a-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200723_COL011-00036a-HLAIp_R04.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200731_COL011-00039-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200731_COL011-00040-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200731_COL011-00041-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200731_COL011-00042-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200731_COL011-00044-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200731_COL011-00045-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200731_COL011-00045-HLAIp_R04.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_COL011-00022-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_COL011-00023-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_COL011-00024-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_COL011-00026-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_COL011-00028-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_COL011-00029-HLAIp_R03.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_COL011-00029-HLAIp_R04.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_COL011-00056-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_COL011-00057-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_COL011-00059-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_COL011-00060-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_COL011-00061-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_COL011-00062-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_COL011-00063-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_COL011-00063-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_COL011-00001a-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_COL011-00002a-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_COL011-00004a-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_COL011-00005a-HLAIp_R01.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_COL011-00005a-HLAIp_R02.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200909_COL011-00025-HLAIp_R04.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./sternberg_2023_lung_nc {}"

# PXD016060
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq48140_QE2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2020/05/PXD016060/Seq48141_QE2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 2 -I {} bash -c "wget -P ./PXD016060 {}"

# phase2_PXD058303_IPX0010347000
declare -a samples=(
http://download.iprox.org/IPX0010347000/IPX0010347001/NEO_WN_161_DMS114_HLA-I_60min_1013_HM1114_tims_Slot2-2_1_5881.d.zip
http://download.iprox.org/IPX0010347000/IPX0010347001/NEO_WN_158_H526_HLA-I_60min_1009_HM1114_tims_Slot2-1_1_5830.d.zip
http://download.iprox.org/IPX0010347000/IPX0010347001/NEO_WN_162_H196_HLA-I_60min_1012_HM1114_tims_Slot2-4_1_5872.d.zip
http://download.iprox.org/IPX0010347000/IPX0010347001/NEO_WN_100_SHP77_HLAI_0717_HM1114_tims_Slot2-1_1_4886.d.zip
http://download.iprox.org/IPX0010347000/IPX0010347001/W_N385_H2066_HLAI_60min_20241010_HM1114_Slot2-2_1_2346.d.zip
http://download.iprox.org/IPX0010347000/IPX0010347001/NEO_WN_160_H82_HLA-I_60min_1013_HM1114_tims_Slot2-1_1_5879.d.zip
http://download.iprox.org/IPX0010347000/IPX0010347001/NEO_WN_167_H69_HLA-I_60min_1013_HM1114_tims_Slot2-3_1_5883.d.zip
http://download.iprox.org/IPX0010347000/IPX0010347001/NEO_WN_141_DCWT_HLAI_0905_HM1114_tims_Slot2-7_1_5348.d.zip
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD058303_IPX0010347000 {}"
cd ./phase2_PXD058303_IPX0010347000
for f in *.zip; do unzip $f; done

# phase2_PXD033351
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/DMS53.massspec.MHC1pulldown.R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/DMS53.massspec.MHC1pulldown.R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/DMS53.massspec.MHC1pulldown.R3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/DMS53.massspec.MHC1pulldown.R4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/H2228.massspec.MHC1pulldown.R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/H2228.massspec.MHC1pulldown.R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/H2228.massspec.MHC1pulldown.R3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/H2228.massspec.MHC1pulldown.R4.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD033351 {}"

# phase2_PXD043057
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/7324_1566_Vd_Lung_070918.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/7901Vd_1100_Lung_070918.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/13058Vd_1770_Lung_070918.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/AAEQEAGO_T_111022_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/COT6ZACG_T_111022_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/ILS34047D3_T_111022_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/ILS36726FT2_T_111022_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/ILS39926FT3_T_111022_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/ILS40683FT1_T_111022_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/ILS40700FT3_T_111022_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_042464T2_1_120320_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_042464T2_1_120320_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_042512T2_021020_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_042512T2_021020_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_042520T2_1_120320_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_042520T2_1_120320_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_042544T2_021020_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_042544T2_021020_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_042908T2_021020_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_042908T2_021020_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_045656T2_1_120320_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_045656T2_1_120320_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_045722T2_021020_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_045722T2_021020_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_045770T2_1_120320_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_045770T2_1_120320_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_045903T2_021020_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_045903T2_021020_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_045961T2_021020_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_045961T2_021020_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_045986T2_021020_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_045986T2_021020_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_046005T2_300920_1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2025/02/PXD043057/Lung_046005T2_300920_2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD043057 {}"

# phase2_PXD034820
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD034820/H2705BL.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD034820/4064_MC_H1650-Fr14-22.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD034820/4064_MC_H1395-Fr0-10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD034820/4064_MC_H1395-Fr14-22.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/02/PXD034820/4064_MC_H1395-Fr26-34.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD034820 {}"

# PXD022949
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/H1975_Epitope_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/H1975_Epitope_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/H1975_Epitope_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/PC9_epitope_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/PC9_epitope_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/PC9_epitope_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/PC9_epitope_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/PC9_epitope_Rep5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/PC9_epitope_Rep6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_RA007_Epitope_Rep1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_RA007_Epitope_Rep2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_RA007_Epitope_Rep3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_RA007_Epitope_Rep4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/08/PXD022949/NCI_RA007_Epitope_Rep5.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./PXD022949 {}"

# phase2_PXD038165
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/10/PXD038165/0520_1_2_Slot1-19_1_4024.d.7z
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/10/PXD038165/0520_2_1_Slot1-20_1_4027.d.7z
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/10/PXD038165/0520_5_1_Slot1-23_1_4036.d.7z
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD038165 {}"
cd ./phase2_PXD038165
module load 7zip
for f in *.7z; do 7zz x $f; done
for f in *.7z; do rm $f; done

# phase2_PXD044794
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD044794/H085878_WNE-3_CMB-710_Rupert_Immunopeptidomics_MIDRIXneo_patient_PNE1904_009_LFQ.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD044794/H085886_WNE-3_CMB-710_Rupert_Immunopep_MIDRIXneo_patient_PNE1904_009_LFQ_z2-4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD044794/B08157_Ap_WNE1_CMB-735_FRIMP-Rupert_ImmunoPep_MIDRIXneo.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2024/03/PXD044794/H088333_1p_WNE15_trap24_CMB-867_3_LFQ_PNE1904-039.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD044794 {}"

# phase2_PXD022020
declare a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2021/09/PXD022020/VMRC-LCD-nzuh000202a19101xms1.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD022020 {}"

# phase2_PXD034772_DIA
declare a samples=(
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00046-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00046-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00048-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00048-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00049-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00049-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00050-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00050-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00051-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00051-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00052-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00052-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00054_00055-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200519_DIA_COL011-00054_00055-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200526_DIA_COL011-00053-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00014-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00014-HLAIp_R04.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00015-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00015-HLAIp_R04.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00016-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00016-HLAIp_R04.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00017-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00017-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00018-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00018-HLAIp_R04.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00019-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00019-HLAIp_R04.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00021-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200715_DIA_COL011-00021-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200720_DIA_COL011-00006a-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200720_DIA_COL011-00006a-HLAIp_R04.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200720_DIA_COL011-00007a-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200720_DIA_COL011-00007a-HLAIp_R04.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200720_DIA_COL011-00008a-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200720_DIA_COL011-00008a-HLAIp_R04.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200720_DIA_COL011-00009a-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200720_DIA_COL011-00009a-HLAIp_R04.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200721_DIA_COL011-00030a-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200721_DIA_COL011-00030a-HLAIp_R04.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200721_DIA_COL011-00031a-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200721_DIA_COL011-00031a-HLAIp_R04.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200721_DIA_COL011-00032a-HLAIp_R03.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200721_DIA_COL011-00032a-HLAIp_R04.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200721_DIA_COL011-00036a-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200721_DIA_COL011-00036a-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200724_DIA_COL011-00039-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200724_DIA_COL011-00039-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200724_DIA_COL011-00040-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200724_DIA_COL011-00040-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200724_DIA_COL011-00041-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200724_DIA_COL011-00041-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200724_DIA_COL011-00042-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200724_DIA_COL011-00042-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200724_DIA_COL011-00044-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200724_DIA_COL011-00044-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200724_DIA_COL011-00045-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200724_DIA_COL011-00045-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00022-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00022-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00023-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00023-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00024-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00024-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00025-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00025-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00026-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00026-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00028-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00028-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00029-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200804_DIA_COL011-00029-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00056-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00056-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00057-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00057-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00059-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00059-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00060-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00060-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00061-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00061-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00062-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00062-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00063-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200828_DIA_COL011-00063-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_DIA_COL011-00001a-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_DIA_COL011-00001a-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_DIA_COL011-00002a-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_DIA_COL011-00002a-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_DIA_COL011-00004a-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_DIA_COL011-00004a-HLAIp_R02.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_DIA_COL011-00005a-HLAIp_R01.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2023/03/PXD034772/20200904_DIA_COL011-00005a-HLAIp_R02.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 5 -I {} bash -c "wget -P ./phase2_PXD034772_DIA {}"