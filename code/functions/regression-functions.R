#Description: computes the residuals squares given a regression model
#Expected Input: a regression model produced using lm()
#Expected Output: Sum of residuals squared, a double
residual_sum_squares <- function(x){
	sum(x$residuals^2)
}

#Description: computes the total sum squared given a regression model
#Expected Input: a regression model produced using lm()
#Expected Output: Total sum squared: Sum of (Y-Ybar)^2, a double
total_sum_squares <- function(x){

	sum(((x$model[[1]])-mean(x$model[[1]]))^2)

}

#Description: computes R^2 given a regression model
#Expected Input: a regression model produced using lm()
#Expected Output: R squared value for the regression model
r_squared <- function(x){

	1-(residual_sum_squares(x)/total_sum_squares(x))

}

#Description: computes F-statistics given a regression model
#Expected Input: a regression model produced using lm()
#Expected Output: F-statistic of the regression model, a double
f_statistic <- function(x){

	TSS <- total_sum_squares(x)
	RSS <- residual_sum_squares(x)
	p <- length(coefficients(x)) - 1
	n <- length(x$fitted.value)

	f <- ((TSS-RSS)/p)/(RSS/(n - p - 1))
	f
}

#Description: computes residual standard error given a regression model
#Expected Input: a regression model produced using lm()
#Expected Output: residuals standard error, a double
residual_std_error <- function(x){

	RSS <- residual_sum_squares(x)
	n <- length(x$fitted.value)
	p <- length(coefficients(x)) - 1
	rse <- sqrt(RSS/(n-p-1))

	rse
}