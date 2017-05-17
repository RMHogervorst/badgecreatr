# badge placers  #######################
# These functions create the markdown necessary to display the badges
# 
# Most badges wil be created with the badgepaste function defined in utils.

# ------------------------------------------------------------------------

#' Add project status badge
#'
#' @param status one of concept, wip, suspended, abandoned, active, inactive or unsupported
#' @family badges
#' @return text to put into rmd
#' @examples  
#' badge_projectstatus("unsupported")
#' @export
badge_projectstatus <- function(status = NULL){
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
#' badgereader:::licbadgebuilder("GPL-3")
licbadgebuilder <- function(licencetype){
  switch (licencetype,
          "GPL-2" = {badgepaste("https://img.shields.io/badge/licence-GPL--2-blue.svg",
                                  "https://www.gnu.org/licenses/old-licenses/gpl-2.0.html")},
          "GPL-3" = {badgepaste("https://img.shields.io/badge/licence-GPL--3-blue.svg",
                                  "https://www.gnu.org/licenses/gpl-3.0.en.html")},
          "MIT" = {badgepaste("https://img.shields.io/github/license/mashape/apistatus.svg",
                                "http://choosealicense.com/licenses/mit/")},
          "CC0" = {badgepaste("https://img.shields.io/badge/licence-CC0-blue.svg",
                                "http://choosealicense.com/licenses/cc0-1.0/")}
  )
}


# -------------------------------------------------------------------------

#' Travisbadge creates travis badge.
#' 
#' @param ghaccount githubaccountname
#' @param ghrepo githubrepositoryname
#' @param branch master, develop etc
#' @param location defaults to current location
#' @family badges
#' @return markdown including link to travis image
#' @examples 
#' badge_travis(ghaccount = "johntest", ghrepo = "yourreponame", branch = "master")
#' @export
badge_travis <- function(ghaccount = NULL, ghrepo = NULL, branch = NULL, 
                         location = "."){
    credentials<- github_credentials_helper(ghaccount = ghaccount, 
                                            ghrepo = ghrepo,
                                            branch = branch,
                                            location = location
    )
  referlink <- paste0("https://travis-ci.org/", credentials$ghaccount,"/", 
                      credentials$ghrepo)
  imagelink <- paste0(referlink, 
                      ".svg?branch=",credentials$branch)
  badge <-badgepaste(imagelink, referlink, name =  "Build Status")
  badge
  
  
}  
# -------------------------------------------------------------------------




#' CodeCoverage ' ' Adds a code cov badge
#' 
#' Adds codecov badge
#'
#' @inheritParams badge_travis
#' @family badges
#' @examples 
#' badge_codecov(ghaccount = "johntest", ghrepo = "yourreponame", branch = "master")
#' @export
badge_codecov <- function(ghaccount = NULL, ghrepo = NULL, branch=NULL, location = "."){
  credentials<- github_credentials_helper(ghaccount = ghaccount, 
                                          ghrepo = ghrepo,
                                          branch = branch,
                                          location = location
                                          )
  referlink <- paste0("https://codecov.io/gh/", credentials$ghaccount, "/", credentials$ghrepo)
  imagelink <- paste0(referlink, 
                      "/branch/", credentials$branch, 
                      "/graph/badge.svg" )
  codecovbadge <-badgepaste(imagelink,referlink, name =  "codecov")
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
#' @param chunk places a r chunk in the readme
#' @family badges
#' @examples
#' badge_minimal_r_version()
badge_minimal_r_version <- function(chunk = TRUE){
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
              badgepaste(img_link, referlink, name = "minimal R version"))
  result
}


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
#' badge_cran("dplyr")
badge_cran <- function(packagename){
  img_link <- paste0("http://www.r-pkg.org/badges/version/", packagename)
  refer_link <- paste0("https://cran.r-project.org/package=", packagename)    
  badgepaste(imagelink =img_link, 
               referlink = refer_link,
               name = "CRAN_Status_Badge")
}

# ----------------------------------------------------------------------
#' Place a badge with the version of your package.
#' 
#' Place a badge with the version of your package which is automatically read from
#' your description file.
#' @param chunk this argument places a rmarkdown chunk
#' @return markdown to put into readme.rmd
#' @export
#' @family badges
#' @examples
#' badge_packageversion()
badge_packageversion <- function(chunk = TRUE){
  r_chunk <- c(
    "```{r, echo = FALSE}", 
    eval(expression("version <- as.vector(read.dcf('DESCRIPTION')[, 'Version'])")), 
    eval(expression("version <- gsub('-', '.', version)")),
    "```")
  img_link <- paste0("https://img.shields.io/badge/Package%20version-", "`r version`", 
                     "-orange.svg?style=flat-square")
  referlink <- "commits/master"
  result <- c(
    if(chunk){r_chunk}, 
    badgepaste(img_link, referlink, name = "packageversion"))
  result
}


## -----------------------------------------------------------------------

#' creates last-change badge
#' 
#' Will add a badge containing the current date that changes 
#' on every reknitting. This is a simple pasting of r code. 
#' @family badges
#' @param location defaults to working directory
#' @export 
badge_last_change <- function(location = "."){
  # gsub("-", "--", Sys.Date())
  badgepaste(imagelink = paste0("https://img.shields.io/badge/last%20change-",
                                  "`r ", "gsub('-', '--', Sys.Date())", "`",
                                  "-yellowgreen.svg"),
               referlink = "/commits/master",
               name = "Last-changedate")
}

#' Creates last-change badge static
#' 
#' Will add current day to the repo. This function will 
#' not change when you reknit the readme. If you want that you will 
#' have to use the link{last_change_badge} function.
#' @export
#' @family badges
#' @param date if NULL/empty current date. otherwise use yyyy-mm-dd format
badge_last_change_static <- function(date = NULL){
  date <- ifelse(is.null(date), Sys.Date(), date)
  paste_ready_date <- gsub('-', '--', date)
  badgepaste(imagelink = paste0("https://img.shields.io/badge/last%20change-",
                                paste_ready_date,                                     "-yellowgreen.svg"),
               referlink = "/commits/master",
               name = "Last-changedate")
}


#' R documentation badge
#' 
#' Add a documentation badge, from DataCamp.
#' @param packagename the name of your package
#' @export
#' @family badges
#' @examples 
#' badge_rdocumentation("dplyr")
badge_rdocumentation <- function(packagename){
  badgepaste(
    imagelink = paste0("http://www.rdocumentation.org/badges/version/", packagename),
    referlink = paste0("http://www.rdocumentation.org/packages/", packagename),
    name = "Rdoc"
  )
}


#' Add a github star badge
#' 
#' @inheritParams badge_travis
#' @export
#' @family badges
badge_github_star <- function(ghaccount = NULL, ghrepo = NULL, 
                              branch = NULL, location = NULL){
    credentials<- github_credentials_helper(ghaccount = ghaccount, 
                                            ghrepo = ghrepo,
                                            branch = branch,
                                            location = location
    )
      
    badgepaste(
        imagelink = paste0("http://githubbadges.com/star.svg?user=", 
                           credentials$ghaccount, "&repo=", credentials$ghrepo,
                           "r&style=flat"),
        referlink = paste0("https://github.com/",credentials$ghaccount,"/",
                           credentials$ghrepo),
        name = "star this repo"
    )
}

#' Add a github fork badge
#' 
#' @inheritParams badge_travis
#' @export
#' @family badges
badge_github_fork <- function(ghaccount = NULL, ghrepo = NULL, location = NULL){
    credentials<- github_credentials_helper(ghaccount = ghaccount, 
                                            ghrepo = ghrepo,
                                            branch = NULL,
                                            location = location
    )
    
    badgepaste(
        imagelink = paste0("http://githubbadges.com/fork.svg?user=", 
                           credentials$ghaccount, "&repo=", 
                           credentials$ghrepo,"r&style=flat"),
        referlink = paste0("https://github.com/",credentials$ghaccount,"/",
                           credentials$ghrepo,"/fork"),
        name = "fork this repo"
    )
}

#' Create a licencebadge
#' 
#' when `licence= NULL' this function wil look in your
#' DESCRIPTION file and search for the "Licence:" part. 
#' If it matches GPL or MIT a custum badge will be created. 
#' If it does not match, a general badge will be created with the name of the
#' licence in grey.
#' @param location defaults to current directory
#' @param licence License, for example `GPL-3`, `MIT`, etc. Alternatively, leaving it empty will search.
#' @family badges
#' @return markdown
#' @export
badge_licence <- function(licence = NULL, location = "."){
    if(is.null(licence)){
        description <- read.dcf(file.path(location, "DESCRIPTION"))
        licencetype <- as.vector(description[1, "License"])
        if(length(licencetype) == 0) stop("No licence was described in DESCRIPTION")
    } else {
        licencetype <- licence
    }
    
    recommended_licenses <- c(
        "GPL-2", "GPL-3", #"LGPL-2", "LGPL-2.1", "LGPL-3", 
        #"AGPL-3", "Artistic-2.0",
        #"BSD_2_clause", "BSD_3_clause", 
        "MIT"
    )
    if(!(licencetype %in% recommended_licenses)){
        message("the licence ", licencetype, " is not recommended for R packages")
        badgepaste(imagelink = paste0("https://img.shields.io/badge/licence-",
                                      gsub("-","--", licencetype), "-lightgrey.svg"),
                   referlink = "http://choosealicense.com/")
    } else {
        licbadgebuilder(licencetype)
    }
}    

#' RPackages.io ranking
#' 
#' If this is something you care about, you can add
#' the current rank of your package to your readme. 
#' 
#' @param packagename the name of your package
#' @family badges
#' @return markdown
#' @export
badge_rank <- function(packagename){
    badgepaste(
        imagelink = paste0("https://www.rpackages.io/badge/", packagename, ".svg"),
        referlink = paste0("https://www.rpackages.io/package/", packagename),
        name = "rpackages.io rank"
    )
}
