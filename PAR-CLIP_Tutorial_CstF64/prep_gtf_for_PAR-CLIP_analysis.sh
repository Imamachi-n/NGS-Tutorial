#!/bin/bash

# gtffile="gencode.v25lift37.annotation_for_UCSC.gtf"
gtffile="gencode.v19.annotation.gtf"
filename=`basename ${gtffile} .gtf`

# Prepare Protein-coding RNAs (Status: Basic)
python A_prep_gtf_for_PAR-CLIP.py ${filename}.gtf \
${filename}_only_basic_mRNAs.gtf \
${filename}_only_basic_mRNAs_gene_trx_list.txt

# Convert gtf to bed
gtf2bed ${filename}_only_basic_mRNAs.gtf

# Extract longest isoforms
python B_prep_longest_trx_id_list.py ${filename}_only_basic_mRNAs.bed \
${filename}_only_basic_mRNAs_gene_trx_list.txt \
${filename}_only_Rep_basic_mRNAs.bed

# Extract 3UTR bed file
bed12to3UTRbed ${filename}_only_Rep_basic_mRNAs.bed

# Get fasta file
bed2fasta ${filename}_only_Rep_basic_mRNAs.bed
