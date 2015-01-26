library('RUnit')
 
source('sample.R')
 
test.suite <- defineTestSuite("nnet_tests",
                              dirs = file.path("tests"),
                              testFileRegexp = '^\\d+\\.R')
 
test.result <- runTestSuite(test.suite)
 
printTextProtocol(test.result)