#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=4G
#$ -l mem_req=4G

wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/SRX/SRX740/SRX740748/SRR1630831/SRR1630831.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/SRX/SRX740/SRX740751/SRR1630838/SRR1630838.sra

mv SRR1630831.sra Ribo-Seq_HEK293_Cell_Control_SRR1630831.sra
mv SRR1630838.sra RNA-Seq_HEK293_Cell_SRR1630838.sra 

fastq-dump Ribo-Seq_HEK293_Cell_Control_SRR1630831.sra
fastq-dump RNA-Seq_HEK293_Cell_SRR1630838.sra 

