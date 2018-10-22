#! /usr/bin/env julia
using Blink
using PlotlyJS
using CSV
using ORCA
using DataFrames
infile = CSV.read(
                  "/home/pdimens/Downloads/queentrigger_2_illumina.csv",
                  delim = ",",
                  datarow=8,
                  header=[
                          "lane",
                          "project",
                          "sample",
                          "barcode",
                          "reads",
                          "percent of lane",
                          "percent perfect barcode",
                          "percent one mismatch",
                          "yield",
                          "percent PF clusters",
                          "pq30",
                          "mqscore"
                          ]
                  )
function statplots()
    trace1 = bar(
                x=infile.sample,
                y=infile.reads,
                name = "Number of reads",
                text = infile.sample
                )
    trace2 = bar(
                x=infile.sample,
                y=infile.yield,
                name = "Yield (mbases)"
                )
    trace3 = bar(
                x=infile.sample,
                y=infile.pq30,
                name = "% > Q30"
                )
    trace4 = bar(
                x=infile.sample,
                y=infile.mqscore,
                name = "Mean Quality Score"
                )

    layout = Layout(
                   barmode = "stack",
                   bargap = 0.1,
                   font_size = 10,
                   margin = attr(l=100, r=50, b=50, t=50, pad=10)
                   )

    plot([trace1,trace2,trace3,trace4], layout)
end
# statplots()
PlotlyJS.savehtml(
                 statplots(),
                 "/home/pdimens/Documents/seqstats.html",
                 :embed
                 )
