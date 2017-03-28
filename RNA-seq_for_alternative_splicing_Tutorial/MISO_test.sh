#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

source activate miso

file=`basename ${1} .fastq`

bamFile="./tophat_out_${file}/accepted_hits.bam"
read_length="101"
MISO_setting_file="./miso_settings.txt"

# Run MISO
for type in A3SS A5SS MXE RI SE
do
    gff_index="./MISO_index/gff/commonshortest/indexed_${type}_events"
    outputDir="MISO_output_${file}_${type}_events/"

    miso --run ${gff_index} ${bamFile} --output-dir ${outputDir} \
    --read-len ${read_length} --settings-filename ${MISO_setting_file}

    summarize_miso --summarize-samples ${outputDir} ${outputDir}
done
