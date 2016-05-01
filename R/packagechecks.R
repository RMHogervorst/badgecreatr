## package checks


description <- readLines("DESCRIPTION")


list <- list.files(,pattern = "\\.*")

# Finding readme.
readme <- readLines("README.Rmd")


grep("travis-ci.org", readme)

# find if there are already badges.
#
if(file.exists(".travis.yml")){
    travis <- readLines(".travis.yml")
}else {travis <- "no file"}
grep("codecov()", travis)


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
badgeplacer <- function(){
    readme <- readLines("README.Rmd")
    # find yaml top content
    if(length(grep("---", readme))<2){stop("no top yaml at readme.Rmd")}
    bottomyaml <- grep("---", readme)[2]
    readme <- append(readme, projectstatusbadge("active"), bottomyaml)
    writeLines(readme, con = "README.Rmd")
}

