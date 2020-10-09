 #! /usr/bin/env bash

if [[ -z "$1" ]]; then
  echo "Run a series of fastSTRUCTURE for a range of 1 to K values"
  echo "[usage] FastStructureK.sh infile Kmax"
  echo "- the input file must end in .str"
  exit 1
fi
INRAW=$1
INFILE="${INRAW%.str}" 
KVAL=$2
echo "#fastSTRUCTURE likelihoods for $INRAW" > ${INFILE}.fs.summary
echo -ne "k likelihood\n" >> ${INFILE}.fs.summary

export INRAW
export INFILE
export KVAL

fstruct(){
	echo "Running fastSTRUCTURE for K = $1"
	structure.py \
	-K $1 \
	--format=str \
	--input=$INFILE \
	--output=${INFILE}_out
	grep 'Marginal Likelihood =' ${INFILE}_out.$1.log
}
export -f fstruct

parallel --jobs $(nproc) fstruct {1} ::: $(seq 1 $KVAL)

# add to summary file
for K in $(seq 1 $KVAL) ; do
	echo -ne $K >> ${INFILE}.fs.summary
	grep 'Marginal Likelihood =' ${INFILE}_out.$K.log | cut -d"=" -f2 >> ${INFILE}.fs.summary
done
