#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=32G
#$ -l mem_req=32G

file=`basename $@ .fastq`
riboSeq="/home/akimitsu/data/Ribo-seq_HeLa_Guo_2010/Ribo-seq_mock_12hr/STAR_output_SRR057526_Ribo-seq_mock_12hr_run1/STAR_accepted_hits_genome.bam"
annoDir="/home/akimitsu/software/RiboTaper_v1.3/annotation/hg38_Gencode_v24/start_stops_FAR.bed"
bedtoolsDir="/home/akimitsu/software/RiboTaper_v1.3/bedtools_dir/"
scriptsDir="/home/akimitsu/software/RiboTaper_v1.3/scripts/"

create_metaplots.bash ${riboSeq} ${annoDir} metaplots_result ${bedtoolsDir} ${scriptsDir}
