#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

source activate miso

File1=`basename ${1} .fastq` #"SRR4081222_Control_1"
File2=`basename ${2} .fastq` #"SRR4081225_UPF1_knockdown_1"

# Run MISO comparison
for type in A3SS A5SS MXE RI SE
do
    outputDir="./MISO_comparison_${type}_events"
    MISOFile1="./MISO_output_${file1}_${type}_events"
    MISOFile2="./MISO_output_${file2}_${type}_events"

    compare_miso --compare-samples ${MISOFile1} ${MISOFile2} ${outputDir}
done
