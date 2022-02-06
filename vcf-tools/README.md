# VCF manipulation tools

### filter_hwe_by_pop.pl ![perl logo](https://img.shields.io/badge/perl-violet.svg?logo=perl&logoColor=white)
Filters loci for Hardy-Weinberg outliers on a by-population basis, that is, removes loci that are out of equilibrium in >N number of populations.

### remove_contigs_from_vcf.sh ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Take a set of contigs, find matching SNPs in a vcf file, and remove all SNPs in those contigs. (requires `vcftools`)

### vcf_contig_rename.sh ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Wraps AWK commands to prepend text to your contig names, or find-&-replace text in the contig names.

### vcf_hwe_filter ![R logo](https://img.shields.io/badge/R-blueviolet.svg?logo=R)
- #### locus (mode 1)
Used to generate HWE heterozygosity info from a VCF file and perform the necessary outlier test with Benjamini-Hochberg correction. It outputs outlier contigs and loci into separate files and removes those loci and contigs from your VCF file, eliminating a lot of manual effort.
- #### individual (mode 2)
Used to generate heterozygosity information per individual from a VCF file and perform a Tukey outlier test where outliers are individuals with F scores < Q1 - (1.5 x IQR) or > Q3 + (1.5 x IQR), then remove those individuals flagged as outliers from the input VCF. (Q = Quartile, IQR = Inter-Quartile Range).

### vcf_metrics.sh ![BASH logo](https://img.shields.io/badge/R-blueviolet.svg?logo=R) ![alt_text](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Calculate the mean depth and missingness per site and per sample in a vcf file. Generates a pre-formatted R file with `.rdata` to explore the results. Requires VCFtools + R::tidyverse.

### vcf_sort_index.sh ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Sort, compress, and index a VCF file. (requires `vcf-sort` and `bcftools`)
