#! /usr/bin/env bash
# Currently, not all of the jcvi modules have been fully ported to Python3

if [[ -z "$1" ]]; then
    echo -e "\nThis script will identify and split contigs at chimeric breakpoints using the jcvi commands outlined in https://github.com/tanghaibao/jcvi/wiki/ALLMAPS:-How-to-split-chimeric-contigs"
    echo -e "Requirements:\n  - jcvi installed into a python2 and python3 environments\n  - a .bed file of distances\n  - the genome assembly"
    echo -e "\n  [usage:] allmaps_split_chimera.sh genome.fasta bedfile.bed threshold    # default threshold=4"
    echo "  [example:] allmaps_split_chimera.sh g_cirratum.fasta distances.bed 4"
    exit
fi

GENO=$(basename $1)
BED=$(basename $2)

if [ ! -f "$GENO" ]; then
    echo "creating a symlink to $1 in current directory"
    ln -sr $1 .
fi

if [ ! -f "$BED" ]; then
    echo "creating a symlink to $2 in current directory"
    ln -sr $2 .
fi

if [[ -z "$3" ]]; then
    THRESH=4
else
    THRESH=$3
fi

FBASE=${GENO%%.fasta}

python -m jcvi.assembly.allmaps split $BED --chunk=$THRESH > breakpoints.bed
python -m jcvi.formats.fasta gaps $GENO
python2 -m jcvi.assembly.patch refine breakpoints.bed $FBASE.gaps.bed
python -m jcvi.formats.sizes agp $GENO
python -m jcvi.formats.agp mask $GENO.agp breakpoints.$FBASE.refined.bed --splitobject --splitsingle
python -m jcvi.formats.agp build $GENO.masked.agp $GENO.SPLIT.fasta
