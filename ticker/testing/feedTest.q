system  "c 2000 150" /Set table height and width to improve readability
\l ../src/feed.q
\l /Users/shaha1/repo/fxalgotrader/ticker/testing/qunit.q
system "d .feedTest";

testConnectTickerplant:{.qunit.assertEquals[.feed.connectTickerplant[5011];`connected;"Feed connect to tickerplant"]};

.qunit.runTests `.feedTest;