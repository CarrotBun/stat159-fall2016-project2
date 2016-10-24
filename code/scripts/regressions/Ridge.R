library(glmnet)

# Load Data and T-T indicies
source("code/scripts/Train-Test.R")

credit = read.csv("data/scaled-credit.csv")

x = model.matrix(Balance ~ .,data = credit) 
y = credit$Balance
y.test = y[test_set_indices]

grid = 10^seq(10, -2, length = 100)

# Run ridge regression on training set
ridge_reg = glmnet(x[train_set_indices,],y[train_set_indices], 
	alpha = 0,lambda = grid)

# Cross Validation, set seed to make work reproducible
set.seed(159)
ridge_cv = cv.glmnet(x[train_set_indices ,],y[train_set_indices], alpha =0, nfold = 10, lambda = grid, intercept =FALSE,standardize = FALSE)

# Best lambda/model
bestlam=ridge_cv$lambda.min

# Validation plot
png(filename="images/ridge-validation.png")
plot(ridge_cv)
dev.off()

# Apply best model to test set
ridge_pred = predict(ridge_reg,s=bestlam,newx=x[test_set_indices,])
ridge_tMSE <- mean((ridge_pred-y.test)^2)

#Full Model
out=glmnet(x,y,alpha=0)
ridge_final <- predict(out,type="coefficients",s=bestlam)


# output primary results
sink("data/ridge-results.txt")

cat("Best Lambda:\n")
bestlam
cat("\n Test MSE:\n")
testMSE
cat("\n Official Coefficients:\n")
ridge_final

sink()

save(ridge_cv, bestlam,ridge_tMSE,ridge_final, file ="data/Ridge-Regression.RData")
