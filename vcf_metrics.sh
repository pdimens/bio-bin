#! /usr/bin/env bash

if [[ -z "$1" ]]; then
  cat <<EOF
Calculate the mean depth and missingness per site and per sample 
in a vcf file. Generates a pre-formatted R file with .rdata 
to explore the results. Requires VCFtools + R::tidyverse.

[usage]:	vcf_metrics.sh <vcf.file>
[example]: 	vcf_metrics.sh TotalRawSNPs.vcf

EOF
  exit 1
fi

echo "Calculating mean depth per individual (1 of 4)"
vcftools --vcf $1 --out metrics --depth
echo "Calculating mean depth per site (2 of 4)"
vcftools --vcf $1 --out metrics --site-mean-depth
echo "Calculating missingness per individual (3 of 4)"
vcftools --vcf $1 --out metrics --missing-indv
echo "Calculating missingness per site (4 of 4)"
vcftools --vcf $1 --out metrics --missing-site

echo "Generating vcf_metrics.r and vcf_metrics.rdata files"

RFile() {
cat <<EOF
#! /usr/bin/env Rscript

setwd(getwd())

#load tidyverse library, or install it if necessary
if (!require("tidyverse")) install.packages("tidyverse")
library("tidyverse")

# load vcf_metrics.rdata if it exists
if (file.exists("vcf_metrics.rdata")) {
    load("vcf_metrics.rdata")
} else {
    variant_depth <- read_delim("./metrics.ldepth.mean", delim = "\t", col_names = c("chr", "pos", "mean_depth", "var_depth"), skip = 1)
    plt_variant_depth <- ggplot(variant_depth, aes(mean_depth)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)

    ind_depth <- read_delim("./metrics.idepth", delim = "\t", col_names = c("ind", "nsites", "depth"), skip = 1)
    plt_ind_depth <- ggplot(ind_depth, aes(depth)) + geom_histogram(fill = "dodgerblue1", colour = "black", alpha = 0.3)

    variant_miss <- read_delim("./metrics.lmiss", delim = "\t", col_names = c("chr", "pos", "nchr", "nfiltered", "nmiss", "fmiss"), skip = 1)
    plt_variant_miss <- ggplot(variant_miss, aes(fmiss)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)

    ind_miss  <- read_delim("./metrics.imiss", delim = "\t", col_names = c("ind", "ndata", "nfiltered", "nmiss", "fmiss"), skip = 1)
    plt_ind_miss <- ggplot(ind_miss, aes(fmiss)) + geom_histogram(fill = "dodgerblue1", colour = "black", alpha = 0.3)

    save.image("vcf_metrics.rdata")
}

summary(variant_depth$mean_depth)
plt_variant_depth + ggtitle("Mean Depth per Site") + theme_light()

plt_ind_depth + ggtitle("Mean Depth per Individual") + theme_light()

summary(variant_miss$fmiss)
plt_variant_miss + ggtitle("Missingness per Site") + theme_light()

plt_ind_miss + ggtitle("Missingness per Individual") + theme_light()

EOF
}

# generate R file
RFile > vcf_metrics.r && chmod +x vcf_metrics.r
# run R file and suppress printing to console
./vcf_metrics.r 2&> /dev/null
# rename plot pdf
mv Rplots.pdf vcf_metrics.pdf
