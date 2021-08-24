#! /usr/bin/env julia

if length(ARGS)==0
  println("This julia script will take a fasta file input and output a separate fasta file for each read")
  println("Typically used for splitting a scaffolded genome by chromosome after mapping/contig anchoring")
  println("\n","[usage] SplitChrom.jl <fasta file>")
  println("[example] SplitChrom.jl eggplant.fasta")
  exit()
end

using BioSequences

inputfasta = FASTA.Reader(open(ARGS[1],"r"))
function SplitChrs()
    i = 1
    for eachread in inputfasta
        outfile = FASTA.Writer(open(split(ARGS[1], ".")[1] * ".chr" * string(i) * ".fasta", "w"))
        write(outfile,eachread)
        close(outfile)
        i += 1
    end
end

SplitChrs()
