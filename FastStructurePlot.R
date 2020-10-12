args <- commandArgs(trailingOnly = TRUE)

library(ggplot2)
library(tidyr)
library(gridExtra)
library(data.table)
setwd(getwd())

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

# add names column to each
for (i in 1:length(q_scores)){
    q_scores[i][[1]]$sample = samp_names
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

# stack each into long format
for (i in 1:length(q_scores)){
    q_scores[i][[1]] <- pivot_longer(q_scores[i][[1]], cols = !(dim(q_scores[i][[1]])[2]))
    colnames(q_scores[i][[1]]) <- c("sample", "population", "probability")
    tmp <- strsplit(q_scores[i][[1]]$population, "V")
    q_scores[i][[1]]$population <- as.factor(sapply(tmp, function(x){x[2]}))
}

plots <- list()
for (i in 1:length(q_scores)) {
   str_plot <- ggplot(q_scores[i][[1]], aes_string(fill = "population", y = "probability", x = "sample")) +
            ylab("Probability of Membership") + 
            geom_bar(position = "fill", stat = "identity", width = 1.0) +
            geom_vline(xintercept = poplines$freq, size = 0.4, color = "#000000") +
            coord_cartesian(ylim = c(0, 1), expand = FALSE, clip = "off") +
            annotate("text", x = poptext, y = 0.1, label = levels(popnames)) +
            theme(
                axis.title = element_text(size=14),
                axis.title.x = element_blank(),
                axis.text.x = element_blank(),
                axis.ticks.x = element_blank(),
                panel.grid.major = element_blank(),
                panel.background = element_blank(),
                panel.grid.minor = element_blank()
            )
   plots[[i]] <- str_plot
}


plt_h <- length(q_scores) %% 3 * 5
pdf(file = paste0(f_basename, ".pdf"), 24, plt_h)
do.call(grid.arrange,plots)
.x <- dev.off()

q()
