files: key `:/Users/shaha1/q/tick_data/
sym_location: `:/Users/shaha1/q/db1/;
db_root:":/Users/shaha1/q/db/tick1/";
dst:`:/Users/shaha1/db1
test:{
	val:: 1;}
get_date_data:{
	select sym, t:"t"$dt, bid, offer from temp where ("d"$dt)=x}

splay_table_for_date:{
	d::x;
	path:: `$(db_root, (string x));
	test[];
//	(`$((string path), "/tr/")) set (.Q.en[path] get_date_data[x]);
	t:: .Q.en[dst] update sym:`p#sym from `sym xasc get_date_data[x];
	(` sv dst, `$((string x), "/trade/")) set t;
	tab:: get_date_data[x]}
larun:{
	temp:: flip `sym`dt`bid`offer!("SZFF";",") 0:`$("/Users/shaha1/q/tick_data/", string x);
	dates:: (select distinct "d"$dt from temp)[`dt];
	splay_table_for_date each dates}
	
a: larun each files
