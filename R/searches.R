# searchfortravis
# 
description <- readLines("DESCRIPTION")
grep()

list <- list.files(,pattern = "\\.*")

# travis checks
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

#remote <-git2r::remote_url(git2r::repository())
#ghaccount <- "RMHogervorst"
#ghrepo <- "badgecreatr"


#git2r::branch_remote_url()

# [![Build Status](https://travis-ci.org/RMHogervorst/
#                      heisertransform.svg?branch=develop)]
# (https://travis-ci.org/RMHogervorst/heisertransform)

# 
# if (grepl("^https", x)) {
#     # https://github.com/hadley/devtools.git
#     re <- "github.com/(.*?)/(.*)\\.git"
# } else if (grepl("^git", x)) 
#     
# Finding readme.
readme <- readLines("README.Rmd")
grep("travis-ci.org", readme)

http://www.repostatus.org/badges/latest/concept_md.txt# devtools::use_github_links()

http://www.repostatus.org/badges/latest/active_md.txt

# add project status
# 
status<- "wip"
projectstatusbadge <- function(status){
    name <- c("concept", "wip", "suspended", "abandoned", "active", "inactive", "unsupported")
    if(!status %in% name)stop("status needs to be one of concept, wip, suspended, abandoned, active, inactive, unsupported")
    projectstatus <- paste0("http://www.repostatus.org/badges/latest/",status, "_md.txt" )
    repostatus <- readLines(con = projectstatus )
    repostatus <- gsub("â€“", "-", repostatus)
    repostatus
}
projectstatusbadge("unsupported")

## readLines(con = paste0("http://www.repostatus.org/badges/latest/",name[7], "_md.txt" ))
# this works
# 
# add_badges(status = active, )
# 
# tests: 
# status<- "kip" should give error
# Error: status needs to be one of concept, wip, suspended, abandoned, active, inactive, unsupported
# projectstatusbadge("wip") should give 
# "[![Project Status: WIP - Initial development is in progress, 
# but there has not yet been a stable, usable release suitable for the 
# public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)"
# 

# adds the github links. 
# if you have connected the repo to github. 
# 
# check using git2r. 
