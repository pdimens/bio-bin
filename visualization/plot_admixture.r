#! /usr/bin/env Rscript

library(tidyr)
library(ggplot2)

args <- commandArgs(trailingOnly = TRUE)

if(length(args) != 1){
  cat("Makes a nice exploratory barplot from an Admixture results file\n\n") 
  cat("[usage]   Rscript admixplot.r <inputfile>\n")
  cat("[example] Rscript admixplot.r menidia.4.Q\n")
  q()
}

pdf(NULL)

data <- read.table(args[1])
names(data) <- paste("pop", 1:ncol(data), sep = "_")
data$name <- paste("sample", 1:nrow(data), sep = "_")

data <- data %>% 
  pivot_longer(-name, names_to = "population", values_to = "probability")

data %>% 
  ggplot(aes(x = name, y= probability, fill = population)) +
  geom_bar(stat = "identity", width = 1.0) +
  theme_bw() +
  labs(title = "Posterior Membership Probability") +
  ylab("Membership probability") +
  xlab("Samples") +
  guides(fill=guide_legend(title="Membership")) +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  coord_cartesian(ylim = c(0, 1), expand = FALSE, clip = "off")

ggsave(
  paste0("admixplot_", args[1], ".png"), 
  height = 3,
  width = 8,
  units= "in"
  )
