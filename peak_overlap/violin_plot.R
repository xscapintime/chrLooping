# Violin + strip plot for all tfs against each CTCF sample
# histogram for all

rm(list = ls())
library(dplyr)

load("./pct_table.Rdata")
load("../peak/pos.cfx/rad21_pct_table.Rdata")

all_olp <- rbind(as.data.frame(overlap_pct),rad21_pct)

#### plotdat prep
library(reshape2)
dat <- all_olp %>%
  as.matrix() %>%
  melt()
colnames(dat) <- c("factor","group","pct")

##### ============= violin & strip ========= ########
library(ggplot2)
#library(ggthemr)
#ggthemr('pale')
theme_set(
  theme_classic() +
    theme(legend.position = "none")
) 

p <- ggplot(dat,aes(x = group, y = pct,color = group)) 
p + geom_violin()+
  geom_jitter(width=0.15, height=0.05, alpha=0.5, size=0.75)+
  geom_text(data = subset(dat, pct > 0.5 & dat$factor %in% row.names(overlap_pct)),
            mapping = aes(label = factor))+
  geom_text(data = subset(dat, pct < 0.03),
           mapping = aes(label = factor))+
  scale_y_continuous(labels = scales::percent,limits=c(0, 1),breaks = c(0,0.2,0.4,0.6,0.8,1))+
  labs(x = "CTCF", y = "Peak Overlap Pct.", 
       title = "TFs/CTCF binding sites Overlap Pct.")
  #coord_flip()
ggsave(filename = "all.tf_overlap_pct.png")



### 云雨图
#install.packages("gghalves")
library(gghalves)
#library(ggthemr)
#ggthemr('pale')
library(ggrepel)

theme_set(
  theme_classic()+
    theme(legend.position = "none"))


q <- ggplot(dat,aes(x = group, y = pct,color=group)) 
q + geom_half_violin(aes(fill=group),
                     position = position_nudge(x = .15, y = 0),
                     side = 'r',
                     show.legend=F)+
  geom_point(aes(x = as.numeric(group)-0.2,y = pct),
              position = position_jitter(width = .08),size = .8, shape = 20,
              show.legend=F)+
  geom_boxplot(aes(fill=group),outlier.shape = NA,
               width = .05,
               color = "black")+
  # geom_dotplot(binaxis = "y",binwidth = 0.03,stackdir = "down",dotsize = 0.2,
  #              position = )+
  # 
  geom_text_repel(data = subset(dat, pct > 0.6 & dat$factor %in% row.names(overlap_pct)),
            mapping = aes(x = as.numeric(group)-0.2,label = factor),color="grey20",
            segment.color = "grey50", segment.size = 0.5,size=3)+
  geom_text_repel(data = subset(dat, pct < 0.03),
            mapping = aes(x = as.numeric(group)-0.2,label = factor),color="grey20",
            segment.color = "grey50", segment.size = 0.5,size=3,
            position = position_jitter(width = .08))+
  scale_y_continuous(labels = scales::percent,limits=c(0, 1),breaks = c(0,0.2,0.4,0.6,0.8,1))+
  labs(x = "CTCF", y = "Peak Overlap Pct.", 
       title = "TFs/CTCF Binding Sites Overlap Pct.")+
  scale_colour_manual(values=cbPalette)+
  scale_fill_manual(values=cbPalette)+
  coord_flip()
ggsave(filename = "raincloud_alltf_overlap_pct.png")







##### ============= histogram ========= ########
library(ggplot2)

theme_set(
  theme_classic()+
    theme(legend.position = "none"))


rad21smp <- row.names(rad21_pct)
m_rad21pct <- vector()
for (s in 1:length(rad21smp)) {
  m_rad21pct[s] <- mean(dat$pct[dat$factor==rad21smp[s]]) 
}


h <- ggplot(dat,aes(x = pct)) 

h + geom_histogram(aes(y = stat(density),colour = "black"), 
               fill="white",binwidth = 0.05)+
  geom_density(alpha = 0.2, fill = "#FF6666")+
  scale_color_manual(values = c("#868686FF"))+
  geom_vline(aes(xintercept = mean(m_rad21pct)), 
             linetype = "dashed", size = 0.6,color="#868686FF")+
  geom_text(aes(x = mean(m_rad21pct) , y = 0.5, 
                label = paste0("RAD21: ", round(mean(m_rad21pct), 2))))+
  scale_x_continuous(labels = scales::percent,limits=c(0, 1),breaks = c(0,0.2,0.4,0.6,0.8,1))+
  labs(y = "Dens.", x = "Peak Overlap Pct.", 
       title = "TFs/CTCF Binding Sites Overlap Pct. Histogram")
ggsave(filename = "hist_alltf_overlap_pct.png")

