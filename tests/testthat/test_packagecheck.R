# # tests for packagecheck
# # test badgeplacer
# context("curent location")
# test_that("working directory is tests/testthat",{
#     expect_match(getwd(), "/tests/testthat")
# })
# 
# context("badgeplacer function")
# 
# test_that("badgeplacer throws error when no yaml", {
#    # skip("because I couldn't get it to work")
#    # this one fails on normal check, but should not fail during
#    # r cmd check
#    skip_if_not(getwd()== "D:/RmhDocs/Documents/docs/actief/Projecten/badgecreatr/tests/testthat",message = "wd is not testdir ")
#     expect_error(badgeplacer(name = "noyaml.Rmd"), 
#                  regexp = "no top yaml")
#     # expect_error(badgeplacer("tests/testfiles/malformed2"), 
#     #              regexp = "no top yaml")  # does not yet recognize invalid yaml
# })
# # badgeplacer(name = "CopyOfnoyaml.Rmd") # this one works. 
# test_that("badgeplacer throws error when no yaml", {
#    #version for in interactive use
#     skip_if_not(getwd()== "D:/RmhDocs/Documents/docs/actief/Projecten/badgecreatr",message = "wd is not interactive")
#     expect_error(badgeplacer(location = "tests/testthat", name = "noyaml.Rmd"), 
#                  regexp = "no top yaml")
#     # expect_error(badgeplacer("tests/testfiles/malformed2"), 
#     #              regexp = "no top yaml")  # does not yet recognize invalid yaml
# })
# 
# test_that("placement of badges works", {
#     skip_if_not(getwd()== "D:/RmhDocs/Documents/docs/actief/Projecten/badgecreatr",message = "wd is not interactive")
#     # copy CopyOfREadme.rmd 
#     # and add badges. 
#     # test if it worked.
# })
# 
# 
# test_that("badgeplacer places valid badges", {
#     skip(" untill files are at right  location ")
#     #https://stackoverflow.com/questions/8898469/is-it-possible-to-use-r-package-data-in-testthat-tests-or-run-examples
#     skip_on_travis()
#     skip_on_cran()
#     file.copy(from = "tests/testfiles/correct/README.Rmd", 
#               to = "tests/testfiles/correct/templocation/README.Rmd" )
#     badgeplacer("tests/testfiles/correct")
#     readme <- readLines("tests/testfiles/correct/README.Rmd")
#     expect_match(readme[6], regexp = "Project Status:")
#     rm(readme)
#     file.remove("tests/testfiles/correct/README.Rmd")
#     file.copy(from = "tests/testfiles/correct/templocation/README.Rmd", 
#               to =  "tests/testfiles/correct/README.Rmd")
# })
# 
# test_that("placement of badge does not lead to losing of information in readme",{
#     skip(" untill tests work correclty")
#     
# })
