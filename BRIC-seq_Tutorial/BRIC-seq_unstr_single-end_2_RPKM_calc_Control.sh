#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

filename="BRIC-seq_PUM1_siCTRL_Gencode"
gtfFile="/home/akimitsu/database/gencode.v19.annotation_filtered.gtf"

# calc RPKM
cuffnorm -p 8 --compatible-hits-norm -o ${filename} ${gtfFile} \
tophat_out_BRIC-seq_siCTRL_0h_Sample_140318_Hiseq3A_l1_005_Dr_Akimitsu_RNA/accepted_hits.bam \
tophat_out_BRIC-seq_siCTRL_1h_Sample_140318_Hiseq3A_l1_006_Dr_Akimitsu_RNA/accepted_hits.bam \
tophat_out_BRIC-seq_siCTRL_2h_Sample_140318_140414_Hiseq3A_l1_012_Dr_Akimitsu_RNA/accepted_hits.bam \
tophat_out_BRIC-seq_siCTRL_4h_Sample_140318_Hiseq3A_l1_019_Dr_Akimitsu_RNA/accepted_hits.bam \
tophat_out_BRIC-seq_siCTRL_8h_Sample_140318_140414_Hiseq3A_l4_005_Dr_Akimitsu_RNA/accepted_hits.bam \
tophat_out_BRIC-seq_siCTRL_12h_Sample_140318_140414_Hiseq3A_l4_019_Dr_Akimitsu_RNA/accepted_hits.bam

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