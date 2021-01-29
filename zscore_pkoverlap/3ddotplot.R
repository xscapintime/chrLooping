# try 3D dotplot
## overlap, zscore, peak number
#install.packages("scatterplot3d") # Install
library(dplyr)
library("scatterplot3d")

rm(list = ls())


load("zscore_overlap.Rdata")
load("../intrachr/1.intrachr_norm/h.all_chipseq_peaks.Rdata")

tf_peaknum <- vector()
for(i in 1:(length(peak)-9)){
  tf_peaknum[i] <- length(peak[[i]])
}

cr_peaknum <- vector()
for (j in (length(peak)-8):length(peak)) {
  cr_peaknum[j-88] <- length(peak[[j]])
  
}

ctcf_peaknum <- mean(cr_peaknum[1:5])
rad21_peaknum <- mean(cr_peaknum[6:9])

peaknum <- c(tf_peaknum,ctcf_peaknum,rad21_peaknum)
names(peaknum) <- c(names(peak)[1:(length(peak)-9)],"CTCF","RAD21")
peaknum <- as.data.frame(peaknum)


overlap_zscore_peak <- merge(zscore_overlap,peaknum,by = 0, all =T)

overlap_zscore_peak$group <- ifelse(overlap_zscore_peak$mean_all >= 0.8, "top",
                                    ifelse(overlap_zscore_peak$mean_all <= -0.8, "bott","mid")) %>%
  as.factor()

write.csv(overlap_zscore_peak,file = "overlap_zscore_peak.csv")

colors <- c("#1E90FF", "#C0C0C0","#F08080")
colors <- colors[as.numeric(overlap_zscore_peak$group)]

shapes = c(18, 15, 17) 
shapes <- shapes[as.numeric(overlap_zscore_peak$group)]

#source('http://www.sthda.com/sthda/RDoc/functions/addgrids3d.r')

scatterplot3d(overlap_zscore_peak[,c(8,3,4)],
              pch = shapes, color=colors,
              box = F, type="h",
              main="3D Scatter Plot",
              xlab = "No. of Peaks",
              ylab = "Peak Overlap Pct.",
              zlab = "Z-Score")
pdf(file = "3d_peak_overlap_zscore.pdf")
ggsave(filename = "3d_peak_overlap_zscore.png")
