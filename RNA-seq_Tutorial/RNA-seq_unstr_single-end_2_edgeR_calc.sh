#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

#File information - required
BamFile1="/path/to/tophat_out_150123_Hiseq2B_l1_005_Dr_Akimitu_ACAGTG_L001_R1_no_infection_2h/accepted_hits.bam"
BamFile2="/path/to/tophat_out_150123_Hiseq2B_l1_006_Dr_Akimitu_GCCAAT_L001_R1_wt_2h/accepted_hits.bam"
BamFile1Name="no_infection_2h"
BamFile2Name="wt_2h"

GTFFile="/home/akimitsu/database/gencode.v19.annotation_filtered+PROMPT_v2+eRNA_v2+FANTOM_eRNA.gtf"
# annoListは'extract_gene_symbol_type_from_gtf.py'を使って作成。
annoList="/home/akimitsu/database/gencode.v19.annotation_filtered+PROMPT_v2+eRNA_v2+FANTOM_eRNA_symbol_type_list.txt"

#edgeR - statistical analysis without replicates
Rscript edgeR_no_replicates.R featureCounts_result_${BamFile1Name}_for_R.txt featureCounts_result_${BamFile2Name}_for_R.txt ${BamFile1Name} ${BamFile2Name}

#Output results
python3 annotate_gene_symbol_type.py  ${annoList} edgeR_no_replicates_${BamFile1Name}_vs_${BamFile2Name}.txt edgeR_no_replicates_${BamFile1Name}_vs_${BamFile2Name}_result.txt

# Final Annotation
filename=`basename edgeR_no_replicates_${BamFile1Name}_vs_${BamFile2Name}_result.txt .txt`
head -n 1 ${filename}.txt > header.tmp
sed -e '1d' ${filename}.txt | sort -k2,2 -k1,1 - | cat header.tmp - > ${filename}_sorted.txt
python3 split_into_each_gene_type.py ${filename}_sorted.txt
