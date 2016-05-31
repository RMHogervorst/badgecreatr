
# 
#' Travisbadge creates travis badge.
#' 
#' @param ghaccount githubaccountname
#' @param ghrepo githubrepositoryname
#' @param branch master, develop etc
#' @param createbadge a TRUE or FALSE for checking. 
#'
#' @return link to travis image
#' @examples 
#' travisbadge(createbadge = TRUE, ghaccount = "johntest", ghrepo = "badgecreatr", branch = "master")
#' @export
travisbadge <- function(createbadge=TRUE, ghaccount, ghrepo, branch){
    if(createbadge == TRUE){
        if(methods::hasArg(ghaccount) & methods::hasArg(ghrepo)){
            badge <-paste0("[![Build Status](https://travis-ci.org/",ghaccount,
                           "/",ghrepo, ".svg?branch=",branch,")](https://travis-ci.org/",ghaccount,"/",ghrepo,")")
            badge
        }else{stop("no githubaccount or repo could be found, or were supplied")}
            
    
    }
}



# 

#' Add project status badge
#'
#' @param status one of concept, wip, suspended, abandoned, active, inactive or unsupported
#'
#' @return text to put into rmd
#' @examples  
#' projectstatusbadge("unsupported")
#' @export
projectstatusbadge <- function(status){
    name <- c("concept", "wip", "suspended", "abandoned", "active", "inactive", "unsupported")
    if(!status %in% name)stop("status needs to be one of concept, wip, suspended, abandoned, active, inactive, unsupported")
    projectstatus <- paste0("http://www.repostatus.org/badges/latest/",status, "_md.txt" )
    repostatus <- readLines(con = projectstatus, encoding = "UTF-8" )
    #repostatus <- readLines(textConnection(projectstatus, encoding="UTF-8"), encoding="UTF-8")
    #repostatus <- gsub("â€“", "-", repostatus)
    repostatus
}



# 

# adds the github links. 
# if you have connected the repo to github. 
# 
# check using git2r. 


#' CodeCoverage ' ' Adds a code cov badge
#
#
#zit dit erin: after_success: - bash <(curl -s https://codecov.io/bash)
#
#dan shield toevoegen
#
#[![codecov](https://img.shields.io/codecov/c/github/codecov/example-r.svg)](https://codecov.io/github/codecov/example-r)
#[![codecov](https://codecov.io/gh/RMHogervorst/badgecreatr/branch/master/graph/badge.svg)](https://codecov.io/gh/RMHogervorst/badgecreatr)

#' Give or search for github name and repo.
#'
#' @param account accountname or search for
#' @param repo repositoryname or search for
#' @param branch master, develop etc.
#'
#' @return markdown text to be placed in readme
#' @export
#'
#' 
githubcredentials <- function(account = "search", repo = "search", branch = "master"){
    if(account == "search"){
        if(repo != "search"){stop("provide accountname and reponame please")}
        link <- git2r::remote_url(git2r::repository())
        credz <- gsub(".git", "", gsub("https://github.com/", "", link))
        ghaccount <- gsub("/[A-z]{3,}", "", credz)
        ghrepo <- gsub("[A-z]{3,}/", "", credz)
        branch <- attr(git2r::branches(flags = "local"), "names")
    }else{
        ghaccount <- account
        ghrepo <- repo
        branch <- branch    
    }
    return(
        as.list(
            c(ghaccount= ghaccount, ghrepo = ghrepo, branch= branch)
            
        )
        )
    
}
    
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

#' Build badges for licences
#'
#' @param licencetype one of GPL-3, GPL-2, MIT, or CC0.
#'
#' @return markdown
#' @export
licbadgebuilder <- function(licencetype){
    switch (licencetype,
            "GPL-2" = {licencepaste("https://img.shields.io/badge/licence-GPL--2-blue.svg",
                                  "https://www.gnu.org/licenses/old-licenses/gpl-2.0.html")},
            "GPL-3" = {licencepaste("https://img.shields.io/badge/licence-GPL--3-blue.svg",
                                 "https://www.gnu.org/licenses/gpl-3.0.en.html")},
            "MIT" = {licencepaste("https://img.shields.io/github/license/mashape/apistatus.svg",
                                "http://choosealicense.com/licenses/mit/")},
            "CC0" = {licencepaste("https://img.shields.io/badge/licence-CC0-blue.svg",
                                "http://choosealicense.com/licenses/cc0-1.0/")}
    )
}

# https://img.shields.io/badge/licence-GPL--3-red.svg
# licbadgebuilder("GPL-3) 
#"[![Licence](https://img.shields.io/badge/licence-GPL--3-red.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)"


#' return markdown with image and link. 
#' 
#' for internal use. used within licencebuilder
#'
#' @param imagelink link to image file
#' @param referlink link to where to send to on click
#'
#' @return markdown
licencepaste<- function(imagelink, referlink){
    paste0("[![Licence]","(",imagelink, ")]","(",referlink,")")
}
# tests


#' What badges are already found in the Readme document
#'
#' @param location where should we search for readme.rmd?
#'
#' @return list of locations inside of readme
#' @export
#'
#' 
findbadges <- function(location = "."){
    readme <- readLines(file.path(location,"README.Rmd"))
    buildbadge <- grep("\\[\\!\\[Build Status\\]", readme)
    projectstatbadge <- grep("\\[\\!\\[Project Status:", readme)
    cranbadge <- grep("\\[\\!\\[CRAN_Status_Badge", readme)
    coverage <- grep("\\[\\!\\[Coverage Status\\]", readme)
    list <- list( "buildbadge" = buildbadge,
          "projectstatus" = projectstatbadge,
          "cran"= cranbadge,
          "codecoverage" = coverage)
    list
}
# tests
# location = "."
# examples:
# "[![Build Status](https://travis-ci.org/RMHogervorst/badgecreatr.svg?branch=master)](https://travis-ci.org/RMHogervorst/badgecreatr)
# [![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/roxygen2)](http://cran.r-project.org/package=roxygen2)
# [![Coverage Status](https://img.shields.io/codecov/c/github/klutometis/roxygen/master.svg)](https://codecov.io/github/klutometis/roxygen?branch=master)
#findbadges()
