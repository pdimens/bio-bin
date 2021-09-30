 #! /usr/bin/env bash

if [[ -z "$1" ]]; then
  echo "Run a series of fastSTRUCTURE for a range of 1 to K values"
  echo "[usage] FastStructureK.sh infile Kmax"
  echo "- the input file must end in .str"
  exit 1
fi
INRAW=$1
INFILE="${INRAW%.str}"
OUTBASE=$(basename $INFILE)
KVAL=$2
echo "#fastSTRUCTURE likelihoods for $INRAW" > ${OUTBASE}.fs.summary
echo -ne "k likelihood\n" >> ${OUTBASE}.fs.summary

export INRAW
export INFILE
export OUTBASE
export KVAL

fstruct(){
	echo "Running fastSTRUCTURE for K = $1"
	echo "Output file: ${OUTBASE}"
	python $(which structure.py) \
	-K $1 \
	--format=str \
	--input=$INFILE \
	--output=${OUTBASE} \
	--cv=30
	grep 'Marginal Likelihood =' ${OUTBASE}.$1.log
}
export -f fstruct

parallel --jobs $(nproc) fstruct {1} ::: $(seq 1 $KVAL)

# add to summary file
for K in $(seq 1 $KVAL) ; do
	echo -ne $K >> ${OUTBASE}.fs.summary
	grep 'Marginal Likelihood =' ${OUTBASE}.$K.log | cut -d"=" -f2 >> ${OUTBASE}.fs.summary
done
