#################=========z-score vs. no. of peaks===============##################################
## scatter plot: z-score vs no. of chip-seq peaks
rm(list = ls())
library(dplyr)

load("../1.intrachr_norm/h.all_chipseq_peaks.Rdata")
load("../2.intrachr_sbtr/h.subipt_loops.Rdata")

tf <- subipt_loops[,-((ncol(subipt_loops)-17):ncol(subipt_loops))]
ctcf <- subipt_loops[,(ncol(subipt_loops)-17):(ncol(subipt_loops)-8)]
rad21 <- subipt_loops[,(ncol(subipt_loops)-7):ncol(subipt_loops)]
#wapl <- subipt_loops[,c("WAPL_r1","WAPL_r2")]

#### no. of chip-seq peaks
peaks_num <- vector()
for (i in 1:length(peak)) {
  peaks_num[i] <- length(peak[[i]])
}


peaks_num <- peaks_num[rep(1:length(peaks_num),each=2)]
tf_peaks_num <- peaks_num[-((ncol(subipt_loops)-17):ncol(subipt_loops))]


### plot dat prep. 
plotdat <- list()
for (i in 1:nrow(tf)){
  plotdat[[i]] <- cbind(subipt_loops[i,],peaks_num) %>% as.data.frame()
  colnames(plotdat[[i]]) <- c("no.loops","no.peaks")
  names(plotdat)[i] <- row.names(subipt_loops)[i]
  plotdat[[i]]$sig <- ifelse(plotdat[[i]]$no.loops > mean(ctcf[i,])*.85,
                             "top", 
                             ifelse(plotdat[[i]]$no.loops < min(plotdat[[i]]$no.loops)*.7,
                                    "bott","mid"))
  plotdat[[i]]$sample <- row.names(plotdat[[i]])
}

### plot
library(ggplot2)
library(ggpubr)
library(ggpmisc)

theme_set(theme_bw())
options(scipen = 999)

## highlight the sigs


for (q in 1:length(plotdat)) {
  zvp <- ggplot(plotdat[[q]], aes(x=no.loops, y=no.peaks))
  formula <- y ~ x
  zvp + geom_point(aes(color = sig), alpha=0.6
                   )+
    scale_color_manual(values = c("#1E90FF","#C0C0C0","#F08080")) +
    geom_smooth(method="auto", se=TRUE, fullrange=FALSE, level=0.95)+
    ggrepel::geom_text_repel(data = plotdat[[q]] %>% 
                               filter(sig != "mid"  & sample %in% colnames(tf)),
                             mapping = aes(label = sample), size=3,
                             segment.color = "#DCDCDC", segment.size = 0.3,
                             parse = T)+
     
    #geom_rug(sides='l', color='black')+
    
    geom_vline(aes(xintercept = mean(ctcf[q,])), 
               linetype = "dashed", size = 0.6, color = "#16A085")+
    geom_text(aes(x = mean(ctcf[q,])*1.02 , 
                  y = 25000, label = "CTCF"), color = "#138D75")+
    geom_vline(aes(xintercept = mean(rad21[q,])), 
               linetype = "dashed", size = 0.6, color = "#16A085")+
    geom_text(aes(x = mean(rad21[q,])*1.02 , 
                  y = 25000, label = "RAD21"), color = "#138D75")+
    #geom_vline(aes(xintercept = mean(wapl[q,])), 
    #           linetype = "dashed", size = 0.6, color = "#5D6D7E")+
    #geom_text(aes(x = mean(wapl[q,])*1.02 , 
    #              y = 120000, label = "WAPL"), color = "#34495E")+
    
    labs(title = "Human: No. of Loops vs. No. of Peaks",
         subtitle = paste0("threshold: ", row.names(tf)[q]),
         x = "No. of Loops", y = "No. of Peaks")+
    theme(legend.position = "none")+
    #stat_cor(method = "pearson",hjust=2.25,vjust=-26)+
    #stat_poly_eq(
     #aes(label = ..eq.label..),
      #formula = formula,parse = TRUE, geom = "text",vjust=1, hjust=1)+
    coord_flip()
  ggsave(filename = paste0("threshold_", seq(1,20,1)[q],".png"),
         path = "../../figure/exless_new_itr_lvp/")
}



  



