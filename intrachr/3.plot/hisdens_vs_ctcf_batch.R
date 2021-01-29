##========================= xxxx vs CTCF batch
rm(list = ls())
library(dplyr)
library(reshape2)

load("./tf_zscore.Rdata")
load("./ctcf_zscore.Rdata")
load("./rad21_zscore.Rdata")

### dat prep.
dat <- tf_zscore

#### ctcf 
ctcf_r1_mean <- rowMeans(ctcf[,seq(1,ncol(ctcf),by = 2)])
ctcf_r2_mean <- rowMeans(ctcf[,seq(2,ncol(ctcf),by = 2)])

### rad21
rad21_r1_mean <- rowMeans(rad21[,seq(1,ncol(rad21),by = 2)])
rad21_r2_mean <- rowMeans(rad21[,seq(2,ncol(rad21),by = 2)])



#### sep r1 r2
genenum <- seq(1,ncol(dat),by = 2)
dat_r1 <- dat[,genenum]
dat_r2 <- dat[,genenum+1]
# save(dat_r1,file = "zscoremx_drp2_r1.Rdata")
# save(dat_r2,file = "zscoremx_drp2_r2.Rdata")


#### genename
genename <- vector()
for (j in genenum) {
 genename[(j+1)/2] <- strsplit(colnames(dat)[j],split = "_",fixed = F)[[1]][1]
}
# m.genename <- genename ##
# save(m.genename, file = "m.genename_noCTCF.Rdata")
# 
# 
# #### duplication found in `genename`
# #### corrected in another script
# load("genename_drpdupl.Rdata")

####plotdat prep.
plotdat_r1 <- list()
for (p in 1:ncol(dat_r1)) {

  plotdat_r1[[p]] <- cbind(ctcf_r1_mean,dat_r1[,p])
  names(plotdat_r1)[p] <- paste0("CTCF_vs_",genename[p],"_r1")
  colnames(plotdat_r1[[p]]) <- c("CTCF",genename[p])
  plotdat_r1[[p]] <- as.data.frame(plotdat_r1[[p]])
  plotdat_r1[[p]] <- stack(plotdat_r1[[p]])
  plotdat_r1[[p]]$reads <- rep(row.names(dat),times = 2)
  colnames(plotdat_r1[[p]]) <- c("zscore","TF","reads") 
}


plotdat_r2 <- list()
for (p in 1:ncol(dat_r2)) {
  
  plotdat_r2[[p]] <- cbind(ctcf_r2_mean, dat_r2[,p])
  names(plotdat_r2)[p] <- paste0("CTCF_vs_",genename[p],"_r2")
  colnames(plotdat_r2[[p]]) <- c("CTCF",genename[p])
  plotdat_r2[[p]] <- as.data.frame(plotdat_r2[[p]])
  plotdat_r2[[p]] <- stack(plotdat_r2[[p]])
  plotdat_r2[[p]]$reads <- rep(row.names(dat),times = 2)
  colnames(plotdat_r2[[p]]) <- c("zscore","TF","reads") 
}



#### ggplot2 plot

library(ggplot2)
theme_set(
  theme_classic() +
    theme(legend.position = "top")
)


##### r1 plots
for (q in 1:length(plotdat_r1)) {
  p <- ggplot(plotdat_r1[[q]], aes(x = zscore))
  densvsctcf <- p + geom_histogram(aes(y = stat(density), color = `TF`, fill = `TF`), 
                                   alpha = 0.4, position = "identity")+
    geom_density(aes(color = `TF`), size = 1) +
    scale_color_manual(values = c("#868686FF", "#EFC000FF"))+
    scale_fill_manual(values = c("#868686FF", "#EFC000FF"))+
    geom_vline(aes(xintercept = mean(ctcf_r1_mean)),  ## Ctcf line
               linetype = "dashed", size = 0.6)+
    geom_vline(aes(xintercept = mean(dat_r1[,q])),    ## Tf line
               linetype = "dashed", size = 0.6)+
    geom_vline(aes(xintercept = mean(rad21_r1_mean)), ## Rad21
               linetype = "dashed", size = 0.6)+
    geom_text(aes(x = mean(ctcf_r1_mean) , y = 0, 
                  label = paste0("CTCF: ", round(mean(ctcf_r1_mean),2))))+
    geom_text(aes(x = mean(dat_r1[,q]) , y = 0, 
                  label = paste0(genename[q],": ",round(mean(dat_r1[,q]),2))))+
    geom_text(aes(x = mean(rad21_r1_mean) , y = 0, 
                  label = paste0("RAD21: ", round(mean(rad21_r1_mean),2))))+
    #ggtitle(paste0("Human ", genename[q], " vs CTCF r1"))+
    labs(title = paste0(genename[q], " vs CTCF r1"),
	        subtitle = "Human")+
	    ylab('Dens.')+
	      xlab('Z-Score')
  
  ggsave(filename = paste0(genename[q],"_vs_CTCF_r1_hisdens.png"),path = "../../figure/new_dist_against_CTCF")
  
  
}



##### r2 plots

for (q in 1:length(plotdat_r2)) {
  p <- ggplot(plotdat_r2[[q]], aes(x = zscore))
  densvsctcf <- p + geom_histogram(aes(y = stat(density), color = `TF`, fill = `TF`), 
                                   alpha = 0.4, position = "identity")+
    geom_density(aes(color = `TF`), size = 1) +
    scale_color_manual(values = c("#868686FF", "#EFC000FF"))+
    scale_fill_manual(values = c("#868686FF", "#EFC000FF"))+
    geom_vline(aes(xintercept = mean(ctcf_r2_mean)), 
               linetype = "dashed", size = 0.6)+
    geom_vline(aes(xintercept = mean(dat_r2[,q])), 
               linetype = "dashed", size = 0.6)+
    geom_text(aes(x = mean(ctcf_r2_mean) , y = 0, 
                  label = paste0("CTCF: ", round(mean(ctcf_r2_mean),2))))+
    geom_text(aes(x = mean(dat_r2[,q]) , y = 0, 
                  label = paste0(genename[q],": ",round(mean(dat_r2[,q]),2))))+
    geom_vline(aes(xintercept = mean(rad21_r2_mean)), 
               linetype = "dashed", size = 0.6)+
    geom_text(aes(x = mean(rad21_r2_mean) , y = 0, 
                  label = paste0("RAD21: ", round(mean(rad21_r2_mean),2))))+
    #ggtitle(paste0("Human ", genename[q], " vs CTCF r2"))
    labs(title = paste0(genename[q], " vs CTCF r2"),
                 subtitle = "Human")+
	         ylab('Dens.')+
	         xlab('Z-Score')
  
  ggsave(filename = paste0(genename[q],"_vs_CTCF_r2_hisdens.png"),path = "../../figure/new_dist_against_CTCF")
  
  
}


#######========for RAd21===========
rad_dat_r1 <- cbind(ctcf_r1_mean,rad21_r1_mean) 
colnames(rad_dat_r1) <- c("CTCf", "RAD21")
rad_dat_r1 <- rad_dat_r1 %>% melt()
colnames(rad_dat_r1) <- c("thr","TF","zscore")

p1 <- ggplot(rad_dat_r1,aes(x = zscore))
densvsctcf <- p1 + geom_histogram(aes(y = stat(density), color = `TF`, fill = `TF`), 
                                 alpha = 0.4, position = "identity")+
  geom_density(aes(color = `TF`), size = 1) +
  scale_color_manual(values = c("#868686FF", "#EFC000FF"))+
  scale_fill_manual(values = c("#868686FF", "#EFC000FF"))+
  geom_vline(aes(xintercept = mean(ctcf_r1_mean)), 
             linetype = "dashed", size = 0.6)+
  geom_text(aes(x = mean(ctcf_r1_mean) , y = 0, 
                label = paste0("CTCF: ", round(mean(ctcf_r1_mean),2))))+
  geom_vline(aes(xintercept = mean(rad21_r1_mean)), 
             linetype = "dashed", size = 0.6)+
  geom_text(aes(x = mean(rad21_r1_mean) , y = 0, 
                label = paste0("RAD21: ", round(mean(rad21_r1_mean),2))))+
  labs(title = paste0("RAD21", " vs CTCF r1"),
       subtitle = "Human")+
  ylab('Dens.')+
  xlab('Z-Score')
ggsave(filename = paste0("RAD21","_vs_CTCF_r1_hisdens.png"),path = "../../figure/new_dist_against_CTCF")



rad_dat_r2 <- cbind(ctcf_r2_mean,rad21_r2_mean) 
colnames(rad_dat_r2) <- c("CTCf", "RAD21")
rad_dat_r2 <- rad_dat_r2 %>% melt()
colnames(rad_dat_r2) <- c("thr","TF","zscore")

p2 <- ggplot(rad_dat_r2,aes(x = zscore))
densvsctcf <- p2 + geom_histogram(aes(y = stat(density), color = `TF`, fill = `TF`), 
                                  alpha = 0.4, position = "identity")+
  geom_density(aes(color = `TF`), size = 1) +
  scale_color_manual(values = c("#868686FF", "#EFC000FF"))+
  scale_fill_manual(values = c("#868686FF", "#EFC000FF"))+
  geom_vline(aes(xintercept = mean(ctcf_r2_mean)), 
             linetype = "dashed", size = 0.6)+
  geom_text(aes(x = mean(ctcf_r2_mean) , y = 0, 
                label = paste0("CTCF: ", round(mean(ctcf_r2_mean),2))))+
  geom_vline(aes(xintercept = mean(rad21_r2_mean)), 
             linetype = "dashed", size = 0.6)+
  geom_text(aes(x = mean(rad21_r2_mean) , y = 0, 
                label = paste0("RAD21: ", round(mean(rad21_r2_mean),2))))+
  labs(title = paste0("RAD21", " vs CTCF r2"),
       subtitle = "Human")+
  ylab('Dens.')+
  xlab('Z-Score')
ggsave(filename = paste0("RAD21","_vs_CTCF_r2_hisdens.png"),path = "../../figure/new_dist_against_CTCF")

