 #! /usr/bin/env bash

if [[ -z "$1" ]]; then
  echo "Run a series of fastSTRUCTURE for a range of Kstart to Kmax values"
  echo "[usage] FastStructureK.sh infile Kstart Kmax"
  echo "  - the input file must end in .str"
  exit 1
fi
INRAW=$1
INFILE="${INRAW%.str}"
KSTART=$2
KVAL=$3
echo "#fastSTRUCTURE likelihoods for $INRAW" > ${INFILE}.fs.summary
echo -ne "k likelihood\n" >> ${INFILE}.fs.summary

export INRAW
export INFILE
export KSTART
export KVAL

fstruct(){
	echo "Running fastSTRUCTURE for K = $1"
	mkdir -p k$1
	python $(which structure.py) \
	-K $1 \
	--format=str \
	--input=$INFILE \
	--output=k$1/${INFILE}_out
	grep 'Marginal Likelihood =' k$1/${INFILE}_out.$1.log
	# add to summary file
	echo -ne "$1 " >> ${INFILE}.fs.summary
	grep 'Marginal Likelihood =' k$1/${INFILE}_out.$1.log | cut -d"=" -f2 >> ${INFILE}.fs.summary
}
export -f fstruct

parallel --jobs $(nproc) fstruct {1} ::: $(seq $KSTART $KVAL)
