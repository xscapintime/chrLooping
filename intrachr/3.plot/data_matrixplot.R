rm(list = ls())
library(dplyr)

### chcek data
########### plot.matrix ###########
library(RColorBrewer)
# display.brewer.all()
cols <- brewer.pal(9, "Blues")
pal <- colorRampPalette(cols)
# install.packages("plot.matrix")

library('plot.matrix')
options(scipen = 999)


#### loops matrixplot
load("../1.norm/h.all_loops.Rdata")
dat <- as.matrix(alldata_cbind)
par(mar=c(4.0, 4.0, 6.0, 4.0))
# png("loops_mxplot.png")
plot(dat,col=pal(20), border = NA,axis.col=NULL, axis.row=NULL,
     main = "No. of Loops",key=list(side=3, cex.axis=0.75,las = 1))
# dev.off()

# pheatmap::pheatmap(alldata_cbind,scale = "none",
#                    cluster_rows = F,
#                    cluster_cols = F)


#### peak matrixplot
load("../1.norm/h.factor_nopeak_mx.Rdata")
dat <- as.matrix(nm_peaks_mx)
par(mar=c(4.0, 4.0, 6.0, 4.0))
plot(dat,col=pal(20), border = NA,axis.col=NULL, axis.row=NULL,
     main = "No. of Peaks",key=list(side=3, cex.axis=0.75))


### norm.loops matrixplot
load("../1.norm/h.norm_loop.Rdata")
dat <- as.matrix(norm_loop)
par(mar=c(4.0, 4.0, 6.0, 4.0))
plot(dat,col=pal(20), border = NA,axis.col=NULL, axis.row=NULL,
     main = "No. of Norm. Loops",key=list(side=3, cex.axis=0.75))




### background matrixplot
load("../2.sbtr_ipt/norm.bg_loops.Rdata")
dat <- norm_input
par(mar=c(4.0, 4.0, 6.0, 4.0))
plot(dat,col=pal(20), border = NA,axis.col=NULL, axis.row=NULL,
     main = "No. of Norm. Background Loops",key=list(side=3, cex.axis=0.75))



### norm.loops after sbtr background
load("../2.sbtr_ipt/h.subipt_loops.Rdata")
dat <- subipt_loops
ar(mar=c(4.0, 4.0, 6.0, 4.0))
plot(dat,col=pal(20), border = NA,axis.col=NULL, axis.row=NULL,
     main = "No. of Norm. Loops Subtract Bg.",key=list(side=3, cex.axis=0.75))




### zscore matrixplot
load("../2.sbtr_ipt/h.zscore_mx.Rdata")
dat <- zscore_mx
par(mar=c(4.0, 4.0, 6.0, 4.0))
plot(dat,col=pal(20), border = NA,axis.col=NULL, axis.row=NULL,
     main = "Z-Score",key=list(side=3, cex.axis=0.75))
