# intra-chr loop pct. histogram for each threshold
rm(list = rm())
library(dplyr)

## dat prep
load("../1-2.intrachr_norm/all_intralp_pct.Rdata")

library(reshape2)

dat <- intralp_pct %>%
  as.matrix() %>%
  melt()
colnames(dat) <- c("threshold","factor","pct")

#### ============= histogram for each threshold ========= ####
library(ggplot2)
theme_set(
  theme_classic() +
    theme(legend.position = "none")
) 

thr <- row.names(intralp_pct)

for(t in thr) {
  
  p <- ggplot(data=subset(dat, threshold == t),aes(x = pct)) 
  p + geom_histogram(aes(y = stat(density),colour = "black"), 
                     fill="white",binwidth = 0.08)+
    geom_density(alpha = 0.2, fill = "#FF6666")+
    scale_color_manual(values = c("#868686FF"))+
    # geom_vline(aes(xintercept = mean(m_rad21pct)), 
    #            linetype = "dashed", size = 0.6,color="#868686FF")+
    # geom_text(aes(x = mean(m_rad21pct) , y = 0.5, 
    #               label = paste0("RAD21: ", round(mean(m_rad21pct), 2))))+
    scale_x_continuous(labels = scales::percent,limits=c(0, 1),breaks = c(0,0.2,0.4,0.6,0.8,1))+
    labs(y = "Dens.", x = "Intra-chr Loops Pct.", 
         title = "Intra-chromosomal Loops Pct. Histogram",
         subtitle = paste0("threshold: ",t))
  ggsave(filename = paste0(t,"intrachr_pct_hist.png"),path = "../figure/intrachr_pct_hist")
  
}
