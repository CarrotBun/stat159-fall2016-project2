
# import data
credit = read.csv("data/scaled-credit.csv")

# OLS regression
OLS_reg = lm(Balance ~., data = credit)

# table summary
library(pander)
sink("data/ols-results.txt")
pander(OLS_reg)
sink()

save(OLS_reg, file ="data/OLS-Regression.RData")

