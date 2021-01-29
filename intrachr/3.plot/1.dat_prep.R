#dat prep
rm(list = ls())
library(dplyr)

## z-score dat prep
load("../2.intrachr_sbtr/h.zscore_mx.Rdata")
#zscore_mx <- zscore_mx2 #

### *delete list : "PAX6", "CEBPB","SNAI2","HEY1","EOMES","HNF1B","FOXA1","FOXA2","GATA4","SOX17","GATA6",
# "GATA3","TFAP2A","GATA2","HAND1","CDX2"



# checkr1 <- paste0(c("PAX6", "CEBPB","SNAI2","HEY1","EOMES","HNF1B","FOXA1","FOXA2","GATA4","SOX17","GATA6",
#                     "GATA3","TFAP2A","GATA2","HAND1","CDX2"),"_r1")
# checkr2 <- paste0(c("PAX6", "CEBPB","SNAI2","HEY1","EOMES","HNF1B","FOXA1","FOXA2","GATA4","SOX17","GATA6",
#                     "GATA3","TFAP2A","GATA2","HAND1","CDX2"),"_r2")
# check <- c(checkr1,checkr2)
# 
# colnames(zscore_mx) %in% check %>% table()
# .
# FALSE 
# 260


droptwo_z <- zscore_mx[-(1:2),]

### split the z-score matrix
tf_zscore <- droptwo_z[,-((ncol(droptwo_z)-17):ncol(droptwo_z))]
ctcf <- droptwo_z[,(ncol(droptwo_z)-17):(ncol(droptwo_z)-8)]
rad21 <- droptwo_z[,(ncol(droptwo_z)-7):ncol(droptwo_z)]

save(tf_zscore, file = "tf_zscore.Rdata")
save(ctcf,file = "ctcf_zscore.Rdata")
save(rad21,file = "rad21_zscore.Rdata")




