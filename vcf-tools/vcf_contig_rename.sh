#! /usr/bin/env bash

usage() {
cat <<EOF

This script wraps AWK commands to prepend text to your contig names, or find-&-replace text in the contig names.
Output is piped to STDOUT

[replace]:	vcf_contig_rename.sh -m replace -i <infile.name> -f <find word> -r <replace word>
[example]: 	vcf_contig_rename.sh -m replace -i murder_hornet.vcf -f chrom -r chr > murder_hornet.renamed.vcf

[prepend]:	vcf_contig_rename.sh -m prepend -i <infile.name> -t <text>
[example]: 	vcf_contig_rename.sh -m prepend -i murder_hornet.vcf  -t murder_ > murder_hornet.renamed.vcf
EOF
}

if [[ -z "$1" ]]; then
  usage
  exit 1
fi

while getopts ":m:i:f:r:t:" opt; do
  case $opt in
    m)
      METHOD=$OPTARG
      if [[ "$METHOD" != 'prepend' ]] && [[ "$METHOD" != 'replace' ]]; then
        echo -e "\n\t :::Please specify either prepend or replace:::"
        usage
        exit 1
      fi
      ;;
    i)
      IN=$OPTARG
      ;;
    f)
      FIND=$OPTARG
      ;;
    r)
      REPLACE=$OPTARG
      ;;
    t)
      TEXT=$OPTARG
      ;;
	\?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      exit 1
      ;;
    :)
      echo "-$OPTARG requires an argument." >&2
      usage
      exit 1
      ;;
  esac
done


if [ "$METHOD" == 'replace' ] ; then
    awk '{gsub(/"$FIND"/,"$REPLACE"); print}' $IN
else
    awk '{if($0 !~ /^#/) print $TEXT$0; else print $0}' $IN
fi
