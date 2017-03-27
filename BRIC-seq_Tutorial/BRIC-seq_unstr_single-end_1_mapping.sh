#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

file=`basename ${1} _2_norrna.fastq`
file=`basename ${file} .fastq`
# gtfFile="/home/akimitsu/database/Refseq_gene_hg19_June_02_2014.gtf"
gtfFile="/home/akimitsu/database/gencode.v19.annotation_filtered.gtf"
indexContamFile="/home/akimitsu/database/bowtie1_index/contam_Ribosomal_RNA"
indexGenomeFile="/home/akimitsu/database/bowtie1_index/hg19"

## 1. Quality check
mkdir fastqc_${file}
fastqc -o ./fastqc_${file} ./${file}.fastq -f fastq

## 2. Quality filtering (Option)
fastq_quality_trimmer -Q33 -t 20 -l 10 -i ./${file}.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o ${file}_1_filtered.fastq

## 3. rRNA removal
bowtie -p 8 --un ./${file}_2_norrna.fastq ${indexContamFile} ./${file}_1_filtered.fastq > rRNA_${file}.fastq 2>> ./log_${file}.txt

## 4. Quality check
mkdir fastqc_${file}_filtered
fastqc -o ./fastqc_${file}_filtered ./${file}_2_norrna.fastq -f fastq

## 4. Mapping to genome and transcriptome
tophat --bowtie1 -p 8 -o tophat_out_${file} -G ${gtfFile} ${indexGenomeFile} ${file}_2_norrna.fastq

# RNA quality check from mapped reads
mkdir geneBody_coverage_${file}
samtools index ./tophat_out_${file}/accepted_hits.bam
geneBody_coverage.py -r /home/akimitsu/database/hg19.HouseKeepingGenes_for_RSeQC.bed -i ./tophat_out_${file}/accepted_hits.bam  \
-o ./geneBody_coverage_${file}/${file}_RSeQC_output

# Visualization for UCSC genome browser
mkdir UCSC_visual_${file}
bedtools genomecov -ibam ./tophat_out_${file}/accepted_hits.bam -bg -split > ./UCSC_visual_${file}/${file}_4_result.bg
echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}/tmp.txt
cat ./UCSC_visual_${file}/tmp.txt ./UCSC_visual_${file}/${file}_4_result.bg > ./UCSC_visual_${file}/${file}_4_result_for_UCSC.bg
bzip2 -c ./UCSC_visual_${file}/${file}_4_result_for_UCSC.bg > ./UCSC_visual_${file}/${file}_4_result_for_UCSC.bg.bz2
