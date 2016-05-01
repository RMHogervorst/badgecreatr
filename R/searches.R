
# 
#' Travisbadge creates travis badge.
#' 
#' @param createbadge a TRUE or FALSE for checking. 
#' @return link to travis image
#' @export
#'
travisbadge <- function(createbadge=TRUE){
    if(createbadge == TRUE){
    
        branch <- attr(git2r::branches(flags = "local"), "names")
        link <- git2r::remote_url(git2r::repository())
        credz <- gsub(".git", "", gsub("https://github.com/", "", link))
        ghaccount <- gsub("/[A-z]{3,}", "", credz)
        
        ghrepo <- gsub("[A-z]{3,}/", "", credz)
        badge <-paste0("[![Build Status](https://travis-ci.org/",ghaccount,
               "/",ghrepo, ".svg?branch=",branch,")](https://travis-ci.org/",ghaccount,"/",ghrepo,")")
        badge
    
    }
}

# 
# 

#' Add project status badge
#'
#' @param status one of concept, wip, suspended, abandoned, active, inactive or unsupported
#'
#' @return text to put into rmd
#' @export
#'
#' @examples projectstatusbadge("unsupported")
projectstatusbadge <- function(status){
    name <- c("concept", "wip", "suspended", "abandoned", "active", "inactive", "unsupported")
    if(!status %in% name)stop("status needs to be one of concept, wip, suspended, abandoned, active, inactive, unsupported")
    projectstatus <- paste0("http://www.repostatus.org/badges/latest/",status, "_md.txt" )
    repostatus <- readLines(con = projectstatus )
    repostatus <- gsub("â€“", "-", repostatus)
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
