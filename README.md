# Genomics Repository

A place to store my custom and forked scripts used for genomic analysis

Currently, there are only two such scripts in here:

### bh_hardy.py
A python script that takes your raw `--hardy` output from `VCFtools` and performs a Benjamini-Hochberg correction on the data, outputting a file with the contigs that have >1 significant locus. This version requires no additional python packages (e.g. `numpy` or `pandas`)

### demultiplex_SE.pl
A perl script forked from Chris Hollenbeck's `demultiplex.pl` (perl wrapper for automating `process_RADtags` across several indices) that has an additional flag to handle single-end data for demultiplexing raw sequence reads. 
