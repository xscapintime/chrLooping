rm(list = ls())

## get the matrix for no. of loops at different threshold (no. of reads to form of loop)
## random background; presumed peak 
### only intra-ch loops this time 

library(dplyr)   
source("functions.R")


## histogram
files <- list.files('../../data/random_background/intraloop_histo/',pattern = ".txt$")
data <- lapply(files, function(file) { read.csv(paste0('../../data/random_background/intraloop_histo/', file), 
                                                stringsAsFactors = FALSE,
                                                sep = ' ',
                                                header = F,
                                                comment.char = "#")})
data_cbind <- Reduce(cbind, data)
#data_cbind <- data_cbind[-nrow(data_cbind),c(seq(1,ncol(data_cbind),2))]

### leave name like 'input_random02'
samplename <- vector()
for (j in 1:length(files)){
  if (oddnmb(j) == TRUE){
    samplename[j] <- paste0(strsplit(files[j], 
                                     split = ".bed.gz",fixed=FALSE)[[1]][1],"_r1")
  } else {
    samplename[j] <-paste0(strsplit(files[j], 
                                    split = ".bed.gz",fixed=FALSE)[[1]][1],"_r2")}
}


data_cbind <- as.data.frame(lapply(data_cbind,as.numeric))
colnames(data_cbind) <- samplename
row.names(data_cbind) <- paste0(c(1:19,"20+")," reads")

random_loops <- data_cbind ##
save(random_loops,file = "h.randombg_loops.Rdata")







