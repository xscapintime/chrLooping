# load RAD21 against CTCF overlap | no. of peaks \
rm(list = ls())
library(dplyr)

intsc <- list.files('.',pattern = "[^a][0-9]\\.txt$") ### fk finally
data <- lapply(intsc, function(file) { read.csv(paste0('./', file), 
                                                stringsAsFactors = FALSE,
                                                sep = ' ',
                                                header = F,
                                              comment.char = "#")})
data_cbind <- Reduce(cbind, data)

tf_id <- unlist(lapply(X = data_cbind[,1], FUN = function(x) {
  return(strsplit(x, split = "_against")[[1]][1])}))
CTCF_id <- unlist(lapply(X = intsc, FUN = function(x) {
  return(strsplit(x, split = "_")[[1]][2])})) %>% 
  strsplit(".txt") %>% unlist() 

CTCF_id <- paste0("CTCF_",CTCF_id)  

intsc.table <- data_cbind[,c(3,6,9,12,15,18)] 

dimnames(intsc.table) <- list(tf_id, CTCF_id)

save(intsc.table, file = "intsc_table.Rdata")

