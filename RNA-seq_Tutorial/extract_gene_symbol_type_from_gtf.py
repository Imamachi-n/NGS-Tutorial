#!/usr/bin/env python2

from __future__ import print_function
import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')
tmp_file = open('anno_tmp.txt', 'w')

ref_dict = {}
# gene_id | gene_name | Akimitsu_anno | Gencode_anno

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if line.startswith('#'):
        continue
    status = data[2]
    gene_infor = data[8].split('; ')

    if data[1] == 'FAMTOM5':
        gene_name = ''
        chrom = data[0]
        st = data[3]
        ed = data[4]
        strand = data[6]
        chrom_infor = chrom + ':' + st + '-' + ed + ',' + strand
        for x in gene_infor:
            if x.startswith('gene_name'):
                x = x.replace('gene_name "', '')
                x = x.replace('"', '')
                x = x.replace(';', '')
                gene_name = x
                print(gene_name, "NA", 'FANTOM5_eRNA', 'NA',chrom_infor, sep="\t", end="\n", file=output_file)
                continue
    elif data[1] == 'AkimitsuLab':
        gene_name = ''
        chrom = data[0]
        st = data[3]
        ed = data[4]
        strand = data[6]
        chrom_infor = chrom + ':' + st + '-' + ed + ',' + strand
        for x in gene_infor:
            if x.startswith('gene_name'):
                x = x.replace('gene_name "', '')
                x = x.replace('"', '')
                x = x.replace(';', '')
                gene_name = x
                if gene_name.startswith('ERNA'):
                    print(gene_name, "NA", 'Akimitsu_eRNA', 'NA',chrom_infor, sep="\t", end="\n", file=output_file)
                    continue
                elif gene_name.startswith('PROT'):
                    print(gene_name, "NA", 'Akimitsu_PROMPT', 'NA',chrom_infor, sep="\t", end="\n", file=output_file)
                    continue

    if status == 'gene':
        gene_type = ''
        gene_name = ''
        gene_id = ''
        chrom = data[0]
        st = data[3]
        ed = data[4]
        strand = data[6]
        chrom_infor = chrom + ':' + st + '-' + ed + ',' + strand
        for x in gene_infor:
            if x.startswith('gene_type'):
                x = x.replace('gene_type "', '')
                x = x.replace('"', '')
                gene_type = x
            elif x.startswith('gene_name'):
                x = x.replace('gene_name "', '')
                x = x.replace('"', '')
                gene_name = x
            elif x.startswith('gene_id'):
                x = x.replace('gene_id "', '')
                x = x.replace('"', '')
                gene_id = x
        ref_dict[gene_id] = [gene_type, gene_name, gene_id, chrom_infor]

mRNA_list = [
"protein_coding"
]

lncRNA_list = [
"3prime_overlapping_ncrna",
"antisense",
"lincRNA",
"misc_RNA",
"sense_intronic",
"sense_overlapping"
]

pseudogene_list = [
"IG_C_pseudogene",
"IG_J_pseudogene",
"IG_V_pseudogene",
"polymorphic_pseudogene",
"processed_pseudogene",
"pseudogene",
"TR_J_pseudogene",
"TR_V_pseudogene",
"transcribed_processed_pseudogene",
"transcribed_unprocessed_pseudogene",
"translated_processed_pseudogene",
"unitary_pseudogene",
"unprocessed_pseudogene"
]

processed_transcript_list = [
"processed_transcript"
]

print('# gene_id | gene_symbol | Akimitsu_lab_type | Gencode_gene_type | chrom_infor', end="\n", file=output_file)

mRNA_gene_name_dict = {}

for key in ref_dict.keys():
    gene_infor = ref_dict[key]
    gene_type = gene_infor[0]
    gene_name = gene_infor[1]
    gene_id = gene_infor[2]
    chrom_infor = gene_infor[3]
    if gene_type in mRNA_list:
        print(gene_id, gene_name, "mRNA", gene_type,chrom_infor, sep="\t", end="\n", file=output_file)
        mRNA_gene_name_dict[gene_name] = 1
    elif gene_type in lncRNA_list:
        print(gene_id, gene_name, "lncRNA", gene_type,chrom_infor, sep="\t", end="\n", file=output_file)
    elif gene_type in pseudogene_list:
        print(gene_id, gene_name, "pseudogene", gene_type,chrom_infor, sep="\t", end="\n", file=output_file)
    elif gene_type in processed_transcript_list:
        print(gene_id, gene_name, "pending", gene_type,chrom_infor, sep="\t", end="\n", file=tmp_file)
    else:
        print(gene_id, gene_name, "others", gene_type,chrom_infor, sep="\t", end="\n", file=output_file)

tmp_file.close()

for line in open("anno_tmp.txt", 'r'):
    line = line.rstrip()
    data = line.split("\t")
    gene_name = data[1]
    if gene_name in mRNA_gene_name_dict:
        print("checked" + gene_name)
        print(data[0], data[1], "black", data[3], data[4], sep="\t", end="\n", file=output_file)
        continue
    print(data[0], data[1], "lncRNA", data[3], data[4], sep="\t", end="\n", file=output_file)
