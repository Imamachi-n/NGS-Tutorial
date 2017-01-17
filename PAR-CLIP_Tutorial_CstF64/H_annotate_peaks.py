#!/usr/bin/env python2

from __future__ import print_function
import sys

input_file = open(sys.argv[1], 'r')
ref_file = open(sys.argv[2], 'r')
output_file = open(sys.argv[3], 'w')

peak_sites_dict = {}
peak_anno_dict = {}

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if data[6] == '.':
        continue
    strand_peaks = data[5]
    strand_anno = data[9]
    peak_anno = data[10]
    gene_symbol = data[12]
    if strand_peaks != strand_anno:
        continue
    site = "{0}:{1}-{2},{3},{4}".format(data[0],data[1],data[2],data[5],data[10])
    if gene_symbol in peak_sites_dict:
        peak_sites_dict[gene_symbol].append(site)
        peak_anno_dict[gene_symbol].append(peak_anno)
    else:
        peak_sites_dict[gene_symbol] = [site]
        peak_anno_dict[gene_symbol] = [peak_anno]

for line in ref_file:
    line = line.rstrip()
    data = line.split("\t")
    if data[0] == 'gr_id':
        print("\t".join(data[:4]), "peak_sites", "peak_anno", sep="\t", end="\n", file=output_file)
        continue
    gene_symbol = data[1]
    if gene_symbol in peak_sites_dict:
        peak_sites = peak_sites_dict[gene_symbol]
        peak_anno = peak_anno_dict[gene_symbol]
        peak_anno_compact = []
        if '5UTR' in peak_anno:
            peak_anno_compact.append('5UTR')
        if 'CDS' in peak_anno:
            peak_anno_compact.append('CDS')
        if '3UTR' in peak_anno:
            peak_anno_compact.append('3UTR')
        if 'Intron' in peak_anno:
            peak_anno_compact.append('Intron')
        print("\t".join(data[:4]), '|'.join(peak_sites), '|'.join(peak_anno_compact), sep="\t", end="\n", file=output_file)
    else:
        print("\t".join(data[:4]), "NA", "NA", sep="\t", end="\n", file=output_file)
        continue
