#! /usr/bin/env Rscript

library(ggplot2)
library(tidyr)
suppressMessages(library(dplyr))
library(RColorBrewer)

args <- commandArgs(trailingOnly = TRUE)

if(length(args) != 1){
  cat("Makes a nice exploratory barplot from a Structure results file\n\n") 
  cat("[usage]   Rscript plot_structure.r <inputfile>\n")
  cat("[example] Rscript plot_structure menidia.4_f\n")
  q()
}

f <- readLines(args[1], warn = FALSE)
linestart <- which(grepl("Label", f))
lineend <- which(grepl("Estimated Allele Frequencies in each cluster", f))
f <- f[(linestart+1):(lineend-3)]
trainingsamples <- f[which(grepl(" \\| Pop", f))]
testingsamples <- f[which(!(grepl(" \\| Pop", f)))]

# stack training samples
trainprobinfo <- function(stringval){
  .splt <- unlist(strsplit(stringval, "\\(|\\)")) |> trimws()
  .name <- unlist(strsplit(.splt, "\\s+"))[2]
  popinfo <- (.splt[3] |> trimws())
  .splt <- strsplit(popinfo, ":\\s+|\\||\\*") |> unlist() |> trimws()
  .splt <- .splt[.splt != ""]
  .origin <- .splt[1]
  n <- length(.splt)
  odds <- (1:n)[(1:n)%%2!=0]
  evens <- (1:n)[(1:n)%%2==0]

  data.frame(
    name = .name,
    population = .origin,
    group = gsub("Pop", "", .splt[odds]) |> trimws(), 
    probability = gsub("Pop", "", .splt[evens]) |> trimws()
    )
}

df <- trainprobinfo(trainingsamples[1])

for(i in trainingsamples[2:length(trainingsamples)]){
  df <- rbind(df, trainprobinfo(i))
}

## stack testing samples
testprobinfo <- function(stringval){
  .splt <- unlist(strsplit(trimws(stringval), "\\s+")) |> trimws()
  data.frame(
    name = .splt[2],
    population = .splt[4],
    group = 1:(length(.splt)-5),
    probability = .splt[6:length(.splt)]
  )
}

for(i in testingsamples){
  df <- rbind(df, testprobinfo(i))
}

df$probability <- as.numeric(df$probability)
df$population <- as.factor(df$population)
df$group <- as.factor(df$group)

pdf(NULL)
my_pal <- RColorBrewer::brewer.pal(n = 8, name = "Dark2")

df %>% 
  ggplot(aes(x = name, y = probability, fill = group)) +
  geom_bar(stat = "identity", width = 1.0) +
  theme_bw() +
  labs(title = "Posterior Membership Probability") +
  ylab("Membership probability") +
  xlab("Samples") +
  guides(fill=guide_legend(title="Membership")) +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  coord_cartesian(ylim = c(0, 1), expand = FALSE, clip = "off") +
  scale_fill_manual(values=c(my_pal)) +
  facet_grid(~population, scales = "free_x", space = "free" )

ggsave(paste0("structplot_", args[1], ".png"), width = 8, height = 3, units = "in")
