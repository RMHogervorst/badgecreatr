# unit tests of all the individual placers.

context("projectstatusbadge")
# tests: 

##projectstatus ####
test_that("error when incorrect status",{
    expect_error(
        badge_projectstatus("kip"),
        regexp = "status needs to be one of concept, wip, suspended, abandoned, active, inactive, unsupported"
        )  
})
test_that("internetconnection works",{
    expect_equal(readLines("http://www.repostatus.org/#wip")[1], "<!doctype html>" )
})

test_that("all status options work",{
    expect_match(badge_projectstatus("concept"),regexp = "\\[Project Status: Concept")
    expect_match(badge_projectstatus("wip"),regexp = "Project Status: WIP")
    expect_match(badge_projectstatus("suspended"),regexp = "Project Status: Suspended")
    expect_match(badge_projectstatus("abandoned"),regexp = "Project Status: Abandoned")
    expect_match(badge_projectstatus("active"),regexp = "Project Status: Active")
    expect_match(badge_projectstatus("inactive"),regexp = "Project Status: Inactive")
    expect_match(badge_projectstatus("unsupported"),regexp = "Project Status: Unsupported")
})
context("license placer")
# license placer ####
test_that("license placer works", {
    expect_match(badgecreatr:::licbadgebuilder("MIT"), regexp = "license/mashape/apistatus.svg")
    expect_match(badgecreatr:::licbadgebuilder("MIT"), regexp = "choosealicense.com/licenses/mit/")
    expect_match(badgecreatr:::licbadgebuilder("GPL-3"), regexp = "badge/license-GPL--3")
    expect_match(badgecreatr:::licbadgebuilder("GPL-3"), regexp = "www.gnu.org/licenses/gpl-3.0.en")
    expect_match(badgecreatr:::licbadgebuilder("GPL-2"), regexp = "old-licenses/gpl-2.0.html")
    expect_match(badgecreatr:::licbadgebuilder("CC0"), regexp = "choosealicense.com/licenses/cc0-1.0/")
    
})

context("general function of travisbadge") 

# travisbadge #####
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

#setup

test_that("travisbadge function creates output",{
    ghaccount <-"RMHogervorst"
    ghrepo = "badgecreatr"
    branch = "develop"
    badge_travis <- badge_travis(ghaccount, ghrepo, branch)#fails
    expect_match(badge_travis, regexp = "Build" )
    expect_match(badge_travis, regexp = "\\[\\!\\[Build" )
    expect_match(badge_travis, regexp = "ci.org/RMHogervorst/badgecreatr.svg\\?branch=develop")
    rm(badge_travis)
    
})



context("codecov")
# codecov ####
test_that("codecov function creates a badge", {
    ghaccount <-"RMHogervorst"
    ghrepo = "badgecreatr"
    branch = "develop"
    badge_codecov <- badge_codecov(ghaccount, ghrepo, branch)
    expect_match(badge_codecov , 
                 regexp = "\\[\\!\\[codecov")
    expect_match(badge_codecov, 
                 regexp = "https://codecov.io/gh/RMHogervorst/badgecreatr/branch/develop/graph/badge.svg")             
    rm(badge_codecov)             
})

context("min r version")
# minimal r version ####
test_that("min r version creates correct badge", {
    badge_rver <- badge_minimal_r_version(chunk = FALSE)
    expect_match(badge_rver, regexp = "\\[\\!\\[minimal R version\\]")#fails
    expect_match(badge_rver, regexp = "https://cran.r-project.org/")#fails
    rm(badge_rver)
})


context("Cran badges")
# cran badge placer ####
test_that("cran badge placed", {
    badge_cran <- badge_cran("xyz")
    expect_match(badge_cran, regexp = "www.r-pkg.org/badges/version/xyz")
    rm(badge_cran)
})

test_that("other cran badges links are correct", {
    expect_match(badge_cran_version_ago("xyz"), "www.r-pkg.org/badges/version-ago/xyz")
    expect_match(badge_cran_version_release("xyz"), "www.r-pkg.org/badges/version-last-release/xyz")
    expect_match(badge_cran_downloads("xyz", period = "last-week"), "cranlogs.r-pkg.org/badges/last-week/xyz")
    expect_match(badge_cran_downloads("xyz"), "cranlogs.r-pkg.org/badges/xyz")
    expect_match(badge_cran_ago("xyz"), "r-pkg.org/badges/ago/xyz")
})

# packageversion ####
# This function does not create a badge, but a rmarkdown chunk.
context("package versionbadge function creates the right chunk")

test_that("package version badge creates valid markdown and codechunk",{
    # there is probably a nicer way to test this thing
    badge_packageversion <- badge_packageversion(chunk = FALSE)
    #expect_match(badge_packageversion[1], "echo = FALSE")
    #expect_match(badge_packageversion[2], "DESCRIPTION")
    #expect_match(badge_packageversion[3], "\"Version:\", description")#fails
    #expect_match(badge_packageversion[4], "```")
    expect_match(badge_packageversion, "!\\[packageversion\\]")
    rm(badge_packageversion)
})

    




context("last change badge")
# last change badge ####
test_that("last change badge creates markdown",{
    badge_lastchange <- badge_last_change()
    expect_match(badge_lastchange, regexp = "\\[\\!\\[Last-changedate")
    expect_match(badge_lastchange, regexp = "Sys.Date()")
    rm(badge_lastchange)
})
test_that("last change badge static works",{
    expect_match(badge_last_change_static("2017-01-02"), "last%20change-2017--01--02")
    expect_match(badge_last_change_static(), gsub("-", "--", Sys.Date()))
})

context("badge rank")
test_that("pasting works, really this should work", {
    badge <- badge_rank("badgecreatr")
    expect_match(badge, "\\[\\!\\[rpackages.io rank\\]")
    expect_match(badge, "badge/badgecreatr.svg")
    expect_match(badge, "www.rpackages.io/package/badgecreatr")
})
