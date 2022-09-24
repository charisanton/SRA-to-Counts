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
  |                Download SRA datasets                   |
  +--------------------------------------------------------+
  $clear
  "
cd /media/charis/hdd/RNA-seq/datasets
datasets="*.txt"
for f in $datasets
do
while read -r line
do
prefetch $line \
--output-directory /media/charis/hdd/RNA-seq/$f \
--verify yes \
--max-size 420000000000000000000000000000000 \
-p
echo -e "$cyan

  $line of the $f dataset has been downloaded at /media/charis/hdd/RNA-seq/$f/$line

  $clear"
done < $f
echo -e "$green

  Completed downloading $f dataset.

  $clear"
done
