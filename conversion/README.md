# Conversion Scripts
Because what is bioinformatics without converting a file into some other format, like 100 times?

### bed2faidxintervals ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Converts a .`bed` format file into the chrom:start-end format required by `samtools faidx`.

### fastq2fasta ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Converts a fastq file into a fasta file. Only requires basic built-in BASH commands.

### genepop2structure ![R logo](https://img.shields.io/badge/R-blueviolet.svg?logo=R)
Convert a genepop file to STRUCTURE format. The input file must end in `.gen`. The default conversion is to a standard STRUCTURE file. Use 'fast' or 'both' as an optional second argument to convert to FASTRUCTURE or both instead. Requires `R::radiator` package.

### interpro2wego![R logo](https://img.shields.io/badge/R-blueviolet.svg?logo=R)
Convert interproscan TSV output into [WEGO](https://wego.genomics.cn/) format, with optional e-score filtering. No external packages required.

### sam2bam ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Convert a SAM file into a BAM file. It will also sort and index the file, along with removing unmapped reads. Provide the number of threads as the second argument to run everything multithreaded.

### vcf2ped ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Converts a VCF file to `PLINK1.9` (required) PED format.

### vcf2ped_alt ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Convert a vcf file into `PLINK1.9` format using `VCFtools`

### vcf2plink2 ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Convert a vcf file into `PLINK2` (required) BED format.
