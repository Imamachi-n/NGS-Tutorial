
library(bridger2)
library(data.table)

dirname_lncRNA <- commandArgs(trailingOnly=TRUE)[1]
dirname_mRNA <- commandArgs(trailingOnly=TRUE)[2]
inputFile <- strsplit(commandArgs(trailingOnly=TRUE)[3], ',')[[1]]

group <- c("siCTRL", "siPUM1")    # Required
hour <- c(0, 1, 2, 4, 8, 12)    # Required

input_matrix <- NULL
  for (file in inputFile) {
    if (is.null(input_matrix)) {
      input_matrix <- suppressWarnings(fread(file, header = T))
    }else{
      input_matrix <- cbind(input_matrix,
                            suppressWarnings(fread(file, header = T)))
    }
  }

# Calculate relative RPKM values compared with 0hr.
test_table <- BridgeRDataSetFromMatrix(inputFile = input_matrix,
                                       group = group,
                                       hour = hour,
                                       cutoff = 0.1,
                                       cutoffBelow = 0.1,
                                       inforColumn = 4,
                                       save = T,
                                       outputPrefix = paste(dirname_lncRNA, "BridgeR_1", sep="/"))
raw_table <- test_table[[1]]
test_table <- test_table[[2]]

# Calc Normalized RPKM values
factor_table <- read.table(paste(dirname_mRNA, "BridgeR_3_normalization_factor.txt", sep="/"), header = T, row.names=1)
factor_table <- as.matrix(factor_table)

normalized_table <- BridgeRNormalization(test_table,
                                         factor_table,
                                         group = group,
                                         hour = hour,
                                         inforColumn = 4,
                                         save = T,
                                         outputPrefix = paste(dirname_lncRNA, "BridgeR_4", sep="/"))

halflife_table <- BridgeRHalfLifeCalcR2Select(normalized_table,
                                              group = group,
                                              hour = hour,
                                              inforColumn = 4,
                                              CutoffTimePointNumber = 4,
                                              R2_criteria = 0.9,
                                              TimePointRemoval1 = c(1,2),
                                              TimePointRemoval2 = c(8,12),
                                              ThresholdHalfLife1 = 3,
                                              ThresholdHalfLife2 = 12,
                                              save = T,
                                              outputPrefix = paste(dirname_lncRNA, "BridgeR_5", sep="/"))

pvalue_table <- BridgeRPvalueEvaluation(halflife_table, group = group,
                        hour = hour, comparisonFile = c("siCTRL", "siPUM1"),
                        inforColumn = 4, CutoffTimePointNumber = 4, calibration = FALSE,
                        save = TRUE, outputPrefix = paste(dirname_lncRNA, "BridgeR_6_PUM1KD", sep="/"))

