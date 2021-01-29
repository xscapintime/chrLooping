# skip the random background step
# use normed number of loops to generate z-score

rm(list = ls())

load("../1.intrachr_norm/h.norm_intraloop.Rdata")

####### z-score matrix
row_mean <- apply(norm_loop, 1, mean)
row_sd <- apply(norm_loop, 1, sd)
zscore_mx <- (norm_loop - row_mean)/row_sd
fivenum(zscore_mx[-(1:2),])
# [1] -1.2819725 -0.8468089 -0.3581819  0.7837802  2.9475817

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
                   filename = "./nobg_intrachr_zscore_heatmap.pdf")
