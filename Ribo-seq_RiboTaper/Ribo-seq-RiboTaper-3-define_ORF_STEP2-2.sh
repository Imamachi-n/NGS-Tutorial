#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=60G
#$ -l mem_req=60G

source activate ribotaper

RNA_bamfile="/home/akimitsu/data/NGS_tutorial/Ribo-seq/STAR_output_RNA-Seq_HEK293_Cell_SRR1630838/RNA-Seq_HEK293_Cell_SRR1630838_4_STAR_result_Aligned.sortedByCoord.out.bam"
Ribo_bamfile="/home/akimitsu/data/NGS_tutorial/Ribo-seq/STAR_output_Ribo-Seq_HEK293_Cell_Control_SRR1630831/Ribo-Seq_HEK293_Cell_Control_SRR1630831_4_STAR_result_Aligned.sortedByCoord.out.bam"
annotation_dir="/home/akimitsu/software/RiboTaper_v1.3/annotation/hg38_Gencode_v24"
read_lenghts_ribo="27,28,29"
cutoffs="12,12,12"
scripts_dir="/home/akimitsu/software/RiboTaper_v1.3/scripts"
bedtools_dir="/home/akimitsu/software/RiboTaper_v1.3/bedtools_dir"
n_cores="16"

echo "-- Starting RiboTaper..."
Ribotaper_step2-2.sh ${Ribo_bamfile} ${RNA_bamfile} \
${annotation_dir} ${read_lenghts_ribo} ${cutoffs} \
${scripts_dir} ${bedtools_dir} ${n_cores}
