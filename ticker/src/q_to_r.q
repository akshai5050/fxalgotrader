\l /Users/shaha1/q/demo.q
nnet_predict:{
	previous_ma: x;
	Rset ["x";previous_ma];
	a:Rget "pred(x)";
	:a[0]}

svr_predict:{
	previous_ma: x;
	Rset ["x";previous_ma];
	a:Rget "pred_svr(x)";
	:a[0]}


arima_predict:{
	previous_ma: x;
	Rset ["x";previous_ma];
	a:Rget "pred_arima(x)";
	:a[0]}


combined_predict:{[arima;nnet;svr;actual]
	Rset ["arima_predictions"; arima];
	Rset ["nnet_predictions"; nnet];
	Rset ["svr_predictions"; svr];
	Rset ["actual"; actual];
	a: Rget "get_final_prediction(arima_predictions,nnet_predictions,svr_predictions,actual)";
	:a[0]}

confidence_interval:{[actuals;predictionss;current_actuals;current_predicteds]
	Rset ["actual"; actuals];
	Rset ["predictions"; predictionss];
	Rset ["current_actual"; current_actuals];
	Rset ["current_predicted"; current_predicteds];
	a: Rget "check_confidence_interval(actual, predictions, current_actual, current_predicted)";
	:a[0]}

arima_rmse:{
	mape:(avg(abs[(arima_predictions[`actual])-(arima_predictions[`predictions])]%(arima_predictions[`actual]))*100)*4;
	:mape}

conf_calculate:{[current_actual;predicted]
	sd:sqrt[(1%((count final_predictions)-1))*(sum((final_predictions[`actual]-final_predictions[`predictions]) xexp 2))];
	x_bar:avg((final_predictions[`actual]-final_predictions[`predictions])%final_predictions[`actual]);
	conf_interval_lower:x_bar - (1.96 * sd%sqrt[count final_predictions]);
	conf_interval_upper:x_bar + (1.96 * sd%sqrt[count final_predictions]);
	current_error:(current_actual-predicted)%current_actual;
	:$[(current_error <= conf_interval_upper) & (current_error >= conf_interval_lower);1;0]}


nnet_rmse:{
	mape:avg(abs[(nnet_predictions[`actual])-(nnet_predictions[`predictions])]%(nnet_predictions[`actual]))*100;
	:mape}

svr_rmse:{
	mape:avg(abs[(svr_predictions[`actual])-(svr_predictions[`predictions])]%(svr_predictions[`actual]))*100;
	:mape}

combined_rmse:{
	mape:avg(abs[(final_predictions[`actual])-(final_predictions[`predictions])]%(final_predictions[`actual]))*100;
	:mape}


add_hours:{[ts;hours_to_add]
	:`timestamp$ts+8.64e13 * hours_to_add%24}
