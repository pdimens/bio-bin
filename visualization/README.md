# Vizualization scripts
These are used to make exploratory/nice plots for specific use cases.

### plot_admixture.r ![R logo](https://img.shields.io/badge/R-blueviolet.svg?logo=R)
Makes nice stacked barplots as common from the Structure software for raw ADMIXTURE results.

### plot_faststructure.r ![R logo](https://img.shields.io/badge/R-blueviolet.svg?logo=R)
Makes nice stacked barplots as common from the Structure software for raw fastStructure results. This takes
input directly from `FastStructureK.sh` where you run it for multiple K's. Returns a decent faceted plot showing
the different outcomes over the range of K's you did.

### plot_structure_popinfo.r ![R logo](https://img.shields.io/badge/R-blueviolet.svg?logo=R)
Makes nice stacked barplots as common from the Structure software for raw Structure results.

### plot_structure.r ![R logo](https://img.shields.io/badge/R-blueviolet.svg?logo=R)
Makes nice stacked barplots as common from the Structure software for raw Structure results.

### seqstatplot ![Python logo](https://img.shields.io/badge/python-green.svg?logo=python&logoColor=white)
Outputs an interactive [bokeh](https://bokeh.pydata.org/en/latest/) plot as an html for the sequencing run metrics we recieve as .csv from the facility that sequences our samples. *Specific to their file output format*.

### seqstatplotly ![Julia logo](https://img.shields.io/badge/julia-blue.svg?logo=julia&logoColor=white)
Julia implementation of `seqstatplot` using `PlotyJS`