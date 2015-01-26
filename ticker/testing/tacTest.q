system "d .tacTest";

testWema:{.qunit.assertEquals[last .tac.wema[5;(1;2;3;4;5)];3f;"WEMA 5 calculation"]};
