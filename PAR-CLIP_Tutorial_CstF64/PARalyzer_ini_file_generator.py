#!/usr/bin/env python2

from __future__ import print_function
import sys

filepath = sys.argv[1]
filename = sys.argv[2]
genome_2bit = sys.argv[3]
output_file = open(sys.argv[4], 'w')

line_1 = "BANDWIDTH=3"
line_2 = "CONVERSION=T>C"
line_3 = "MINIMUM_READ_COUNT_PER_GROUP=5"
line_4 = "MINIMUM_READ_COUNT_PER_CLUSTER=5"
line_5 = "MINIMUM_READ_COUNT_FOR_KDE=5"
line_6 = "MINIMUM_CLUSTER_SIZE=8"
line_7 = "MINIMUM_CONVERSION_LOCATIONS_FOR_CLUSTER=1"
line_8 = "MINIMUM_CONVERSION_COUNT_FOR_CLUSTER=1"
line_9 = "MINIMUM_READ_COUNT_FOR_CLUSTER_INCLUSION=5"
line_10 = "MINIMUM_READ_LENGTH=13"
line_11 = "MAXIMUM_NUMBER_OF_NON_CONVERSION_MISMATCHES=0"
line_12 = "EXTEND_BY_READ"
line_13 = "SAM_FILE={0}/STAR_output_{1}_EndtoEnd/{1}_4_STAR_result_Aligned.sortedByCoord.out.sam".format(filepath, filename)
line_14 = "GENOME_2BIT_FILE={0}".format(genome_2bit)
line_15 = "OUTPUT_DISTRIBUTIONS_FILE={0}_distribution.csv".format(filename)
line_16 = "OUTPUT_GROUPS_FILE={0}_groups.csv".format(filename)
line_17 = "OUTPUT_CLUSTERS_FILE={0}_clusters.csv".format(filename)

print(line_1, end="\n", file=output_file)
print(line_2, end="\n", file=output_file)
print(line_3, end="\n", file=output_file)
print(line_4, end="\n", file=output_file)
print(line_5, end="\n", file=output_file)
print(line_6, end="\n", file=output_file)
print(line_7, end="\n", file=output_file)
print(line_8, end="\n", file=output_file)
print(line_9, end="\n", file=output_file)
print(line_10, end="\n", file=output_file)
print(line_11, end="\n", file=output_file)
print(line_12, end="\n", file=output_file)
print(line_13, end="\n", file=output_file)
print(line_14, end="\n", file=output_file)
print(line_15, end="\n", file=output_file)
print(line_16, end="\n", file=output_file)
print(line_17, end="\n", file=output_file)
