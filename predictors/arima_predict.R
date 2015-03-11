library(forecast)
library(lm.beta)
library(ggplot2)
library("ggthemes")

pred_arima <- function(a) {
   res <- forecast(auto.arima(a),h=1)$mean[1]*1.002
   res
}	

get_final_prediction <- function(arima_predictions,nnet_predictions,svr_predictions,actual) {
  df <- data.frame(nnet_predictions, arima_predictions, svr_predictions, actual)
  
  latest_predictions <- as.vector(tail(df,1), mode='numeric')

  current_actual <- tail(latest_predictions,n=1)
  
  latest_predictions <- head(latest_predictions,-1)
  
  df <- head(df,-1)

  print(df)
  
  res <- lm(actual ~ -1 + nnet_predictions + arima_predictions + svr_predictions, df)
  
  gg <- lm.beta(res)
  
  x <- as.matrix(gg$coefficients)

  combined <- (x[1] * df$nnet_predictions) + (x[2] * df$arima_predictions) + (x[3] * df$svr_predictions)
  print(qplot(combined, df$actual, colour=I("red"), size=I(5)) + theme_solarized(light=FALSE) + scale_colour_economist() + geom_point(aes(crossprod(x, latest_predictions)[1],current_actual), colour="blue", size=5) + geom_abline(colour="green"))

  crossprod(x,latest_predictions)[1]
}



check_confidence_interval <- function(actual, predictions, current_actual, current_predicted) {


	df <- data.frame(actual,predictions)

	newdata <- data.frame(actual=current_actual)

	model <- lm(predictions ~ actual, df)

	confidence_interval <- predict(model, newdata, interval="predict") 

	if (current_predicted <= confidence_interval[,"upr"] && current_predicted >= confidence_interval[,"lwr"]) {
	  1
	} else {
	  0
	}
}