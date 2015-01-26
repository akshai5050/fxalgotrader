/ QUnit testing mathematical functions
system "d .mathTest";

testAdd:{.qunit.assertEquals[.math.add[2;2]; 4; "2 plus 2 equals four"]};