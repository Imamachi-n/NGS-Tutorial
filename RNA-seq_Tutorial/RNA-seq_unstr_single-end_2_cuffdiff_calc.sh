#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=32G
#$ -l mem_req=32G

filename="RNA-seq_UPF1_Knockdown_Gencode"
gtfFile="/home/akimitsu/database/gencode.v19.annotation_filtered.gtf"

## Quantification
cuffdiff -p 8 --multi-read-correct -o ./cuffdiff_out_${filename} ${gtfFile} \
./tophat_out_XXX_1/accepted_hits.bam,./tophat_out_XXX_2/accepted_hits.bam \
./tophat_out_YYY_1/accepted_hits.bam,./tophat_out_YYY_2/accepted_hits.bam

## Annotation
gene_list="/home/akimitsu/database/gencode.v19.annotation_filtered_symbol_type_list.txt" #Required
cuffnorm_data="gene_exp.diff"
# mRNA
gene_type="mRNA"
result_file="cuffdiff_result_mRNA.txt"
python cuffdiff_result.py ${gene_list} ./cuffdiff_out_${filename}/${cuffnorm_data} ${gene_type} ./cuffdiff_out_${filename}/${result_file}


# lncRNA
gene_type="lncRNA"
result_file="cuffdiff_result_lncRNA.txt"
python cuffdiff_result.py ${gene_list} ./cuffdiff_out_${filename}/${cuffnorm_data} ${gene_type} ./cuffdiff_out_${filename}/${result_file}
