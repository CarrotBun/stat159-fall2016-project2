
# import data
credit = read.csv("data/scaled-credit.csv")

# OLS regression
OLS_reg = lm(Balance ~., data = credit)

# table summary
library(pander)
pander(OLS_reg)
