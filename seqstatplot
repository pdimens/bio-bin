#!/usr/bin/env python3

"""
Created on Fri Oct 19 12:06:05 2018

@author: pdimens
"""
import sys

if len(sys.argv) != 2:
    def usage():
        print("\n", "This py3 script uses pandas and bokeh to create an interactive plot of the sequencing information from U-Colorado")
        print("[usage] seqstatplot <name of .csv file>", "\n")
    usage()
else:
    import os
    import pandas as pd
    from bokeh.plotting import figure, ColumnDataSource
    from bokeh.models import HoverTool
    from bokeh.io import save, output_file

    def seqstatplot():

        seqfile = sys.argv[1]
        df = pd.read_csv(seqfile, sep=",", header=None, names=["lane", "project", "sampid", "barcode", "reads", "percent of lane",
                                                               "percent perfect barcode", "percent one mismatch", "yields", "percent PF clusters", "pq30", "mqscore"], skiprows=7)
        fixedreads = []
        for i in range(len(df.reads)):
            fixedreads.append(df.reads[i].replace(",", ""))
        output_file("seqstats.html")

        sourcedata = ColumnDataSource(data={
            'sampid': df.sampid,
            'reads': fixedreads,
            'yields': df.yields,
            'mean quality': df.mqscore,
            'pq30': df.pq30
        })

        TOOLTIPS = [
            ("Sample Name", "@sampid"),
            ("Number of Reads", "@reads"),
            ("Yield", "@{yields}mb"),
            ("Mean Quality Score", "@{mean quality}"),
            ("> Q30", "@pq30%"),
        ]

        p = figure(x_range=df.sampid, sizing_mode='stretch_both',
                   title="Raw Sequences Stats", toolbar_location=None)
        p.vbar(x='sampid', top='reads', source=sourcedata, width=0.8, color='#0099cc',
               hover_fill_color='#ff7f50', hover_line_color='#ff7f50')

        p.min_border = 50
        p.xgrid.grid_line_color = None
        p.background_fill_color = "#f5f5f5"
        p.y_range.start = 0
        p.axis.axis_line_color = None
        p.yaxis.axis_label = 'Number of Reads'
        p.xaxis.visible = False
        p.axis.minor_tick_line_color = None
        p.add_tools(HoverTool(tooltips=TOOLTIPS, mode='vline'))
        save(filename='seqstatplot.html', title=os.path.splitext(sys.argv[1])[0], obj=p)
    seqstatplot()
    print("\n", "you can find your plot in seqstatplot.html", "\n")
