# generalizaiton? no. of loops (from chip-seq bed) - no. of loops (from random background)

rm(list = ls())


# normed loops
load("../1.intrachr_norm/h.norm_intraloop.Rdata")

# r1 mean and r2 mean for random background
load("./input_mean_r1.Rdata")
load("./input_mean_r2.Rdata")


###### ====== TF loops - bg loops ======= ####
### no. of reads minus input mean (r1, r2 respectively)
subipt_loops <- matrix(nrow = nrow(norm_loop),ncol = ncol(norm_loop),
                        dimnames = list(row.names(norm_loop),
                                        colnames(norm_loop)))

for (i in 1:(ncol(norm_loop)/2)) {
  subipt_loops[,seq(1,ncol(norm_loop),by = 2)][,i] <- (norm_loop[,seq(1,ncol(norm_loop),by = 2)] - input_mean_r1)[,i]
  subipt_loops[,seq(2,ncol(norm_loop),by = 2)][,i] <- (norm_loop[,seq(2,ncol(norm_loop),by = 2)] - input_mean_r2)[,i]
}


# minus_ipt_loops[,seq(1,ncol(mesc_norm_noread2loop),by = 2)] <- mesc_norm_noread2loop[,seq(1,ncol(mesc_norm_noread2loop),by = 2)] - input_mean_r1
# minus_ipt_loops[,seq(2,ncol(mesc_norm_noread2loop),by = 2)] <- mesc_norm_noread2loop[,seq(2,ncol(mesc_norm_noread2loop),by = 2)] - input_mean_r2


save(subipt_loops,file = "h.subipt_loops.Rdata")



####### z-score matrix
row_mean <- apply(subipt_loops, 1, mean)
row_sd <- apply(subipt_loops, 1, sd)
zscore_mx <- (subipt_loops - row_mean)/row_sd
fivenum(zscore_mx[-(1:2),])
# [1] -1.2428653 -0.8020185 -0.3468956  0.6182403  2.9708731

#### just for a quick look
boxplot(zscore_mx[-(1:2),])
pheatmap::pheatmap(t(zscore_mx[-(1:2),]), scale = "none",
                   fontsize = 6, fontsize_row = 6,
                   cellwidth =8 , cellheight = 7,
                   show_colnames = T,
                   cluster_cols = F,
                   cluster_rows = T,
                   angle_col = 90,
                   border_color=NA,
                   filename = "./new_intrachr_zscore_heatmap.pdf")


save(zscore_mx, file = "h.zscore_mx.Rdata")


