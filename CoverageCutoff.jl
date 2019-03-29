#! /usr/bin/env julia

if length(ARGS)==0
  println("This julia script will sort contig coverage generated from dDocent, and output")
  println("the names of contigs below a specified coverage threshold")
  println("\n","[usage] CoverageCutoff.jl <coverage file> <coverage threshold>")
  println("[example] CoverageCutoff.jl genome.file 500")
  println("\n", "input file format must be <contig> <-tab-> <number>")
  exit()
end

function IsolateBad()
  #infile = open(readlines,ARGS[1])
  infile = open(readlines,"BWA_coverage.txt")
  outfile = open("bad_contigs.txt","w")
  i=0
  for marker in infile
    if parse(Int64,split(marker, "\t")[2]) < parse(Int64,"500")
      write(outfile, split(marker, "\t")[1],"\n")
      i += 1
    end
  end
  close(outfile)
  println(i," markers below coverage of ",ARGS[2]," can be found in bad_contigs.txt")
end

IsolateBad()
