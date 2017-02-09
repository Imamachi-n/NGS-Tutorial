#!/bin/bash

for file in *.fastq
do
    qsub ./RNA-seq_strand-specific_single-end_1_mapping.sh ${file}
done
