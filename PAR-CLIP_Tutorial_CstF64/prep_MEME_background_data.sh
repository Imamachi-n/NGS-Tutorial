#!/bin/bash

fastafile="/home/akimitsu/database/gencode.v19.annotation_only_Rep_basic_mRNAs_3UTR.fa"
filename=`basename ${fastafile} .fa`

fasta-get-markov -m 3 ${filename}.fa ${filename}_markov_background_for_MEME.txt
