#! /usr/bin/env bash

echo "Renaming forward \"R1\" reads. "
for i in *_R1_*.gz; do
    NAME=$(echo $i | cut -d"_" -f1,2)
    mv $i $NAME.F.fq.gz
done
echo -n "Done!"

echo "Renaming reverse \"R2\" reads. "
for i in *_R2_*.gz; do
    NAME=$(echo $i | cut -d"_" -f1,2)
    mv $i $i.R.fq.gz
done
echo -n "Done!"
