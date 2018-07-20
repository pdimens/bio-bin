# Genomic toolbox

A place to store my custom and forked scripts used for genomic analysis

Currently, there are only five such scripts in here, but the list slowly grows as things come up.

### bh_hardy.py
A python script that takes your raw `--hardy` output from `VCFtools` and performs a Benjamini-Hochberg correction on the data, outputting a file with the contigs that have >1 significant locus. This version requires no additional python packages (e.g. `numpy` or `pandas`)

### countseq
The section of `unpac` that counts the number of sequences and base pairs in a fasta file merged with Gummybear's quick fastq counting script to now take either (user specified) fasta or fastq format files. (needs to be parallelized)

### demultiplex_SE.pl
A perl script forked from Chris Hollenbeck's `demultiplex.pl` (perl wrapper for automating `process_RADtags` across several indices) that has an additional flag to handle single-end data for demultiplexing raw sequence reads. 

### process_UMI
A specialized (but editable!) python script that takes RAD sequences with UMI elements, checking for PCR duplicates, removing them, and outputting filtered sequences. 

### punzip
Parallelized unzipping of .gz files from one directory into another. Can do an entire directory, or only files containing something specific in their name, such as `lobster`, `_R1_`, `britneyspears`, etc.

### unpac
A bash script that converts pacbio sequences from bam to fasta, concatenates them into a single fasta file, counts the number of sequences and base pairs in the concatenated fasta and prints it to a log file.
