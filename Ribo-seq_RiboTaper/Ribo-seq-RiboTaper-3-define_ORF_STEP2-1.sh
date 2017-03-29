#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=60G
#$ -l mem_req=60G

rnaseq="/home/akimitsu/data/Ribo-seq_HEK293_Gao_2015/HEK293_RNA-seq/STAR_output_SRR1630838_HEK293_RNA-seq/STAR_accepted_hits_genome.bam"
riboseq="/home/akimitsu/data/Ribo-seq_HEK293_Gao_2015/HEK293_Ribo-seq/STAR_output_SRR1630831_HEK293_Ribo-seq/STAR_accepted_hits_genome.bam"

echo "-- Starting RiboTaper..."
Ribotaper_step2-1.sh ${riboseq} ${rnaseq} /home/akimitsu/software/RiboTaper_v1.3/annotation/hg38_Gencode_v24 27,28,29 12,12,12 /home/akimitsu/software/RiboTaper_v1.3/scripts /home/akimitsu/software/RiboTaper_v1.3/bedtools_dir 16
