#context("general function of projectstatusbadge")
# tests: 
# status<- "kip" should give error
# Error: status needs to be one of concept, wip, suspended, abandoned, active, inactive, unsupported
# projectstatusbadge("wip") should give 
# "[![Project Status: WIP - Initial development is in progress, 
# but there has not yet been a stable, usable release suitable for the 
# public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)"


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
# badgepaste
# should return valid markdown for image and link. 
# badgepaste("https://img.shields.io/badge/licence-GPL--3-red.svg",
#"https://www.gnu.org/licenses/gpl-3.0.en.html")
# 
