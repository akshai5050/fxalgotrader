library(forecast)
library(lm.beta)
pred_arima <- function(a) {
   res <- forecast(auto.arima(a),h=1)$mean[1]
   print(a)
   res
}	

get_final_prediction <- function(arima_predictions,nnet_predictions,svr_predictions,actual) {
  df <- data.frame(nnet_predictions, arima_predictions, svr_predictions, actual)
  
  latest_predictions <- as.vector(tail(df,1), mode='numeric')
  
  latest_predictions <- head(latest_predictions,-1)
  
  df <- head(df,-1)
  
  res <- lm(actual ~ -1 + nnet_predictions + arima_predictions + svr_predictions, df)
  
  gg <- lm.beta(res)
  
  x <- as.matrix(gg$coefficients)
  
  crossprod(x,latest_predictions)[1]
}
