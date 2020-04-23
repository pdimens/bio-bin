#! /usr/bin/env julia

using PlotlyJS, CSV ;

function pairwise(x::String, y::String = x, op = ==)
    broadcast(op, Iterators.Stateful(x), Iterators.Stateful(y))
end

function pairwise(x::Array{String,1}, y::Array{String,1} = x, op = ==)
    sum.(pairwise.(x, permutedims(y), op))
end

function countmatch(infile)
    indexfile = open(readlines,infile)
    mismatchArray = pairwise(indexfile)
    outfile_array = vcat(permutedims(["string";indexfile]), hcat(indexfile,mismatchArray))
    CSV.write("PairwiseMatch.txt", outfile_array)
    layout = Layout(
                title = "Matches",
                margin = attr(
                            l=100,
                            r=100,
                            b=100,
                            t=100,
                            pad=0
                    )
            )
    p = plot(
            heatmap(
                x = indexfile,
                y = indexfile,
                z=mismatchArray,
                colorscale = :YlGnBu,
                reversescale = true
                ),
            layout
        )
    PlotlyJS.savehtml(
        p,
        split(ARGS[1], ".")[1]*".PairwiseMatch.html",
        :embed
    )
end
countmatch(ARGS[1])
