# badge placers  #######################
# These functions will be called to place a badge in the 
# readme file. All take some arguments and will
# place markdown. 
# 
# Most badges wil be created with the licencepaste function defined in utils.


#' CodeCoverage ' ' Adds a code cov badge
#' 
#' adds codecov badge
#'
#' @param ghaccount your github account f.i. "rmhogervorst"
#' @param ghrepo the name of the repo f.i. "badgecreatr"
#' @param branch the branch, defaults to master
codecovbadge <- function(ghaccount, ghrepo, branch="master" ){
    referlink <- paste0("https://codecov.io/gh/", ghaccount, "/", ghrepo)
    imagelink <- paste0(referlink, 
                        "/branch/", branch, 
                        "/graph/badge.svg" )
    codecovbadge <-licencepaste(imagelink,referlink, name =  "codecov")
    codecovbadge
}

# test:
# ghaccount <- "RMHogervorst"
# ghrepo <- "badgecreatr"
# branch <- "master"
# codecovbadge(ghaccount, ghrepo, branch)


## -----------------------------------------------------------------------

#' creates last-change badge
#' 
#' Will add current day to the repo. 
last_change_badge <- function(location = "."){
    # gsub("-", "--", Sys.Date())
    licencepaste(imagelink = paste0("https://img.shields.io/badge/last%20change-",
                                    "`r ", "gsub('-', '--', Sys.Date())", "`",
                                    "-yellowgreen.svg"),
                 referlink = "/commits/master",
                 name = "Last-changedate")
}
# -------------------------------------------------------------------------

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
# ------------------------------------------------------------------------

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

# ----------------------------------------------------------------------

#' Add licence badge
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

