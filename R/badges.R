# badge placers  #######################
# These functions create the markdown necessary to display the badges
#
# Most badges wil be created with the badgepaste function defined in utils.

# ------------------------------------------------------------------------

#' Add project status badge
#'
#' Project-status is based on the repo-status project on \url{https://www.repostatus.org/}.
#' A project-status badge gives a clear indication of the current state of a project. This
#' helps answer questions about development (whether or not further development is planned)
#' and support (whether bugfixes and user assistance will be given).
#'
#' @section Project Statuses:
#' The following list is a literal copy of repostatus.org
#'
#' * Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.
#' * WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.
#' * Suspended – Initial development has started, but there has not yet been a stable, usable release; work has been stopped for the time being but the author(s) intend on resuming work.
#' * Abandoned – Initial development has started, but there has not yet been a stable, usable release; the project has been abandoned and the author(s) do not intend on continuing development.
#' * Active – The project has reached a stable, usable state and is being actively developed.
#' * Inactive – The project has reached a stable, usable state but is no longer being actively developed; support/maintenance will be provided as time allows.
#' * Unsupported – The project has reached a stable, usable state but the author(s) have ceased all work on it. A new maintainer may be desired.
#' * Moved - The project has been moved to a new location, and the version at that location should be considered authoritative. This status should be accompanied by a new URL.
#'
#' @param status one of concept, wip, suspended, abandoned, active, inactive, unsupported, or moved
#' @family badges
#' @return markdown
#' @examples
#' badge_projectstatus("unsupported")
#' @export
badge_projectstatus <- function(status = "concept"){
  name <- c("concept", "wip", "suspended", "abandoned", "active", "inactive", "unsupported", "moved")
  if(!status %in% name)stop("status needs to be one of concept, wip, suspended, abandoned, active, inactive, unsupported, or moved")
  projectstatus <- paste0("https://www.repostatus.org/badges/latest/",status, "_md.txt" )
  repostatus <- readLines(con = projectstatus, encoding = "UTF-8" )
  #repostatus <- readLines(textConnection(projectstatus, encoding="UTF-8"), encoding="UTF-8")
  #repostatus <- gsub("â€“", "-", repostatus)
  repostatus
}

# ----------------------------------------------------------------------

#' Add license badge
#'
#' @param licensetype one of GPL-3, GPL-2, MIT, or CC0.
#' @return markdown
#' @examples
#' badgecreatr:::licbadgebuilder("GPL-3")
licbadgebuilder <- function(licensetype){
  switch (licensetype,
          "GPL-2" = {badgepaste("https://img.shields.io/badge/license-GPL--2-blue.svg",
                                  "https://www.gnu.org/licenses/old-licenses/gpl-2.0.html")},
          "GPL-3" = {badgepaste("https://img.shields.io/badge/license-GPL--3-blue.svg",
                                  "https://www.gnu.org/licenses/gpl-3.0.en.html")},
          "MIT" = {badgepaste("https://img.shields.io/github/license/mashape/apistatus.svg",
                                "https://choosealicense.com/licenses/mit/")},
          "CC0" = {badgepaste("https://img.shields.io/badge/license-CC0-blue.svg",
                                "https://choosealicense.com/licenses/cc0-1.0/")}
  )
}


# -------------------------------------------------------------------------

#' Travisbadge creates travis badge.
#'
#' @param ghaccount Github account name
#' @param ghrepo Github repository name
#' @param branch branch name such as master, develop etc
#' @param location defaults to current location
#' @family badges
#' @return markdown
#' @examples
#' badge_travis(ghaccount = "johntest", ghrepo = "yourreponame", branch = "master")
#' @export
badge_travis <- function(ghaccount = NULL, ghrepo = NULL, branch = NULL,
                         location = "."){
    if(any(is.null(ghaccount), is.null(ghrepo), is.null(branch))){
        credentials<- github_credentials_helper(ghaccount = ghaccount,
                                                ghrepo = ghrepo,
                                                branch = branch,
                                                location = location
        )
    }else{
        credentials <- list(
            ghaccount = ghaccount,
            ghrepo = ghrepo,
            branch = branch
        )
    }


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
#' @return markdown
#' @examples
#' badge_codecov(ghaccount = "johntest", ghrepo = "yourreponame", branch = "master")
#' @export
badge_codecov <- function(ghaccount = NULL, ghrepo = NULL, branch=NULL, location = "."){
    if(any(is.null(ghaccount), is.null(ghrepo), is.null(branch))){
        credentials<- github_credentials_helper(ghaccount = ghaccount,
                                                ghrepo = ghrepo,
                                                branch = branch,
                                                location = location
        )
    }else{
        credentials <- list(
            ghaccount = ghaccount,
            ghrepo = ghrepo,
            branch = branch
            )
    }
  referlink <- paste0("https://codecov.io/gh/", credentials$ghaccount, "/", credentials$ghrepo)
  imagelink <- paste0(referlink,
                      "/branch/", credentials$branch,
                      "/graph/badge.svg" )
  codecovbadge <-badgepaste(imagelink,referlink, name =  "codecov")
  codecovbadge
}


# -----------------------------------------------------------------------

#' Display the minimal R version
#'
#' @return markdown
#' @export
#' @param chunk places a r chunk in the readme
#' @family badges
#' @return Rmarkdown
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

#' Add a badge for CRAN
#'
#' Shows the version number of the package on CRAN,
#' or “not published” if the package is not published on CRAN.
#' See \url{https://r-pkg.org/services#badges}
#' One of the metacran badges.
#' @param packagename the name of your package
#'
#' @return markdown
#' @export
#' @family badges
#' @examples
#' badge_cran("dplyr")
badge_cran <- function(packagename){
  img_link <- paste0("https://www.r-pkg.org/badges/version/", packagename)
  refer_link <- paste0("https://cran.r-project.org/package=", packagename)
  badgepaste(imagelink =img_link,
               referlink = refer_link,
               name = "CRAN_Status_Badge")
}

# Variations on CRAN versions and release dates. ------------------

#' CRAN version and release in time
#'
#' See \url{https://r-pkg.org/services#badges}
#' One of the metacran badges.
#' @param packagename the name of your package
#'
#' @return markdown
#' @export
#' @family badges
#' @examples
#' badge_cran_version_ago("dplyr")
badge_cran_version_ago <- function(packagename){
    img_link <- paste0("https://www.r-pkg.org/badges/version-ago/", packagename)
    refer_link <- paste0("https://cran.r-project.org/package=", packagename)
    badgepaste(imagelink =img_link,
               referlink = refer_link,
               name = "CRAN_Status_Badge_version_ago")

}


#' CRAN version and date of release
#'
#' @inheritParams badge_cran_version_ago
#' @export
#' @family badges
#' @return markdown
#' @examples
#' badge_cran_version_release("dplyr")
badge_cran_version_release <- function(packagename){
    img_link <- paste0("https://www.r-pkg.org/badges/version-last-release/", packagename)
    refer_link <- paste0("https://cran.r-project.org/package=", packagename)
    badgepaste(imagelink =img_link,
               referlink = refer_link,
               name = "CRAN_Status_Badge_version_last_release")

}

#' CRAN time ago released
#'
#' @inheritParams badge_cran_version_ago
#' @export
#' @family badges
#' @return markdown
#' @examples
#' badge_cran_ago("dplyr")
badge_cran_ago <- function(packagename){
    img_link <- paste0("https://www.r-pkg.org/badges/ago/", packagename)
    refer_link <- paste0("https://cran.r-project.org/package=", packagename)
    badgepaste(imagelink =img_link,
               referlink = refer_link,
               name = "CRAN_time_from_release")

}

#https://www.r-pkg.org/badges/last-release/{package}
#' CRAN release date of current version.
#' @inheritParams badge_cran_version_ago
#' @export
#' @family badges
#' @return markdown
#' @examples
#' badge_cran_date("dplyr")
badge_cran_date <- function(packagename){
    img_link <- paste0("https://www.r-pkg.org/badges/last-release/", packagename)
    refer_link <- paste0("https://cran.r-project.org/package=", packagename)
    badgepaste(imagelink =img_link,
               referlink = refer_link,
               name = "CRAN_latest_release_date")
}


#' Add a badge for downloads from CRAN
#'
#' Display the number of downloads from CRAN. Use
#' last-week, last-day, or grand-total, defaults to montly.
#'
#' @param packagename name of the package
#' @param period defaults to month, other options are last-week, last-day, grand-total
#' @export
#' @return markdown
#' @examples
#' badge_cran_downloads("dplyr", period = "last-week")
badge_cran_downloads <- function(packagename, period = NULL){
    if(is.null(period)){
        paste_thing <-  packagename
        }else{
            if(!period %in% c("last-week", "last-day","grand-total"))stop("Use last-week, last-day, or grand-total for period")
            paste_thing <- paste0(period, "/",packagename)
        }# do something with missing
    badgepaste(imagelink = paste0("https://cranlogs.r-pkg.org/badges/",paste_thing),
               referlink = paste0("https://cran.r-project.org/package=", packagename),
               name = "metacran downloads")
}


# ----------------------------------------------------------------------
#' Place a badge with the version of your package.
#'
#' Place a badge with the version of your package which is automatically read from
#' your description file.
#' @param chunk this argument places a RMarkdown chunk
#' @return Rmarkdown
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

#' Creates last-change badge
#'
#' Will add a badge containing the current date that changes
#' on every reknitting. This is a simple pasting of r-code.
#' @family badges
#' @param location defaults to working directory
#' @return Rmarkdown
#' @export
badge_last_change <- function(location = "."){
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
#' @return markdown
#' @param date if NULL/empty current date. otherwise use yyyy-mm-dd format
badge_last_change_static <- function(date = NULL){
  date_1 <- ifelse(is.null(date), as.character(Sys.Date()), date)
  paste_ready_date <- gsub('-', '--', date_1)
  badgepaste(imagelink = paste0("https://img.shields.io/badge/last%20change-",
                                paste_ready_date,"-yellowgreen.svg"),
               referlink = "/commits/master",
               name = "Last-changedate")
}


#' R documentation badge
#'
#' Add a documentation badge, from DataCamp.
#' @param packagename the name of your package
#' @export
#' @family badges
#' @return markdown
#' @examples
#' badge_rdocumentation("dplyr")
badge_rdocumentation <- function(packagename){
  badgepaste(
    imagelink = paste0("https://www.rdocumentation.org/badges/version/", packagename),
    referlink = paste0("https://www.rdocumentation.org/packages/", packagename),
    name = "Rdoc"
  )
}


#' Add a Github star badge
#'
#' @inheritParams badge_travis
#' @export
#' @family badges
#' @return markdown
badge_github_star <- function(ghaccount = NULL, ghrepo = NULL,
                              branch = NULL, location = NULL){
    credentials<- github_credentials_helper(ghaccount = ghaccount,
                                            ghrepo = ghrepo,
                                            branch = branch,
                                            location = location
    )

    badgepaste(
        imagelink = paste0("https://githubbadges.com/star.svg?user=",
                           credentials$ghaccount, "&repo=", credentials$ghrepo,
                           "r&style=flat"),
        referlink = paste0("https://github.com/",credentials$ghaccount,"/",
                           credentials$ghrepo),
        name = "star this repo"
    )
}

#' Add a Github fork badge
#'
#' @inheritParams badge_travis
#' @export
#' @family badges
#' @return markdown
badge_github_fork <- function(ghaccount = NULL, ghrepo = NULL, location = NULL){
    credentials<- github_credentials_helper(ghaccount = ghaccount,
                                            ghrepo = ghrepo,
                                            branch = NULL,
                                            location = location
    )

    badgepaste(
        imagelink = paste0("https://githubbadges.com/fork.svg?user=",
                           credentials$ghaccount, "&repo=",
                           credentials$ghrepo,"r&style=flat"),
        referlink = paste0("https://github.com/",credentials$ghaccount,"/",
                           credentials$ghrepo,"/fork"),
        name = "fork this repo"
    )
}

#' Create a licensebadge
#'
#' when `license= NULL' this function will look in your
#' DESCRIPTION file and search for the "license:" part.
#' If it matches GPL or MIT a custom badge will be created.
#' If it does not match, a general badge will be created with the name of the
#' license in grey.
#' @param location defaults to current directory
#' @param license License, for example `GPL-3`, `MIT`, etc. Alternatively, leaving it empty will search.
#' @family badges
#' @return markdown
#' @export
badge_license <- function(license = NULL, location = "."){
    if(is.null(license)){
        description <- read.dcf(file.path(location, "DESCRIPTION"))
        licensetype <- as.vector(description[1, "License"])
        if(length(licensetype) == 0) stop("No license was described in DESCRIPTION")
    } else {
        licensetype <- license
    }

    recommended_licenses <- c(
        "GPL-2", "GPL-3", #"LGPL-2", "LGPL-2.1", "LGPL-3",
        #"AGPL-3", "Artistic-2.0",
        #"BSD_2_clause", "BSD_3_clause",
        "MIT"
    )
    if(!(licensetype %in% recommended_licenses)){
        message("the license ", licensetype, " is not recommended for R packages")
        badgepaste(imagelink = paste0("https://img.shields.io/badge/license-",
                                      gsub("-","--", licensetype), "-lightgrey.svg"),
                   referlink = "https://choosealicense.com/")
    } else {
        licbadgebuilder(licensetype)
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



#' Add thanks badge
#' 
#' Add a thanks badge and file to your project.
#' @param add_file Should the badge add the THANKS.md file to your project?
#' 
#' @source <https://github.com/paulmolluzzo/thanks-md>
#' @family badges
#' @return markdown
#' @export
badge_thanks_md <- function(add_file = TRUE){
    if(!file.exists("THANKS.md") & add_file ){file.create("THANKS.md")}
    badgepaste(
        imagelink = "https://img.shields.io/badge/THANKS-md-ff69b4.svg",
        referlink = "THANKS.md",
        name = "thanks-md"
    )
}

