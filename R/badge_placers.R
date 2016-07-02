# badge placers  #######################
# These functions will be called to place a badge in the 
# readme file. 
# 
# I keep the following order (also in test_badge_placers):
# - project status badge
# - licence badge
# - travis badge
# - codecov badge
# - minimal r version
# - cran badge
# - package version badge
# - last change.
# 
# 
# 
# Most badges wil be created with the licencepaste function defined in utils.

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
#' @examples 
#' licbadgebuilder("GPL-3")
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

# -------------------------------------------------------------------------

#' Travisbadge creates travis badge.
#' 
#' @param ghaccount githubaccountname
#' @param ghrepo githubrepositoryname
#' @param branch master, develop etc
#' 
#' @return link to travis image
#' @examples 
#' travisbadge(ghaccount = "johntest", ghrepo = "yourreponame", branch = "master")
#' @export
travisbadge <- function(ghaccount, ghrepo, branch){
            referlink <- paste0("https://travis-ci.org/",ghaccount,"/",ghrepo)
            imagelink <- paste0(referlink, 
                                ".svg?branch=",branch)
            badge <-licencepaste(imagelink,referlink, name =  "Build Status")
            badge
        
    
}  
# -------------------------------------------------------------------------




#' CodeCoverage ' ' Adds a code cov badge
#' 
#' adds codecov badge
#'
#' @param ghaccount your github account f.i. "rmhogervorst"
#' @param ghrepo the name of the repo f.i. "badgecreatr"
#' @param branch the branch, defaults to master
#' @examples 
#' codecovbadge(ghaccount = "johntest", ghrepo = "yourreponame", branch = "master")
#' @export
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
# -----------------------------------------------------------------------

#' Display the minimal R version
#'
#' @param rversion minimal r version
#'
#' @return markdown
#' @export
#'
#' @examples
#' minimal_r_version_badge("3.0.3")
minimal_r_version_badge <- function(rversion){
    img_link <- paste0("https://img.shields.io/badge/R%3E%3D-", rversion, "-6666ff.svg")
    referlink <- "https://cran.r-project.org/"
    licencepaste(img_link, referlink, name = "minimal R version")
    
}
# https://img.shields.io/badge/R%3E%3D-3.0.0-6666ff.svg
#
#  other option is with an extra image, but I cant't get this to work
# ?logo=data:https://raw.githubusercontent.com/RMHogervorst/cleancodeexamples/master/images/Rlogo_small_online.png
# 
# https://img.shields.io/badge/style-flat--squared-green.svg??logo=data:https://raw.githubusercontent.com/RMHogervorst/cleancodeexamples/master/images/Rlogo_small_online.png
# ##   ?logo=data:image/png;base64,… 	Insert logo image (≥ 14px high)
# https://raw.githubusercontent.com/RMHogervorst/cleancodeexamples/master/images/Rlogo_small_online.png


# ------------------------------------------------------------------------
# [![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/roxygen2)]
# (http://cran.r-project.org/package=roxygen2)
# cran badge

#' Add a badge for cran
#'
#' @param packagename the name of your package 
#'
#' @return markdown to put into readme
#' @export
#'
#' @examples
#' cranbadge("badgecreatr")
cranbadge <- function(packagename){
    img_link <- paste0("http://www.r-pkg.org/badges/version/", packagename)
    refer_link <- paste0("http://cran.r-project.org/package=", packagename)    
    licencepaste(imagelink =img_link, 
                 referlink = refer_link,
                 name = "CRAN_Status_Badge")
}

# ----------------------------------------------------------------------
#' place a badge with the version of your package
#'
#' @param packageversionnumber give by hand or let it search in description file.
#'
#' @return markdown to put into readme.rmd
#' @export
#'
#' @examples
#' packageversionbadge("0.0.2")
packageversionbadge <- function(packageversionnumber){
    img_link <- paste0("https://img.shields.io/badge/Package%20version-", packageversionnumber, "-orange.svg?style=flat-square")
    referlink <- "commits/master"
    licencepaste(img_link, referlink, name = "packageversion")
}

#https://img.shields.io/badge/Package%20version-0.0.2-orange.svg?style=flat-square


## -----------------------------------------------------------------------

#' creates last-change badge
#' 
#' Will add current day to the repo. 
#'
#' @param location defaults to working directory 
last_change_badge <- function(location = "."){
    # gsub("-", "--", Sys.Date())
    licencepaste(imagelink = paste0("https://img.shields.io/badge/last%20change-",
                                    "`r ", "gsub('-', '--', Sys.Date())", "`",
                                    "-yellowgreen.svg"),
                 referlink = "/commits/master",
                 name = "Last-changedate")
}
