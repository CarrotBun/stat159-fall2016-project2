# multiple regression
reg <- lm(mpg ~ disp + hp, data = mtcars)
# summary of 'reg'
regsum <- summary(reg)

source("../functions/regression-functions.R")

# context with one test that groups expectations
context("Test for Residual Sum Squares") 

test_that("RSS works as expected", {
  expect_length(residual_sum_squares(reg), 1)
  expect_type(residual_sum_squares(reg), 'double')
  expect_equal(residual_sum_squares(reg), sum(reg$residuals^2))
})


context("Test for Total Sum Squares") 

test_that("TSS works as expected", {
  expect_length(total_sum_squares(reg), 1)
  expect_type(total_sum_squares(reg), 'double')
  expect_equal(total_sum_squares(reg), sum((mtcars$mpg - mean(mtcars$mpg))^2))
})


context("Test for Residual Standard Error") 

test_that("RSE works as expected", {
  expect_length(residual_std_error(reg), 1)
  expect_type(residual_std_error(reg), 'double')
  expect_equal(residual_std_error(reg), regsum$sigma)
})


context("Test for R-Squared") 

test_that("R Squared works as expected", {
  expect_length(r_squared(reg), 1)
  expect_type(r_squared(reg), 'double')
  expect_equal(r_squared(reg), regsum$r.squared)

})


context("Test for F-stat") 

test_that("F-stat works as expected", {
  expect_length(f_statistic(reg), 1)
  expect_type(f_statistic(reg), 'double')
  expect_equal(f_statistic(reg), regsum$fstatistic[[1]])

})




