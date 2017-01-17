#!/usr/bin/env python

# Usage: python B_prep_longest_trx_id_list.py gencode.v25lift37.annotation_for_UCSC_only_basic_mRNAs.bed gencode.v25lift37.annotation_for_UCSC_only_basic_mRNAs_gene_trx_list.txt gencode.v25lift37.annotation_for_UCSC_only_Rep_basic_mRNAs.bed

from __future__ import print_function
import sys

ref_file = open(sys.argv[1], 'r')
input_file = open(sys.argv[2], 'r')
output_file = open(sys.argv[3], 'w')

ref_dict = {}

for line in ref_file:
    line = line.rstrip()
    data = line.split("\t")
    trx_id = data[3]
    exon_block_list = data[10].split(',')
    exon_block_list.pop()
    exon_block_list = map(int, exon_block_list)
    rna_length = sum(exon_block_list)
    ref_dict[trx_id] = [rna_length, line]

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    gene_id = data[0]
    trx_id_list = data[1].split(',')
    trx_id_dict = [[x, ref_dict[x][0], ref_dict[x][1]] for x in trx_id_list]
    trx_id_dict.sort(key=lambda x:x[1])
    gene_name = data[2]
    test_line = trx_id_dict[-1][2].split("\t")
    name = "{0}|{1}|{2}".format(gene_name, gene_id, test_line[3])
    print("\t".join(test_line[:3]), name, "\t".join(test_line[4:]),  sep="\t", end="\n", file=output_file)
