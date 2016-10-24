library(glmnet)

credit = read.csv("data/scaled-credit.csv")

x = model.matrix(Balance ~ .,data = credit)[,-1] 
y = credit$Balance

grid = 10^seq(10, -2, length = 100)
ridge.mod = glmnet(x, y, alpha = 0, lambda = grid)

source("code/scripts/Train-Test.R")

y.test = y[test_set_indices]


ridge.mod = glmnet(x[train_set_indices,],y[train_set_indices], alpha = 0,lambda = grid,thresh = 1e-12)

ridge.pred=predict(ridge.mod, s = 2, newx = x[test_set_indices,])

mean((ridge.pred-y.test)^2)


ridge.pred=predict(ridge.mod,s=0,newx=x[test_set_indices,],exact=T)
mean((ridge.pred-y.test)^2)


#set.seed(159)
cv.out=cv.glmnet(x[train_set_indices ,],y[train_set_indices],alpha =0)
plot(cv.out)
bestlam=cv.out$lambda.min
bestlam

ridge.pred=predict(ridge.mod,s=bestlam,newx=x[test_set_indices ,])
mean((ridge.pred-y.test)^2)


out=glmnet(x,y,alpha=0)
predict(out,type="coefficients",s=bestlam)

