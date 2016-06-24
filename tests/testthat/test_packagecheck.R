# tests for packagecheck
# test badgeplacer

context("badgeplacer function")

test_that("badgeplacer throws error when no yaml", {
    skip("because")
    expect_error(badgeplacer("tests/testfiles/malformed"), 
                 regexp = "no top yaml")
    # expect_error(badgeplacer("tests/testfiles/malformed2"), 
    #              regexp = "no top yaml")  # does not yet recognize invalid yaml
})

test_that("badgeplacer places valid badges", {
    skip(" untill files are at right  location ")
    #https://stackoverflow.com/questions/8898469/is-it-possible-to-use-r-package-data-in-testthat-tests-or-run-examples
    skip_on_travis()
    skip_on_cran()
    file.copy(from = "tests/testfiles/correct/README.Rmd", 
              to = "tests/testfiles/correct/templocation/README.Rmd" )
    badgeplacer("tests/testfiles/correct")
    readme <- readLines("tests/testfiles/correct/README.Rmd")
    expect_match(readme[6], regexp = "Project Status:")
    rm(readme)
    file.remove("tests/testfiles/correct/README.Rmd")
    file.copy(from = "tests/testfiles/correct/templocation/README.Rmd", 
              to =  "tests/testfiles/correct/README.Rmd")
})

test_that("placement of badge does not lead to losing of information in readme",{
    skip(" untill tests work correclty")
    
})
