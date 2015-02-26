#Load Packages
require(quantmod) #for Lag()
require(nnet)
require(caret)
require(RSNNS)

dat = read.csv("/tmp/joined_15.csv", header = TRUE)
ma5 <- dat[,c("c")];

inputs <- data.frame(Lag(ma5,5), Lag(ma5,4), Lag(ma5,3), Lag(ma5,2), Lag(ma5))
names(inputs) <- c("x1", "x2", "x3", "x4", "x5")
outputs <- ma5
#Make toy dataset
patterns <- splitForTrainingAndTest(inputs,outputs, ratio=0.5)

g<- data.frame(patterns$inputsTrain)
g$y <- patterns$targetsTrain

#Fit model
modelSvr <- train(y ~ x1 + x2 + x3 + x4 + x5, data = g, method='svmPoly', linout=TRUE, trace = TRUE) 
ps <- predict(modelSvr, patterns$inputsTest)

#Examine results
plot(patterns$targetsTest, type = "l")
lines(ps, col=2)

x <- data.frame(actual=patterns$targetsTest, pred=ps)

print(summary(lm(actual ~ pred, x))$r.squared)

pred <- function(a) {
  df <- as.data.frame(rbind(c(a)))
  print(df)
  names (df) <- c("x1", "x2", "x3", "x4", "x5")
  res <- predict(modelSvr, df)[1]
  res
}

a <- c(1,2,3,4,5)

print(pred(a))
save(file = "~/repo/fxalgotrader/predictors/15_Min_SVR_Model.RData", modelSvr)

