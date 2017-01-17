#!/bin/bash

annofile="/home/akimitsu/database/gencode.v19.annotation_only_Rep_basic_mRNAs_3UTR.bed"
peakfile="/home/akimitsu/data/PAR-CLIP_CstF64_test/test/SRR488740_PAR-CLIP_CstF-64_clusters.bed"

filename=`basename ${peakfile} .bed`

# Compare annotion 3'UTR with PAR-CLIP peaks
bedtools intersect -a ${filename}.bed -b ${annofile} -wa -wb -s -split > ${filename}_on_mRNAs_plus_anno.bed
bedtools intersect -a ${filename}.bed -b ${annofile} -wa -s -split > ${filename}_on_mRNAs.bed

# make fasta file for MEME
# python C_prep_fasta_file_for_MEME.py ${filename}_on_mRNAs_plus_anno.bed ${filename}_on_mRNAs_plus_anno.fa
python D_prep_fasta_file_for_MEME_rep_version.py ${filename}_on_mRNAs_plus_anno.bed ${filename}_on_mRNAs_plus_anno_rep_version.fa
