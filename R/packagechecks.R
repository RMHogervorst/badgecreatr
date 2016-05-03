## package checks
# 
# 
# description <- readLines("DESCRIPTION")
# 
# 
# list <- list.files(,pattern = "\\.*")
# 
# # Finding readme.
# readme <- readLines("README.Rmd")
# 
# 
# grep("travis-ci.org", readme)
# 
# # find if there are already badges.
# #
# if(file.exists(".travis.yml")){
#     travis <- readLines(".travis.yml")
# }else {travis <- "no file"}
# grep("codecov()", travis)
# 
# 
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

# check for .travis.yml in here.

### put badges in readme function
#should probably check for badge before placing one
#' Place badges inside readme file
#' 
#' This is the main function to add badges to your readme.
#'
#' @return readme file with added badges
#' @export
#'
badgeplacer <- function(location = "."){
    readme <- readLines(file.path(location,"README.Rmd" ))
    # find yaml top content
    if(length(grep("---", readme))<2){stop("no top yaml at readme.Rmd")}
    bottomyaml <- grep("---", readme)[2]
    readme <- append(readme, c(projectstatusbadge("active"),travisbadge()), bottomyaml)
    writeLines(readme, con = "README.Rmd")
}


