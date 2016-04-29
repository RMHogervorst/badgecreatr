
# 
#' Travisbadge creates travis badge.
#'
#' @return link to travis image
#' @export
#'
#' @examples
travisbadge <- function(){
    if(file.exists(".travis.yml")) {
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

# add project status
# 

#' Title
#'
#' @param status 
#'
#' @return
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
