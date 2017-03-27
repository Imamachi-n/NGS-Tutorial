#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

filename="BRIC-seq_siSTAU1_Gencode"
gtfFile="/home/akimitsu/database/gencode.v19.annotation_filtered.gtf"

# calc RPKM
cuffnorm -p 8 --compatible-hits-norm -o ${filename} ${gtfFile} \
tophat_out_BRIC_siSTAU1_0min_DRR014424_DRR014446/accepted_hits.bam \
tophat_out_BRIC_siSTAU1_45min_DRR014426_DRR014448/accepted_hits.bam \
tophat_out_BRIC_siSTAU1_105min_DRR014428_DRR014450/accepted_hits.bam \
tophat_out_BRIC_siSTAU1_225min_DRR014430_DRR014452/accepted_hits.bam \
tophat_out_BRIC_siSTAU1_465min_DRR014432_DRR014454/accepted_hits.bam \
tophat_out_BRIC_siSTAU1_705min_DRR014434_DRR014456/accepted_hits.bam

# mRNA RPKM
gene_list="/home/akimitsu/database/gencode.v19.annotation_filtered_symbol_type_list.txt"
cuffnorm_data="${filename}/genes.fpkm_table"
gene_type="mRNA"
result_file="${filename}/BridgeR_input_file_mRNA.txt"
python2 ~/custom_command/BridgeR_prep.py ${gene_list} ${cuffnorm_data} ${gene_type} ${result_file}

# lncRNA RPKM
gene_type="lncRNA"
result_file="${filename}/BridgeR_input_file_lncRNA.txt"
python2 ~/custom_command/BridgeR_prep.py ${gene_list} ${cuffnorm_data} ${gene_type} ${result_file}
