h: neg hopen `::5012
i:0;
cdata:([] start_dt:(); end_dt:(); o:(); h:(); l:(); c:());
temp:([] date:(); sym:(); t:(); bid:(); offer:())
st:0;
ft:0;
c:0; / determine if start and end time has been set

/subscribes to the chained tickerplant
subscribe:{[] {h("sub";x)} `fx}
subscribe[];

sdata:{[data]
	i::data;
	set_times[data[`t][0]];
	if["u"$data[`t][0] < ft;
		`temp insert data]
	if["u"$data[`t][0] >= ft;
		`cdata insert ((first temp[`date]) + (first "u"$temp[`t]); ((first temp[`date]) + (first "u"$temp[`t]) + 60) ; first temp[`bid]; max temp[`bid]; min temp[`bid]; last temp[`bid]);
		cleartable[`temp];
		`temp insert data;
		ft+::60]
	}

cleartable:{
	delete from x
	}

set_times:{[time]
	if[not c;
		st::"u"$time;
		ft::("u"$time) + 60;
		c::1]
	}

upd:{[ts;t]
	ts insert (t);
	sdata[t]}




