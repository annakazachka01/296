## Installation of Biobase and NMF

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Biobase")

library(Biobase)

install.packages("CRAN")
install.packages("NMF")
# Load
library(NMF)