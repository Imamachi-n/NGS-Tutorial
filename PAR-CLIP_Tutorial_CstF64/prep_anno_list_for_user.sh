#!/bin/bash

gtffile="gencode.v19.annotation.gtf"
filename=`basename ${gtffile} .gtf`

# Extract gene symbol & ref ID from GTF file
python extract_gene_symbol_type_from_gtf.py ${filename}.gtf ${filename}_symbol_type_list.txt

# Prepare mRNA & lncRNA data list
python I_prep_mRNA_lncRNA_symbol_refid_list.py ${filename}_symbol_type_list.txt \
${filename}_symbol_type_mRNA_list.txt \
${filename}_symbol_type_lncRNA_list.txt
