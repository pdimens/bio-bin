#! /usr/bin/env julia

if length(ARGS)==0
  print("This julia script will pull out all the read names from a fasta file",
  "\n", "and output them into readnames_from_<filename>","\n",
  "[usage] fasta_readnames <fasta file>")
exit()
end
using BioSequences

function outputnames()
    for eachfile in ARGS
  inputfasta = FASTA.Reader(open(eachfile,"r"))
  outfile = open("readnames_from_" * basename(eachfile),"w")
  for eachread in inputfasta
    write(outfile, BioSequences.FASTA.identifier(eachread),"\n")
end
  close(inputfasta)
  close(outfile)
end
end
outputnames()


#= future search functionality
function alter_readnames()
inputfasta = FASTA.Reader(open(ARGS[1],"r"))
outfile = FASTA.Writer(open(basename(ARGS[1]) * "_renamed", "w"))
  for eachread in inputfasta
    readname = BioSequences.FASTA.identifier(eachread)
    new_readname = replace(readname,ARGS[2] => ARGS[3])
    write(outfile, FASTA.Record(new_readname,eachread.sequence),"\n")
end
  close(inputfasta)
  close(outfile)
end
=#
