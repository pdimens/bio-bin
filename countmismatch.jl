#! /usr/bin/env julia

using DataFrames, PlotlyJS, CSV ;

function countmis2(infile)
    indexfile = open(readlines,infile)
    mismatchArray =  []
    mismatchNames = Symbol.(indexfile)
    for each in indexfile 
        tempcol = Array{Int64,1}()
        for other in indexfile
            push!(tempcol, 
                  count(split(each,"") .!= split(other,""))
                  )
        end
        push!(mismatchArray, tempcol)
    end
    df = DataFrame(mismatchArray, mismatchNames)
    insertcols!(df, 1, :index => indexfile)
    CSV.write("MismatchArray.txt", df)
    layout = Layout(title = "Mismatches",
                    margin = attr(l=100,
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
                #reversescale = true
                ),
            layout
            )
    PlotlyJS.savehtml(
                p,
                split(ARGS[1], ".")[1]*".mismatch.html",
                :embed
        )
end
countmis2(ARGS[1])