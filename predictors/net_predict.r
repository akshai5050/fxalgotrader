load("/Users/shaha1/repo/fxalgotrader/predictors/nnet_model.RData")

pred <- function(a) {
   df <- as.data.frame(rbind(c(a)))
   print(df)
   names (df) <- c("x1", "x2", "x3", "x4", "x5")
   res <- predict(model, df)[1]
   res
}
