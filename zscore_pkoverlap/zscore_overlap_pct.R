library(dplyr)
library(reshape2)

overlap <- read.csv("../../peak_overlap/hs/getpct/ave_pct.txt") %>% arrange(X)
row.names(overlap) <- overlap[,1]
colnames(overlap)[2] <- "pct"

zscore <- read.csv("../intrachr/3.plot/exless_mean.zscore_thresholds.csv") %>% arrange(X)
row.names(zscore) <- zscore[,1]

zscore_overlap <- cbind(overlap,zscore)[,-3]
#zscore_overlap <- merge(overlap,zscore)
save(zscore_overlap,file = "zscore_overlap.Rdata")


library(ggplot2)
library(ggpubr)
library(ggrepel)
#library(plotly)


theme_set(
  theme_bw()+
    theme(legend.position = "none"))



p <- ggplot(zscore_overlap,aes(x=pct,y=`mean_threshold..6`))
p+geom_point(alpha=.7,size=2.5,
             aes(color = abs(`mean_threshold..6`) >= .8))+
  scale_color_manual(values = c("#999999","#E69F00"))+
  geom_text_repel(data = zscore_overlap %>% 
                    filter(abs(`mean_threshold..6`) >= .8),
                  mapping = aes(label = X), size=3,
                  segment.color = "#DCDCDC", segment.size = 0.5)+
  geom_smooth(method="auto", se=TRUE, fullrange=FALSE, level=0.95)+
  geom_rug(sides='b')+
  stat_cor(method = "pearson",hjust=-2.5)+
  labs(title = "Human: Peak Overlap vs. Z-Score",
       subtitle = "Threshold: 6 Reads",
       x = "Peak Overlap Pct.", y = "Z-Score")+
  scale_x_continuous(labels = scales::percent,limits=c(0, 1),breaks = c(0,0.2,0.4,0.6,0.8,1))
ggsave(filename = "exless_thre6_zscore_overlap_pct.png")
