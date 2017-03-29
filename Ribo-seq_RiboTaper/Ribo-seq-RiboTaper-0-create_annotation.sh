#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=32G
#$ -l mem_req=32G

gencode_gtf_file="/home/akimitsu/database/annotation_file/hg38/gencode.v24.basic.annotation.gtf"
genome_fasta_file="/home/akimitsu/database/genome/hg38/hg38_UpperLetters.fa"
use_ccdsid="true"
use_appris="true"
dest_folder="/home/akimitsu/software/RiboTaper_v1.3/annotation/hg19_Gencode_v19"
bedtools_path="/home/akimitsu/software/RiboTaper_v1.3/bedtools_dir"
scripts_dir="/home/akimitsu/software/RiboTaper_v1.3/scripts"

echo "-- Create annotation information for RiboTaper..."
create_annotations_files.bash ${gencode_gtf_file} \
${genome_fasta_file} ${use_ccdsid} ${use_appris} \
${dest_folder} ${bedtools_path} ${scripts_dir}
