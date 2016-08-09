## These functions search for badges and other licences. 

#' What badges are already found in the Readme document
#'
#' @param location where should we search for readme.rmd?
#'
#' @return list of locations inside of readme
#' @export
#'
#' 
findbadges <- function(location = "."){
    # readme
    readme <- readLines(file.path(location,"README.Rmd"))
    projectstatbadge <-         grep("\\[\\!\\[Project Status:", readme)
    licencebadge_readme <-      grep("\\[\\!\\[Licence:\\]|\\[\\!\\[Licence\\]", readme)
    buildbadge <-               grep("\\[\\!\\[Build Status\\]", readme)
    coverage <-                 grep("\\[\\!\\[Coverage Status\\]|\\[\\!\\[codecov\\]", readme)
    minrversion <-              grep("\\[\\!\\[minimal R version\\]", readme)
    cranbadge <-                grep("\\[\\!\\[CRAN_Status_Badge", readme)
    packageversion_readme <-    grep("\\[\\!\\[packageversion", readme)
    last_change_readme <-       grep("\\[\\!\\[Last-changedate\\]", readme)
    # description file
    description <- readLines("DESCRIPTION")
    licenceinformation <-grep("License:", description, value = TRUE)
    licencetype <- gsub("+ file LICENSE", "", gsub("License: ", "", licenceinformation)) 
    packagename <- grep("Package:", description, value = TRUE)
    packagename <- gsub(" ", "",   gsub("Package:", "", packagename))
    # travis file
    travisyaml <- if(file.exists(".travis.yml")){ 
        readLines(".travis.yml")
        }else travisyaml <- NULL
    travisfile <- ifelse(length(travisyaml)==0, FALSE, TRUE)
    codecov_in_travis <-ifelse(length(grep("covr", travisyaml))==0, FALSE, TRUE)
    # final list of     
    list <- list(
        "projectstatus_readme" = ifelse(length(projectstatbadge)==0, FALSE, TRUE ), #THE BADGE
        "licencebadge_readme" = ifelse(length(licencebadge_readme)==0, FALSE, TRUE), # Badge
        "travisbadge_readme" = ifelse(length(buildbadge)==0, FALSE, TRUE ), # FINDING THE BADGES
        "codecoverage_readme" = ifelse(length(coverage)==0, FALSE, TRUE ),  # THE BADGE
        "rversion_readme" = ifelse(length(minrversion)==0, FALSE, TRUE ),  # THE BADGE
        "cranbadge_readme"= ifelse(length(cranbadge)==0, FALSE, TRUE ),  # THE BADGE
        "packageversionbadge_readme"= ifelse(length(packageversion_readme)==0, FALSE, TRUE ),  # THE BADGE          
        "last_change_readme"= ifelse(length(last_change_readme)==0, FALSE, TRUE ),  # THE BADGE          
          
                  "licence" = licencetype,     # TYPE
                  "packagename" = packagename, # TYPE
                  "travisfile" = travisfile,
                  "codecov_in_travisfile" =codecov_in_travis
    )
          
    list
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

#' Create a licencebadge
#' 
#' when licence= "search" this function wil look in your
#' DESCRIPTION file and search for the "Licence:" part. 
#' If it matches GPL or MIT a custum badge will be created. 
#' If it does not match, a general badge will be created with the name of the
#' licence in grey.
#'
#' @param licence f.i. GPL-3, MIT, etc or search
#'
#' @return markdown
#' @export
licencebadge <- function(licence = "search"){
    if(licence == "search"){
        description <- readLines("DESCRIPTION")
        licenceinformation <-grep("License:", description, value = TRUE)
        if(length (licenceinformation)==0)(
            stop("No licence was described in DESCRIPTION"))
        licencetype <- gsub("+ file LICENSE", "", gsub("License: ", "", licenceinformation)) 
    }else {
        licencetype <- licence
    }
    
    if(!(licencetype %in%c(
        "GPL-2", "GPL-3", #"LGPL-2", "LGPL-2.1", "LGPL-3", 
        #"AGPL-3", "Artistic-2.0",
        #"BSD_2_clause", "BSD_3_clause", 
        "MIT"
    )) ){message("the licence ", licencetype, " is not recommended for R packages")
        licencepaste(imagelink = paste0("https://img.shields.io/badge/licence-",
                                        gsub("-","--", licencetype), "-lightgrey.svg"),
                     referlink = "http://choosealicense.com/")
    }else{
        licbadgebuilder(licencetype)
    }
    
    
}    

