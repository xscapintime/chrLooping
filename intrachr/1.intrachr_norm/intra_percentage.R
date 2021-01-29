rm(list = ls())

## percentage of intra-chr loop/all loop called

library('dplyr')                            
source("functions.R")

#### =====================load all loops ======================== ####

files <- list.files('../../data/histogram/',pattern = ".histo.txt$")
data <- lapply(files, function(file) { read.csv(paste0('../../data/histogram/', file), 
                                                stringsAsFactors = FALSE,
                                                sep = ' ',
                                                header = F,
                                                comment.char = "#")})
data_cbind <- Reduce(cbind, data)
data_cbind <- data_cbind[-nrow(data_cbind),c(seq(1,ncol(data_cbind),2))]

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

save(data_cbind,file = "h.factor_loops.Rdata")


## load Ctcf and Rad21 histogram
crfiles <- list.files('../../data/ctcf.rad21/histogram/',pattern = ".histo.txt$")
crdata <- lapply(crfiles, function(file) { read.csv(paste0('../../data/ctcf.rad21/histogram/', file), 
                                                    stringsAsFactors = FALSE,
                                                    sep = ' ',
                                                    header = F,
                                                    comment.char = "#")})
crdata_cbind <- Reduce(cbind, crdata)
crdata_cbind <- crdata_cbind[-nrow(crdata_cbind),c(seq(1,ncol(crdata_cbind),2))]

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
save(crdata_cbind,file = "h.ctcfrad_loops.Rdata")

alldata_cbind <- cbind(data_cbind,crdata_cbind)
save(alldata_cbind,file = "h.all_loops.Rdata")

####define
rm(list = ls())
load("./h.all_loops.Rdata")
all_loop <- alldata_cbind


#### =====================load all loops ======================== ####
load("./h.all_intraloops.Rdata")
intra_loop <- alldata_cbind

#rm(alldata_cbind)

### percentage
intralp_pct <- intra_loop/all_loop
save(intralp_pct,file = "all_intralp_pct.Rdata")

#### ================== dens/histogram for each tf ==================== ####
### plot dat prep
sample <- unlist(lapply(X = colnames(intralp_pct), FUN = function(x) {
  return(strsplit(x, split = "_r")[[1]][1])}))

plotdat <- list()
for (i in seq(1,ncol(intralp_pct),by = 2)) {
  
  plotdat[[(i+1)/2]] <- cbind(data.frame(rowMeans(intralp_pct[,i:(i+1)])),c(seq(1,19),"20+"))
  names(plotdat)[(i+1)/2] <- sample[i]
  colnames(plotdat[[(i+1)/2]]) <- c("pct","threshold")
  
}

###### ========== plot! =========== ##########

library(ggplot2)
# library(devtools)
# devtools::install_github('cttobin/ggthemr')
library(ggthemr)
ggthemr('pale')
 

for (j in 1:length(plotdat)) {
  
 ggplot(plotdat[[j]], aes(x=factor(threshold,levels = c(seq(1,19),"20+")), y=plotdat[[j]]$pct))+
    #geom_line(size=1,position="identity",color = "#868686FF")+
    geom_area(alpha = 0.6, fill = "#868686FF",group=1)+
    scale_y_continuous(labels = scales::percent,limits=c(0, 1),breaks = c(0,0.2,0.4,0.6,0.8,1))+
    #scale_x_continuous(breaks=plotdat[[j]]$threshold)+
    labs(title='Intra-chromosomal Loops Percentage',
         subtitle=sample[j*2])+
    ylab('Intra-ch Loops/All Loops')+
    xlab('Reads Threshold')
  
  ggsave(filename = paste0(sample[j*2],"_intralp_pct.png"), path = "../../figure/intralp_pct_all")
   
}



#### ============ stack, "CTCF_35846" as control ============####
### strange ones

stg <- c("BRD2",                    #"BRD3",
         "BRD4",                    #"CTNNB1",
         "FOSL1","HDAC6",           #"HIRA","HIST1H1B",
         "KDM5A","KDM5B",           #"KDM5C","KLF4",
         "KLF5","MPHOSPH8",         #"NR5A2","NUP98","RNF2","SALL4","SIRT6","SOX9","SPI1","STAT3",
         "TCF7L1","THAP11",         #"WAPL",
         "ZFP42",                   #"ZNF57",
         "ZNF274"                   #"ZNF589"
         )


library(ggplot2)
library(ggthemr)
library(RColorBrewer)


#### dat prep.

dat <- matrix(nrow = nrow(intralp_pct),ncol = length(stg))
for (t in 1:length(stg)) {
  dat[,t] <- cbind(plotdat[[stg[t]]][,1])
}

dat <- cbind(plotdat[["CTCF_35846"]][,1],dat) %>% as.data.frame()
dat <- cbind(plotdat[["CTCF_35846"]][,2],dat)

colnames(dat) <- c("threshold","CTCF_35846",stg)


for (t in 3:ncol(dat)) {
  
  ggplot(data = dat,aes(x = factor(threshold,levels = c(seq(1,19),"20+"))))+
    geom_area(aes(y = CTCF_35846,colour = "CTCF"),fill = "#868686FF",group = 1,alpha = 0.3,size=1,linetype="blank")+
    geom_line(aes(y = dat[,t],colour = colnames(dat[t])),group = 1,size =1.2)+
    scale_colour_manual("",
                        breaks = c("CTCF",colnames(dat[t])),
                        values = c("#868686FF","#EFC000FF"))+ 
    scale_y_continuous(labels = scales::percent,limits = c(0, 1),breaks = c(0,0.2,0.4,0.6,0.8,1))+
    labs(title = 'Intra-chromosomal Loops Percentage',
         subtitle = paste0(colnames(dat[t])," vs CTCF"))+
    ylab('Intra-ch Loops/All Loops')+
    xlab('Reads Threshold')
  ggsave(filename = paste0(colnames(dat[t]),"vsctcf_intralp_pct.png"), path = "../../figure/intralp_pct_vsctcf")
  
}




