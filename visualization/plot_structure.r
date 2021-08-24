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

qmat <- read.delim(
  args[1], 
  skip = linestart, 
  nrows = (lineend - linestart) - 3, 
  header = FALSE,
  sep = "",
  strip.white = TRUE
) %>% select(-1,-3, -5)

names(qmat) <- c("name","population", paste0("pop_",1:(ncol(qmat)-2)))
qmat$population <- as.factor(qmat$population)
qmat <- qmat %>% 
  pivot_longer(c(-name, -population), names_to = "group", values_to = "probability")

pdf(NULL)
my_pal <- RColorBrewer::brewer.pal(n = 8, name = "Dark2")

qmat %>% 
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
