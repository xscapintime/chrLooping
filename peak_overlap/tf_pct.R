rm(list = ls())
library(dplyr)

tf_peak <- read.csv("./tf_peaks.txt",
                      stringsAsFactors = FALSE,
                      sep = ' ',
                      header = F,
                      comment.char = "#")
tf_id <- unlist(lapply(X = tf_peak[,1], FUN = function(x) {
  return(strsplit(x, split = "_")[[1]][1])}))

peaknum <- tf_peak$V4
names(peaknum) <- tf_id


## see the pct.
load("./intsc_table.Rdata")
overlap_pct <- as.matrix(intsc.table/peaknum)

overlap_pct <- overlap_pct[,-1] ### becuz CTCF_8086 and CTCF_35846 are exactly the same
save(overlap_pct,file = "pct_table.Rdata")

ave_pct <- rowMeans(overlap_pct) %>% sort(decreasing = T)

write.csv(ave_pct,file = "ave_pct.txt", quote = F)

