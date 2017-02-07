#!/bin/bash

for file in *.fastq
do
    qsub ./RNA-seq_unstr_single-end_1_mapping.sh ${file}
done
