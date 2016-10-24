library(ggplot2)
library(dplyr)


source("code/functions/eda-functions.R")
credit <- read.csv("data/Credit.csv")

# Subset by variable type
quant_credit <- credit[,c(2:7,12)]
cat_credit <- credit[,c(8:11)]

# Creating Upper Triangular Correlation Matrix
corr_matrix <- round(quant_credit,4)
lower <- corr_matrix
lower[lower.tri(corr_matrix, diag =FALSE)] <- ""
lower <- data.frame(lower)


#Save Data to eda-output
sink("data/eda-output.txt")

cat("Summary of Quantiative Variables in Credit:\n")
t(apply(quant_credit,2,getSummary))

cat("Frequency and Relative Frequency:\n")
getFreq(cat_credit)

cat("\n Correlation Matrix:\n")
lower

cat("\n anova output for Balance and Qualitative variables:\n")
aov(Balance~Gender + Student + Married + Ethnicity, credit)
sink()

# Create plots
ggplot(credit) + geom_histogram(aes(Income))
ggsave("images/histogram-Income.png")

ggplot(credit) + geom_histogram(aes(Limit))
ggsave("images/histogram-Limit.png")

ggplot(credit) + geom_histogram(aes(Rating))
ggsave("images/histogram-Rating.png")

ggplot(credit) + geom_histogram(aes(Cards))
ggsave("images/histogram-Cards.png")

ggplot(credit) + geom_histogram(aes(Age))
ggsave("images/histogram-age.png")

ggplot(credit) + geom_histogram(aes(Education))
ggsave("images/histogram-education.png")

ggplot(credit) + geom_histogram(aes(Balance))
ggsave("images/histogram-balance.png")

ggplot(credit, aes(x= Gender, y = Balance))+ geom_boxplot()
ggsave("images/boxplot-Gender.png")

ggplot(credit, aes(x= Married, y = Balance))+ geom_boxplot()
ggsave("images/boxplot-Married.png")

ggplot(credit, aes(x= Student, y = Balance))+ geom_boxplot()
ggsave("images/boxplot-Student.png")

ggplot(credit, aes(x= Ethnicity, y = Balance))+ geom_boxplot()
ggsave("images/boxplot-Ethnicity.png")

png(filename="images/scatterplot-matrix.png")
pairs(quant_credit,pch=18)
dev.off()

save(lower, file = "data/correlation-matrix.RData")

