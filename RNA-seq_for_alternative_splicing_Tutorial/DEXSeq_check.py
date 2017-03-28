#!/usr/bin/env python

from __future__ import print_function
import sys

for line in open(sys.argv[1], 'r'):
    line = line.rstrip()
    data = line.split("\t")
    if data[0] == "groupID":
        print(line, end="\n")
        continue
    padj = 0
    try:
        padj = float(data[7])
    except:
        padj = 1
    if padj < 0.05:
        print(line, end="\n")
