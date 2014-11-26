/chained tickerplant code run on port 5012
mx::0;
h: neg hopen `::5011

Sub:(`fx`ta`)!()
sub:{Sub[x],:neg .z.w}

/subscribes to the tickerplant fx feed
subscribe:{[] {h("sub";x)} `fx}

upd:{x insert y; publish[`fx]}

pubfx:{[h] `g insert (enlist last fx); h("upd";`fx;g)}

publish:{[t] if[t=`fx;{pubfx[x]} each Sub `fx]; delete from `g}

g:([] date:(); sym:(); t:(); bid:(); offer:())
