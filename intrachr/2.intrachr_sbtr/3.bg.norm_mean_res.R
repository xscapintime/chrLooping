# number of loops divided by peaks?  NORMALIZATION
rm(list = ls())
source("functions.R")
library(dplyr)

load("./h.randombg_loops.Rdata")
load("./h.presumed_peaks.Rdata")

nm_peaks <- vector()
for (i in 1:length(peak)) {
  nm_peaks[i] <- length(peak[[i]])
}

nm_peaks <- nm_peaks[rep(1:length(nm_peaks),each=2)]
nm_peaks_mx <- matrix(rep(nm_peaks,each=20),nrow = nrow(random_loops),ncol = ncol(random_loops))


norm_input <- random_loops/nm_peaks_mx
is.matrix(norm_input)
# [1] FALSE
norm_input <- as.matrix(norm_input)
which(is.na(norm_input)==TRUE)
# integer(0)
fivenum(norm_input)
# [1] 0.01440  0.03305  0.06565  0.18210 38.74290 ##from all-loop data
# [1] 0.01420 0.03270 0.06540 0.17895 9.51360 ## intra-loop data 
save(norm_input,file = "norm.bg_loops.Rdata")


### quick look for input data
pheatmap::pheatmap(norm_input, scale = "none",
                   fontsize = 8, fontsize_row = 8, 
                   show_colnames = T,
                   cluster_cols = F,
                   cluster_rows = F,
                   angle_col = 315) %>% ggplot2::ggsave(filename = "norm_input.png")

# save(norm_input,file = "norm_input.Rdata")

### split for r1 and r2

norm_input_r1 <- norm_input[,seq(1,ncol(norm_input),by = 2)]
norm_input_r2 <- norm_input[,seq(2,ncol(norm_input),by = 2)]


### means of different inputs
input_mean_r1 <- vector()
input_mean_r2 <- vector()
for (n in 1:ncol(norm_input)) {
    for (m in 1:nrow(norm_input_r1)) {
      if (oddnmb(n) == TRUE) {
      input_mean_r1[m] <- mean(norm_input_r1[m,]) 

  }  else {
    input_mean_r2[m] <- mean(norm_input_r2[m,]) 
}
      }
}


names(input_mean_r1) <- row.names(norm_input)
names(input_mean_r2) <- row.names(norm_input)

save(input_mean_r1,file = "input_mean_r1.Rdata")
save(input_mean_r2,file = "input_mean_r2.Rdata")
# save(input_mean,file = "input_mean.Rdata")




