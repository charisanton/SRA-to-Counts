#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
clear='\033[0m'
echo -e "$blue
  +--------------------------------------------------------+
  |                                                        |
  |                  RNA-seq workflow                      |
  |                                                        |
  +--------------------------------------------------------+
  |  Author:   Charalabos Antonatos                        |
  |  Purpose:  Download RNA-seq data from NCBI,            |
  |  transform them to .fastq, run a QC analysis,          | 
  |  align them and prepare the count table for DESeq2.    |
  +--------------------------------------------------------+
  "
  echo -e "$green

  +--------------------------------------------------------+
  |                Convert .sra to .fastq                  |
  +--------------------------------------------------------+

  $clear"
cd /media/charis/hdd/RNA-seq/datasets
datasets="*.txt"
for f in $datasets
do
while read -r line
do
cd /media/charis/hdd/RNA-seq/$f/$line
fasterq-dump $line.sra \
--threads 12
rm $line.sra
pigz *.fastq \
--processes 12 
cd /media/charis/hdd/RNA-seq/datasets
echo -e "$red

  Converted $yellow $line $green of $cyan $f $blue dataset into fastq.gz file.

  $clear"
done < $f
echo -e "$green

  Completed converting $f dataset.
  
  $clear"
done
