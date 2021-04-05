#! /usr/bin/env bash


if [[ -z "$1" ]]; then
cat <<EOF

This script pulls out the barcodes from the end of the first read headers in all the forward
 read FASTQ files in the current directory and writes them into a process_radtags compliant
barcodes.txt file. Assumes barcodes are 6bp long.

[usage]:        extract_barcodes.sh <extention for forward reads>
[example]:      extract_barcodes.sh .F.fq.gz

EOF
  exit 1
fi

if [[ -f "barcodes.txt" ]]; then
  echo "Error: barcodes.txt already present in working directory"
  exit 1
fi

for i in *$1; do
    FILE=$(basename $i $1)
    BARCODE=$(zcat $i | head -1 | rev | cut -c -6 | rev)
    echo -e -n "$BARCODE\t$FILE\n" >> barcodes.txt
done

echo "Barcodes found in barcodes.txt"
