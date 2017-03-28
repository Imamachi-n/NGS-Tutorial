#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=32G
#$ -l mem_req=32G

gtfFile="/home/akimitsu/database/gencode.v19.annotation_filtered_DEXSeq.gtf"
resultDir="DEXSeq_output_test"
featureCountFile="${resultDir}/featureCounts_result_test.txt"
resultFile="${resultDir}/DEXSeq_test_result.txt"

# Count reads on each exon
mkdir DEXSeq_output_test
featureCounts -T 8 -f -O -s 2 \
-F GTF -t exon -a ${gtfFile} \
-o ${featureCountFile} \
./tophat_out_SRR4081222_Control_1/accepted_hits.bam \
./tophat_out_SRR4081223_Control_2/accepted_hits.bam \
./tophat_out_SRR4081224_Control_3/accepted_hits.bam \
./tophat_out_SRR4081225_UPF1_knockdown_1/accepted_hits.bam \
./tophat_out_SRR4081226_UPF1_knockdown_2/accepted_hits.bam \
./tophat_out_SRR4081227_UPF1_knockdown_3/accepted_hits.bam

# DEXSeq Run
Rscript ./DEXSeq_test.R \
${featureCountFile} \
${gtfFile} \
${resultFile} \
CTRL_1,CTRL_2,CTRL_3,UPF1KD_1,UPF1KD_2,UPF1KD_3 \
Control,Control,Control,Knockdown,Knockdown,Knockdown
