source("~/software/Subread_to_DEXSeq/load_SubreadOutput.R")
suppressPackageStartupMessages({
  require(dplyr)
})

library(BiocParallel)

featureCountsFile <- commandArgs(trailingOnly=TRUE)[1]
annoGTFFile <- commandArgs(trailingOnly=TRUE)[2]
resultFile <- commandArgs(trailingOnly=TRUE)[3]
row_names <- commandArgs(trailingOnly=TRUE)[4]
row_names_list <- unlist(strsplit(row_names, ','))
condition <- commandArgs(trailingOnly=TRUE)[5]
condition_list <- unlist(strsplit(condition, ','))

# Load featureCounts result file
samp <- data.frame(row.names = row_names_list, 
                   condition = condition_list)
dxd.fc <- DEXSeqDataSetFromFeatureCounts(featureCountsFile,
                                         flattenedfile = annoGTFFile,
                                         sampleData = samp)

# Adjust for coverage biases among samples
print("Adjust for coverage biases among samples")
dxd <- estimateSizeFactors(dxd.fc)

# Estimate variance or dispersion parameters individually exon by exon
print("Estimate variance or dispersion parameters individually exon by exon")
dxd <- estimateDispersions(dxd)

#png(filename = "test.png", width = 600, height = 600)
#plotDispEsts(dxd)
#dev.off()

# Test for differential exon usage in each gene
print("Test for differential exon usage in each gene")
dxd <- testForDEU(dxd)

# Estimate relative exon usage fold changes
print("Estimate relative exon usage fold changes")
dxd <- estimateExonFoldChanges(dxd, fitExpToVar="condition")

# Output DEXSeq result
print("Output DEXSeq result")
dxr1 <- DEXSeqResults(dxd)
# dirname <- ""
# write.table(dxr1, quote = F, sep = "\t", file = paste(dirname, "edgeR_test_result.txt", sep="/"))
write.table(dxr1, quote = F, sep = "\t", file = resultFile) #"DEXSeq_test_result.txt"
print("Finished!!")

#######
# BPPARAM <- MultiCoreParam(workers=8)
# dxd <- estimateSizeFactors(dxd.fc)
# dxd <- estimateDispersions(dxd, BPPARAM=BPPARAM)
# dxd <- testForDEU(dxd, BPPARAM=BPPARAM)
# dxd <- estimateExonFoldChanges(dxd, fitExpToVar="condition", BPPARAM=BPPARAM)
