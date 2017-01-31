#!/bin/bash -e
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=50G
#$ -l mem_req=50G

#Required
threads=8
indexOutput="./repBase_rRNA_contam"
contamFasta="/home/akimitsu/database/repeatitive_elements/RepBase21.08/RepBase_human_rRNA.fa"

mkdir ${indexOutput}
STAR --runThreadN ${threads} --runMode genomeGenerate --genomeDir ${indexOutput} \
     --genomeFastaFiles ${contamFasta}
