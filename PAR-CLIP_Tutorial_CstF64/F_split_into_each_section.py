#!/usr/bin/env python2

# Usage: python F_split_into_each_section.py <input bed file> <output bed file>

from __future__ import print_function
import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    chrom = data[0]
    st = int(data[1])
    ed = int(data[2])
    name = data[3]
    exon_blocks = data[10].split(',')
    exon_blocks.pop()
    exon_blocks = list(map(int,exon_blocks))
    exon_starts = data[11].split(',')
    exon_starts.pop()
    exon_starts = list(map(int, exon_starts))

    cds_st = int(data[6])
    cds_ed = int(data[7])
    strand = data[5]
    for x in range(len(exon_blocks)):
        st_each = st + exon_starts[x]
        ed_each = st + exon_starts[x] + exon_blocks[x]
        if st_each < cds_st: # 5'UTR -
            if ed_each < cds_st: # 5'UTR
                if strand == '+':
                    print(chrom, st_each, ed_each, strand, '5UTR', name, sep="\t", end="\n", file=output_file)
                    continue
                elif strand == '-':
                    print(chrom, st_each, ed_each, strand, '3UTR', name, sep="\t", end="\n", file=output_file)
                    continue
            elif ed_each >= cds_st: # 5'UTR -
                st_each_5UTR = st_each
                ed_each_5UTR = cds_st
                st_each_cds = cds_st
                if ed_each <= cds_ed: # 5'UTR - CDS
                    ed_each_cds = ed_each
                    if strand == '+':
                        print(chrom, st_each_5UTR, ed_each_5UTR, strand, '5UTR', name, sep="\t", end="\n", file=output_file)
                        print(chrom, st_each_cds, ed_each_cds, strand, 'CDS', name, sep="\t", end="\n", file=output_file)
                        continue
                    elif strand == '-':
                        print(chrom, st_each_5UTR, ed_each_5UTR, strand, '3UTR', name, sep="\t", end="\n", file=output_file)
                        print(chrom, st_each_cds, ed_each_cds, strand, 'CDS', name, sep="\t", end="\n", file=output_file)
                        continue
                elif ed_each > cds_ed: # 5'UTR - CDS - 3'UTR
                    ed_each_cds = cds_ed
                    st_each_3UTR = cds_ed
                    ed_each_3UTR = ed_each
                    if strand == '+':
                        print(chrom, st_each_5UTR, ed_each_5UTR, strand, '5UTR', name, sep="\t", end="\n", file=output_file)
                        print(chrom, st_each_cds, ed_each_cds, strand, 'CDS', name, sep="\t", end="\n", file=output_file)
                        print(chrom, st_each_3UTR, ed_each_3UTR, strand, '3UTR', name, sep="\t", end="\n", file=output_file)
                        continue
                    elif strand == '-':
                        print(chrom, st_each_5UTR, ed_each_5UTR, strand, '3UTR', name, sep="\t", end="\n", file=output_file)
                        print(chrom, st_each_cds, ed_each_cds, strand, 'CDS', name, sep="\t", end="\n", file=output_file)
                        print(chrom, st_each_3UTR, ed_each_3UTR, strand, '5UTR', name, sep="\t", end="\n", file=output_file)
                        continue
        elif cds_st <= st_each: # CDS/3UTR
            if st_each > cds_ed: # 3UTR
                st_each_3UTR = st_each
                ed_each_3UTR = ed_each
                if strand == '+':
                    print(chrom, st_each_3UTR, ed_each_3UTR, strand, '3UTR', name, sep="\t", end="\n", file=output_file)
                    continue
                elif strand == '-':
                    print(chrom, st_each_3UTR, ed_each_3UTR, strand, '5UTR', name, sep="\t", end="\n", file=output_file)
                    continue
            elif st_each <= cds_ed: # CDS -
                if ed_each <= cds_ed: # CDS
                    st_each_cds = st_each
                    ed_each_cds = ed_each
                    print(chrom, st_each_cds, ed_each_cds, strand, 'CDS', name, sep="\t", end="\n", file=output_file)
                    continue
                elif ed_each > cds_ed: # CDS - 3UTR
                    st_each_cds = st_each
                    ed_each_cds = cds_ed
                    st_each_3UTR = cds_ed
                    ed_each_3UTR = ed_each
                    if strand == '+':
                        print(chrom, st_each_cds, ed_each_cds, strand, 'CDS', name, sep="\t", end="\n", file=output_file)
                        print(chrom, st_each_3UTR, ed_each_3UTR, strand, '3UTR', name, sep="\t", end="\n", file=output_file)
                        continue
                    elif strand == '-':
                        print(chrom, st_each_cds, ed_each_cds, strand, 'CDS', name, sep="\t", end="\n", file=output_file)
                        print(chrom, st_each_3UTR, ed_each_3UTR, strand, '5UTR', name, sep="\t", end="\n", file=output_file)
                        continue
