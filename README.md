# Genomic toolbox

A place to store my custom and forked scripts used for genomic analysis- a list slowly growing as things come up.

### bh_hardy.py ![alt_text](https://img.shields.io/badge/language-python3-green.svg)
A python script that takes your raw `--hardy` output from `VCFtools` and performs a Benjamini-Hochberg correction on the data, outputting a file with the contigs that have >1 significant locus. This version requires only base python packages (e.g. no `numpy` or `pandas`)

### configure_blasr_install ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
It took me forever to get blasr/sparc installed and running correctly for hybrid genome assemblies, and after finally getting it to work, I vowed to never **ever** have to deal with it again, so this scipt does the necessary tweaks to get sparc_split_and_run.sh working right, *and* from your `$PATH`

### countseq ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
Counts the number of contigs/sequences in fasta or fastq files. The script itself is a chimera of parts of `unpac` and Gummybear's quick fastq counting script with elements to make it work seemlessly across file formats.

### countbam ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
Simple wrapper for `SAMtools` which counts the total number of reads and number of mapped reads in bam files.

### demultiplex_SE.pl ![alt_text](https://img.shields.io/badge/language-perl-yellow.svg)
A perl script forked from Chris Hollenbeck's `demultiplex.pl` (perl wrapper for automating `process_RADtags` across several indices) that has an additional flag to handle single-end data for demultiplexing raw sequence reads. 

### process_UMI ![alt_text](https://img.shields.io/badge/language-python3-green.svg)
A specialized (but editable!) python script that takes RAD sequences with UMI elements, checking for PCR duplicates, removing them, and outputting filtered sequences. 

### punzip ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
Parallelized unzipping of .gz files from one directory into another. Can do an entire directory, or only files containing something specific in their name, such as `lobster`, `_R1_`, `britneyspears`, etc.

### reversecomp ![alt_text](https://img.shields.io/badge/language-julia-blue.svg)
A simple script written in julia (because julia is awesome) that takes  a file of one-per-line sequences and outputs the reverse, complement, or reverse-complement of each of those sequences. This script was used to quickly generate reverse-complements to sequencing barcodes for demultiplexing.

### seqstatplot ![alt_text](https://img.shields.io/badge/language-python3-green.svg)
A convenience script that outputs an interactive [bokeh](https://bokeh.pydata.org/en/latest/) plot as an html for the sequencing run metrics we recieve as .csv from the facility that sequences our samples. *Specific to their file output format*.

### unpac ![alt_text](https://img.shields.io/badge/language-bash-lightgrey.svg)
A bash script that converts pacbio sequences from bam to fasta, concatenates them into a single fasta file, counts the number of sequences and base pairs in the concatenated fasta and prints it to a log file.
