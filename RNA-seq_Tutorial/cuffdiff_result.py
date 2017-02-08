#!/usr/bin/env python

from __future__ import print_function
import sys

# Gene name,type infor
ref_dict = {}
for line in open(sys.argv[1], 'r'): # gencode.v19.annotation_filtered+PROMPT_v2+eRNA_v2+FANTOM_eRNA_symbol_type_list.txt
    line = line.rstrip()
    data = line.split("\t")
    if line.startswith('#'):
        continue
    gene_name = data[0]
    ref_dict[gene_name] = line

# Annotate gene infor
output_file = open(sys.argv[4], 'w')
select_gene_type = sys.argv[3].split(',') # 3prime_overlapping_ncrna,antisense,lincRNA,misc_RNA,sense_intronic,sense_overlapping
gr_id = 1

for line in open(sys.argv[2], 'r'):
    line = line.rstrip()
    data = line.split("\t")
    if data[0] == "test_id":
        print("gr_id", "gene_id", "gene_symbol", "AkimitsuLab_gene_type", "Gencode_gene_type", "\t".join(data[4:]), sep="\t", end="\n", file=output_file)
        continue
    gene_name = data[0]
    gene_infor = ref_dict[gene_name]
    gene_infor_list = gene_infor.split("\t")
    gene_type = gene_infor_list[2]
    if not gene_type in select_gene_type:
        continue
    print(gr_id, "\t".join(gene_infor.split("\t")[:4]), "\t".join(data[4:]), sep="\t", end="\n", file=output_file)
    gr_id += 1

output_file.close()
