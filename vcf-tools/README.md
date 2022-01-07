# VCF manipulation tools

### remove_contigs_from_vcf.sh ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Take a set of contigs, find matching SNPs in a vcf file, and remove all SNPs in those contigs. (requires `vcftools`)

### vcf_contig_rename.sh ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Wraps AWK commands to prepend text to your contig names, or find-&-replace text in the contig names.

### vcf_sort_index.sh ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Sort, compress, and index a VCF file. (requires `vcf-sort` and `bcftools`)
