### mean of threshol 4-6 ##############
rm(list = ls())
library(dplyr)

load("./tf_zscore.Rdata")
load("./ctcf_zscore.Rdata")
load("./rad21_zscore.Rdata")
load("../1.intrachr_norm/peakname.Rdata")


# droptwo_tf <- tf_dataset[-(1:2),]
fivenum(tf_zscore)
# [1] -1.2602677 -0.8381510 -0.4246789  0.2926011  3.0799740

## long data format
library(reshape2)
dat <- melt(tf_zscore[2:4,])
colnames(dat) <- c("thr","tf","zscore")


### ctcf and rad, mean of all
ctcf_mean <- mean(ctcf[2:4,])
rad21_mean <- mean(rad21[2:4,])
smc3 <- tf_zscore[2:4,][,c("SMC3_r1","SMC3_r2")] %>% colMeans() %>% mean()
smc1 <- tf_zscore[2:4,][,c("SMC1A_r1","SMC1A_r2")] %>% colMeans() %>% mean()
#wapl <- tf_zscore[2:4,][,c("WAPL_r1","WAPL_r2")] %>% colMeans() %>% mean()

# dat <- mean_z
# dat$group <- as.factor(ifelse(mean_z < ctcf_mean, "below", "above"))

library(ggplot2)
theme_set(
  theme_classic() +
    theme(legend.position = "none")
)  

p <- ggplot(dat, aes(x = zscore))

p +
  geom_histogram(aes(y = stat(density),colour = "black"), 
                 fill="white",bins=30)+
  geom_density(alpha = 0.2, fill = "#FF6666")+
  scale_color_manual(values = c("#868686FF"))+ ## color of bins
  
  geom_vline(aes(xintercept = ctcf_mean),  ## ctcf line
             linetype = "dashed", size = 0.6, color = "#16A085")+
  geom_text(aes(x = ctcf_mean , y = 0.8, label = paste0("CTCF: ", round(ctcf_mean, 2))),
            color = "#138D75")+
  
  geom_vline(aes(xintercept = rad21_mean),  ## rad21 line
             linetype = "dashed", size = 0.6, color = "#16A085")+
  geom_text(aes(x = rad21_mean , y = 0.95, label = paste0("RAD21: ", round(rad21_mean, 2))),
            color = "#138D75")+
  
  geom_vline(aes(xintercept = smc1),  ## smc1 line
             linetype = "dashed", size = 0.6, color = "#5DADE2")+
  geom_text(aes(x = smc1 , y = 0.05, label = paste0("SMC1A: ", round(smc1, 2))),
            color = "#1F618D")+
  
  geom_vline(aes(xintercept = smc3),  ## smc3 line
             linetype = "dashed", size = 0.6, color = "#5DADE2")+
  geom_text(aes(x = smc3 , y = 0.2, label = paste0("SMC3: ", round(smc3, 2))),
            color = "#1F618D")+
  
  # geom_vline(aes(xintercept = wapl),  ## wapl line
  #            linetype = "dashed", size = 0.6, color = "#5D6D7E")+
  # geom_text(aes(x = wapl, y = 0.5, label = paste0("WAPL: ", round(wapl, 2))),
  #           color = "#34495E")+
  
  labs(title = "Mean Loop Z-Score Histogram of Threshold 4-6 Reads",
       subtitle = "Human")+
  ylab('Dens.')+
  xlab('Mean of Z-Score')
ggsave(filename = "exless_mean.thre4-6_intrloop_zscore_hisogram.png",path = "../../figure/") 



##### 4,5,6 respectively ###############

###########=============threshold4 =================#########
dat <- tf_zscore[2,] %>% as.data.frame()
colnames(dat) <- "zscore"


### ctcf and rad, mean of all
ctcf_mean <- mean(ctcf[2,])
rad21_mean <- mean(rad21[2,])
smc3 <- tf_zscore[2,][c("SMC3_r1","SMC3_r2")] %>% mean()
smc1 <- tf_zscore[2,][c("SMC1A_r1","SMC1A_r2")] %>% mean()
# wapl <- tf_zscore[2,][c("WAPL_r1","WAPL_r2")]  %>% mean()

# dat <- mean_z
# dat$group <- as.factor(ifelse(mean_z < ctcf_mean, "below", "above"))

library(ggplot2)
theme_set(
  theme_classic() +
    theme(legend.position = "none")
)  

p <- ggplot(dat, aes(x = zscore))

p +
  geom_histogram(aes(y = stat(density),colour = "black"), 
                 fill="white",bins=30)+
  geom_density(alpha = 0.2, fill = "#FF6666")+
  scale_color_manual(values = c("#868686FF"))+ ## color of bins
  
  geom_vline(aes(xintercept = ctcf_mean),  ## ctcf line
             linetype = "dashed", size = 0.6, color = "#16A085")+
  geom_text(aes(x = ctcf_mean , y = 0.8, label = paste0("CTCF: ", round(ctcf_mean, 2))),
            color = "#138D75")+
  
  geom_vline(aes(xintercept = rad21_mean),  ## rad21 line
             linetype = "dashed", size = 0.6, color = "#16A085")+
  geom_text(aes(x = rad21_mean , y = 0.95, label = paste0("RAD21: ", round(rad21_mean, 2))),
            color = "#138D75")+
  
  geom_vline(aes(xintercept = smc1),  ## smc1 line
             linetype = "dashed", size = 0.6, color = "#5DADE2")+
  geom_text(aes(x = smc1 , y = 0.05, label = paste0("SMC1A: ", round(smc1, 2))),
            color = "#1F618D")+
  
  geom_vline(aes(xintercept = smc3),  ## smc3 line
             linetype = "dashed", size = 0.6, color = "#5DADE2")+
  geom_text(aes(x = smc3 , y = 0.2, label = paste0("SMC3: ", round(smc3, 2))),
            color = "#1F618D")+
  
  # geom_vline(aes(xintercept = wapl),  ## wapl line
  #            linetype = "dashed", size = 0.6, color = "#5D6D7E")+
  # geom_text(aes(x = wapl, y = 0.5, label = paste0("WAPL: ", round(wapl, 2))),
  #           color = "#34495E")+
  
  labs(title = "Mean Loop Z-Score Histogram of Threshold 4 Reads",
       subtitle = "Human")+
  ylab('Dens.')+
  xlab('Mean of Z-Score')
ggsave(filename = "exless_mean.thre4_intrloop_zscore_hisogram.png",path = "../../figure/") 




###########=============threshold5 =================#########
dat <- tf_zscore[3,] %>% as.data.frame()
colnames(dat) <- "zscore"


### ctcf and rad, mean of all
ctcf_mean <- mean(ctcf[3,])
rad21_mean <- mean(rad21[3,])
smc3 <- tf_zscore[3,][c("SMC3_r1","SMC3_r2")] %>% mean()
smc1 <- tf_zscore[3,][c("SMC1A_r1","SMC1A_r2")] %>% mean()
# wapl <- tf_zscore[3,][c("WAPL_r1","WAPL_r2")]  %>% mean()

# dat <- mean_z
# dat$group <- as.factor(ifelse(mean_z < ctcf_mean, "below", "above"))

library(ggplot2)
theme_set(
  theme_classic() +
    theme(legend.position = "none")
)  

p <- ggplot(dat, aes(x = zscore))

p +
  geom_histogram(aes(y = stat(density),colour = "black"), 
                 fill="white",bins=30)+
  geom_density(alpha = 0.2, fill = "#FF6666")+
  scale_color_manual(values = c("#868686FF"))+ ## color of bins
  
  geom_vline(aes(xintercept = ctcf_mean),  ## ctcf line
             linetype = "dashed", size = 0.6, color = "#16A085")+
  geom_text(aes(x = ctcf_mean , y = 0.8, label = paste0("CTCF: ", round(ctcf_mean, 2))),
            color = "#138D75")+
  
  geom_vline(aes(xintercept = rad21_mean),  ## rad21 line
             linetype = "dashed", size = 0.6, color = "#16A085")+
  geom_text(aes(x = rad21_mean , y = 0.95, label = paste0("RAD21: ", round(rad21_mean, 2))),
            color = "#138D75")+
  
  geom_vline(aes(xintercept = smc1),  ## smc1 line
             linetype = "dashed", size = 0.6, color = "#5DADE2")+
  geom_text(aes(x = smc1 , y = 0.05, label = paste0("SMC1A: ", round(smc1, 2))),
            color = "#1F618D")+
  
  geom_vline(aes(xintercept = smc3),  ## smc3 line
             linetype = "dashed", size = 0.6, color = "#5DADE2")+
  geom_text(aes(x = smc3 , y = 0.2, label = paste0("SMC3: ", round(smc3, 2))),
            color = "#1F618D")+
  
  # geom_vline(aes(xintercept = wapl),  ## wapl line
  #            linetype = "dashed", size = 0.6, color = "#5D6D7E")+
  # geom_text(aes(x = wapl, y = 0.5, label = paste0("WAPL: ", round(wapl, 2))),
  #           color = "#34495E")+
  
  labs(title = "Mean Loop Z-Score Histogram of Threshold 5 Reads",
       subtitle = "Human")+
  ylab('Dens.')+
  xlab('Mean of Z-Score')
ggsave(filename = "exless_mean.thre5_intrloop_zscore_hisogram.png",path = "../../figure/") 



###########=============threshold6 =================#########
dat <- tf_zscore[4,] %>% as.data.frame()
colnames(dat) <- "zscore"


### ctcf and rad, mean of all
ctcf_mean <- mean(ctcf[4,])
rad21_mean <- mean(rad21[4,])
smc3 <- tf_zscore[4,][c("SMC3_r1","SMC3_r2")] %>% mean()
smc1 <- tf_zscore[4,][c("SMC1A_r1","SMC1A_r2")] %>% mean()
# wapl <- tf_zscore[4,][c("WAPL_r1","WAPL_r2")]  %>% mean()

# dat <- mean_z
# dat$group <- as.factor(ifelse(mean_z < ctcf_mean, "below", "above"))

library(ggplot2)
theme_set(
  theme_classic() +
    theme(legend.position = "none")
)  

p <- ggplot(dat, aes(x = zscore))

p +
  geom_histogram(aes(y = stat(density),colour = "black"), 
                 fill="white",bins=30)+
  geom_density(alpha = 0.2, fill = "#FF6666")+
  scale_color_manual(values = c("#868686FF"))+ ## color of bins
  
  geom_vline(aes(xintercept = ctcf_mean),  ## ctcf line
             linetype = "dashed", size = 0.6, color = "#16A085")+
  geom_text(aes(x = ctcf_mean , y = 0.8, label = paste0("CTCF: ", round(ctcf_mean, 2))),
            color = "#138D75")+
  
  geom_vline(aes(xintercept = rad21_mean),  ## rad21 line
             linetype = "dashed", size = 0.6, color = "#16A085")+
  geom_text(aes(x = rad21_mean , y = 0.95, label = paste0("RAD21: ", round(rad21_mean, 2))),
            color = "#138D75")+
  
  geom_vline(aes(xintercept = smc1),  ## smc1 line
             linetype = "dashed", size = 0.6, color = "#5DADE2")+
  geom_text(aes(x = smc1 , y = 0.05, label = paste0("SMC1A: ", round(smc1, 2))),
            color = "#1F618D")+
  
  geom_vline(aes(xintercept = smc3),  ## smc3 line
             linetype = "dashed", size = 0.6, color = "#5DADE2")+
  geom_text(aes(x = smc3 , y = 0.2, label = paste0("SMC3: ", round(smc3, 2))),
            color = "#1F618D")+
  
  # geom_vline(aes(xintercept = wapl),  ## wapl line
  #            linetype = "dashed", size = 0.6, color = "#5D6D7E")+
  # geom_text(aes(x = wapl, y = 0.5, label = paste0("WAPL: ", round(wapl, 2))),
  #           color = "#34495E")+
  
  labs(title = "Mean Loop Z-Score Histogram of Threshold 6 Reads",
       subtitle = "Human")+
  ylab('Dens.')+
  xlab('Mean of Z-Score')
ggsave(filename = "exless_mean.thre6_intrloop_zscore_hisogram.png",path = "../../figure/") 
