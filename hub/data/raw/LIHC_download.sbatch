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

# PXD023143
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2047_L_MdB_6jan2020_MdB027_HCC.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2047_L_MdB_6jan2020_MdB027_HCC_20200107142218.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2060_L_MdB069_1mei19_donor_MdB029_HCC_2_OT.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2060_L_MdB069_1mei19_donor_MdB029_HCC_OT.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2064_L_MdB071_7mei19_donor_MdB032_HCC_OT.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2064_L_MdB071_7mei19_donor_MdB032_HCC_OT_2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2069_L_MdB076_17mei19_donor_MdB033_HCC_OT.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2069_L_MdB076_17mei19_donor_MdB033_HCC_OT_20190520124355.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2047_L_MdB_6jan2020_MdB037_HCC.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2047_L_MdB_6jan2020_MdB037_HCC_20200108041530.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2062_L_MdB070_3mei19_donor_MdB057_HCC_2_OT.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2062_L_MdB070_3mei19_donor_MdB057_HCC_OT.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2064_L_MdB071_7mei19_donor_MdB066_HCC_OT.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2022/09/PXD023143/2064_L_MdB071_7mei19_donor_MdB066_HCC_OT_2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD023143 {}"


# PXD037270
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv1_09945T1_3_.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv2_0000032532.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv3_0000040312.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv4_0000031295.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv5_0000049186.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv6_0000049219.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv7_ILS37316FT2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv8_ILS30987D2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv9_ILS24999D2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv10_ILS39940FT1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv11_ILS31761D1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv12_ILS22791D2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv13_ILS23304D2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv14_ILS20947D3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv15_ILS21034D4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv16_ILS42208FT1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv17_ILS22914D2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv18_ILS20954D2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv19_ILS21955D2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv20_ILS10922D04.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv21_499956PF.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv22_524614VF.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv23_ILS35989FT2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv24_ILS42195FT1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv25_ILS45824FT1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv26_ILS36725FT2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv27_ILS37352FT1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv28_ILS50526FA1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv29_ILS50526FT2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv30_ILS50523FA1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv31_ILS50523FT2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv32_1176935F.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv33_1176559F.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv34_1182970F.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv35_1181680F.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv36_1182812F.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv37_1189452F.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv38_1193117F.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv39_1192879F.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv40_405295F2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv41_ILS32961D2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv42_ILS33989D2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv43_ILS22892S1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv44_ILS24966D3-DS2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv45_ILS30194D2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv46_ILS32365D1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv47_ILS32963D1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD037270/Liv48_ILS36088FT2.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./PXD037270 {}"


# phase2_PXD013057
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/131025_NT_HCC23_Tumor_LysatReRun_W_20%_#1_50cm195min5s_msms10.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/131025_NT_HCC23_Tumor_W_20%_#1_50cm195min5s_msms1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/131025_NT_HCC24_Tumor_W_20%_#1_50cm195min5s_msms6.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/140124_NT_HCC25_Tumor_W_20%_Rep#1_25cm90min3s_msms1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/140122_NT_HCC26_Tumor_W_20%_Rep#1_25cm90min3s_msms5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/140221_nt_HCC27_Tumor_W_20%_Rep#1_50cm195min5s_msms1.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/140221_nt_HCC28_Tumor_W_20%_Rep#1_50cm195min5s_msms5.RAW
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/161002_RZ_HCC030_Tumor_W_Adjusted_#2_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/161002_RZ_HCC030_Tumor_W_Adjusted_#3_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/161002_RZ_HCC030_Tumor_W_Adjusted_#4_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/161002_RZ_HCC030_Tumor_W_Adjusted_#5_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160830_RZ_HCC0034_Tumor_W_Adjusted_#2_25cm90min3s_msms16.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160830_RZ_HCC0034_Tumor_W_Adjusted_#3_25cm90min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160830_RZ_HCC0034_Tumor_W_Adjusted_#4_25cm90min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160830_RZ_HCC0034_Tumor_W_Adjusted_#5_25cm90min3s_msms19.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160830_RZ_HCC0034_Tumor_W_DoseFinding_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160918_RZ_HCC035_Tumor_W_Adjusted_#1_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160918_RZ_HCC035_Tumor_W_Adjusted_#2_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160918_RZ_HCC035_Tumor_W_Adjusted_#3_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160918_RZ_HCC035_Tumor_W_Adjusted_#4_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160918_RZ_HCC035_Tumor_W_Adjusted_#5_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160923_RZ_HCC036_Tumor_W_Adjusted_#2_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160923_RZ_HCC036_Tumor_W_Adjusted_#3_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160923_RZ_HCC036_Tumor_W_Adjusted_#4_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160923_RZ_HCC036_Tumor_W_Adjusted_#5_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/180130_LM_HCC38_Tumor_W6-32_8%_Dosefinding_25cm90min3s_msms38.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/180130_LM_HCC38_Tumor_W6-32_8%_Rep#2_25cm90min3s_msms49.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/180130_LM_HCC38_Tumor_W6-32_8%_Rep#3_25cm90min3s_msms50.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/180130_LM_HCC38_Tumor_W6-32_8%_Rep#4_25cm90min3s_msms51.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/180130_LM_HCC38_Tumor_W6-32_8%_Rep#5_25cm90min3s_msms52.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160912_RZ_HCC040_Tumor_W_Adjusted_#1_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160912_RZ_HCC040_Tumor_W_Adjusted_#2_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160912_RZ_HCC040_Tumor_W_Adjusted_#3_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160912_RZ_HCC040_Tumor_W_Adjusted_#4_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160912_RZ_HCC040_Tumor_W_Adjusted_#5_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/161002_RZ_HCC041_Tumor_W_Adjusted_#1_25cm90min3s_msms28.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/161002_RZ_HCC041_Tumor_W_Adjusted_#2_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/161002_RZ_HCC041_Tumor_W_Adjusted_#3_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/161002_RZ_HCC041_Tumor_W_Adjusted_#4_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/161002_RZ_HCC041_Tumor_W_Adjusted_#5_25cm90min3s_msms32.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160912_RZ_HCC042_Tumor_W_Adjusted_#2_25cm90min3s_msms38.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160912_RZ_HCC042_Tumor_W_Adjusted_#3_25cm90min3s_msms39.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160912_RZ_HCC042_Tumor_W_Adjusted_#4_25cm90min3s_msms40.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160912_RZ_HCC042_Tumor_W_Adjusted_#5_25cm90min3s_msms41.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160824_RZ_HCC0043_Tumor_W_Adjusted_#1_25cm90min3s_msms21.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160824_RZ_HCC0043_Tumor_W_Adjusted_#2_25cm90min3s_msms22.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160824_RZ_HCC0043_Tumor_W_Adjusted_#3_25cm90min3s_msms23.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160824_RZ_HCC0043_Tumor_W_Adjusted_#4_25cm90min3s_msms24.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/160824_RZ_HCC0043_Tumor_W_Adjusted_#5_25cm90min3s_msms25.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#1_Tumor_W_NewDoseFinding_1to10_25cm90min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170710_RZ_HCC45#1_Tumor_W_New_adjusted_Rep1_25cm90min3s_msms1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170710_RZ_HCC45#1_Tumor_W_New_adjusted_Rep2_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170710_RZ_HCC45#1_Tumor_W_New_adjusted_Rep3_25cm90min3s_msms3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170710_RZ_HCC45#1_Tumor_W_New_adjusted_Rep4_25cm90min3s_msms4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170710_RZ_HCC45#1_Tumor_W_New_adjusted_Rep5_25cm90min3s_msms5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170710_RZ_HCC45#7_Tumor_W_New_adjusted_Rep1_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170710_RZ_HCC45#7_Tumor_W_New_adjusted_Rep2_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170710_RZ_HCC45#7_Tumor_W_New_adjusted_Rep3_25cm90min3s_msms9.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170710_RZ_HCC45#7_Tumor_W_New_adjusted_Rep4_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170710_RZ_HCC45#7_Tumor_W_New_adjusted_Rep5_25cm90min3s_msms11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#2_Tumor_W_ReZipTip_New_adjusted_Rep1_25cm90min3s_msms4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#2_Tumor_W_ReZipTip_New_adjusted_Rep2_25cm90min3s_msms5.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#2_Tumor_W_ReZipTip_New_adjusted_Rep3_25cm90min3s_msms6.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#2_Tumor_W_ReZipTip_New_adjusted_Rep4_25cm90min3s_msms7.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#2_Tumor_W_ReZipTip_New_adjusted_Rep5_25cm90min3s_msms8.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#3_Tumor_W_ReZipTip_New_adjusted_Rep1_25cm90min3s_msms10.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#3_Tumor_W_ReZipTip_New_adjusted_Rep2_25cm90min3s_msms11.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#3_Tumor_W_ReZipTip_New_adjusted_Rep3_25cm90min3s_msms12.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#3_Tumor_W_ReZipTip_New_adjusted_Rep4_25cm90min3s_msms13.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#3_Tumor_W_ReZipTip_New_adjusted_Rep5_25cm90min3s_msms14.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#4_Tumor_W_ReZipTip_New_adjusted_Rep1_25cm90min3s_msms16.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#4_Tumor_W_ReZipTip_New_adjusted_Rep2_25cm90min3s_msms17.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#4_Tumor_W_ReZipTip_New_adjusted_Rep3_25cm90min3s_msms18.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#4_Tumor_W_ReZipTip_New_adjusted_Rep4_25cm90min3s_msms19.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#4_Tumor_W_ReZipTip_New_adjusted_Rep5_25cm90min3s_msms20.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#5_Tumor_W_ReZipTip_New_adjusted_Rep1_25cm90min3s_msms22.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#5_Tumor_W_ReZipTip_New_adjusted_Rep2_25cm90min3s_msms23.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#5_Tumor_W_ReZipTip_New_adjusted_Rep3_25cm90min3s_msms24.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#5_Tumor_W_ReZipTip_New_adjusted_Rep4_25cm90min3s_msms25.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#5_Tumor_W_ReZipTip_New_adjusted_Rep5_25cm90min3s_msms26.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#6_Tumor_W_ReZipTip_New_adjusted_Rep1_25cm90min3s_msms28.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#6_Tumor_W_ReZipTip_New_adjusted_Rep2_25cm90min3s_msms29.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#6_Tumor_W_ReZipTip_New_adjusted_Rep3_25cm90min3s_msms30.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#6_Tumor_W_ReZipTip_New_adjusted_Rep4_25cm90min3s_msms31.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#6_Tumor_W_ReZipTip_New_adjusted_Rep5_25cm90min3s_msms32.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#7_Tumor_W_NewDoseFinding_1to10_25cm90min3s_msms2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#8_Tumor_W_ReZipTip_New_adjusted_Rep1_25cm90min3s_msms34.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#8_Tumor_W_ReZipTip_New_adjusted_Rep2_25cm90min3s_msms35.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#8_Tumor_W_ReZipTip_New_adjusted_Rep3_25cm90min3s_msms36.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#8_Tumor_W_ReZipTip_New_adjusted_Rep4_25cm90min3s_msms37.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#8_Tumor_W_ReZipTip_New_adjusted_Rep5_25cm90min3s_msms38.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#9_Tumor_W_ReZipTip_New_adjusted_Rep1_25cm90min3s_msms40.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#9_Tumor_W_ReZipTip_New_adjusted_Rep2_25cm90min3s_msms41.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#9_Tumor_W_ReZipTip_New_adjusted_Rep3_25cm90min3s_msms42.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#9_Tumor_W_ReZipTip_New_adjusted_Rep4_25cm90min3s_msms43.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#9_Tumor_W_ReZipTip_New_adjusted_Rep5_25cm90min3s_msms44.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#10_Tumor_W_ReZipTip_New_adjusted_Rep1_25cm90min3s_msms46.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#10_Tumor_W_ReZipTip_New_adjusted_Rep2_25cm90min3s_msms47.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#10_Tumor_W_ReZipTip_New_adjusted_Rep3_25cm90min3s_msms48.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#10_Tumor_W_ReZipTip_New_adjusted_Rep4_25cm90min3s_msms49.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#10_Tumor_W_ReZipTip_New_adjusted_Rep5_25cm90min3s_msms50.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#11_Tumor_W_ReZipTip_New_adjusted_Rep1_25cm90min3s_msms52.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#11_Tumor_W_ReZipTip_New_adjusted_Rep2_25cm90min3s_msms53.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#11_Tumor_W_ReZipTip_New_adjusted_Rep3_25cm90min3s_msms54.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#11_Tumor_W_ReZipTip_New_adjusted_Rep4_25cm90min3s_msms55.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#11_Tumor_W_ReZipTip_New_adjusted_Rep5_25cm90min3s_msms56.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#12_Tumor_W_ReZipTip_New_adjusted_Rep1_25cm90min3s_msms58.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#12_Tumor_W_ReZipTip_New_adjusted_Rep2_25cm90min3s_msms59.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#12_Tumor_W_ReZipTip_New_adjusted_Rep3_25cm90min3s_msms60.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#12_Tumor_W_ReZipTip_New_adjusted_Rep4_25cm90min3s_msms61.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/05/PXD013057/170707_RZ_HCC45#12_Tumor_W_ReZipTip_New_adjusted_Rep5_25cm90min3s_msms62.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD013057 {}"

# phase2_PXD033351
declare -a samples=(
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/SNU475.massspec.MHC1pulldown.R1.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/SNU475.massspec.MHC1pulldown.R2.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/SNU475.massspec.MHC1pulldown.R3.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/SNU475.massspec.MHC1pulldown.R4.raw
ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2023/01/PXD033351/SNU475.massspec.MHC1pulldown.R5.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD033351 {}"

# phase2_PXD029882
declare -a samples=(
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210508_JB_HLE_p1011_24h_W6-32_20_DDA1_235-1151mz_msms1.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210508_JB_HLE_p1011_24h_W6-32_20_DDA2_235-1151mz_msms2.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210508_JB_HLE_p1011_24h_W6-32_20_DDA3_235-1151mz_msms3.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210508_JB_HLE_p1431_24h_W6-32_20_DDA1_235-1151mz_msms8.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210508_JB_HLE_p1431_24h_W6-32_20_DDA2_235-1151mz_msms9.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210508_JB_HLE_p1431_24h_W6-32_20_DDA3_235-1151mz_msms10.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210512_JB_SMMC_p1011_24h_W6-32_20_DDA1_235-1151mz_msms6.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210512_JB_SMMC_p1011_24h_W6-32_20_DDA2_235-1151mz_msms7.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210512_JB_SMMC_p1011_24h_W6-32_20_DDA3_235-1151mz_msms8.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210512_JB_SMMC_p1431_24h_W6-32_20_DDA1_235-1151mz_msms13.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210512_JB_SMMC_p1431_24h_W6-32_20_DDA2_235-1151mz_msms14.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210512_JB_SMMC_p1431_24h_W6-32_20_DDA3_235-1151mz_msms15.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210531_JB_SMMC_2_p1011_24h_W6-32_20_DDA1_235-1151mz_msms13.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210531_JB_SMMC_2_p1011_24h_W6-32_20_DDA2_235-1151mz_msms14.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210531_JB_SMMC_2_p1011_24h_W6-32_20_DDA3_235-1151mz_msms15.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210531_JB_SMMC_2_p1431_24h_W6-32_20_DDA1_235-1151mz_msms20.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210531_JB_SMMC_2_p1431_24h_W6-32_20_DDA2_235-1151mz_msms21.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210531_JB_SMMC_2_p1431_24h_W6-32_20_DDA3_235-1151mz_msms22.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210531_JB_SMMC_3_p1011_24h_W6-32_20_DDA1_235-1151mz_msms27.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210531_JB_SMMC_3_p1011_24h_W6-32_20_DDA2_235-1151mz_msms28.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210531_JB_SMMC_3_p1011_24h_W6-32_20_DDA3_235-1151mz_msms29.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210531_JB_SMMC_3_p1431_24h_W6-32_20_DDA1_235-1151mz_msms34.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210531_JB_SMMC_3_p1431_24h_W6-32_20_DDA2_235-1151mz_msms35.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210531_JB_SMMC_3_p1431_24h_W6-32_20_DDA3_235-1151mz_msms36.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_1_p1011_W6-32_33_DDA1_235-1151mz_msms12.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_1_p1011_W6-32_33_DDA1_235-1151mz_msms13.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_1_p1011_W6-32_33_DDA1_235-1151mz_msms14.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_1_p1431_W6-32_33_DDA1_235-1151mz_msms5.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_1_p1431_W6-32_33_DDA2_235-1151mz_msms6.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_1_p1431_W6-32_33_DDA3_235-1151mz_msms7.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_2_p1011_W6-32_33_DDA1_235-1151mz_msms26.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_2_p1011_W6-32_33_DDA2_235-1151mz_msms27.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_2_p1011_W6-32_33_DDA3_235-1151mz_msms28.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_2_p1431_W6-32_33_DDA1_235-1151mz_msms19.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_2_p1431_W6-32_33_DDA2_235-1151mz_msms20.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_2_p1431_W6-32_33_DDA3_235-1151mz_msms21.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_3_p1011_W6-32_33_DDA1_235-1151mz_msms40.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_3_p1011_W6-32_33_DDA2_235-1151mz_msms41.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_3_p1011_W6-32_33_DDA3_235-1151mz_msms42.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_3_p1431_W6-32_33_DDA1_235-1151mz_msms33.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_3_p1431_W6-32_33_DDA2_235-1151mz_msms34.raw
https://ftp.pride.ebi.ac.uk/pride/data/archive/2022/10/PXD029882/210614_JB_HepG2_3_p1431_W6-32_33_DDA3_235-1151mz_msms35.raw
)

for item in ${samples[@]}; do echo ${item}; done | xargs -n 1 -L 1 -P 10 -I {} bash -c "wget -P ./phase2_PXD029882 {}"