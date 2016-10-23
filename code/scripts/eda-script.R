library(ggplot2)
library(dplyr)


source("code/functions/eda-functions.R")
credit <- read.csv("data/Credit.csv")

quant_credit <- credit[,c(2:7,12)]
cat_credit <- credit[,c(8:11)]




corr_matrix <- round(quant_credit,4)
lower <- corr_matrix
lower[lower.tri(corr_matrix, diag =FALSE)] <- ""
lower <- data.frame(lower)



sink("data/eda-output.txt")

cat("Summary of Quantiative Variables in Credit:\n")
t(apply(quant_credit,2,getSummary))

cat("Frequency and Relative Frequency:\n")
getFreq(cat_credit)

cat("\n Correlation Matrix:\n")
lower
sink()

ggplot(ad_data) + geom_histogram(aes(TV))
ggsave("images/histogram-tv.png")

ggplot(ad_data) + geom_histogram(aes(Radio))
ggsave("images/histogram-radio.png")

ggplot(ad_data) + geom_histogram(aes(Newspaper))
ggsave("images/histogram-newspaper.png")

ggplot(ad_data) + geom_histogram(aes(Sales))
ggsave("images/histogram-sales.png")

png(filename="images/scatterplot-matrix.png")
pairs(ad_data[-1],pch=18)
dev.off()

save(lower, file = "data/correlation-matrix.RData")
