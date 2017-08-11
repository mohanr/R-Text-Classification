library(dplyr)
setwd("D:/eclipse/workspace/Text Classification")

data <- read.csv("20_newsgroups.csv",fill=TRUE,as.is=T,header=F, quote="", sep=",", encoding="UTF-8")
munged <- data[, unlist(lapply(data, function(x) !all(is.na(x))))]
munged <- munged[-1,]
munged$text <- apply( munged[ , c(3:ncol(munged)) ] , 1 , paste0 , collapse = " ")

munged <- munged[,c("V1","V2","text")]

print(head(munged$text))
