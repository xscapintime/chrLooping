## peaks
### presume the random background generated are peaks
# rm(list = ls())
# 
# library(ChIPseeker)
# # library(ggplot2)
# # library(GenomicRanges)
# 
# 
# peakfiles <- list.files('../data/random_background/peak/')
# peak <- lapply(peakfiles, function(file) { readPeakFile(paste0('../data/random_background/peak/', file))})
# peakname <- unlist(lapply(X = peakfiles, FUN = function(x) {return(strsplit(x, split = ".bed.gz")[[1]][1])}))
# names(peak) <- peakname
# 
# save(peak,file = "h.presumed_peaks.Rdata")

load("../../fin/2.sbtr_ipt/h.presumed_peaks.Rdata") # also symbolic link in this dir