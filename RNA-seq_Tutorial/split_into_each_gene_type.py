#!/usr/bin/env python2

from __future__ import print_function
import sys
import os

input_file = open(sys.argv[1], 'r')

output_filename_core = os.path.splitext(sys.argv[1])[0]
mRNA_output_file = open(output_filename_core + '_mRNA.txt', 'w')
lncRNA_output_file = open(output_filename_core + '_lncRNA.txt', 'w')
pseudogene_output_file = open(output_filename_core + '_pseudogene.txt', 'w')
others_output_file = open(output_filename_core + '_others.txt', 'w')
Akimitsu_eRNA_output_file = open(output_filename_core + '_Akimitsu_eRNA.txt', 'w')
FANTOM5_eRNA_output_file = open(output_filename_core + '_FANTOM5_eRNA.txt', 'w')
Akimitsu_PROMPT_output_file = open(output_filename_core + '_Akimitsu_PROMPT.txt', 'w')

header_flg = 0
mRNA_counter = 1
lncRNA_counter = 1
pseudogene_counter = 1
others_counter = 1
Akimitsu_eRNA_counter = 1
FANTOM5_eRNA_counter = 1
Akimitsu_PROMPT_counter = 1

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if header_flg == 0:
        print("gr_id", line, sep="\t", end="\n", file=mRNA_output_file)
        print("gr_id", line, sep="\t", end="\n", file=lncRNA_output_file)
        print("gr_id", line, sep="\t", end="\n", file=pseudogene_output_file)
        print("gr_id", line, sep="\t", end="\n", file=others_output_file)
        print("gr_id", line, sep="\t", end="\n", file=Akimitsu_eRNA_output_file)
        print("gr_id", line, sep="\t", end="\n", file=FANTOM5_eRNA_output_file)
        print("gr_id", line, sep="\t", end="\n", file=Akimitsu_PROMPT_output_file)
        header_flg = 1
        continue
    gene_type = data[2]
    if gene_type == 'mRNA':
        print(mRNA_counter, line, sep="\t", end="\n", file=mRNA_output_file)
        mRNA_counter += 1
    elif gene_type == 'lncRNA':
        print(lncRNA_counter, line, sep="\t", end="\n", file=lncRNA_output_file)
        lncRNA_counter += 1
    elif gene_type == 'pseudogene':
        print(pseudogene_counter, line, sep="\t", end="\n", file=pseudogene_output_file)
        pseudogene_counter += 1
    elif gene_type == 'others':
        print(others_counter, line, sep="\t", end="\n", file=others_output_file)
        others_counter += 1
    elif gene_type == 'Akimitsu_eRNA':
        print(Akimitsu_eRNA_counter, line, sep="\t", end="\n", file=Akimitsu_eRNA_output_file)
        Akimitsu_eRNA_counter += 1
    elif gene_type == 'FANTOM5_eRNA':
        print(FANTOM5_eRNA_counter, line, sep="\t", end="\n", file=FANTOM5_eRNA_output_file)
        FANTOM5_eRNA_counter += 1
    elif gene_type == 'Akimitsu_PROMPT':
        print(Akimitsu_PROMPT_counter, line, sep="\t", end="\n", file=Akimitsu_PROMPT_output_file)
        Akimitsu_PROMPT_counter += 1
