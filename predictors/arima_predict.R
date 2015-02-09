library(forecast)
pred_arima <- function(a) {
   res <- forecast(Arima(a, order = c(0,1,1),include.drift=TRUE),h=1)$mean[1]
   res
}	

get_final_prediction <- function(arima,nnet,svr,actual) {
	df_arima <- data.frame(arima, actual);
	df_nnet <- data.frame(nnet, actual);
	df_svr <- data.frame(svr, actual);

	names(df_arima) <- c("x", "y")
	names(df_nnet) <- c("x", "y")
	names(df_svr) <- c("x", "y")

	arima_pred <- tail(df_arima, 1)
	nnet_pred <- tail(df_nnet, 1)
	svr_pred <- tail(df_svr, 1)

	df_arima <- head(df_arima, -1)
	df_nnet <- head(df_nnet, -1)
	df_svr <- head(df_svr, -1)

	arima_intercept <- lm(y ~x, df_arima)$coefficients[[1]]
	nnet_intercept <- lm(y ~x, df_nnet)$coefficients[[1]]
	svr_intercept <- lm(y ~x, df_svr)$coefficients[[1]]

	arima_coeff <- lm(y ~x, df_arima)$coefficients[[2]]
	nnet_coeff <- lm(y ~x, df_nnet)$coefficients[[2]]
	svr_coeff <- lm(y ~x, df_svr)$coefficients[[2]]

	((arima_intercept + arima_coeff * arima_pred$x) + (nnet_intercept + nnet_coeff * nnet_pred$x) + (svr_intercept + svr_coeff * svr_pred$x))/3

}
