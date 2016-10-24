source("../functions/eda-functions.R")

context("Test for getSummary") 

test_that("getSummary works as expected", {
	x= c(1,2,3)
  expect_length(getSummary(x), 9)
  expect_type(getSummary(x), 'double')
  expect_equal(getSummary(x)[[3]],2)
  expect_equal(getSummary(x)[[7]],1)
})

context("Test for getFreq") 

test_that("getFreq works as expected", {
	x= data.frame(c(1,2),c(1,1))
  expect_null(getFreq(x))
})