## These functions search for badges and other licences. 




#' What badges are already found in the `README.Rmd` document
#'
#' @param location where should we search for `README.Rmd`?
#' @param name which file to place badges in defaults to `README.Rmd`
#' 
#' @return list of locations inside of readme
findbadges <- function(location = ".", name = "README.Rmd"){
  create_pattern <- function(x) paste("\\[\\!\\[", x, "\\]", sep ="", collapse = "|")
  
  find_in_readme <- function(x){
    ptn <- create_pattern(x)
    grep(ptn, readme)
  }
  
  # readme
  readme <- readLines(file.path(location, name))
  projectstatbadge <-      find_in_readme("Project Status:.*")
  licencebadge_readme <-   find_in_readme(c("Licence:", "Licence"))
  buildbadge <-            find_in_readme("Build Status")
  coverage <-              find_in_readme(c("Coverage Status", "codecov"))
  minrversion <-           find_in_readme("minimal R version")
  cranbadge <-             find_in_readme("CRAN_Status_Badge")
  packageversion_readme <- find_in_readme("packageversion")
  last_change_readme <-    find_in_readme("Last-changedate")
  
  
  # description file
  description <- read.dcf(file.path(location, "DESCRIPTION"))
  licencetype <- as.vector(description[1, "License"])
  packagename <- as.vector(description[1, "Package"])
  
  # travis file
  travisyaml <- if(file.exists(file.path(location, ".travis.yml"))){ 
    readLines(file.path(location, ".travis.yml"))
  } else NULL
  travisfile <- length(travisyaml) > 0
  codecov_in_travis <- length(grep("covr", travisyaml)) > 0
  
  list(
    "projectstatus_readme" = length(projectstatbadge) > 0,
    "licencebadge_readme"  = length(licencebadge_readme) > 0,
    "travisbadge_readme"   = length(buildbadge) > 0,
    "codecoverage_readme"  = length(coverage) > 0,
    "rversion_readme"      = length(minrversion) > 0,
    "cranbadge_readme"     = length(cranbadge) > 0,
    "packageversionbadge_readme" = length(packageversion_readme) > 0,
    "last_change_readme"         = length(last_change_readme) > 0,
    
    "licence"     = licencetype,
    "packagename" = packagename,
    "travisfile"  = travisfile,
    "codecov_in_travisfile" = codecov_in_travis
  )
}
# tests
# location = "."
# examples:
# "[![Build Status](https://travis-ci.org/RMHogervorst/badgecreatr.svg?branch=master)](https://travis-ci.org/RMHogervorst/badgecreatr)
# [![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/roxygen2)](http://cran.r-project.org/package=roxygen2)
# [![Coverage Status](https://img.shields.io/codecov/c/github/klutometis/roxygen/master.svg)](https://codecov.io/github/klutometis/roxygen?branch=master)
#findbadges()
# # zit dit erin: after_success: - bash <(curl -s https://codecov.io/bash)
# https://codecov.io/github/rmhogervorst/badgecreatr
#dan shield toevoegen
#


# #################### parts

# [![Date]("https://img.shields.io/badge/last%20change-
# gsub("-", "--", Sys.Date())
# -yellowgreen.svg")](https://github.com/
# githubname
# /
# githubrepo
# /
# /commits/master)
# #################
# When it prints to knitr the quotes are not working, this is what I want:
# [![Last-changedate](https://img.shields.io/badge/last%20change-`r gsub("-", "--", Sys.Date())`-yellowgreen.svg)](/commits/master)"
# 
# goal:
#[![Date]("https://img.shields.io/badge/last%20change-2016--05--31-yellowgreen.svg")](https://github.com/RMHogervorst/badgecreatr/commits/master)
# paste needs to end in paste of command
# 


## --------------------------------------------------------------

