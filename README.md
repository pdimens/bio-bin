# Bio-bin, the genomic toolbox

A place to store custom and forked scripts used for genomic analysis- a list slowly growing as things come up.
### allmaps_split_chimera.sh ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
A reusable script that wraps [the steps provided by ALLMAPS](https://github.com/tanghaibao/jcvi/wiki/ALLMAPS:-How-to-split-chimeric-contigs) to identify and split chimeric contigs. 

### bampurge.sh ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Sort and index a BAM file, along with removing unmapped reads. Provide the number of threads as the second argument to run multithreaded.

### bed2faidxintervals ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Converts a .`bed` format file into the chrom:start-end format required by `samtools faidx`.

### configure_blasr_install ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
It took me forever to get blasr/sparc installed and running correctly for hybrid genome assemblies, and after finally getting it to work, I vowed to never **ever** have to deal with it again, so this scipt does the necessary tweaks to get sparc_split_and_run.sh working right, *and* from your `$PATH`. **Deprecated since adding PR's to DBG2OLC repo**

### CoverageCutoff.jl ![Julia logo](https://img.shields.io/badge/julia-blue.svg?logo=julia&logoColor=white)
Simple isolation of contigs below a specified sequence coverage threshold. Typically used for the `genome.file` output from `dDocent`'s `FreeBayes` step when `FreeBayes` crashes due to memory load because _de novo_ assembly with too many contigs. Output usually fed into [faSomeRecords](https://github.com/ENCODE-DCC/kentUtils/blob/master/src/utils/faSomeRecords/faSomeRecords.c) to "prune" the de novo assembly of low-coverage contigs. 

### countbam ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Simple wrapper for `SAMtools` which counts the total number of reads and number of mapped reads in bam files.

### CountMatch.jl ![Julia logo](https://img.shields.io/badge/julia-blue.svg?logo=julia&logoColor=white)
Takes an input file of strings (like 6bp indices) and does and all vs. all match to count the number of mismatches between the indices. Outputs an html heatmap and textfile of the pairwise comparisons.

### exportenv ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
For al those times you forget the command to export (and strip the prefix from) your current conda environment to a yaml file.

### FastStructureK.sh ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
A convenience wrapper to perform `fastStructure` anaylses for a range of `1` to `k` values, then summarize all the marginal likelihoods into a single file. 

### FastStructurePlot.R ![R logo](https://img.shields.io/badge/R-blueviolet.svg?logo=R)
Pairs with `FastStructureK.sh` to create a pdf of a reasonably nice non-publication quality plot of your fastStructure results for exploration. Assumes your fastStructure input file (`__.str`) is in the working directory, if it's not, then supply its name as the only argument. This is the [example output](https://github.com/pdimens/bioinformatics-toolbox/blob/master/misc/FastStructurePlot.example.pdf).

### genepop2structure ![R logo](https://img.shields.io/badge/R-blueviolet.svg?logo=R)
Convert a genepop file to STRUCTURE and/or FASTSTRUCTURE format.

### punzip ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Parallelized unzipping of .gz files from one directory into another. Can do an entire directory, or only files containing something specific in their name, such as `lobster`, `_R1_`, `britneyspears`, etc.

### revcomp  ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Returns the reverse, complement, or reverse-complement of DNA bases in a text file.

### sam2bam ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Automates basic conversion of a single `sam` file to a `bam` file, sorts it, and indexes it. 

### unpac ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Converts pacbio sequences from bam to fasta/q. A wrapper for `bam2fastx`

### vcf2ped ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Perform a simple conversion of VCF format into Plink1.9 PED format.

### vcf_hwe_filter ![R logo](https://img.shields.io/badge/R-blueviolet.svg?logo=R)
- #### locus (mode 1)
Used to generate HWE heterozygosity info from a VCF file and perform the necessary outlier test with Benjamini-Hochberg correction. It outputs outlier contigs and loci into separate files and removes those loci and contigs from your VCF file, eliminating a lot of manual effort.
- #### individual (mode 2)
Used to generate heterozygosity information per individual from a VCF file and perform a Tukey outlier test where outliers are individuals with F scores < Q1 - (1.5 x IQR) or > Q3 + (1.5 x IQR), then remove those individuals flagged as outliers from the input VCF. (Q = Quartile, IQR = Inter-Quartile Range).

### vcf_metrics.sh ![BASH logo](https://img.shields.io/badge/R-blueviolet.svg?logo=R) ![alt_text](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Calculate the mean depth and missingness per site and per sample in a vcf file. Generates a pre-formatted R file with `.rdata` to explore the results. Requires VCFtools + R::tidyverse.
