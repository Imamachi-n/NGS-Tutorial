#!/usr/bin/env python2

from __future__ import print_function
import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

name_ref = ''
st_ref = 0
ed_ref = 0

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    name = data[5]
    st = data[1]
    ed = data[2]
    if name_ref == name:
        if ed_ref == st:
            st_ref = st
            ed_ref = ed
            print(line, end="\n", file=output_file)
            continue
        elif ed_ref != st:
            intron_st = ed_ref
            intron_ed = st
            st_ref = st
            ed_ref = ed
            print(data[0], intron_st, intron_ed, data[3], 'Intron', "\t".join(data[5:]), sep="\t", end="\n", file=output_file)
            print(line, end="\n", file=output_file)
            continue
    elif name_ref != name:
        name_ref = name
        st_ref = st
        ed_ref = ed
        print(line, end="\n", file=output_file)
        continue
