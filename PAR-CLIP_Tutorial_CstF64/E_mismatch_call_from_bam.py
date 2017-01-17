#!/usr/bin/env python

# Usage: python E_mismatch_call_from_bam.py SRR488740_PAR-CLIP_CstF-64_4_STAR_result_Aligned.sortedByCoord.out.sam SRR488740_PAR-CLIP_CstF-64_4_STAR_result_Aligned.sortedByCoord.out_indel.txt Base_substitution_frequency.txt

from __future__ import print_function
import sys
import re
import string

def CIGAR_parse(string):
    return re.findall(r'(\d+|\D+)', string)

def MD_parse(string):
    MD_string = string.split(':')[2]
    return re.findall(r'(\d+|\D+)', MD_string)

def reverse_seq(seq):
    if 'U' in seq or 'u' in seq:
        trans_table = string.maketrans("AUGCaugc","UACGUACG")
    else:
        trans_table = string.maketrans("ATGCatgc","TACGtacg")
    rev_seq = seq.translate(trans_table)
    return rev_seq

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')
freq_file = open(sys.argv[3], 'w')

count = 0
ref_nuc = {}

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if line.startswith('@'):
        continue
    flag = int(data[1])
    strand = '+'
    if flag == 16:
        strand = '-'
    seq_infor = data[5]
    read_seq = data[9]
    indel_infor = data[16]
    if len(CIGAR_parse(seq_infor)) > 2:
        continue
    if len(MD_parse(indel_infor)) == 1:
        continue
    for x in MD_parse(indel_infor):
        if re.match(r'\d', x):    # Integer
            read_seq = read_seq[int(x):]
        elif re.match(r'\D', x):    # String
            read_nucleotide = read_seq[0]
            ref_nucleotide = x
            if strand == '-':
                read_nucleotide = reverse_seq(read_nucleotide)
                ref_nucleotide = reverse_seq(ref_nucleotide)
            read_seq = read_seq[1:]
            print(seq_infor, indel_infor, ref_nucleotide, read_nucleotide, strand, sep="\t", end="\n", file=output_file)
    count += 1
    conv_infor = "{0}>{1}".format(ref_nucleotide, read_nucleotide)
    if not conv_infor in ref_nuc:
        ref_nuc[conv_infor] = 1
    else:
        ref_nuc[conv_infor] += 1

print("Read count: ", str(count))

for x in ref_nuc.keys():
    count = ref_nuc[x]
    print(x, count, sep="\t", end="\n", file=freq_file)
