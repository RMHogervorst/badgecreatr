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
#' @family badges
#' @return text to put into rmd
#' @examples  
#' projectstatusbadge("unsupported")
#' @export
projectstatusbadge <- function(status = NULL){
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
#' @family badges
#' @return markdown
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
#' @family badges
#' @return markdown including link to travis image
#' @examples 
#' travisbadge(ghaccount = "johntest", ghrepo = "yourreponame", branch = "master")
#' @export
travisbadge <- function(ghaccount = "search", ghrepo = "search", branch = "master", location = "."){
  git_info <- search_git(location)
  if(ghaccount == "search") ghaccount <- git_info$account
  if(ghrepo == "search") ghrepo  <- git_info$repo
  if(branch == "search"){
    #default to master when you can't find something.
    branch <- git_info()$branch
  }
  referlink <- paste0("https://travis-ci.org/", ghaccount,"/", ghrepo)
  imagelink <- paste0(referlink, 
                      ".svg?branch=",branch)
  badge <-licencepaste(imagelink, referlink, name =  "Build Status")
  badge
  
  
}  
# -------------------------------------------------------------------------




#' CodeCoverage ' ' Adds a code cov badge
#' 
#' Adds codecov badge
#'
#' @param ghaccount your github account f.i. "rmhogervorst",you can use "search"
#' @param ghrepo the name of the repo f.i. "badgecreatr",you can use "search"
#' @param branch the branch, defaults to master, you can use "search"
#' @family badges
#' @examples 
#' codecovbadge(ghaccount = "johntest", ghrepo = "yourreponame", branch = "master")
#' @export
codecovbadge <- function(ghaccount = "search", ghrepo = "search", branch="master", location = "."){
  git_info <- search_git(location)
  if(ghaccount == "search") ghaccount <- git_info$account
  if(ghrepo == "search") ghrepo  <- git_info$repo
  if(branch == "search"){
    #default to master when you can't find something.
    branch <- git_info()$branch
  }
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
#' @return markdown
#' @export
#' 
#' @importFrom stringr str_match
#' @family badges
#' @examples
#' minimal_r_version_badge()
minimal_r_version_badge <- function(chunk = TRUE){
  r_chunk <- c(
    "```{r, echo = FALSE}", 
    eval(expression("dep <- as.vector(read.dcf('DESCRIPTION')[, 'Depends'])")),
    eval(expression("m <- regexpr('R *\\\\(>= \\\\d+.\\\\d+.\\\\d+\\\\)', dep)")),
    eval(expression("rm <- regmatches(dep, m)")),
    eval(expression("rvers <- gsub('.*(\\\\d+.\\\\d+.\\\\d+).*', '\\\\1', rm)")),
    "```")
  img_link <- paste0("https://img.shields.io/badge/R%3E%3D-", "`r rvers`", "-6666ff.svg")
  referlink <- "https://cran.r-project.org/"
  result <- c(if(chunk){r_chunk}, 
              licencepaste(img_link, referlink, name = "minimal R version"))
  result
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
#' @family badges
#' @examples
#' cranbadge("dplyr")
cranbadge <- function(packagename){
  img_link <- paste0("http://www.r-pkg.org/badges/version/", packagename)
  refer_link <- paste0("https://cran.r-project.org/package=", packagename)    
  licencepaste(imagelink =img_link, 
               referlink = refer_link,
               name = "CRAN_Status_Badge")
}

# ----------------------------------------------------------------------
#' Place a badge with the version of your package.
#' 
#' Place a badge with the version of your package which is automatically read from
#' your description file.
#'
#' @return markdown to put into readme.rmd
#' @export
#' @family badges
#' @examples
#' packageversionbadge()
packageversionbadge <- function(chunk = TRUE){
  r_chunk <- c(
    "```{r, echo = FALSE}", 
    eval(expression("version <- as.vector(read.dcf('DESCRIPTION')[, 'Version'])")), 
    "```")
  img_link <- paste0("https://img.shields.io/badge/Package%20version-", "`r version`", 
                     "-orange.svg?style=flat-square")
  referlink <- "commits/master"
  result <- c(
    if(chunk){r_chunk}, 
    licencepaste(img_link, referlink, name = "packageversion"))
  result
}

#https://img.shields.io/badge/Package%20version-0.0.2-orange.svg?style=flat-square


## -----------------------------------------------------------------------

#' creates last-change badge
#' 
#' Will add a badge containing the current date that changes 
#' on every reknitting. This is a simple pasting of r code. 
#' @family badges
#' @param location defaults to working directory 
last_change_badge <- function(location = "."){
  # gsub("-", "--", Sys.Date())
  licencepaste(imagelink = paste0("https://img.shields.io/badge/last%20change-",
                                  "`r ", "gsub('-', '--', Sys.Date())", "`",
                                  "-yellowgreen.svg"),
               referlink = "/commits/master",
               name = "Last-changedate")
}

#' Creates last-change badge
#' 
#' Will add current day to the repo. This function will 
#' not change when you reknit the readme. If you want that you will 
#' have to use the link{last_change_badge} function.
#' @export
#' @family badges
#' @param location defaults to working directory 
last_change_badge_static <- function(location = "."){
  today <- gsub('-', '--', Sys.Date())
  licencepaste(imagelink = paste0("https://img.shields.io/badge/last%20change-",
                                  today,                                     "-yellowgreen.svg"),
               referlink = "/commits/master",
               name = "Last-changedate")
}


#' R documentation badge
#' 
#' Add a documentation badge, from DataCamp.
#' @param packagename the name of your package
#' @export
#' @examples 
#' rdocumentation_badge("dplyr")
rdocumentation_badge <- function(packagename){
  licencepaste(
    imagelink = paste0("http://www.rdocumentation.org/badges/version/", packagename),
    referlink = paste0("http://www.rdocumentation.org/packages/", packagename),
    name = "Rdoc"
  )
}
