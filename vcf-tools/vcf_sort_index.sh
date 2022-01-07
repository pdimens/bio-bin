#! /usr/bin/env bash

if [[ -z $1 ]]; then
echo -e "\nSort, compress, and index a VCF file.\n"
echo -e "[usage] vcf_sort_index.sh somefile.vcf\n"
exit 1
fi

echo -ne "\nsorting vcf and compressing with bgzip... "
# sort the vcf with vcftools/vcflib and bgzip compress it
vcf-sort $1 2> /dev/null | bgzip --stdout > ${1}.gz
echo -ne "done!\n"

# index the vcf using bcftools
echo -ne "\nindexing the compressed vcf file... "
bcftools index ${1}.gz
echo -e  "done!\n"
