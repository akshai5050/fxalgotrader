require(quantmod) #for Lag()
require(nnet)
require(caret)
require(RSNNS)

build_nnet <- function(splitRatio)
{
	if (checkPatternsRatio(splitRatio)) {
		g<- data.frame(patterns$inputsTrain)
		g$y <- patterns$targetsTrain

		#Fit model
		model <- train(y ~ x1 + x2 + x3 + x4 + x5, data = g, method='nnet', linout=TRUE, trace = TRUE,
		               #Grid of tuning parameters to try:
		               tuneGrid=expand.grid(.size=c(1,5,10),.decay=c(0,0.001,0.1))) 

		ps <- predict(model, patterns$inputsTest)

		#Examine results
		plot(patterns$targetsTest, type = "l")
		lines(ps, col=2)

		x <- data.frame(actual=patterns$targetsTest, pred=ps)

		return(summary(lm(actual ~ pred, x))$r.squared)
	}
	
}

convertInputsToTrainingAndTest <- function(splitRatio)
{
	dat = read.csv("/Users/shaha1/repo/fxalgotrader/predictors/predictor_csvs/joined_15.csv", header = TRUE)
	ma5 <- dat[,c("c")];

	inputs <- data.frame(Lag(ma5,5), Lag(ma5,4), Lag(ma5,3), Lag(ma5,2), Lag(ma5))
	names(inputs) <- c("x1", "x2", "x3", "x4", "x5")
	outputs <- ma5

	return(splitForTrainingAndTest(inputs,outputs, ratio=splitRatio))
}

checkPatternsRatio <- function(splitRatio)
{
	patterns <<- convertInputsToTrainingAndTest(splitRatio)
	ratio <- round(length(patterns$inputsTest)/(length(patterns$inputsTest)+length(patterns$inputsTrain)),2)
	return(ratio==splitRatio)
}