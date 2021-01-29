# pubmed.mineR
rm(list = ls())

#install.packages("pubmed.mineR")
library(pubmed.mineR)
loop_abstracts <- readabs("abstract-ctcfORchro-set.txt")


class(loop_abstracts@Abstract)[1]

### 需要将系统语言设置为英文
# sessionInfo()
# Sys.setlocale(category = "LC_ALL",locale = "English_United States.1252")

# words <- word_atomizations(loop_abstracts)
# words <- as.data.frame(words)
# words$Freq <- as.numeric(words$Freq)
# ggdotchart(words[1:30,], x="words", y="Freq",
#            #color="Freq",
#            sorting="descending",
#            add="segments",
#            ggtheme=theme_minimal(),
#            rotate=T,
#            title="search (CTCF) OR (chromatin loop) NOT (r-loop) on PubMed",
#            yscale = "log2",
#            xlab = "Words", ylab = "log2 Freq.",
#            font.x = c(11, "black"),font.y = c(11, "black"))



genes <- gene_atomization(loop_abstracts)
class(genes)
# [1] "matrix" "array" 
genes <- as.data.frame(genes)
genes$Freq <- as.numeric(genes$Freq)

write.csv(genes,file = "pubmed_gene_freq.csv")

library(ggpubr)
ggdotchart(genes[1:30,], x="Gene_symbol", y="Freq",
            #color="Freq",
            sorting="descending",
            add="segments",
            ggtheme=theme_minimal(),
            rotate=T,
            title="search (CTCF) OR (chromatin loop) NOT (r-loop) on PubMed",
            yscale = "log2",
            xlab = "Gene Symbol", ylab = "log2 Freq.",
            caption = "out of 3504 results",
            font.x = c(11, "black"),font.y = c(11, "black"))
ggsave(filename = "gene_freq.png")


