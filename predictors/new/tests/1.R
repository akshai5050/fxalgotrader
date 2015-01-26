test.nnet <- function()
{
  checkTrue(checkPatternsRatio(0.6), 'Patterns matrix creation')
  checkTrue(build_nnet(0.6) > 0.7)
}
 
test.deactivation <- function()
{
  DEACTIVATED('Deactivating this test function')
}