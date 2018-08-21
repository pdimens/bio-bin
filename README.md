# Genomic toolbox

A place to store my custom and forked scripts used for genomic analysis

Currently, there are seven such scripts in here and the list slowly grows as things come up.

### bh_hardy.py
A python script that takes your raw `--hardy` output from `VCFtools` and performs a Benjamini-Hochberg correction on the data, outputting a file with the contigs that have >1 significant locus. This version requires no additional python packages (e.g. `numpy` or `pandas`)

### countseq
Counts the number of contigs/sequences in fasta or fastq files. The script itself is a chimera of parts of `unpac` and Gummybear's quick fastq counting script with elements to make it work seemlessly across file formats.

### demultiplex_SE.pl
A perl script forked from Chris Hollenbeck's `demultiplex.pl` (perl wrapper for automating `process_RADtags` across several indices) that has an additional flag to handle single-end data for demultiplexing raw sequence reads. 

### process_UMI
A specialized (but editable!) python script that takes RAD sequences with UMI elements, checking for PCR duplicates, removing them, and outputting filtered sequences. 

### punzip
Parallelized unzipping of .gz files from one directory into another. Can do an entire directory, or only files containing something specific in their name, such as `lobster`, `_R1_`, `britneyspears`, etc.

### reversecomp.jl
A simple script written in julia that takes a basic headerless `.csv` file of one-per-line sequences and outputs the reverse-complement of each of those sequences. This script was used to quickly generate reverse-complements to sequencing barcodes for demultiplexing.

### unpac
A bash script that converts pacbio sequences from bam to fasta, concatenates them into a single fasta file, counts the number of sequences and base pairs in the concatenated fasta and prints it to a log file.
