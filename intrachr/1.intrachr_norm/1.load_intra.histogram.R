rm(list = ls())


library('dplyr')                            
source("functions.R")


#### =====================load intra-chr loops ======================== ####

files <- list.files('../../data/intraloop_histo/',pattern = "_num.txt$")
data <- lapply(files, function(file) { read.csv(paste0('../../data/intraloop_histo/', file), 
                                                stringsAsFactors = FALSE,
                                                sep = ' ',
                                                header = F,
                                                comment.char = "#")})
data_cbind <- Reduce(cbind, data)
#data_cbind <- data_cbind[-nrow(data_cbind),c(seq(1,ncol(data_cbind),2))]

### only take the factor name
samplename <- vector()
for (i in 1:length(files)){
  if (oddnmb(i) == TRUE){
    samplename[i] <- paste0(strsplit(files[i], 
                                     split = "_",fixed=FALSE)[[1]][1],"_r1")
  } else {
    samplename[i] <-paste0(strsplit(files[i], 
                                    split = "_",fixed=FALSE)[[1]][1],"_r2")}
}

data_cbind <- as.data.frame(lapply(data_cbind,as.numeric))
colnames(data_cbind) <- samplename
row.names(data_cbind) <- paste0(c(1:19,"20+")," reads")

### check if there are duplicated peak bed samples
duplicated(colnames(data_cbind))  %>% table()  ## all F

save(data_cbind,file = "h.factor_intraloops.Rdata")


## load Ctcf and Rad21 histogram
crfiles <- list.files('../../data/ctcf.rad21/intraloop_histo/',pattern = "_num.txt$")
crdata <- lapply(crfiles, function(file) { read.csv(paste0('../../data/ctcf.rad21/intraloop_histo/', file), 
                                                    stringsAsFactors = FALSE,
                                                    sep = ' ',
                                                    header = F,
                                                    comment.char = "#")})
crdata_cbind <- Reduce(cbind, crdata)
#crdata_cbind <- crdata_cbind[-nrow(crdata_cbind),c(seq(1,ncol(crdata_cbind),2))]

### factor name and DCid
ctcf.rad21 <- vector()
for (j in 1:length(crfiles)){
  if (oddnmb(j) == TRUE){
    ctcf.rad21[j] <- paste0(strsplit(crfiles[j], 
                                     split = "_peaks",fixed=FALSE)[[1]][1],"_r1")
  } else {
    ctcf.rad21[j] <-paste0(strsplit(crfiles[j], 
                                    split = "_peaks",fixed=FALSE)[[1]][1],"_r2")}
}

crdata_cbind <- as.data.frame(lapply(crdata_cbind,as.numeric))
colnames(crdata_cbind) <- ctcf.rad21
row.names(crdata_cbind) <- paste0(c(1:19,"20+")," reads")

### check if there are duplicated peak bed samples
duplicated(colnames(crdata_cbind))  %>% table()  ## all F
save(crdata_cbind,file = "h.ctcfrad_intraloops.Rdata")

alldata_cbind <- cbind(data_cbind,crdata_cbind)
save(alldata_cbind,file = "h.all_intraloops.Rdata")
