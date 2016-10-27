
# import data
credit = read.csv("data/scaled-credit.csv")
source("code/functions/regression-functions.R")

# OLS regression
OLS_reg = lm(Balance ~., data = credit)

OLS_tMSE = sqrt(residual_std_error(OLS_reg))

# table summary
library(pander)
sink("data/ols-results.txt")
cat("MSE:\n")
OLS_tMSE
cat("\n Official Coefficients:\n")
pander(OLS_reg)
sink()

save(OLS_reg, OLS_tMSE, file ="data/OLS-Regression.RData")

