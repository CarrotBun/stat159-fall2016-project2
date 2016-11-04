library(pls)
set.seed(159)

# Load Data and T-T indicies
source("code/scripts/Train-Test.R")
credit = read.csv("data/scaled-credit.csv")

x = model.matrix(Balance ~ .,data = credit)[,-1]
y = credit$Balance
y.test = y[test_set_indices]

# Run PCR and Cross Validation
pcr_reg <- pcr(Balance ~ ., data= credit, validation = "CV")
pcr_train <- pcr(Balance ~ ., data=credit, subset = train_set_indices,
	scale =TRUE, validation = "CV")

# Best lambda/model
bestmodel = which.min(pcr_train$validation$PRESS)

# Validation plot
png(filename="images/reg-plots/pcr-validation.png")
validationplot(pcr_train, val.type = "MSEP")
dev.off()

###### prediction plot ################################################################### 
png("images/reg-plots/pcr-prediction-plot.png")
plot(predict(pcr_reg, x[test_set_indices,], ncomp = bestmodel), 
     type = "l", col = "red",main = "PCR Predicted and Actual Credit Balances", 
     ylab = "Normalized Credit Balance")

lines(y.test, col = "black")

legend(0, 3, legend = c("Predicted", "Actual"), fill = c("red", "black"), bty = "n")
dev.off()
##########################################################################################


# Apply best model to test set
pcr_pred <- predict(pcr_train, x[test_set_indices,],ncomp=bestmodel)
pcr_tMSE <- mean((pcr_pred-y.test)^2)

#Full Model
pcr_final <- pcr(Balance ~ ., data= credit, scale =TRUE, ncomp = bestmodel)


# output primary results
sink("data/pcr-results.txt")

cat("Best Model:\n")
bestmodel
cat("\n Test MSE:\n")
pcr_tMSE
cat("\n Official Model and Coefficients:\n")
summary(pcr_final)
cat("\n")
coefficients(pcr_final)

sink()

save(pcr_reg, bestmodel,pcr_tMSE,pcr_final, file ="data/PCR-Regression.RData")

