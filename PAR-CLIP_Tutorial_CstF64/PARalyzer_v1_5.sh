#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

filename=`basename ${1} .fastq`
PARalyzer="/home/akimitsu/software/PARalyzer_v1_5"
PARalyzer_ini_file="PARalyzer_v1_5.ini"
genome_2bit="/home/akimitsu/database/genome/hg19.2bit"
filepass=`pwd`

# Generate ini file
python ./PARalyzer_ini_file_generator.py ${filepass} ${filename} ${genome_2bit} ${PARalyzer_ini_file}

# Run PARalyzer
PARalyzer 11G ${PARalyzer_ini_file}

python ./PARalyzer2BEDandFASTA.py ${filename}_clusters.csv ${filename}_clusters.bed ${filename}_clusters.fa
