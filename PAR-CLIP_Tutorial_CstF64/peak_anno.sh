#!/bin/bash

# From prep_gtf_for_PAR-CLIP_analysis.sh
# gtffile="gencode.v25lift37.annotation_for_UCSC.gtf"
gtfdir="/home/akimitsu/database"
gtffile="gencode.v19.annotation.gtf"
filename=`basename ${gtffile} .gtf`

# Get region infor for each gene (5UTR, ORF, 3UTR)
# python F_split_into_each_section.py ${gtfdir}/${filename}_only_Rep_basic_mRNAs.bed ${gtfdir}/${filename}_only_Rep_basic_mRNAs_each_region.bed

# Add intron region
# python G_add_intron_infor.py ${gtfdir}/${filename}_only_Rep_basic_mRNAs_each_region.bed ${gtfdir}/${filename}_only_Rep_basic_mRNAs_each_region_intron_plus.bed

# Compare mRNA region with CLIP peaks
peak_bed_file="SRR488740_PAR-CLIP_CstF-64_clusters.bed"
peakfilename=`basename ${peak_bed_file} .bed`
# bedtools intersect -a ${peakfilename}.bed -b ${gtfdir}/${filename}_only_Rep_basic_mRNAs_each_region_intron_plus.bed -wa -wb -loj > ${peakfilename}_with_mRNA_region.tmp

# Annotate peaks
python H_annotate_peaks.py ${peakfilename}_with_mRNA_region.tmp /home/akimitsu/database/gencode.v19.annotation_symbol_type_mRNA_list.txt ${peakfilename}_with_mRNA_region.txt
