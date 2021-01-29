# devide random background, to see the fold
rm(list = ls())

# normed loops
load("../1.intrachr_norm/h.norm_intraloop.Rdata")

# r1 mean and r2 mean for random background
load("./input_mean_r1.Rdata")
load("./input_mean_r2.Rdata")

### no. of reads DEVIDE input mean (r1, r2 respectively)
dvdipt_loops <- matrix(nrow = nrow(norm_loop),ncol = ncol(norm_loop),
                       dimnames = list(row.names(norm_loop),
                                       colnames(norm_loop)))

for (i in 1:(ncol(norm_loop)/2)) {
  dvdipt_loops[,seq(1,ncol(norm_loop),by = 2)][,i] <- (norm_loop[,seq(1,ncol(norm_loop),by = 2)] / input_mean_r1)[,i]
  dvdipt_loops[,seq(2,ncol(norm_loop),by = 2)][,i] <- (norm_loop[,seq(2,ncol(norm_loop),by = 2)] / input_mean_r2)[,i]
}

########============= z-score matrix ==============#############

row_mean <- apply(dvdipt_loops, 1, mean)
row_sd <- apply(dvdipt_loops, 1, sd)
zscore_mx2 <- (dvdipt_loops - row_mean)/row_sd
fivenum(zscore_mx2[-(1:2),])
# [1] -1.2562706 -0.8402569 -0.3481086  0.7641950  2.8216484

#boxplot(zscore_mx2[-(1:2),])
pheatmap::pheatmap(t(zscore_mx2[-(1:2),]), scale = "none",
                   fontsize = 6, fontsize_row = 6,
                   cellwidth =8 , cellheight = 7,
                   show_colnames = T,
                   cluster_cols = F,
                   cluster_rows = T,
                   angle_col = 90,
                   border_color=NA,
                   filename = "./dvdibg_intrachr_zscore_heatmap.pdf")

save(zscore_mx2, file = "h.d_zscore_mx.Rdata")
