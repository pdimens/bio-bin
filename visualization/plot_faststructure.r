#! /usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

library(ggplot2)
library(tidyr)
library(data.table)

setwd(getwd())

if (length(args) == 0 && length(list.files(pattern = "\\.str$")) == 0){
    cat("\nCreates data exploration plots from FastStructureK.sh results.")
    cat("\nAssumes the fastStructure input file (\"__.str\") is in the working dir. \nIf it's not, then supply its path/name as the only argument")
    cat("\n\n[usage] plot_faststructure.r   or    plot_faststructure.r ../data/somefile.str")
    q()
}

## pattern match to find output files from FaststructureK.sh
infiles <- list.files(pattern = "[2-9][0-9]?.meanQ")

## pull out basename to regenerate original structure filename

## load in all the q values
q_scores <- lapply(infiles,fread)

## load in fs file and pull out sample names from the first column
f_basename <- strsplit(infiles[1], "_out")[[1]][1]
if (length(args) == 0) {
    samp_names <- as.character(unlist(unique(fread(paste0(f_basename, ".str"))[,1])))
} else {
    samp_names <- as.character(unlist(unique(fread(args[1])[,1])))
}

## correct any hyphens in sample names to underscores
samp_names <- gsub("-", "_", samp_names)

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
    # add a names column
    q_scores[[i]]$sample <- samp_names
    # wide-to-long format & append
    tidy_data <- rbind(
        tidy_data,
        pivot_longer(q_scores[[i]], cols = !c(k, sample), names_to = "population")    
    ) 
}


# values for population annotations
## derive population names from sample names
popnames <- as.factor(
    unlist(
        lapply(strsplit(samp_names, "_"), function(x) {x[1]})
    )
)

## derive x values for v-lines for each population
poplines <- as.data.frame(summary(popnames))
colnames(poplines) <- "freq"

### make the values cumulative
for(i in 2:8){
    poplines$freq[i] <- poplines$freq[i] + poplines$freq[i-1]
}

### the x values for text will fall in the center between two lines
poptext <- c(0,poplines$freq)
for(i in 1:8){
        poptext[i] <- poptext[i] + (poptext[i+1] -  poptext[i])/2
}

#### trim off last value
poptext <- poptext[1:length(poptext)-1]
poplines <- head(poplines, -1)

popdata_df <- data.frame(
    xposition = poptext, 
    yposition = -0.2, 
    population = levels(popnames), 
    k = factor(max(as.numeric(levels(tidy_data$k)), levels(tidy_data$k)))
    )

p <- ggplot(tidy_data, aes_string(fill = "population", y = "value", x = "sample")) +
    ylab("Probability of Membership") +
    geom_bar(position = "fill", stat = "identity", width = 1) +
    geom_vline(xintercept = poplines$freq, size = 0.4, color = "#000000", linetype = "dashed") +
    coord_cartesian(ylim = c(0, 1), expand = FALSE, clip = "off") +
    labs(title = "fastStructure probabilities for values of K") +
    facet_wrap(~ k, ncol = 1,labeller = labeller(k = label_both), strip.position = "right") +
    geom_text(data = popdata_df, inherit.aes = FALSE, aes(x = xposition, y = yposition, label = population), show.legend = FALSE) +
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

plt_h <- length(q_scores) %% 3 * 5
pdf(file = paste0(f_basename, ".pdf"), 24, plt_h)
p
.x <- dev.off()

q()
