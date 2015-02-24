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

arima_rmse:{
	rmse:sqrt((sum (arima_predictions[`actual]-arima_predictions[`predictions]) xexp 2)%count arima_predictions[`actual]);
	mape:avg(abs[arima_predictions[`actual]-arima_predictions[`predictions]]%arima_predictions[`actual])*100;
	:rmse, mape}


nnet_rmse:{
	rmse:sqrt((sum (nnet_predictions[`actual]-nnet_predictions[`predictions]) xexp 2)%count nnet_predictions[`actual]);
	mape:avg(abs[nnet_predictions[`actual]-nnet_predictions[`predictions]]%nnet_predictions[`actual])*100;
	:rmse, mape}

svr_rmse:{
	rmse:sqrt((sum (svr_predictions[`actual]-svr_predictions[`predictions]) xexp 2)%count svr_predictions[`actual]);
	mape:avg(abs[svr_predictions[`actual]-svr_predictions[`predictions]]%svr_predictions[`actual])*100;
	:rmse, mape}

combined_rmse:{
	rmse:sqrt((sum (final_predictions[`actual]-final_predictions[`predictions]) xexp 2)%count final_predictions[`actual]);
	mape:avg(abs[final_predictions[`actual]-final_predictions[`predictions]]%final_predictions[`actual])*100;
	:rmse, mape}


add_hours:{[ts;hours_to_add]
	:`timestamp$ts+8.64e13 * hours_to_add%24}
