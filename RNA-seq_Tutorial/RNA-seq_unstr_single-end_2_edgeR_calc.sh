#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

annoList="/home/akimitsu/database/gencode.v19.annotation_symbol_type_list.txt"

#edgeR - statistical analysis
saveDir="edgeR_result_UPF1_Knockdown"

mkdir ${saveDir}
Rscript ~/custom_command/edgeR_test.R \
featureCounts_result_SRR4081222_Control_1/featureCounts_result_SRR4081222_Control_1_for_R.txt,\
featureCounts_result_SRR4081223_Control_2/featureCounts_result_SRR4081223_Control_2_for_R.txt,\
featureCounts_result_SRR4081224_Control_3/featureCounts_result_SRR4081224_Control_3_for_R.txt,\
featureCounts_result_SRR4081225_UPF1_knockdown_1/featureCounts_result_SRR4081225_UPF1_knockdown_1_for_R.txt,\
featureCounts_result_SRR4081226_UPF1_knockdown_2/featureCounts_result_SRR4081226_UPF1_knockdown_2_for_R.txt,\
featureCounts_result_SRR4081227_UPF1_knockdown_3/featureCounts_result_SRR4081227_UPF1_knockdown_3_for_R.txt \
Control,Control,Control,Knockdown,Knockdown,Knockdown \
${saveDir} \
Yes

# Add Annotation
python2 ~/custom_command/annotate_gene_symbol_type.py  ${annoList} ${saveDir}/edgeR_test_result.txt ${saveDir}/edgeR_test_result_anno_plus.txt
