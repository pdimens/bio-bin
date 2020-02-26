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
for i in $(seq 1 $KVAL);
do
  echo "Running fastSTRUCTURE for K = $i"
  structure.py \
    -K $i \
    --format=str \
    --input=$INFILE \
    --output=${INFILE}_out
  echo -e "\nK = $i :\t" >> fastStructure.summary
  grep 'Marginal Likelihood =' ${INFILE}_out.$i.log >> ${INFILE}.fs.summary
done
