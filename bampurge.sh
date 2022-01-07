#! /usr/bin/env bash

if [[ -z "$1" ]]; then
    echo -e "\n  This script will sort and index a BAM file, along with removing unmapped reads. Provide the number of threads as the second argument to run everything multithreaded."
    echo -e "\n [usage] bam_purge filename.bam threads"
    exit
fi

if [[ -z "$2" ]]; then
    THREADS=1
else
    THREADS=$2
fi

FILENAME=`echo "$1" | cut -d '.' -f1`

# sort the BAM
samtools view -h -F4 $FILENAME.bam -@$THREADS | samtools sort -m 16G -l0  -@$THREADS> $FILENAME.sorted.bam

# index sorted BAM
samtools index $FILENAME.sorted.bam -@$THREADS