#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

markovFile="/home/akimitsu/database/gencode.v19.annotation_only_Rep_basic_mRNAs_3UTR_markov_background_for_MEME.txt"
peakFile="./SRR488740_PAR-CLIP_CstF-64_clusters_on_mRNAs_plus_anno_rep_version.fa"
output="MEME_result_SRR488740_PAR-CLIP_CstF-64_rep_version2"

meme ${peakFile} -dna -bfile ${markovFile} -oc ${output} -minw 5 -maxw 8 -nmotifs 3 -maxsize 1000000000 -mod zoops
