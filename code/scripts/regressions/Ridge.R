library(glmnet)

source("code/scripts/Train-Test.R")

credit = read.csv("data/scaled-credit.csv")

x = model.matrix(Balance ~ .,data = credit) 
y = credit$Balance
y.test = y[test_set_indices]

grid = 10^seq(10, -2, length = 100)


ridge_reg = glmnet(x[train_set_indices,],y[train_set_indices], 
	alpha = 0,lambda = grid)
set.seed(159)
ridge_cv = cv.glmnet(x[train_set_indices ,],y[train_set_indices], alpha =0, nfold = 10, lambda = grid, intercept =FALSE,standardize = FALSE)
bestlam=ridge_cv$lambda.min
bestlam

png(filename="images/ridge-validation.png")
plot(ridge_cv)
dev.off()


ridge_pred=predict(ridge_reg,s=bestlam,newx=x[test_set_indices,])
testMSE <- mean((ridge_pred-y.test)^2)


out=glmnet(x,y,alpha=0)
ridge_final <- predict(out,type="coefficients",s=bestlam)


# output primary results
sink("data/ridge-results.txt")

cat("Best Lambda:\n")
bestlam
cat("Official Coefficients:\n")
ridge_final
cat("Test MSE:\n")
testMSE

sink()

save(ridge_pred, ridge_cv, bestlam,testMSE,ridge_final, file ="data/Ridge-Regression.RData")

