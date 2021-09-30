#! /usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

library(ggplot2)
library(tidyr)
library(data.table)

setwd(getwd())

if (length(args) == 0 && length(list.files(pattern = "\\.str$")) == 0){
    cat("\nCreates data exploration plots from FastStructureK.sh results.")
    cat("\nAssumes the fastStructure input file (\"__.str\") is in the working dir. \nIf it's not, then supply its path/name as the only argument")
    cat("\n\n[usage] FastStructurePlot.r   or    FastStructurePlot.r ../data/somefile.str")
    q()
}

## pattern match to find output files from FaststructureK.sh
infiles <- list.files(pattern = "[2-9][0-9]?.meanQ")

## pull out basename to regenerate original structure filename

## load in all the q values
q_scores <- lapply(infiles,fread)

## load in fs file and pull out sample names from the first column
f_basename <- strsplit(infiles[1], "\\.") |> unlist()
f_basename <- paste(f_basename[1:(length(f_basename) - 2)], collapse = ".")
f_outbase <- basename(f_basename)
if (length(args) == 0) {
    samp_names <- samp_names <- fread(paste0(f_basename, ".str"))[,1:2] |> unique()
} else {
    samp_names <- fread(args[1])[,1:2] |> unique()
}


## correct any hyphens in sample names to underscores
pop_names <- samp_names$V2
samp_names <- gsub("-", "_", samp_names$V1)


## instantiate empty DF to be our awesome long-format table
tidy_data <- data.frame(
    matrix(vector(), 0, 4,
    dimnames=list(c(), c("k", "sample", "population", "value"))),
    stringsAsFactors=TRUE
)

for (i in 1:length(q_scores)){
    # drop the "V" in the columns names
    colnames(q_scores[[i]]) <- gsub("^[V]", "", colnames(q_scores[[i]]))
    # add a K column
    q_scores[[i]]$k <- as.factor(length(colnames(q_scores[[i]])))
    # add sample/population names column
    q_scores[[i]]$sample <- samp_names
    q_scores[[i]]$origin_population <- pop_names
    # wide-to-long format & append
    tidy_data <- rbind(
        tidy_data,
        pivot_longer(q_scores[[i]], cols = !c(k, sample, origin_population), names_to = "population")    
    ) 
}
pdf(NULL)
.colors <- RColorBrewer::brewer.pal(n=8, "Set2")
ggplot(tidy_data, aes_string(fill = "population", y = "value", x = "sample")) +
    ylab("Probability of Membership") +
    geom_bar(position = "fill", stat = "identity", width = 1) +
    coord_cartesian(ylim = c(0, 1), expand = FALSE, clip = "off") +
    labs(title = "fastStructure probabilities for values of K") +
    facet_grid(k~origin_population, scales = "free_x", space = "free_x", labeller = label_both) +
    scale_fill_manual(values = .colors) +
    theme(
        axis.title = element_text(size=12),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        strip.text = element_text(size = 14),
        panel.grid.major = element_blank(),
        panel.background = element_blank(),
        panel.grid.minor = element_blank(),
        panel.spacing.y = unit(1.5, "lines"),
        plot.margin = unit(c(5.5, 5.5, 30, 5.5), "pt")
    )


ggsave(paste0(f_outbase, ".png"), height = 7, width = 14, units = "in")
#p
#.x <- dev.off()

q()
