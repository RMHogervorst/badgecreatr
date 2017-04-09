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
    expect_match(projectstatusbadge("concept"),regexp = "\\[Project Status: Concept")
    expect_match(projectstatusbadge("wip"),regexp = "Project Status: WIP")
    expect_match(projectstatusbadge("suspended"),regexp = "Project Status: Suspended")
    expect_match(projectstatusbadge("abandoned"),regexp = "Project Status: Abandoned")
    expect_match(projectstatusbadge("active"),regexp = "Project Status: Active")
    expect_match(projectstatusbadge("inactive"),regexp = "Project Status: Inactive")
    expect_match(projectstatusbadge("unsupported"),regexp = "Project Status: Unsupported")
})
context("general function of travisbadge")
#
## possibly create fake github like hadley
## 
### fake GitHub connectivity: set a GitHub remote and add GitHub links
# mock_use_github <- function(pkg) {
#     use_git(pkg = pkg)
#     r <- git2r::repository(pkg)
#     git2r::remote_add(r, "origin", "https://github.com/hadley/devtools.git")
#     use_github_links(pkg)
#     git2r::add(r, "DESCRIPTION")
#     git2r::commit(r, "Add GitHub links to DESCRIPTION")
#     invisible(NULL)
# }
 
test_that("travisbadge function creates output",{
    testthat::skip("until github fake connectivity is functional")
        expect_match(travisbadge(), regexp = "Build" )
    expect_match(travisbadge(TRUE), regexp = "\\[\\!\\[Build" )
})

test_that("travisbadge function does nothing when FALSE",{
    expect_silent(travisbadge(FALSE))
})

# a githubcredentials tester
# 
# licencebadge 
# licence = "search"  should find the description file
# a message should be thrown when not MIT, GPL-2 GPL-3
# creates a badge any time. 
# 
# licbadgebuilder
# https://img.shields.io/badge/licence-GPL--3-red.svg
# licbadgebuilder("GPL-3) 
#"[![Licence](https://img.shields.io/badge/licence-GPL--3-red.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)"
# should return the four different badges.  
# 
# licencepaste
# should return valid markdown for image and link. 
# licencepaste("https://img.shields.io/badge/licence-GPL--3-red.svg",
#"https://www.gnu.org/licenses/gpl-3.0.en.html")
# 
