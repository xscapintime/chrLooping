# number of loops divide no. of peaks? NORMALIZATION
rm(list = ls())


load("./h.all_intraloops.Rdata")
load("./h.all_chipseq_peaks.Rdata")

loops <- alldata_cbind

nm_peaks <- vector()
for (i in 1:length(peak)) {
  nm_peaks[i] <- length(peak[[i]])
}

names(nm_peaks) <- names(peak)
save(nm_peaks,file = "h.all_peak_num.Rdata")

nm_peaks <- nm_peaks[rep(1:length(nm_peaks),each=2)]
nm_peaks_mx <- matrix(rep(nm_peaks,each=20),nrow = nrow(loops),ncol = ncol(loops))
colnames(nm_peaks_mx) <- colnames(loops)
#save(nm_peaks_mx,file = "h.factor_nopeak_mx.Rdata")

norm_loop <- loops/nm_peaks_mx


is.matrix(norm_loop)
# [1] FALSE
norm_loop <- as.matrix(norm_loop)
which(is.na(norm_loop)==TRUE)
# integer(0)
# norm_loop[is.na(norm_loop)]=0 ## make NA=0
fivenum(norm_loop)
# [1]  0.00000000  0.03287868  0.09344521  0.29657138 71.09351130
fivenum(norm_loop[-(1:2),]) 
# [1] 0.00000000 0.02979524 0.07851866 0.20179688 4.46018148
fivenum(norm_loop[4,])
# CTNNB1_r2       FOSL1_r2      ZNF486_r2       SSU72_r2 RAD21_46164_r2 
# 0.0000000      0.1449777      0.4190651      1.0365504      2.4800809 

save(norm_loop,file = "h.norm_intraloop.Rdata")

pheatmap::pheatmap(t(norm_loop[(4:6),]), scale = "none",
                   fontsize = 6, fontsize_row = 6,
                   cellwidth =8 , cellheight = 7,
                   show_colnames = T,
                   cluster_cols = F,
                   cluster_rows = T,
                   angle_col = 90,
                   border_color=NA,
                   filename = "./new_norm_intraloop_heatmap.pdf")






####============== 1000 barchart ================################ useless
# start.time <- Sys.time()
# for (f in 1:ncol(droptwo)) {
#   # pdf("Loop_histograms.pdf", width=12, height=8)
#   histogram <- ggplot(data.frame(droptwo[,f]),aes(x=factor(row.names(droptwo),
#                                                           levels=paste0(c(1:19,"20+")," reads")),
#                                                   y=droptwo[,f]))+
#     geom_bar(stat = "identity", width = 0.7, fill = "skyblue")+
#     labs(title = colnames(droptwo)[f], x="Number of Reads to Call A Loop ", y="Loops")+
#     theme(axis.text.x = element_text(angle = 45, hjust = 0.5, vjust = 0.5)) +
#     theme(text = element_text(size=17))
#   ggsave(filename = paste0(colnames(droptwo)[f],'.png'),
#          path = "./figure/normalized/",
#          print(histogram))
#   # dev.off()
# }
# end.time <- Sys.time()
# end.time - start.time
