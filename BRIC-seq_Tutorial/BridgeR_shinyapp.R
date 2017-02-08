setwd("C:/Users/Naoto/Downloads")

library(bridger2)
library(data.table)

filename <- "BridgeR_6_PUM1KD_halflife_pvalue_evaluation.txt"

pvalue_table <- fread(filename, header=T)
shiny_test <- BridgeReport(pvalue_table,
                           searchRowName = "gene_symbol",
                           hour = c(0,1,2,4,8,12),
                           TimePointRemoval1 = c(1, 2), 
                           TimePointRemoval2 = c(8, 12))
shiny_test
