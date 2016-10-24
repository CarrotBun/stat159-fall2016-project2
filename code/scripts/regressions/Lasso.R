# import csv
credit = read.csv("data/scaled-credit.csv")

# lasso regression
source("code/scripts/Train-Test.R")
library(glmnet)
grid <- 10^seq(10, -2, length = 100)
lasso_reg = cv.glmnet(as.matrix(credit[train_set_indices, 1:11]), 
                      as.vector(credit[train_set_indices, 12]), 
                      intercept = FALSE,
                      standardize = FALSE, 
                      lambda = grid)

lasso_reg_min_lambda = lasso_reg$lambda.min

png("images/lasso-lambda-plot.png")
plot(lasso_reg$lambda, ylab = "Lasso Lambda", main = "Lambda Grid")
abline(v = lasso_reg_min_lambda)
dev.off()

png("images/lasso-mse-plot.png")
plot(lasso_reg)
dev.off()


# prediction plot
png("images/lasso-prediction-plot.png")
plot(predict(lasso_reg, as.matrix(credit[test_set_indices, 1:11]), s = "lambda.min"), type = "l"
     , col = "red",main = "Predicted and Actual Credit Balances", 
     ylab = "Normalized Credit Balance")

lines(credit[test_set_indices, 12], col = "black")

legend(0, 3, legend = c("Predicted", "Actual"), fill = c("red", "black"), bty = "n")
dev.off()

# test MSE
test_lasso_reg = cv.glmnet(as.matrix(credit[test_set_indices, 1:11]), 
                           as.vector(credit[test_set_indices, 12]), 
                           intercept = FALSE,
                           standardize = FALSE, 
                           lambda = grid)

png("images/test-lasso-mse-plot.png")
plot(test_lasso_reg)
dev.off()

# refit model on full data set
lasso_pred_coef = predict(lasso_reg, as.matrix(credit[ , 1:11]), s = "lambda.min")

# saved to RData
save(lasso_reg, lasso_reg_min_lambda, test_lasso_reg, lasso_pred_coef,
     file = "data/lasso-regression.RData")



        