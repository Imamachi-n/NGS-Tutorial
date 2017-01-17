#!/usr/bin/env python

# Usage: python A_prep_gtf_for_PAR-CLIP.py gencode.v25lift37.annotation_for_UCSC.gtf gencode.v25lift37.annotation_for_UCSC_only_basic_mRNAs.gtf gencode.v25lift37.annotation_for_UCSC_only_basic_mRNAs_gene_trx_list.txt

from __future__ import print_function
import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')
rep_iso_file = open(sys.argv[3], 'w')

rep_dict = {}
rep_name_dict = {}

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if line.startswith('#'):
        continue
    gene_infor = data[8].split("; ")
    flg_tag = 0
    flg_NG = 0
    gene_id = ''
    trx_id = ''
    gene_type = ''
    gene_name = ''
    for x in gene_infor:
        if x.startswith('gene_type'):
            x = x.replace('gene_type "', '')
            x = x.replace('"', '')
            if x != "protein_coding":
                flg_NG = 1
                break
            gene_type = x
        elif x.startswith('gene_id'):
            x = x.replace('gene_id "', '')
            x = x.replace('"', '')
            gene_id = x
        elif x.startswith('transcript_id'):
            x = x.replace('transcript_id "', '')
            x = x.replace('"', '')
            trx_id = x
        elif x.startswith('gene_name'):
            x = x.replace('gene_name "', '')
            x = x.replace('"', '')
            gene_name = x
        elif x.startswith('transcript_type'):
            x = x.replace('transcript_type "', '')
            x = x.replace('"', '')
            if x != "protein_coding":
                flg_NG = 1
                break
        elif x.startswith('transcript_status'):
            x = x.replace('transcript_status "', '')
            x = x.replace('"', '')
            if x == "PUTATIVE":
                flg_NG = 1
                break
        elif x.startswith('tag'):
            x = x.replace('tag "', '')
            x = x.replace('"', '')
            if x == "basic":
                flg_tag = 1
    if flg_NG == 1 or flg_tag == 0:
        continue

    if not gene_id in rep_dict:
        rep_dict[gene_id] = [trx_id]
    else:
        if not trx_id in rep_dict[gene_id]:
            rep_dict[gene_id].append(trx_id)
    if not gene_id in rep_name_dict:
        rep_name_dict[gene_id] = [gene_name, gene_type]
    print(line, sep="\t", end="\n", file=output_file)

for gene_id in rep_dict.keys():
    trx_id_list = rep_dict[gene_id]
    rep_names = rep_name_dict[gene_id]
    print(gene_id, ','.join(trx_id_list), rep_names[0], rep_names[1], sep="\t", end="\n", file=rep_iso_file)
