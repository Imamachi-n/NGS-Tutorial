#!/bin/bash -e
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=50G
#$ -l mem_req=50G

#Required
threads=8
indexOutput="./hg19_Gencode_v19"
genomeFasta="/home/akimitsu/database/bowtie1_index/hg19.fa"
annotationGTF="/home/akimitsu/database/gencode.v19.annotation.gtf"

mkdir ${indexOutput}
STAR --runThreadN ${threads} --runMode genomeGenerate --genomeDir ${indexOutput} \
     --genomeFastaFiles ${genomeFasta} --sjdbGTFfile ${annotationGTF} --sjdbOverhang 100
