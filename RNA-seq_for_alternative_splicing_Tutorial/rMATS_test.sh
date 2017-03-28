#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=32G
#$ -l mem_req=32G

gtfFile="/home/akimitsu/database/gencode.v19.annotation_filtered.gtf"

RNASeq-MATS.py \
-b1 ./tophat_out_SRR4081222_Control_1/accepted_hits.bam,./tophat_out_SRR4081223_Control_2/accepted_hits.bam,./tophat_out_SRR4081224_Control_3/accepted_hits.bam \
-b2 ./tophat_out_SRR4081225_UPF1_knockdown_1/accepted_hits.bam,./tophat_out_SRR4081226_UPF1_knockdown_2/accepted_hits.bam,./tophat_out_SRR4081227_UPF1_knockdown_3/accepted_hits.bam \
-gtf ${gtfFile} \
-o rMATS_test -t single -len 101 -c 0.0001 -analysis U -libType fr-firststrand -novelSS 1
