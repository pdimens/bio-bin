# Tools for FASTA/Q manipulation

### countasm ![alt_text](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Counts the number of sequences, number of `A` `T` `C` `G` bases, and `N`/`-`/`.` bases in a fasta file, typically a genome assembly. The base-counting is not case-sensitive, i.e. `a`=`A`, `t`=`T`, etc.

### countseq ![alt_text](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Counts the number of contigs/sequences in fasta or fastq files. Parallelized for when counting multiple files!

### CountSeq.jl ![alt_text](https://img.shields.io/badge/julia-blue.svg?logo=julia&logoColor=white)
A Julia implementation of `countseq` just to try it out. Tends to be more useful when fasta files are large or there are many fasta files that need to be counted. Slower than the GNU version otherwise.

### ddocent_rename.sh ![alt_text](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
A simple way to batch-rename files to be dDocent compliant. Some _light_ modification may be needed depending on the naming scheme of your sequencing facility.

### dDuplicator ![alt_text](https://img.shields.io/badge/python-green.svg?logo=python&logoColor=white)
A specialized (but editable!) python script that takes RAD sequences with UMI elements, checking for PCR duplicates, removing them, and outputting filtered reads.

### demultiplex_SE.pl ![alt_text](https://img.shields.io/badge/perl-yellow.svg?logo=perl&logoColor=white) (not maintained)
Fork of Chris Hollenbeck's `demultiplex.pl` (perl wrapper for automating `process_RADtags` across several indices) that has an additional flag to handle single-end data for demultiplexing raw sequence reads. 

### extract_barcodes.sh ![alt_text](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Creates a `process_radtags` compliant `barcodes.txt` file from fastq/fasta files by extracting the barcode from the end of the first read's header. 
It assumes your reads have the barcode at the end (not always the case) and that the barcode is 6bp long. 

### fastaprefix ![alt_text](https://img.shields.io/badge/bash-lightgrey.svg?logo=gnu%20bash&logoColor=white)
Renames all contigs in a fasta file into a consistent sequential naming convention based on a prefix, like "Gbiloba_1".

### FastaReadnames.jl ![alt_text](https://img.shields.io/badge/julia-blue.svg?logo=julia&logoColor=white)
Simple julia wrapper to extract all the read names from within a fasta file (or multiple) into separate text files, or do a find-replace of readnames, such as replacing readnames "dDocent_contig_" with "Ginglymostoma_cirratum_contig_".

### SplitChrom.jl ![alt_text](https://img.shields.io/badge/julia-blue.svg?logo=julia&logoColor=white)
Takes input fasta file and splits reads into their own fasta files. Useful for splitting a genome file by chromosome. 
