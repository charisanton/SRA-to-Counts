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
  |              Time for count data                       |
  +--------------------------------------------------------+
  $clear"
echo -e "$green
  Single-end reads
  $clear"
cd /media/charis/hdd/RNA-seq/datasets/single
datasets="*.txt"
for f in $datasets
do
cd /media/charis/hdd/RNA-seq/$f
featureCounts -t gene -T 12 \
-a /media/charis/hdd/RNA-seq/Indexes/Homo_sapiens.GRCh38.107.gtf \
-o /media/charis/hdd/RNA-seq/$f/count \
/media/charis/hdd/RNA-seq/$f/*.bam
echo "$blue
    Completed counting project $f.
    $clear"
done
echo -e "$green
  Paired-end reads
  $clear"
cd /media/charis/hdd/RNA-seq/datasets/paired
datasets="*.txt"
for f in $datasets
do
cd /media/charis/hdd/RNA-seq/$f
featureCounts -t gene -T 12 -p \
--countReadPairs \
-a /media/charis/hdd/RNA-seq/Indexes/Homo_sapiens.GRCh38.107.gtf \
-o /media/charis/hdd/RNA-seq/$f/count \
/media/charis/hdd/RNA-seq/$f/*.bam
echo "$blue
    Completed counting project $f.
    $clear"
done
echo "$red
  +--------------------------------------------------------+
  |                   Proceed to DGE                       |
  +--------------------------------------------------------+
  $clear"

