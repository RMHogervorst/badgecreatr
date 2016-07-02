## package checks
# 
# 
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
#' @param location folder where readme.rmd resides
#' @param status one of: "concept", "wip", "suspended", "abandoned", "active", "inactive",  or "unsupported"
#' @param travis logical true or false
#' @param codecov logical true or false
#' @param licence "search", "gpl-2" , "MIT", etc
#' @param githubaccount your githubname
#' @param githubrepo your githubrepositoryname
#' @param branch master, develop, etc.
#'
#' @return readme file with added badges
#' @export
#'
badgeplacer <- function(location = ".", status = "active", travis = TRUE, 
                        codecov = FALSE, licence = "search", 
                        githubaccount = "search", githubrepo = "search", 
                        branch = "master"){
    badge_result <-findbadges(location)
    if(sum(sapply(badge_result, length))==0){message("no badges found in readme.")}
    #account <- githubcredentials(account = githubaccount,repo = githubrepo,
                               #  branch = branch)
    readme <- readLines(file.path(location,"README.Rmd" ))
    # find yaml top content
    if(length(grep("---", readme))<2){stop("no top yaml at readme.Rmd")}
    bottomyaml <- grep("---", readme)[2]
    # action based on bagdge_result
    #if(length(sapply(bagdge_result, length))==0){
        readme <- append(readme, c(projectstatusbadge(status),
                                   #travisbadge(createbadge = travis, 
                                              # ghaccount = account$ghaccount,
                                              # ghrepo = account$ghrepo,
                                              # branch = account$branch),
                                   licbadgebuilder(badge_result$licence),
                                   minimal_r_version_badge(badge_result$R_version),
                                   travisbadge(createbadge = TRUE, 
                                               ghaccount = githubaccount, 
                                               ghrepo = githubrepo ,
                                               branch = branch),
                                   codecovbadge(ghaccount = githubaccount, 
                                                ghrepo = githubrepo ,
                                                branch = branch),
                                   cranbadge(badge_result$packagename),
                                   packageversionbadge(badge_result$packageversion),
                                   last_change_badge()
                                   ), 
                         bottomyaml)
        
    #}else   ### HIER VERDER MET PER 
        
    writeLines(readme, con = file.path(location,"README.Rmd" ))
    message("badges placed at top of readme.rmd document")
}


