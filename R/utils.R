# utils 
# Functions for internal use. 
# 

#' return markdown with image and link. 
#' 
#' for internal use. used within licensebuilder
#'
#' @param imagelink link to image file
#' @param referlink link to where to send to on click
#' @param name what to call the button
#'
#' @return markdown
badgepaste<- function(imagelink, referlink, name= "license"){
    paste0("[![", name,"]","(",imagelink, ")]","(",referlink,")")
}
# tests

#' Returns github accountname, repo name and current branch.
#' 
#' @inheritParams badge_travis
github_credentials_helper <- function(ghaccount = NULL, ghrepo = NULL, 
                                      branch = NULL, location = "."){
    if(any(is.null(ghaccount), is.null(ghrepo), is.null(branch))) {
        git_info <- search_git(location)
        
    if(is.null(ghaccount)) {ghaccount <- git_info$account}
    if(is.null(ghrepo)) {ghrepo  <- git_info$repo}
    if(is.null(branch)){branch <- git_info$branch
    }}
    return(list(ghaccount = ghaccount, ghrepo = ghrepo, branch = branch))
}
# github_credentials_helper("sjors", "hoi", "master")
# github_credentials_helper()
# github_credentials_helper("sjors", "hoi")
# ghaccount = "bal"

#' Return a list of remotes associated with this repo
#'
#' a function that checks the remote branches 
#' and returns their names.
#' 
#' @importFrom git2r repository remotes branches
#' @param location defaults to current location
search_git <- function(location = "."){
    if(!dir.exists(location)) stop("location is not a folder")
    repo <- tryCatch(git2r::repository(location), error=function(e)e)
    if(inherits(repo, "error")) stop("location does not contain a valid git repo")
    remote <- git2r::remote_url(repo)  
    z <- gsub(".*?(\\w*/\\w*).*$", "\\1", remote)
    zz <- strsplit(z, "/")[[1]]
    list(account = zz[1], 
         repo = zz[2],
         branch = git2r::branches(repo, flags = "local")[[1]]@name
    )
}
