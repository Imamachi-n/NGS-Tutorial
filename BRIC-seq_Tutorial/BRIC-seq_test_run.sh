#!/bin/bash

for file in *.fastq
do
    qsub ./BRIC-seq_unstr_single-end.sh ${file}
done
