
library(edgeR)

filename_list <- commandArgs(trailingOnly=TRUE)[1]
inputFile <- unlist(strsplit(filename_list, ','))
labelname_list <- commandArgs(trailingOnly=TRUE)[2]
dirname <- commandArgs(trailingOnly=TRUE)[3]
duplicate <- commandArgs(trailingOnly=TRUE)[4]

count <- NULL
for (file in inputFile) {
  if (is.null(count)) {
    count <- read.table(file, header = F, row.names = 1)
  }else{
    count <- cbind(count,
                   read.table(file, header = F, row.names = 1))
  }
}

colnames(count) <- inputFile 

group <- unlist(strsplit(labelname_list, ',')) 

d <- DGEList(counts = count, group = group)
d <- calcNormFactors(d)
if(duplicate == "No"){
  d <- estimateGLMCommonDisp(d, method = "deviance", robust = T, subset = NULL)
}else{ # Yes
  d <- estimateGLMCommonDisp(d)
}

result <- exactTest(d)
result_table <- result$table

output_file <- cbind(count, result_table)

write.table(output_file, quote = F, sep = "\t", file = paste(dirname, "edgeR_test_result.txt", sep="/"))
