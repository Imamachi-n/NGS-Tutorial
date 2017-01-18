#!/usr/bin/env python

from __future__ import print_function
import sys

input_file = open(sys.argv[1], 'r')
output_mRNA_file = open(sys.argv[2], 'w')
output_lncRNA_file = open(sys.argv[3], 'w')

mRNA_dict = {}
lncRNA_dict = {}

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if line.startswith('#'):
        print('# gr_id | gene_id | gene_symbol | Akimitsu_lab_type | Gencode_gene_type | chrom_infor', sep="\t", end="\n", file=output_mRNA_file)
        print('# gr_id | gene_id | gene_symbol | Akimitsu_lab_type | Gencode_gene_type | chrom_infor', sep="\t", end="\n", file=output_lncRNA_file)
        continue
    gene_symbol = data[1]
    lab_label = data[2]
    if lab_label == "mRNA":
        if not gene_symbol in mRNA_dict:
            mRNA_dict[gene_symbol] = line
        else:
            gene_symbol += "||"
            mRNA_dict[gene_symbol] = line
    elif lab_label == "lncRNA":
        if not gene_symbol in lncRNA_dict:
            lncRNA_dict[gene_symbol] = line
        else:
            gene_symbol += "||"
            lncRNA_dict[gene_symbol] = line

gr_id = 1
for gene_symbol in sorted(mRNA_dict.keys()):
    line = mRNA_dict[gene_symbol]
    print(gr_id, line, sep="\t", end="\n", file=output_mRNA_file)
    gr_id += 1

gr_id = 1
for gene_symbol in sorted(lncRNA_dict.keys()):
    line = lncRNA_dict[gene_symbol]
    print(gr_id, line, sep="\t", end="\n", file=output_lncRNA_file)
    gr_id += 1
