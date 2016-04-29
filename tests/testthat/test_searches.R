context("general function of projectstatusbadge")
# tests: 
# status<- "kip" should give error
# Error: status needs to be one of concept, wip, suspended, abandoned, active, inactive, unsupported
# projectstatusbadge("wip") should give 
# "[![Project Status: WIP - Initial development is in progress, 
# but there has not yet been a stable, usable release suitable for the 
# public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)"

test_that("error when incorrect status",{
    expect_error(
        projectstatusbadge("kip"),
        regexp = "status needs to be one of concept, wip, suspended, abandoned, active, inactive, unsupported"
        )  
})
test_that("internetconnection works",{
    expect_equal(readLines("http://www.repostatus.org/#wip")[1], "<!doctype html>" )
})

test_that("all status options work",{
    expect_output(projectstatusbadge("concept"),regexp = "\\[Project Status: Concept")
    expect_output(projectstatusbadge("wip"),regexp = "Project Status: WIP")
    expect_output(projectstatusbadge("suspended"),regexp = "Project Status: Suspended")
    expect_output(projectstatusbadge("abandoned"),regexp = "Project Status: Abandoned")
    expect_output(projectstatusbadge("active"),regexp = "Project Status: Active")
    expect_output(projectstatusbadge("inactive"),regexp = "Project Status: Inactive")
    expect_output(projectstatusbadge("unsupported"),regexp = "Project Status: Unsupported")
})
context("general function of travisbadge")

test_that("travisbadge function creates output",{
    expect_output(travisbadge(), regexp = "Build" )
    expect_output(travisbadge(TRUE), regexp = "\\[\\!\\[Build" )
})
test_that("travisbadge function does nothing when FALSE",{
    expect_silent(travisbadge(FALSE))
})
