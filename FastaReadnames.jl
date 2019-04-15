#! /usr/bin/env julia

if length(ARGS)==0
    println("This julia script can pull out all the read names from fasta files")
    println("or it can do a find-replace of readnames")
    println("\n","[usage1] FastaReadnames.jl <fasta file(s)>      # to pull out all readnames")
    println("[usage2] FastaReadnames.jl rename <fasta file> <find.this> <replace.with.this>")
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
        println("Find your read names in readnames_from_", ARGS[1])
      end
    end
    outputnames()

elseif ARGS[1]=="rename"
    function alter_readnames()
        inputfasta = FASTA.Reader(open(ARGS[2],"r"))
        outfile = FASTA.Writer(open(split(ARGS[2],".")[1] * ".renamed.fasta", "w"))
        println("replacing ",ARGS[3]," with ",ARGS[4], " in ", ARGS[2])
        for eachread in inputfasta
            readname = BioSequences.FASTA.identifier(eachread)
            new_read = BioSequences.FASTA.Record(replace(readname,ARGS[3] => ARGS[4]),BioSequences.FASTA.sequence(eachread))
            write(outfile,new_read)
        end
        close(inputfasta)
        close(outfile)
        println("Your read-renamed fasta file is named ", split(ARGS[2],".")[1] * ".renamed.fasta")
    end

    alter_readnames()

else
    println("incorrect usage, try again using this format:")
    println("\n","[usage1] FastaReadnames.jl <fasta file(s)>      # to pull out all readnames")
    println("[usage2] FastaReadnames.jl rename <fasta file> <find.this> <replace.with.this>")
    exit()

end
