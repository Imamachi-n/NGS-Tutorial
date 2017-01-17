#!/usr/bin/env python

# Usage: python D_prep_fasta_file_for_MEME_rep_version.py ${filename}_on_mRNAs_plus_anno.bed ${filename}_on_mRNAs_plus_anno_rep_version.fa

from __future__ import print_function
import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

rep_dict = {}

for line in input_file :
    line = line.rstrip()
    data = line.split("\t")
    seq = data[3].split('|')[1]
    read_count = int(data[3].split('|')[2])
    gene_name = data[9]
    if not gene_name in rep_dict:
        rep_dict[gene_name] = [[seq, read_count]]
    else:
        rep_dict[gene_name].append([seq, read_count])

for gene_name in rep_dict:
    data_list = rep_dict[gene_name]
    data_list.sort(key=lambda x:x[1])
    seq = data_list[-1][0]
    read_count = data_list[-1][1]
    name = ">{0}|{1}".format(gene_name, read_count)
    print(name, end="\n", file=output_file)
    print(seq, end="\n", file=output_file)
