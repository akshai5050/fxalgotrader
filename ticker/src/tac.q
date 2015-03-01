\l /Users/shaha1/repo/fxalgotrader/ticker/src/q_to_r.q
Rcmd "source(\"/Users/shaha1/repo/fxalgotrader/predictors/arima_predict.r\")";

capital:1000;
current_actual:0;
base_currency:1;

capital_confidence:1000;
base_currency_confidence:1;

lis:(`dt`pre!()();`dt`pre!()());
lisSvr:(`dt`pre!()();`dt`pre!()());


tac:{[]
	ita[];
	tanalysis[]
	}

ita:{[]
	d:last cdata[`start_dt];
	`ma5 insert (d;0n);
	`ma10 insert (d;0n);
	`ma20 insert (d;0n);
	`closing insert (d;0n);
	/ `nnet_predictions insert (add_hours[d;0.5];0n;0n);
	}

tanalysis:{	
	closingprice[];
	}

wema:{((x-1)#0n),i,{z+x*y}\[i:avg x#y;1-a;(x _y)*a:2%1+x]}

emavg:{[m1t]
	manum::`$ "" sv("ma"; string(m1t));
	if[(count cdata) >= m1t +1;
		m1:last wema[m1t;cdata[`c]];
		c:enlist(=;`dt;last cdata[`start_dt]);
		a:(enlist `ma)!(enlist m1);
		update ma:m1 from manum where dt=last cdata[`start_dt];
		/ if[m1t=5; add_to_predict_window[last ma5]];
		/ if[m1t=5;[predicted:nnet_predict[last cdata[`c];m1]; update predictions:predicted from `nnet_predictions where dt=add_hours[last cdata[`start_dt];0.5]]]
		]} 

closingprice:{
	close:last cdata[`c];
	update c:close from `closing where dt=last cdata[`start_dt];
	add_to_predict_window[last closing]}

ma:([] dt:(); ma:());
ma5:([] dt:(); ma:());
ma10:([] dt:(); ma:());
ma20:([] dt:(); ma:());
closing:([] dt:(); c:());
manum:0;
nnet_predictions:([] dt:(); actual:(); predictions:());
svr_predictions:([] dt:(); actual:(); predictions:());
arima_predictions:([] dt:(); actual:(); predictions:());
final_predictions:([] dt:(); actual:(); predictions:());

sliding_window:([] dt:(); v1:(); v2:(); v3:(); v4:(); v5:())

predict1:`dt`pre!();();

predict:{
	inputs:x;
	predicted: nnet_predict[inputs];
	:predicted}

predictSvr:{
	inputs:x;
	predicted: svr_predict[inputs];
	:predicted}

predictArima:{
	inputs:x;
	predicted: arima_predict[inputs];
	:predicted}


add_to_predict_window:{
	val:x[`c];
	$[(count lis[0;`pre]) < 5; lis[0;`pre],::val;[lis[0;`dt]:x[`dt];`nnet_predictions insert (x[`dt]; val; predict[lis[0;`pre]]);`svr_predictions insert (x[`dt]; val; predictSvr[lis[0;`pre]]);`arima_predictions insert (x[`dt]; val; predictArima[lis[0;`pre]]);`final_predictions insert (x[`dt]; val; combined_predict[-20#arima_predictions[`predictions];-20#nnet_predictions[`predictions];-20#svr_predictions[`predictions];-20#arima_predictions[`actual]]);lis[1;`pre]::1_lis[0;`pre];lis::1_lis;lis,::(`dt`pre)!()();lis[0;`pre],::val;publish_nnet_web[];publish_svr_web[];publish_arima_web[];publish_final_web[];if[(count final_predictions)>=21;tradingStrategy[]];publish_nnet_errors_web[x[`dt]]]]}

tradingStrategy:{
	records:-2#final_predictions;
	predicted:last records[`predictions];
	current_actual:last records[`actual];
	actual: first records[`actual];
	$[predicted>actual;`predictedbigger;`predictedsmaller];
	trade[predicted;actual;current_actual];
	
	data:select from final_predictions where i within((count final_predictions)-21;(count final_predictions)-2);
	confidence:confidence_interval[data[`actual];data[`predictions];last final_predictions[`actual];last final_predictions[`predictions]]}
	/ trade_confidence[predicted;actual;current_actual;confidence]}

new:{
	data:select from final_predictions where i within((count final_predictions)-21;(count final_predictions)-2);
	confidence:confidence_interval[data[`actual];data[`predictions];last final_predictions[`actual];last final_predictions[`predictions]]}

trade:{[predicted;actual;current_actual]
	if[(predicted>actual)&not base_currency;capital::(1%current_actual)*capital;base_currency::1]
	if[(predicted<actual)&base_currency;capital::current_actual*capital;base_currency::0]}

trade_confidence:{[predicted;actual;current_actual;confidence]
	confidence:"i"$confidence;
	if[(predicted>actual)&not base_currency_confidence&confidence;capital_confidence::(1%current_actual)*capital_confidence;base_currency_confidence::1]
	if[(predicted<actual)&base_currency_confidence&confidence;capital_confidence::current_actual*capital_confidence;base_currency_confidence::0]}

publish_nnet_web:{
	web_entry:select dt: ts_to_unix[dt], actual, predictions from last nnet_predictions;
		sendData\:[Sub `web; (`table`type`data)!(`nnet_predictions;type web_entry; web_entry)]}


publish_svr_web:{
	web_entry:select dt: ts_to_unix[dt], actual, predictions from last svr_predictions;
		sendData\:[Sub `web; (`table`type`data)!(`svr_predictions;type web_entry; web_entry)]}

publish_arima_web:{
	web_entry:select dt: ts_to_unix[dt], actual, predictions from last arima_predictions;
		sendData\:[Sub `web; (`table`type`data)!(`arima_predictions;type web_entry; web_entry)]}

publish_final_web:{
	web_entry:select dt: ts_to_unix[dt], actual, predictions from last final_predictions;
		sendData\:[Sub `web; (`table`type`data)!(`final_predictions;type web_entry; web_entry)]}

publish_nnet_errors_web:{
	web_entry:enlist `rmse`mape! nnet_rmse[][0],nnet_rmse[][1];
		sendData\:[Sub `web; (`table`type`data)!(`nnet_errors;type web_entry; web_entry)]}