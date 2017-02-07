#!/bin/bash

mRNA_result="BridgeR_result_PUM1_study_mRNA"
lncRNA_result="BridgeR_result_PUM1_study_lncRNA"

# mRNA half-life
mkdir ${mRNA_result}
Rscript ./BridgeR_analysis_mRNA.R ${mRNA_result} \
./BRIC-seq_PUM1_siCTRL_Gencode/BridgeR_input_file_mRNA.txt,./BRIC-seq_PUM1_siPUM1_Gencode/BridgeR_input_file_mRNA.txt

# lncRNA half-life
mkdir ${lncRNA_result}
Rscript ./BridgeR_analysis_lncRNA.R ${lncRNA_result} ${mRNA_result} \
./BRIC-seq_PUM1_siCTRL_Gencode/BridgeR_input_file_lncRNA.txt,./BRIC-seq_PUM1_siPUM1_Gencode/BridgeR_input_file_lncRNA.txt
