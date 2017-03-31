#!/bin/bash -e
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=50G
#$ -l mem_req=50G

#Required
threads=8
indexOutput="./rRNA_contam"
contamFasta="/home/akimitsu/database/repeatitive_elements/contam_Ribosomal_RNA.fa"

mkdir ${indexOutput}
STAR --runThreadN ${threads} --runMode genomeGenerate --genomeDir ${indexOutput} \
     --genomeFastaFiles ${contamFasta}
