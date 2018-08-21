#! /usr/bin/env julia

using CSV, BioSequences
if length(ARGS) < 1
    print("This julia script takes a simple headerless csv file of sequences and outputs \n a file of the reverse complements of those sequences")
    print("\n [usage] reversecomp.jl <indexfile.csv>")
else
indexes= CSV.read(ARGS[1], header=false)

indlist = indexes[1]
altered=[]
newlist=[]
for i in indlist
    altered=join(reverse_complement(DNASequence(i)))
    push!(newlist,altered)
end

writecsv("reverse_complement.csv",newlist)
print("Your sequences are located in the file reverse_complement.csv")
end

#= THE OLD MANUAL METHOD
indlist = indexes[1]
tempsplit=[]
tempjoin=[]
newlist=[]
for i in indlist
    tempsplit=split(i,"")
    for k in 1:length(tempsplit)
        if tempsplit[k] == "A"
            tempsplit[k]="T"
        elseif tempsplit[k] == "T"
            tempsplit[k]="A"
        elseif tempsplit[k] == "C"
            tempsplit[k]= "G"
        else
            tempsplit[k]= "C"
        end
        tempjoin=prod(tempsplit)
    end
    push!(newlist,tempjoin)
end

revcomplist=[]
for i in 1:length(revcomplist)
    push!(revcomplist,reverse(newlist[i]))
end
writecsv("revcomp_indexes.csv",revcomplist)
=#
