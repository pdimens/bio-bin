#! /usr/bin/env bash

echo -n "Renaming forward \"R1\" reads. "
for i in *_R1_*.gz; do
    NAME=$(echo $i | cut -d"_" -f1,2)
    mv $i $NAME.F.fq.gz
done
echo "Done!"

echo -n "Renaming reverse \"R2\" reads. "
for i in *_R2_*.gz; do
    NAME=$(echo $i | cut -d"_" -f1,2)
    mv $i $NAME.R.fq.gz
done
echo "Done!"
