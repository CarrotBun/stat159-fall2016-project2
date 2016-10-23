# set seed for sampling
set.seed(159)

# training set
train_set_indices = as.vector(sample(1:400, size = 300, replace = FALSE))

# testing set
test_set_indices = as.vector(setdiff(1:400, train_set_indices))
