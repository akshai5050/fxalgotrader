system  "c 2000 150" /Set table height and width to improve readability
\l ../src/feed.q
\l /Users/shaha1/repo/fxalgotrader/ticker/testing/qunit.q
system "d .tickerplantTest";

testUpdat:{.qunit.assertEquals[.feed.h ".tickerplant.tick";t;"Received data from tickerplant"]};

beforeNamespaceTickerPlantTest:{
	t::([]date:enlist 2012.02.01; t: enlist 00:00:00.303; bid:enlist 1.57594; offer:enlist 1.57609);
	.feed.connectTickerplant[5011];
	.feed.feed[t]} // Sends tick data to feed using IPC

.qunit.runTests `.tickerplantTest;