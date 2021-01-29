rm(list = ls())

load("ctcf_zscore.Rdata")
load("rad21_zscore.Rdata")
load("tf_zscore.Rdata")
load("../1.intrachr_norm/peakname.Rdata")

mean_z <- apply(tf_zscore, 2, mean)
# barplot(mean_z)
mean_z <- as.data.frame(mean_z)

tf_num <- seq(1,ncol(tf_zscore),by =2)

r.mean_z <- vector()
for (n in tf_num){
	  r.mean_z[(n+1)/2] <- mean(mean_z[(n:n+1),]) 
}
r.mean_z <- as.data.frame(r.mean_z)
row.names(r.mean_z) <- peakname 


#### descent list #### maybe when threshold is done?
ctcf_mean <- mean(ctcf)
rad21_mean <- mean(rad21)

desc.list <- rbind(ctcf_mean,rad21_mean,r.mean_z)
row.names(desc.list)[1:2] <- c("CTCF","RAD21")
#list <- desc.list$r.mean_z
#names(list) <- row.names(desc.list)
desc.list <-  arrange(desc.list, -r.mean_z)

write.csv(desc.list,file = "exless_h.all.tf_des-meanz.v2.csv",col.names = F)



#############========== for threshold 4-6 ================##############
mean_4 <- vector()
for (n in tf_num){
  mean_4[(n+1)/2] <- mean(tf_zscore[2,][n:(n+1)]) 
}
mean_4 <- as.data.frame(mean_4)
mean_4 <- rbind(mean(ctcf[2,]),mean(rad21[2,]),mean_4)
row.names(mean_4) <- c("CTCF","RAD21",peakname)


mean_5 <- vector()
for (n in tf_num){
  mean_5[(n+1)/2] <- mean(tf_zscore[3,][n:(n+1)]) 
}
mean_5 <- as.data.frame(mean_5)
mean_5 <- rbind(mean(ctcf[3,]),mean(rad21[3,]),mean_5)
row.names(mean_5) <- c("CTCF","RAD21",peakname)

mean_6 <- vector()
for (n in tf_num){
  mean_6[(n+1)/2] <- mean(tf_zscore[4,][n:(n+1)]) 
}
mean_6 <- as.data.frame(mean_6)
mean_6 <- rbind(mean(ctcf[4,]),mean(rad21[4,]),mean_6)
row.names(mean_6) <- c("CTCF","RAD21",peakname)


#### table
mean_all <- rbind(ctcf_mean,rad21_mean,r.mean_z)
row.names(mean_all)[1:2] <- c("CTCF","RAD21")

z_table <- cbind(mean_all,mean_4,mean_5,mean_6)
colnames(z_table) <- c("mean_all","mean_threshold: 4","mean_threshold: 5","mean_threshold: 6")

pheatmap::pheatmap(z_table, scale = "none",
                   fontsize = 6, fontsize_row = 6,
                   cellwidth =8 , cellheight = 7,
                   show_colnames = T,
                   cluster_cols = F,
                   cluster_rows = T,
                   angle_col = 90,
                   border_color=NA,
                   filename = "./exless_mean.zscore_heatmap.pdf")

write.csv(z_table,file = "exless_mean.zscore_thresholds.csv")
