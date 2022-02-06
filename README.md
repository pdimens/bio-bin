# Bio-bin, the genomic toolbox

A place to store custom and forked scripts used for genomic analysis- a list slowly growing as things come up.
### allmaps_split_chimera.sh ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
A reusable script that wraps [the steps provided by ALLMAPS](https://github.com/tanghaibao/jcvi/wiki/ALLMAPS:-How-to-split-chimeric-contigs) to identify and split chimeric contigs. 

### bampurge.sh ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Sort and index a BAM file, along with removing unmapped reads. Provide the number of threads as the second argument to run multithreaded.

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

### punzip ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Parallelized unzipping of .gz files from one directory into another. Can do an entire directory, or only files containing something specific in their name, such as `lobster`, `_R1_`, `britneyspears`, etc.

### revcomp  ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Returns the reverse, complement, or reverse-complement of DNA bases in a text file.

### unpac ![BASH logo](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Converts pacbio sequences from bam to fasta/q. A wrapper for `bam2fastx`

