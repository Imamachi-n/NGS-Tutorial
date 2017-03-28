#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

file=`basename ${1} .fastq`
# gtfFile="/home/akimitsu/database/Refseq_gene_hg19_June_02_2014.gtf"
gtfFile="/home/akimitsu/database/gencode.v19.annotation_filtered.gtf"
indexContamFile="/home/akimitsu/database/bowtie1_index/contam_Ribosomal_RNA"
indexGenomeFile="/home/akimitsu/database/bowtie1_index/hg19"

## 1. Quality check
mkdir fastqc_${file}
fastqc -o ./fastqc_${file} ./${file}.fastq -f fastq

## 2. Mapping to genome and transcriptome
tophat --bowtie1 -p 8 --library-type fr-firststrand -o tophat_out_${file}_ss -G ${gtfFile} ${indexGenomeFile} ${file}_1_filtered.fastq

## 3. Data quality check from mapped reads
mkdir geneBody_coverage_${file}_ss
samtools index ./tophat_out_${file}_ss/accepted_hits.bam
geneBody_coverage.py -r /home/akimitsu/database/hg19.HouseKeepingGenes_for_RSeQC.bed -i ./tophat_out_${file}_ss/accepted_hits.bam  \
-o ./geneBody_coverage_${file}_ss/${file}_RSeQC_output

## 4. Check Strandness
infer_experiment.py -i ./tophat_out_${file}_ss/accepted_hits.bam \
-r /home/akimitsu/database/gencode.v19.annotation.bed -s 400000 >  ./tophat_out_${file}_ss/${file}_strand_stat.txt

## 5. Visualization for UCSC genome browser
savedir="UCSC_visual_${file}_ss"
mkdir ${savedir}
bedtools genomecov -ibam ./tophat_out_${file}_ss/accepted_hits.bam -bg -split -strand - > ${savedir}/${file}_forward.bg
bedtools genomecov -ibam ./tophat_out_${file}_ss/accepted_hits.bam -bg -split -strand + > ${savedir}/${file}_reverse.bg
echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20 color=255,0,0" > ${savedir}/tmp_${file}_forward.txt
echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20 color=0,0,255" > ${savedir}/tmp_${file}_reverse.txt
cat ${savedir}/tmp_${file}_forward.txt ${savedir}/${file}_forward.bg > ${savedir}/${file}_forward_for_UCSC.bg
cat ${savedir}/tmp_${file}_reverse.txt ${savedir}/${file}_reverse.bg > ${savedir}/${file}_reverse_for_UCSC.bg
bzip2 -c ${savedir}/${file}_forward_for_UCSC.bg > ${savedir}/${file}_forward_for_UCSC.bg.bz2
bzip2 -c ${savedir}/${file}_reverse_for_UCSC.bg > ${savedir}/${file}_reverse_for_UCSC.bg.bz2
