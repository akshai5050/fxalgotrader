load("/Users/shaha1/repo/fxalgotrader/predictors/15_Min_Nnet_Model.RData")

pred <- function(a) {
   df <- as.data.frame(rbind(c(a)))
   print(df)
   names (df) <- c("x1", "x2", "x3", "x4", "x5")
   res <- predict(model, df)[1]
   res
}
