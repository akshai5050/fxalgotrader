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



add_hours:{[ts;hours_to_add]
	:`timestamp$ts+8.64e13 * hours_to_add%24}
