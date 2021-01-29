## load chip-seq data
rm(list = ls())

# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("ChIPseeker")


#library(ChIPseeker)
library(dplyr)
#library(GenomicRanges)
library(rtracklayer)
library(IRanges)

### factors
peakfiles <- list.files('../../data/peak/',pattern = ".bed$")
peak <- lapply(peakfiles, function(file) { import.bed(paste0('../../data/peak/', file))})
#### only factor name
peakname <- unlist(lapply(X = peakfiles, FUN = function(x) {return(strsplit(x, split = "_")[[1]][1])}))
names(peak) <- peakname

save(peakname,file="peakname.Rdata")



### Ctcf and Rad21
crpeakfiles <- list.files('../../data/ctcf.rad21/peak/',pattern = "bed$")
crpeak <- lapply(crpeakfiles, function(file) { import.bed(paste0('../../data/ctcf.rad21/peak/', file))})
#### name and DCid
crpeakname <- unlist(lapply(X = crpeakfiles, FUN = function(x) {return(strsplit(x, split = "_peaks")[[1]][1])}))
names(crpeak) <- crpeakname


### combine
peak <- c(peak,crpeak)
names(peak) %>% duplicated() %>% table() # all F
save(peak,file = "h.all_chipseq_peaks.Rdata")


######## ========== get it from last time! ===========#####
#load("./h.all_chipseq_peaks.Rdata")



