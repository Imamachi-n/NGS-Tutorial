#!/bin/bash

for file in *.fastq
do
    qsub ./BRIC-seq_unstr_single-end_1_mapping.sh ${file}
done
