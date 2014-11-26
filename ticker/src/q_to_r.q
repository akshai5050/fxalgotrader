\l /Users/shaha1/q/demo.q
Rcmd "source(\"/Users/shaha1/repo/fxalgotrader/predictors/net_predict.r\")";
nnet_predict:{
	previous_ma: x;
	Rset ["x";previous_ma];
	a:Rget "pred(x)";
	:a[0]}


add_hours:{[ts;hours_to_add]
	:`timestamp$ts+8.64e13 * hours_to_add%24}
