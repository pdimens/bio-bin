#! /usr/bin/env julia

if length(ARGS)==0
  println("This julia script counts the # of reads and basepairs in fasta or fastq files")
  println(":: dependencies: BioSequences.jl, GZip.jl ::")
  println("\n","[usage] CountSeq <fasta/q file1> <fasta/q file2> <etc.>")
  exit()
end

using BioSequences
using GZip

function getcounts()
  for infile in ARGS
    if occursin(".fastq", lowercase(infile)) | occursin(".fq", lowercase(infile))
      if occursin(".gz", lowercase(infile))
        seqfile= FASTQ.Reader(GZip.open(infile,"r")) 
      else
        seqfile= FASTQ.Reader(open(infile,"r"))
      end
      filetype="fastq"
    elseif occursin(".fasta", lowercase(infile)) | occursin(".fa", lowercase(infile)) | occursin(".txt", lowercase(infile))
      if occursin(".gz", lowercase(infile))
        seqfile= FASTA.Reader(GZip.open(infile,"r"))
      else
        seqfile= FASTA.Reader(open(infile,"r"))
      end
      filetype="fasta"
    else
      println("file format not recognized, accepted formats are .fa .fasta .txt .fq .fastq and their gzipped counterparts")
    exit()
    end
    reads = 0
    bp = 0
    for record in seqfile
      reads += 1
      if filetype == "fasta"
        bp += length(BioSequences.FASTA.sequence(record))
      elseif filetype == "fastq"
        bp += length(BioSequences.FASTQ.sequence(record))
      end
    end
    println(infile, "\t", reads, "\t", bp)
    close(seqfile)
  end
end

println("filename", "\t", "#reads", "\t", "#basepairs")

getcounts()
