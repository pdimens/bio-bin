#! /usr/bin/env julia

if length(ARGS)==0
    println("This julia script renames FASTA squences sequentially with a given prefix")
    println("i.e. \n>prefix_1\nAATTA\n>prefix_2\nCCATA\n>prefix_3\netc.")
    println("\n","[usage1] FastaSequentialID.jl <fasta file> <prefix>")
    exit()
end

using FASTX, BioSequences

function renameheaders()
    reader = open(FASTA.Reader, ARGS[1])
    writer = open(FASTA.Writer, ARGS[2] * ".renamed.fasta")
    i = 1
    for record in reader
        newrec = FASTA.Record(ARGS[2] * "_" * "$i", FASTA.sequence(record))
        write(writer, newrec)
        i += 1
    end

    close(reader)
    close(writer)
end

renameheaders()
