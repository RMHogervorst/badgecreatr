# unit tests of all the individual placers.
# 
# I keep the following order (also in badge_placers):
# - project status badge
# - licence badge
# - travis badge
# - codecov badge
# - minimal r version
# - cran badge
# - package version badge
# - last change.



context("projectstatusbadge")
# tests: 

##projectstatus ####
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
context("Licence placer")
# licence placer ####
test_that("Licence placer works", {
    expect_match(licbadgebuilder("MIT"), regexp = "license/mashape/apistatus.svg")
    expect_match(licbadgebuilder("MIT"), regexp = "choosealicense.com/licenses/mit/")
    expect_match(licbadgebuilder("GPL-3"), regexp = "badge/licence-GPL--3")
    expect_match(licbadgebuilder("GPL-3"), regexp = "www.gnu.org/licenses/gpl-3.0.en")
    expect_match(licbadgebuilder("GPL-2"), regexp = "old-licenses/gpl-2.0.html")
    expect_match(licbadgebuilder("CC0"), regexp = "choosealicense.com/licenses/cc0-1.0/")
    
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
ghaccount <-"RMHogervorst"
ghrepo = "badgecreatr"
branch = "develop"

test_that("travisbadge function creates output",{
    badge_travis <- travisbadge(ghaccount, ghrepo, branch)
    expect_match(badge_travis, regexp = "Build" )
    expect_match(badge_travis, regexp = "\\[\\!\\[Build" )
    expect_match(badge_travis, regexp = "ci.org/RMHogervorst/badgecreatr.svg\\?branch=develop")
    expect_error(travisbadge(ghaccount, ghrepo), 
    regexp = 'argument "branch" is missing, with no default')
    rm(badge_travis)
    
})



context("codecov")
# codecov ####
test_that("codecov function creates a badge", {
    badge_codecov <- codecovbadge(ghaccount, ghrepo, branch)
    expect_match(badge_codecov , 
                 regexp = "\\[\\!\\[codecov")
    expect_match(badge_codecov, 
                 regexp = "https://codecov.io/gh/RMHogervorst/badgecreatr/branch/develop/graph/badge.svg")             
    rm(badge_codecov)             
})

context("min r version")
# minimal r version ####
test_that("min r version creates correct badge", {
    badge_rver <- minimal_r_version_badge()
    expect_match(badge_rver[5], regexp = "\\[\\!\\[minimal R version\\]")
    expect_match(badge_rver[5], regexp = "https://cran.r-project.org/")
    rm(badge_rver)
})


context("Cran badge placer")
# cran badge placer ####
test_that("cran badge placed", {
    badge_cran <- cranbadge("xyz")
    expect_match(badge_cran, regexp = "www.r-pkg.org/badges/version/xyz")
    rm(badge_cran)
})

# packageversion ####
# This function does not create a badge, but a rmarkdown chunk.
context("package versionbadge function creates the right chunk")

test_that("package version badge creates valid markdown and codechunk",{
    # there is probably a nicer way to test this thing
    badge_packageversion <- packageversionbadge()
    expect_match(badge_packageversion[1], "echo = FALSE")
    expect_match(badge_packageversion[2], "DESCRIPTION")
    expect_match(badge_packageversion[3], "\"Version:\", description")
    expect_match(badge_packageversion[4], "```")
    expect_match(badge_packageversion[5], "!\\[packageversion\\]")
    rm(badge_packageversion)
})

    




context("last change badge")
# last change badge ####
test_that("last change badge creates markdown",{
    badge_lastchange <- last_change_badge()
    expect_match(badge_lastchange, regexp = "\\[\\!\\[Last-changedate")
    expect_match(badge_lastchange, regexp = "Sys.Date()")
    rm(badge_lastchange)
})
