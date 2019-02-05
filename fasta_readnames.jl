#! /usr/bin/env julia

if length(ARGS)==0
  print("This julia script can pull out all the read names from fasta files",
        "\n", "or it can do a find-replace of readnames", "\n","\n",
  "[usage1] fasta_readnames <fasta file(s)>      # to pull out all readnames","\n",
  "[usage2] fasta_readnames rename <fasta file> <find.this> <replace.with.this>")
exit()
end

using BioSequences

if ARGS[1]!="rename"
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
  print("Your readnames file(s) are prefixed with readnames_from_")

  elseif ARGS[1]=="rename"
  function alter_readnames()
    inputfasta = FASTA.Reader(open(ARGS[2],"r"))
    outfile = FASTA.Writer(open(ARGS[2] * "_renamed", "w"))
    for eachread in inputfasta
      readname = BioSequences.FASTA.identifier(eachread)
      new_read = BioSequences.FASTA.Record(replace(readname,ARGS[3] => ARGS[4]),BioSequences.FASTA.sequence(eachread))
      write(outfile,new_read)
    end
    close(inputfasta)
    close(outfile)
  end

  alter_readnames()
  print("Your read-renamed fasta file is named ", ARGS[2] * "_renamed")
end
