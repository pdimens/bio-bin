#! usr/bin/env bash
#this script will take a set of contigs, find matching SNPs in a vcf file, and remove all SNPs in those contigs

if [ -z "$2" ]
then
    echo "No files with contigs to remove or vcf file specified."
    echo "Correct usage: remove_contigs_from_vcf.sh fileofcontigs vcffile"
    exit 1
else
    CONTIGS=( `cut -f1  $1 `)
    LEN=( `wc -l $1 `)
    LEN=$(($LEN - 1))

    for ((i=0; i <= $LEN; i++));
    do
        grep -P "${CONTIGS[$i]}\t" $2 >> out_loci.txt
    done

    cut -f-2 out_loci.txt >> remove_SNPs_from_vcf.txt

    vcftools --recode-INFO-all --vcf "$2" --exclude-positions remove_SNPs_from_vcf.txt --recode --out vcf-minus-contigs

    rm out_loci.txt
    rm remove_SNPs_from_vcf.txt
fi