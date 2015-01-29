\l /Users/shaha1/repo/fxalgotrader/ticker/src/q_to_r.q

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
	/ `nnet_predictions insert (add_hours[d;0.5];0n;0n);
	}

tanalysis:{
	emavg[5];
	emavg[10];
	emavg[20];
	}

wema:{((x-1)#0n),i,{z+x*y}\[i:avg x#y;1-a;(x _y)*a:2%1+x]}

emavg:{[m1t]
	manum::`$ "" sv("ma"; string(m1t));
	if[(count cdata) >= m1t +1;
		m1:last wema[m1t;cdata[`c]];
		c:enlist(=;`dt;last cdata[`start_dt]);
		a:(enlist `ma)!(enlist m1);
		update ma:m1 from manum where dt=last cdata[`start_dt];
		if[m1t=5; add_to_predict_window[last ma5]];
		/ if[m1t=5;[predicted:nnet_predict[last cdata[`c];m1]; update predictions:predicted from `nnet_predictions where dt=add_hours[last cdata[`start_dt];0.5]]]
		]} 


ma:([] dt:(); ma:());
ma5:([] dt:(); ma:());
ma10:([] dt:(); ma:());
ma20:([] dt:(); ma:());
manum:0;
nnet_predictions:([] dt:(); actual:(); predictions:());
svr_predictions:([] dt:(); actual:(); predictions:());

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


add_to_predict_window:{
	val:x[`ma];
	$[(count lis[0;`pre]) < 5; lis[0;`pre],::val;[lis[0;`dt]:x[`dt];`nnet_predictions insert (x[`dt]; val; predict[lis[0;`pre]]);`svr_predictions insert (x[`dt]; val; predictSvr[lis[0;`pre]]);lis[1;`pre]::1_lis[0;`pre];lis::1_lis;lis,::(`dt`pre)!()();lis[0;`pre],::val;publish_nnet_web[];publish_svr_web[]]]}


publish_nnet_web:{
	web_entry:select dt: ts_to_unix[dt], actual, predictions from last nnet_predictions;
		sendData\:[Sub `web; (`table`type`data)!(`nnet_predictions;type web_entry; web_entry)]}


publish_svr_web:{
	web_entry:select dt: ts_to_unix[dt], actual, predictions from last svr_predictions;
		sendData\:[Sub `web; (`table`type`data)!(`svr_predictions;type web_entry; web_entry)]}