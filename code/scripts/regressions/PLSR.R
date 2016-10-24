# partial least squares regression
library(pls)

# import csv
credit = read.csv("data/scaled-credit.csv")

# import indices
source("code/scripts/Train-Test.R")

# set seed
set.seed(159)

pls_reg = plsr(as.vector(credit[train_set_indices, 12]) ~ as.matrix(credit[train_set_indices, 1:11]), 
validation = "CV")

#best model
library(pander)
mse_plsr = min(pls_reg$validation$PRESS)
pls_reg$validation$PRESS
# 7 comps

# plot CV errors MSEP
png("images/plsr-mse-plot.png")
validationplot(pls_reg, val.type = "MSEP", main = "PLSR Cross Validated Error")
abline(v = 7, lty = 2)
dev.off()

# prediction plot
test_pls_reg = plsr(as.vector(credit[test_set_indices, 12]) ~ as.matrix(credit[test_set_indices, 1:11]), 
               ncomp = 7)
MSEP(test_pls_reg)
test_mse_plsr = 0.05045 

# prediction on full data set
plsr_pred = plsr(as.vector(credit[ ,12]) ~ as.matrix(credit[ ,1:11]),
                      ncomp = 7)

# save regressions
save(pls_reg, test_pls_reg, plsr_pred,file = "data/pls-regression.RData")

