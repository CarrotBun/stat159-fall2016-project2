credit_df <- read.csv("../../data/Credit.csv")

# dummy out categorical variables 
temp_credit <- model.matrix(Balance ~ ., data = credit_df)

# removing column of ones, and appending regressors to Balance
new_credit_df <- cbind(temp_credit[ ,-1], Balance = credit_df$Balance)

# scaling and centering
scaled_credit <- scale(new_credit_df, center = TRUE, scale = TRUE)

# export scaled data
write.csv(scaled_credit, file = "../../data/scaled-credit.csv")
