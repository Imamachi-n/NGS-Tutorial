#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=4G
#$ -l mem_req=4G

wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012976/DRR014456/DRR014456.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012974/DRR014454/DRR014454.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012972/DRR014452/DRR014452.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012970/DRR014450/DRR014450.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012968/DRR014448/DRR014448.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012966/DRR014446/DRR014446.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012965/DRR014445/DRR014445.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012963/DRR014443/DRR014443.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012961/DRR014441/DRR014441.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012959/DRR014439/DRR014439.sra
wget  ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012957/DRR014437/DRR014437.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012955/DRR014435/DRR014435.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012954/DRR014434/DRR014434.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012952/DRR014432/DRR014432.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012950/DRR014430/DRR014430.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012948/DRR014428/DRR014428.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012946/DRR014426/DRR014426.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012944/DRR014424/DRR014424.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012943/DRR014423/DRR014423.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012941/DRR014421/DRR014421.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012939/DRR014419/DRR014419.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012937/DRR014417/DRR014417.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012935/DRR014415/DRR014415.sra
wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/DRX/DRX012/DRX012933/DRR014413/DRR014413.sra

mv DRR014456.sra BRIC_siSTAU1_705min_2_DRR014456.sra
mv DRR014434.sra BRIC_siSTAU1_705min_1_DRR014434.sra
mv DRR014454.sra BRIC_siSTAU1_465min_2_DRR014454.sra
mv DRR014432.sra BRIC_siSTAU1_465min_1_DRR014432.sra
mv DRR014452.sra BRIC_siSTAU1_225min_2_DRR014452.sra
mv DRR014430.sra BRIC_siSTAU1_225min_1_DRR014430.sra
mv DRR014450.sra BRIC_siSTAU1_105min_2_DRR014450.sra
mv DRR014428.sra BRIC_siSTAU1_105min_1_DRR014428.sra
mv DRR014448.sra BRIC_siSTAU1_45min_2_DRR014448.sra
mv DRR014426.sra BRIC_siSTAU1_45min_1_DRR014426.sra
mv DRR014446.sra BRIC_siSTAU1_0min_2_DRR014446.sra
mv DRR014424.sra BRIC_siSTAU1_0min_1_DRR014424.sra
mv DRR014445.sra BRIC_siCTRL_705min_2_DRR014445.sra
mv DRR014423.sra BRIC_siCTRL_705min_1_DRR014423.sra
mv DRR014443.sra BRIC_siCTRL_465min_2_DRR014443.sra
mv DRR014421.sra BRIC_siCTRL_465min_1_DRR014421.sra
mv DRR014441.sra BRIC_siCTRL_225min_2_DRR014441.sra
mv DRR014419.sra BRIC_siCTRL_225min_1_DRR014419.sra
mv DRR014439.sra BRIC_siCTRL_105min_2_DRR014439.sra
mv DRR014417.sra BRIC_siCTRL_105min_1_DRR014417.sra
mv DRR014437.sra BRIC_siCTRL_45min_2_DRR014437.sra
mv DRR014415.sra BRIC_siCTRL_45min_1_DRR014415.sra
mv DRR014435.sra BRIC_siCTRL_0min_2_DRR014435.sra
mv DRR014413.sra BRIC_siCTRL_0min_1_DRR014413.sra

for file in *.sra
  do
      fastq-dump ${file}
  done

cat BRIC_siSTAU1_0min_1_DRR014424.fastq BRIC_siSTAU1_0min_2_DRR014446.fastq > BRIC_siSTAU1_0min_DRR014424_DRR014446.fastq
cat BRIC_siSTAU1_45min_1_DRR014426.fastq BRIC_siSTAU1_45min_2_DRR014448.fastq > BRIC_siSTAU1_45min_DRR014426_DRR014448.fastq
cat BRIC_siSTAU1_105min_1_DRR014428.fastq BRIC_siSTAU1_105min_2_DRR014450.fastq > BRIC_siSTAU1_105min_DRR014428_DRR014450.fastq
cat BRIC_siSTAU1_225min_1_DRR014430.fastq BRIC_siSTAU1_225min_2_DRR014452.fastq > BRIC_siSTAU1_225min_DRR014430_DRR014452.fastq
cat BRIC_siSTAU1_465min_1_DRR014432.fastq BRIC_siSTAU1_465min_2_DRR014454.fastq > BRIC_siSTAU1_465min_DRR014432_DRR014454.fastq
cat BRIC_siSTAU1_705min_1_DRR014434.fastq BRIC_siSTAU1_705min_2_DRR014456.fastq > BRIC_siSTAU1_705min_DRR014434_DRR014456.fastq
cat BRIC_siCTRL_0min_1_DRR014413.fastq BRIC_siCTRL_0min_2_DRR014435.fastq > BRIC_siCTRL_0min_DRR014413_DRR014435.fastq
cat BRIC_siCTRL_45min_1_DRR014415.fastq BRIC_siCTRL_45min_2_DRR014437.fastq > BRIC_siCTRL_45min_DRR014415_DRR014437.fastq
cat BRIC_siCTRL_105min_1_DRR014417.fastq BRIC_siCTRL_105min_2_DRR014439.fastq > BRIC_siCTRL_105min_DRR014417_DRR014439.fastq
cat BRIC_siCTRL_225min_1_DRR014419.fastq BRIC_siCTRL_225min_2_DRR014441.fastq > BRIC_siCTRL_225min_DRR014419_DRR014441.fastq
cat BRIC_siCTRL_465min_1_DRR014421.fastq BRIC_siCTRL_465min_2_DRR014443.fastq > BRIC_siCTRL_465min_DRR014421_DRR014443.fastq
cat BRIC_siCTRL_705min_1_DRR014423.fastq BRIC_siCTRL_705min_2_DRR014445.fastq > BRIC_siCTRL_705min_DRR014423_DRR014445.fastq

