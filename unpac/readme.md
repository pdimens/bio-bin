# unpac
#### unpacking pacbio sequences
This is a script written in `bash` meant to automate some basic processing of multi-cell PacBio sequences after they are downloaded from a sequencing facility. If you think of PacBio sequences as a package, then name is derived from `un`packing the `pac`bio reads, into either fast`a` or fast`q`. It was either that or `process_pacbio`, which isn't as fun.

## What it does
Convert `.bam` files into a concatenated `.fasta` file or a `fastq` file

## Usage
```bash
unpaq -p <output.prefix> -d <working.directory> -m <mode>
```
An example of processing a species of fish to produce fasta output
```bash
unpaq -q swordfish -d ~/Data/swordfish_genome/ 
```
### Usage arguments
| flag |  details |
|---|---|
-p <prefix>       | prefix output for ouput file
-d <directory>    | path to working directory
-q                | indicates you want fastq output (optional)
 

## Dependencies
|Package|Used for|Installed by default?|Source|
|---|---|---|---|
|GNU Parallel | FASTA output | hit or miss | https://www.gnu.org/software/parallel/  |
|samtools   | FASTA output |typically not | http://www.htslib.org/   |
|bam2fastq | FASTQ output | no | https://github.com/PacificBiosciences/pbbioconda |

## Why would you use this?
If you had sequencing done of a single individual (or species) across several cells, each run is returned to you as a folder containing `.bam` files of your sequences (among other things). You may need these files in `.fasta` or fastq format for your pipeline, and multiple sequences combined into a single sequence file. 
##### Why use this instead of bam2fastx directly? 
This script makes it a little easier to add multiple files across different folders at once. 



