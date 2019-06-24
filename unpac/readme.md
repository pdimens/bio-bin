# unpac
#### unpacking pacbio sequences
This is a script written in `bash` meant to automate some basic processing of multi-cell PacBio sequences after they are downloaded from a sequencing facility. If you think of PacBio sequences as a package, then name is derived from `un`packing the `pac`bio reads, into either fast`a` or fast`q`. It was either that or `process_pacbio`, which isn't as fun.

## Usage
```sh
unpac -p <output.prefix> -d <working.directory> -m <mode>
```
An example of processing a species of fish
```sh
unpac -p swordfish -d ~/Data/swordfish_genome/ -m multi
```
### Usage arguments
| flag |  details |
|---|---|
-p <prefix>       | prefix output for ouput fil
-d <directory>    | path to working directory
-q                | indicates you want fastq output
 

## Dependencies
|Package|Used for|Installed by default?|Source|
|---|---|---|---|
|GNU Parallel | FASTA output | hit or miss | https://www.gnu.org/software/parallel/  |
|samtools   | FASTA output |typically not | http://www.htslib.org/   |
|bam2fastq | FASTQ output | no | https://github.com/PacificBiosciences/pbbioconda |

## Why would you use this?
If you had sequencing done of a single individual (or species) across several cells, each run is returned to you as a folder containing `.bam` files of your sequences (among other things). You may need these files in `.fasta` format for your pipeline, and multiple sequences combined into a single sequence file.

## What it does
1. Convert `.bam` files into `.fasta` files
  * It will by default do this only for `.subreads.bam` files
  * There is an optional flag to also process `.scraps.bam` files (which may take a while)
  * `GNU parallel` will automatically assign how many cores your system will use based on the number of `subreads.bam` files it finds
2. Concatenate all of the converted `.fasta` files into a single file
3. Count the number of sequences in the concatenated `.fasta`
4. Count the number of total base pairs in the concatenated `.fasta`
5. Create a textfile with those counts for your records
