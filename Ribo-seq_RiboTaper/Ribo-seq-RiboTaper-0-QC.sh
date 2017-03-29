#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

file=`basename $@ .fastq`

echo "-- Raw fastq file QC..."
mkdir fastqc_${file}
fastqc -o ./fastqc_${file} ./${file}.fastq -f fastq
