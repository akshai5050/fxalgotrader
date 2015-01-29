load("/Users/shaha1/repo/fxalgotrader/predictors/15_Min_SVR_Model.RData")

pred_svr <- function(a) {
   df <- as.data.frame(rbind(c(a)))
   print(df)
   names (df) <- c("x1", "x2", "x3", "x4", "x5")
   res <- predict(model, df)[1]
   res
}
