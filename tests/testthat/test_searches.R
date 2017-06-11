#context("general function of projectstatusbadge")

test_that("findbadges returns the correct values",{
    result <- findbadges(location = "../../")
    expect_true(result$projectstatus_readme)
    expect_true(result$travisfile)
})

#readme <- readLines(file.path("../..", "README.Rmd"))    

# findbadges
# output from own is
# $projectstatus_readme
# [1] TRUE
# 
# $licencebadge_readme
# [1] TRUE
# 
# $travisbadge_readme
# [1] TRUE
# 
# $codecoverage_readme
# [1] TRUE
# 
# $rversion_readme
# [1] TRUE
# 
# $cranbadge_readme
# [1] TRUE
# 
# $packageversionbadge_readme
# [1] TRUE
# 
# $last_change_readme
# [1] TRUE
# 
# $licence
# [1] "GPL-3"
# 
# $packagename
# [1] "badgecreatr"
# 
# $travisfile
# [1] TRUE
# 
# $codecov_in_travisfile
# [1] TRUE


