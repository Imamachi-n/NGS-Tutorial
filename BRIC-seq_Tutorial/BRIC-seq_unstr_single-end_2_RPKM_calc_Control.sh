#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

filename="BRIC-seq_siCTRL_Gencode"
gtfFile="/home/akimitsu/database/gencode.v19.annotation_filtered.gtf"

# calc RPKM
cuffnorm -p 8 --compatible-hits-norm -o ${filename} ${gtfFile} \
tophat_out_BRIC_siCTRL_0min_DRR014413_DRR014435/accepted_hits.bam \
tophat_out_BRIC_siCTRL_45min_DRR014415_DRR014437/accepted_hits.bam \
tophat_out_BRIC_siCTRL_105min_DRR014417_DRR014439/accepted_hits.bam \
tophat_out_BRIC_siCTRL_225min_DRR014419_DRR014441/accepted_hits.bam \
tophat_out_BRIC_siCTRL_465min_DRR014421_DRR014443/accepted_hits.bam \
tophat_out_BRIC_siCTRL_705min_DRR014423_DRR014445/accepted_hits.bam

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
