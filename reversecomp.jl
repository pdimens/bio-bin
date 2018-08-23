#! /usr/bin/env julia

if length(ARGS) != 1
    print("This julia script takes a simple file of one-per-line sequences and outputs \na file of the reverse complements of those sequences \n \n[usage] reversecomp.jl <indexfile>")
else
    using BioSequences
    x=ARGS[1]
    function revcomp(x)
        sequences= open(readlines,x)
        outfile=open("reverse_complement.txt","w")
        for i in sequences
            write(outfile,join(reverse_complement(DNASequence(i))),"\n")
        end
        print("Your sequences are located in the file reverse_complement.txt")
    end ;
    revcomp(x)
end
