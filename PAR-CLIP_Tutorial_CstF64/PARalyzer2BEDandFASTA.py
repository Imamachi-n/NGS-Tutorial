#!/usr/bin/env python

from __future__ import print_function
import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')
fasta_file = open(sys.argv[3], 'w')

for line in input_file:
    line = line.rstrip()
    data = line.split(",")
    if data[0] == 'Chromosome':
        continue
    chrom = data[0]
    strand = data[1]
    st_site = data[2]
    ed_site = data[3]
    read_count = data[6]
    conv_location_count = data[9]
    conv_event_count = data[10]
    cluster_id = "{0}|{1}|{2}|{3}|{4}".format(data[4], data[5], read_count, conv_location_count, conv_event_count)
    seq = data[5]
    print(chrom, st_site, ed_site, cluster_id, '0', strand, sep="\t", end="\n", file=output_file)
    print('>' + cluster_id, end="\n", file=fasta_file)
    print(seq, end="\n", file=fasta_file)
