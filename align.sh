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
datasets="/media/charis/hdd/RNA-seq/datasets*.txt"
STAR \
--genomeLoad LoadAndExit \
--genomeDir /media/charis/hdd/RNA-seq/Indexes/GenomeDir
for f in $datasets
do
while read -r line
do
STAR \
--genomeDir /media/charis/hdd/RNA-seq/Indexes/GenomeDir \
--genomeLoad LoadAndKeep \
--readFilesIn /media/charis/hdd/RNA-seq/$f/$line/*.gz \
--alignIntronMax 20 \
--limitBAMsortRAM 310000000000 \
--runThreadN 12 \
--readFilesCommand zcat \
--outSAMtype BAM Unsorted \
--outFilterMultimapNmax 10 \
--outFilterScoreMinOverLread 0 \
--outFilterMatchNminOverLread 0 \
--outFilterMatchNmin 0 \
--alignEndsType Local \
--outBAMsortingBinsN 80 \
--outFileNamePrefix /media/charis/hdd/RNA-seq/$f/$line.final
echo  "
    Completed alignment of $line in project $f.
    "
done < $f
echo -e "$yellow
    Completed alignment of $project $f.
    $clear"
done
STAR \
--genomeDir /media/charis/hdd/RNA-seq/Indexes/GenomeDir \
--genomeLoad Remove
