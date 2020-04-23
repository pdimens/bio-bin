# Genomic toolbox

A place to store my custom and forked scripts used for genomic analysis- a list slowly growing as things come up.

### configure_blasr_install ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
It took me forever to get blasr/sparc installed and running correctly for hybrid genome assemblies, and after finally getting it to work, I vowed to never **ever** have to deal with it again, so this scipt does the necessary tweaks to get sparc_split_and_run.sh working right, *and* from your `$PATH`

### ContigCutoff.jl ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
Simple isolation of contigs below a specified sequence coverage threshold. Typically used for the `genome.file` output from `dDocent`'s `FreeBayes` step when `FreeBayes` crashes due to memory load because _de novo_ assembly with too many contigs. Output usually fed into [faSomeRecords](https://github.com/ENCODE-DCC/kentUtils/blob/master/src/utils/faSomeRecords/faSomeRecords.c) to "prune" the de novo assembly of low-coverage contigs. 

### countseq ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
Counts the number of contigs/sequences in fasta or fastq files. Parallelized for faster counting!

### CountSeq.jl ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
A Julia implementation of `countseq` just to try it out. Tends to be more useful when fasta files are large or there are many fasta files that need to be counted. Slower than the GNU version otherwise.

### countbam ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
Simple wrapper for `SAMtools` which counts the total number of reads and number of mapped reads in bam files.

### CountMatch.jl ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
Takes an input file of strings (like 6bp indices) and does and all vs. all match to count the number of mismatches between the indices. Outputs an html heatmap and textfile of the pairwise comparisons.

### demultiplex_SE.pl ![alt_text](https://img.shields.io/badge/language-perl-yellow.svg) (not maintained)
Fork of Chris Hollenbeck's `demultiplex.pl` (perl wrapper for automating `process_RADtags` across several indices) that has an additional flag to handle single-end data for demultiplexing raw sequence reads. 

### FastaReadnames.jl ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
Simple julia wrapper to extract all the read names from within a fasta file (or multiple) into separate text files, or do a find-replace of readnames, such as replacing readnames "dDocent_contig_" with "Ginglymostoma_cirratum_contig_".

### FastStructureK.sh ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
A convenience wrapper to perform `fastStructure` anaylses for a range of `1` to `k` values, then summarize all the marginal likelihoods into a single file. 

### dDuplicator ![alt_text](https://img.shields.io/badge/language-python3-green.svg)
A specialized (but editable!) python script that takes RAD sequences with UMI elements, checking for PCR duplicates, removing them, and outputting filtered sequences ready for `dDocent` input.

### punzip ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
Parallelized unzipping of .gz files from one directory into another. Can do an entire directory, or only files containing something specific in their name, such as `lobster`, `_R1_`, `britneyspears`, etc.

### ReverseComp ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
Takes  a file of one-per-line sequences and outputs the reverse, complement, or reverse-complement of each of those sequences. This script was used to quickly generate reverse-complements to sequencing barcodes for demultiplexing.

### sam2bam ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
Automates basic conversion of a single `sam` file to a `bam` file, sorts it, and indexes it. 

### seqstatplot ![alt_text](https://img.shields.io/badge/language-python3-green.svg)
Outputs an interactive [bokeh](https://bokeh.pydata.org/en/latest/) plot as an html for the sequencing run metrics we recieve as .csv from the facility that sequences our samples. *Specific to their file output format*.

### seqstatplotly ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
Julia implementation of `seqstatplot` using `PlotyJS`

### SplitChrom.jl ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
Takes input fasta file and splits reads into their own fasta files. Useful for splitting a genome file by chromosome. 

### unpac ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
Converts pacbio sequences from bam to fasta/q. A wrapper for `bam2fastx`

### vcf_hwe_filter ![alt_text](https://img.shields.io/badge/language-R-yellow.svg)
**Two modes**
#### locus
Used to generate HWE heterozygosity info from a VCF file and perform the necessary outlier test with Benjamini-Hochberg correction. It outputs outlier contigs and loci into separate files and removes those loci and contigs from your VCF file, eliminating a lot of manual effort.
#### individual
Used to generate heterozygosity information per individual from a VCF file and perform a Tukey outlier test where outliers are individuals with F scores < Q1 - (1.5 x IQR) or > Q3 + (1.5 x IQR), then remove those individuals flagged as outliers from the input VCF. (Q = Quartile, IQR = Inter-Quartile Range).
