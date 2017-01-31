#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=32G
#$ -l mem_req=32G

# Usage: PAR-CLIP_CstF-64.sh <FASTQ file (.fastq)>

file=`basename ${1} .fastq`
adapter="TCGTATGCCGTCTTCTGCTTGT"

# Quality check
mkdir fastqc_${file}
fastqc -o ./fastqc_${file} ./${file}.fastq -f fastq

# Adapter trimming
cutadapt -f fastq --match-read-wildcards --times 1 -e 0.1 -O 5 --quality-cutoff 6 -m 18 \
-a ${adapter} ${file}.fastq > ${file}_1_trimmed_adapter.fastq 2>> ./log_${file}.txt

# Quality filtering
fastq_quality_trimmer -Q33 -t 20 -l 18 -i ./${file}_1_trimmed_adapter.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o ${file}_2_filtered.fastq

# Remove rRNA, repetitive elements
# ### repeat_index="/home/akimitsu/database/repeatitive_elements/RepBase21.08/RepBase_human_rRNA"
# ### bowtie2 -p 8 -x ${repeat_index} ${file}_2_filtered.fastq --un ${file}_3_rm_repbase_rrna.fastq > ${file}_3_repeats.fastq 2>> ./log_${file}.txt

repeat_index="/home/akimitsu/database/STAR_index/repBase_rRNA_contam"
STAR --runMode alignReads --runThreadN 8 --genomeDir ${repeat_index} \
--readFilesIn ./${file}_2_filtered.fastq \
--outSAMunmapped Within --outFilterMultimapNmax 30 --outFilterMultimapScoreRange 1 \
--outFileNamePrefix ./${file}_3_rm_repbase_rrna.fastq \
--outSAMattributes All --outStd BAM_Unsorted --outSAMtype BAM Unsorted \
--outFilterType BySJout --outReadsUnmapped Fastx --outFilterScoreMin 10 \
--alignEndsType EndToEnd > ./${file}_3_repbase_rrna_comtam.bam
mv ./${file}_3_rm_repbase_rrna.fastqUnmapped.out.mate1 ./${file}_3_rm_repbase_rrna.fastq

# Quality check
mkdir fastqc_${file}_filtered
fastqc -o ./fastqc_${file}_filtered ./${file}_3_rm_repbase_rrna.fastq -f fastq

# Genome mapping
indexFile="/home/akimitsu/database/STAR_index/hg19_Gencode_v25"
maxRAM=32000000000

mkdir STAR_output_${file}_EndtoEnd
STAR --runMode alignReads --runThreadN 8 --genomeDir ${indexFile} \
--readFilesIn ./${file}_3_rm_repbase_rrna.fastq \
--outFilterMultimapNmax 1 -- outFilterMultimapScoreRange 1 \
--outFileNamePrefix ./STAR_output_${file}_EndtoEnd/${file}_4_STAR_result_ \
--outSAMattributes All --outSAMtype BAM SortedByCoordinate --limitBAMsortRAM ${maxRAM} \
--outFilterType BySJout --outReadsUnmapped Fastx --outFilterScoreMin 10 \
--alignEndsType EndToEnd

# --outFilterMultimapNmax 10 \

# Calculate Base substitution frequency (T>C substitution)
samtools view -h ./STAR_output_${file}_EndtoEnd/${file}_4_STAR_result_Aligned.sortedByCoord.out.bam \
> ./STAR_output_${file}_EndtoEnd/${file}_4_STAR_result_Aligned.sortedByCoord.out.sam
python E_mismatch_call_from_bam.py ./STAR_output_${file}_EndtoEnd/${file}_4_STAR_result_Aligned.sortedByCoord.out.sam \
./STAR_output_${file}_EndtoEnd/${file}_4_STAR_result_Aligned.sortedByCoord.out_indel.txt \
./STAR_output_${file}_EndtoEnd/${file}_5_Base_substitution_frequency.txt

# Remove duplicate reads (Option)
picard MarkDuplicates I="STAR_output_${file}_EndtoEnd/${file}_4_STAR_result_Aligned.sortedByCoord.out.bam" \
O="STAR_output_${file}_EndtoEnd/${file}_6_STAR_result_Remove_duplicate.bam" \
M="STAR_output_${file}_EndtoEnd/${file}_picard MarkDuplicates.txt" TMP_DIR="./" AS=true REMOVE_DUPLICATES=false

# BAM to SAM convertion (PARalyzer v1.5)
samtools view -h ./STAR_output_${file}_EndtoEnd/${file}_4_STAR_result_Aligned.sortedByCoord.out.bam > ./STAR_output_${file}_EndtoEnd/${file}_4_STAR_result_Aligned.sortedByCoord.out.sam

# Visualization
# ### BED12_file="/home/akimitsu/database/Refseq_gene_hg19_June_02_2014.bed"
BED12_file="/home/akimitsu/database/gencode.v19.annotation.bed"
infer_experiment.py -i ./STAR_output_${file}_EndtoEnd/${file}_4_STAR_result_Aligned.sortedByCoord.out.bam -r ${BED12_file} -s 400000 > ${file}_4_STAR_result_strand_stat.txt

mkdir UCSC_visual_"$file"_EndtoEnd
filedir="./UCSC_visual_${file}_EndtoEnd"
### bedtools genomecov -ibam ./STAR_output_${file}_EndtoEnd/${file}_6_STAR_result_Remove_duplicate.bam -bg -split -strand + > ${filedir}/${file}_4_STAR_result_Aligned.sortedByCoord.out_Forward.bg
### bedtools genomecov -ibam ./STAR_output_${file}_EndtoEnd/${file}_6_STAR_result_Remove_duplicate.bam -bg -split -strand - > ${filedir}/${file}_4_STAR_result_Aligned.sortedByCoord.out_Reverse.bg
bedtools genomecov -ibam ./STAR_output_${file}_EndtoEnd/${file}_4_STAR_result_Aligned.sortedByCoord.out.bam -bg -split -strand + > ${filedir}/${file}_4_STAR_result_Aligned.sortedByCoord.out_Forward.bg
bedtools genomecov -ibam ./STAR_output_${file}_EndtoEnd/${file}_4_STAR_result_Aligned.sortedByCoord.out.bam -bg -split -strand - > ${filedir}/${file}_4_STAR_result_Aligned.sortedByCoord.out_Reverse.bg
echo "track type=bedGraph name=${file}_STAR_l18_m10_End_Fw description=${file}_STAR_l18_m10_End_Fw visibility=2 maxHeightPixels=40:40:20 color=255,0,0" > ${filedir}/tmp_${file}_forward.txt
echo "track type=bedGraph name=${file}_STAR_l18_m10_End_Re description=${file}_STAR_l18_m10_End_Re visibility=2 maxHeightPixels=40:40:20 color=0,0,255" > ${filedir}/tmp_${file}_reverse.txt
cat ${filedir}/tmp_${file}_forward.txt ${filedir}/${file}_4_STAR_result_Aligned.sortedByCoord.out_Forward.bg > ${filedir}/${file}_4_STAR_result_Aligned.sortedByCoord.out_forward_for_UCSC.bg
cat ${filedir}/tmp_${file}_reverse.txt ${filedir}/${file}_4_STAR_result_Aligned.sortedByCoord.out_Reverse.bg > ${filedir}/${file}_4_STAR_result_Aligned.sortedByCoord.out_reverse_for_UCSC.bg
bzip2 -c ${filedir}/${file}_4_STAR_result_Aligned.sortedByCoord.out_forward_for_UCSC.bg > ${filedir}/${file}_4_STAR_result_Aligned.sortedByCoord.out_forward_for_UCSC.bg.bz2
bzip2 -c ${filedir}/${file}_4_STAR_result_Aligned.sortedByCoord.out_reverse_for_UCSC.bg > ${filedir}/${file}_4_STAR_result_Aligned.sortedByCoord.out_reverse_for_UCSC.bg.bz2

# Peak calling
PARalyzer_ini_file="PARalyzer_v1_5.ini"
genome_2bit="/home/akimitsu/database/genome/hg19.2bit"
filepass=`pwd`
# Generate ini file
python2 ./PARalyzer_ini_file_generator.py ${filepass} ${filename} ${genome_2bit} ${PARalyzer_ini_file}
# Run PARalyzer
PARalyzer 11G ${PARalyzer_ini_file}
python ./PARalyzer2BEDandFASTA.py ${filename}_clusters.csv ${filename}_clusters.bed ${filename}_clusters.fa
