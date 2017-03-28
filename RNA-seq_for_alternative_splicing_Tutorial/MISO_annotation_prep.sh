#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

source activate miso

# Required info
index_name="hg19_Gencode_v19"
index_dir="MISO_index"

# mkdir ${index_dir}
cd ${index_dir}

# Download annotation info from UCSC
# wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/knownGene.txt.gz
# wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/refGene.txt.gz
# wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/ensGene.txt.gz
# gunzip *.gz

# python ../hg19_anno_prep.py ensGene.txt ensGene_hg19.txt
# python ../hg19_anno_prep_for_knownGene knownGene.txt knownGene_hg19.txt
# python ../hg19_anno_prep.py refGene.txt refGene_hg19.txt
# rm ensGene.txt
# rm knownGene.txt
# rm refGene.txt
# mv ensGene_hg19.txt ensGene.txt
# mv knownGene_hg19.txt knownGene.txt
# mv refGene_hg19.txt refGene.txt

# Create gff annotation for MISO
gff_make_annotation ./ ./gff --flanking-rule commonshortest --genome-label ${index_name}

# Create gff index for MISO
cd gff/commonshortest
index_gff --index A3SS.hg19_Gencode_v19.gff3 indexed_A3SS_events/
index_gff --index A5SS.hg19_Gencode_v19.gff3 indexed_A5SS_events/
index_gff --index MXE.hg19_Gencode_v19.gff3 indexed_MXE_events/
index_gff --index SE.hg19_Gencode_v19.gff3 indexed_SE_events/
index_gff --index RI.hg19_Gencode_v19.gff3 indexed_RI_events/
