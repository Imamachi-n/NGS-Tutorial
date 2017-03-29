#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=32G
#$ -l mem_req=32G

file=`basename $@ .fastq`
repeat_index="/home/akimitsu/database/STAR_index/repBase_rRNA_contam"
indexFile="/home/akimitsu/database/STAR_index/hg38_Gencode_v25"
threadNum=8
maxRAM=32000000000
maxSortRAM=32G

# Remove rRNA-derived reads
STAR --runMode alignReads --runThreadN ${threadNum} --genomeDir ${repeat_index} \
--readFilesIn ./${file}_2_filtered.fastq \
--outSAMunmapped Within --outFilterMultimapNmax 30 --outFilterMultimapScoreRange 1 \
--outFileNamePrefix ./${file}_3_rm_repbase_rrna.fastq \
--outSAMattributes All --outStd BAM_Unsorted --outSAMtype BAM Unsorted \
--outFilterType BySJout --outReadsUnmapped Fastx --outFilterScoreMin 10 \
--alignEndsType EndToEnd > ./${file}_3_repbase_rrna_comtam.bam
mv ./${file}_3_rm_repbase_rrna.fastqUnmapped.out.mate1 ./${file}_3_rm_repbase_rrna.fastq

# Mapping
mkdir STAR_output_${file}
echo "-- Mapping fastq file with STAR aligner..."
STAR --runMode alignReads --runThreadN 8 --genomeDir ${indexFile} \
--readFilesIn ./${file}_3_rm_repbase_rrna.fastq \
--outFilterMultimapNmax 8 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --sjdbScore 1 \
--outFilterMismatchNmax 4 --alignIntronMin 20 --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
--outFileNamePrefix ./STAR_output_${file}/${file}_4_STAR_result_ \
--outSAMattributes All --outSAMtype BAM SortedByCoordinate --limitBAMsortRAM ${maxRAM} \
--outFilterType BySJout --outReadsUnmapped Fastx
