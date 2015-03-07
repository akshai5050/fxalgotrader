\l /Users/shaha1/repo/fxalgotrader/ticker/src/tac.q
\l /Users/shaha1/repo/fxalgotrader/ticker/src/setup.q
Rcmd "source(\"/Users/shaha1/repo/fxalgotrader/predictors/net_predict_15.r\")";
Rcmd "source(\"/Users/shaha1/repo/fxalgotrader/predictors/svr_predict_15.r\")";

h: hopen `::5012
\p 4321
i:0;
cdata:([] start_dt:(); o:(); h:(); l:(); c:());
temp:([] date:(); sym:(); t:(); bid:(); offer:())
st:0;
ft:0;
c:0; / determine if start and end time has been set
web:0;
extracted_learning:0;

/subscribes to the chained tickerplant	
subscribe:{[] {h("sub";x)} `fx}
subscribe[];

sdata:{[data]
	i::0;
	i::data;
	set_times[data[`t][0]];
	if[ft>24:00;ft-::24:00;];
	if[st=24:00;st::00:00;];
	if[(("u"$data[`t][0]) < ft);
		`temp insert data;
		];
	if[("u"$data[`t][0]) >= ft;
		`cdata insert ((first temp[`date]) + st; first temp[`bid]; max temp[`bid]; min temp[`bid]; last temp[`bid]);
		tac[];
		get_train_data[];
		cleartable[`temp];
		`temp insert data;
		ft+::15;
		st+::15;
		web_entry:select dt: ts_to_unix[start_dt], o, h, l, c from last cdata;
		sendData\:[Sub `web; (`table`type`data)!(`cdata;type web_entry; web_entry)]]
	if[(("u"$data[`t][0]) = 00:00) & (ft=24:00);
		get_ohlc_data_for_day[first temp[`date]];
		get_trading_data_for_day[first temp[`date]];
		0N!first temp[`date];
		`cdata insert ((first temp[`date]) + st; first temp[`bid]; max temp[`bid]; min temp[`bid]; last temp[`bid]);
		tac[];
		get_train_data[];
		cleartable[`temp];
		`temp insert data;
		ft+::15;
		st+::15;
		web_entry:select dt: ts_to_unix[start_dt], o, h, l, c from last cdata;
		sendData\:[Sub `web; (`table`type`data)!(`cdata;type web_entry; web_entry)]]
	}

cleartable:{
	delete from x
	}

set_times:{[time]
	if[not c;
		st::"u"$time;
		ft::("u"$time) + 15;
		if[ft=24:00;ft::00:00];
		if[st=24:00;st::00:00];
		c::1]
	}

upd:{[ts;t]
	ts insert (t);
	sdata[t];
	}

.z.pc:{Sub[`web]: Sub[`web] except 1#x}



get_train_data:{
	if[not extracted_learning;
		cp: select dt:start_dt, c from cdata;
		joined: ej[`dt; cp;ma5];
		if[(last "d"$joined[`dt])=2012.03.01; `:/tmp/joined_15.csv 0: "," 0: joined; extracted_learning::1]]}
