#!/usr/bin/env python

# Usage: python C_prep_fasta_file_for_MEME.py ${filename}_on_mRNAs_plus_anno.bed ${filename}_on_mRNAs_plus_anno.fa

from __future__ import print_function
import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

for line in input_file :
    line = line.rstrip()
    data = line.split("\t")
    seq = data[3].split('|')[1]
    peak_name = data[3].split('|')[0]
    gene_name = data[9]
    name = ">{0}|{1}".format(gene_name, peak_name)
    print(name, end="\n", file=output_file)
    print(seq, end="\n", file=output_file)
