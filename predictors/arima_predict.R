library(forecast)
pred_arima <- function(a) {
   res <- forecast(Arima(a, order = c(0,1,1),include.drift=TRUE),h=1)$mean[1]
   res
}
