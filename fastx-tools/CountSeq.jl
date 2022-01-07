#! /usr/bin/env julia

if length(ARGS)==0
  println("This julia script counts the # of reads and basepairs in fasta or fastq files")
  println(":: dependencies: BioSequences.jl, GZip.jl ::")
  println("\n","[usage] CountSeq <fasta/q file1> <fasta/q file2> <etc.>")
  println("\n \n", "for multithreading, set \"export JULIA_NUM_THREADS= \" in your shell before running")
  exit()
end

using BioSequences, GZip, Base.Threads

function getcountsfq(fastx::String)
  if occursin(".gz", lowercase(fastx))
    seqfile= FASTQ.Reader(GZip.open(fastx,"r"))
  else
    seqfile= FASTQ.Reader(open(fastx,"r"))
  end
  reads = 0
  bp = 0
  for record in seqfile
    reads += 1
    bp += length(BioSequences.FASTQ.sequence(record))
  end
    println(fastx, "\t", reads, "\t", bp)
    close(seqfile)
end

function getcountsfa(fastx::String)
  if occursin(".gz", lowercase(fastx))
    seqfile= FASTA.Reader(GZip.open(fastx,"r"))
  else
    seqfile= FASTA.Reader(open(fastx,"r"))
  end
  reads = 0
  bp = 0
  for record in seqfile
    reads += 1
    bp += length(BioSequences.FASTA.sequence(record))
  end
  println(fastx, "\t", reads, "\t", bp)
  close(seqfile)
end

println("filename", "\t", "#reads", "\t", "#basepairs")

function runcounts(infiles::Array{String,1})
  @threads for infile in infiles
    if occursin(".fastq", lowercase(infile)) | occursin(".fq", lowercase(infile))
      getcountsfq(infile)
    elseif occursin(".fasta", lowercase(infile)) | occursin(".fa", lowercase(infile)) | occursin(".txt", lowercase(infile))
      getcountsfa(infile)
    else
        println("$infile format incorrect, must be .fa .fasta .txt .fq .fastq or gzipped versions")
        continue
    end
  end
end
runcounts(ARGS)
