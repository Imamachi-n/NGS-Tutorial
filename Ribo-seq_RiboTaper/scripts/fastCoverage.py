#!/usr/bin/env python3

import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

flg = ''
first = 0
for line in input_file:
    data = line.rstrip().split("\t")
    pos = data[1]
    if flg == data[0] and first == 1:
        print(" ",data[1],sep="",end="",file=output_file)
    elif first == 0:
        print(data[0],data[1],sep="\t",end="",file=output_file)
    elif first == 1:
        print('',end="\n",file=output_file)
        print(data[0],data[1],sep="\t",end="",file=output_file)
    flg = data[0]
    first = 1
print('',end="\n",file=output_file)
