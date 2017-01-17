#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

file=`basename "SRR488740_PAR-CLIP_CstF-64.fastq" .fastq`

genome="/home/akimitsu/database/genome/hg19/hg19.fa"
sampleFile="./STAR_output_${file}_EndtoEnd/${file}_4_STAR_result_Aligned.sortedByCoord.out"

samtools mpileup -ugf ${genome} ${sampleFile}.bam | bcftools call -vmO v -o ${sampleFile}.vcf
