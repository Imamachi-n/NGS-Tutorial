
library(bridger2)
library(data.table)

dirname <- commandArgs(trailingOnly=TRUE)[1]

inputFile <- strsplit(commandArgs(trailingOnly=TRUE)[2], ',')[[1]]

group <- c("siCTRL", "siSTAU1")    # Required
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

halflife_table <- BridgeRCore(input_matrix,
                              group=group,
                              hour=hour,
                              save = TRUE,
                              TimePointRemoval1 = c(1,2),
                              TimePointRemoval2 = c(8,12),
                              ThresholdHalfLife1 = 3,
                              ThresholdHalfLife2 = 12,
                              outputPrefix = paste(dirname, "BridgeR", sep="/"))


halflife_table <- fread(paste(dirname, "BridgeR_5_halflife_calc_R2_selection.txt", sep="/"), header = T)

pvalue_table <- BridgeRPvalueEvaluation(halflife_table, group = group,
                        hour = hour, comparisonFile = c("siCTRL","siSTAU1"),
                        inforColumn = 4, CutoffTimePointNumber = 4, calibration = FALSE,
                        save = TRUE, outputPrefix = paste(dirname, "BridgeR_6_STAU1KD", sep="/"))

