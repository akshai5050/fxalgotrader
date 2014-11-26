\l /Users/shaha1/q/project/tac.q
\l /Users/shaha1/q/setup.q
h: hopen `::5012
\p 4321
i:0;
cdata:([] start_dt:(); end_dt:(); o:(); h:(); l:(); c:());
temp:([] date:(); sym:(); t:(); bid:(); offer:())
st:0;
ft:0;
c:0; / determine if start and end time has been set
web:0;

/subscribes to the chained tickerplant	
subscribe:{[] {h("sub";x)} `fx}
subscribe[];

sdata:{[data]
	i::data;
	if[ft=24:00;ft::00:00];
	if[st=24:00;st::00:00];
	set_times[data[`t][0]];
	if["u"$data[`t][0] < ft;
		`temp insert data]
	if["u"$data[`t][0] >= ft;
		`cdata insert ((first temp[`date]) + st; ((first temp[`date]) + ft) ; first temp[`bid]; max temp[`bid]; min temp[`bid]; last temp[`bid]);
		tac[];
		cleartable[`temp];
		`temp insert data;
		ft+::30;
		st+::30;
		web_entry:select dt: ts_to_unix[start_dt], o, h, l, c from last cdata;
		sendData\:[Sub `web; (`table`type`data)!(`cdata;type web_entry; web_entry)]]

	}

cleartable:{
	delete from x
	}

set_times:{[time]
	if[not c;
		st::"u"$time;
		ft::("u"$time) + 30;
		if[ft=24:00;ft::00:00];
		c::1]
	}

check_times:{
	$[x=24:00;:00:00;:x]}

upd:{[ts;t]
	ts insert (t);
	sdata[t]
	}

.z.pc:{-1"Connection opened!"; 0N!"x";
	web::x}
