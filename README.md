# Genomic toolbox

A place to store my custom and forked scripts used for genomic analysis- a list slowly growing as things come up.

### bh_hardy.py ![alt_text](https://img.shields.io/badge/language-python3-green.svg)
A python script that takes your raw `--hardy` output from `VCFtools` and performs a Benjamini-Hochberg correction on the data, outputting a file with the contigs that have >1 significant locus. This version requires only base python packages (e.g. no `numpy` or `pandas`)

### configure_blasr_install ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
It took me forever to get blasr/sparc installed and running correctly for hybrid genome assemblies, and after finally getting it to work, I vowed to never **ever** have to deal with it again, so this scipt does the necessary tweaks to get sparc_split_and_run.sh working right, *and* from your `$PATH`

### ContigCutoff.jl ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
Simple isolation of contigs below a specified sequence coverage threshold. Typically used for the `genome.file` output from `dDocent`'s `FreeBayes` step when `FreeBayes` crashes due to memory load because _de novo_ assembly with too many contigs. Output usually fed into [faSomeRecords](https://github.com/ENCODE-DCC/kentUtils/blob/master/src/utils/faSomeRecords/faSomeRecords.c) to "prune" the de novo assembly of low-coverage contigs. 

### countseq ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
Counts the number of contigs/sequences in fasta or fastq files. The script itself is a chimera of parts of `unpac` and Gummybear's quick fastq counting script with elements to make it work seemlessly across file formats.

### CountSeq.jl ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
A Julia implementation of `countseq` just to try it out. Tends to be more useful when fasta files are large or there are many fasta files that need to be counted. 

### countbam ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
Simple wrapper for `SAMtools` which counts the total number of reads and number of mapped reads in bam files.

### demultiplex_SE.pl ![alt_text](https://img.shields.io/badge/language-perl-yellow.svg)
Fork of Chris Hollenbeck's `demultiplex.pl` (perl wrapper for automating `process_RADtags` across several indices) that has an additional flag to handle single-end data for demultiplexing raw sequence reads. 

### FastaReadnames.jl ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
Simple julia wrapper to extract all the read names from within a fasta file (or multiple) into separate text files, or do a find-replace of readnames, such as replacing readnames "dDocent_contig_" with "Ginglymostoma_cirratum_contig_".

### dDuplicator ![alt_text](https://img.shields.io/badge/language-python3-green.svg)
A specialized (but editable!) python script that takes RAD sequences with UMI elements, checking for PCR duplicates, removing them, and outputting filtered sequences ready for `dDocent` input.

### lepmap2allmaps ![alt_text](https://img.shields.io/badge/language-python3-green.svg)
Takes `lepmap3` ordered marker linkage group files (using module `OrderMarkers2`) and converts them into `ALLMAPS` input format with the help of your contig name/positions courtesy of `vcftools` or a clever `grep` command. Can be used on either regular or sex-averaged maps.  

### punzip ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
Parallelized unzipping of .gz files from one directory into another. Can do an entire directory, or only files containing something specific in their name, such as `lobster`, `_R1_`, `britneyspears`, etc.

### ReverseComp ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
Takes  a file of one-per-line sequences and outputs the reverse, complement, or reverse-complement of each of those sequences. This script was used to quickly generate reverse-complements to sequencing barcodes for demultiplexing.

### seqstatplot ![alt_text](https://img.shields.io/badge/language-python3-green.svg)
Outputs an interactive [bokeh](https://bokeh.pydata.org/en/latest/) plot as an html for the sequencing run metrics we recieve as .csv from the facility that sequences our samples. *Specific to their file output format*.

### seqstatplotly ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
Julia implementation of `seqstatplot` using `PlotyJS`

### SplitChrom.jl ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
Takes input fasta file and splits reads into their own fasta files. Useful for splitting a genome file by chromosome. 

### unpac ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
Converts pacbio sequences from bam to fasta, concatenates them into a single fasta file, counts the number of sequences and base pairs in the concatenated fasta and prints it to a log file.
