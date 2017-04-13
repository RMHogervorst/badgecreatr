# utils 
# Functions for internal use. 
# 

#' return markdown with image and link. 
#' 
#' for internal use. used within licencebuilder
#'
#' @param imagelink link to image file
#' @param referlink link to where to send to on click
#' @param name what to call the button
#'
#' @return markdown
badgepaste<- function(imagelink, referlink, name= "Licence"){
    paste0("[![", name,"]","(",imagelink, ")]","(",referlink,")")
}
# tests

#' Returns github accountname, repo name and current branch.
github_credentials_helper <- function(ghaccount = NULL, ghrepo = NULL, 
                                      branch = NULL, location = "."){
    if(any(is.null(ghaccount), is.null(ghrepo), is.null(branch))) {
        git_info <- search_git(location)
        }
    if(is.null(ghaccount)) {ghaccount <- git_info$account}
    if(is.null(ghrepo)) {ghrepo  <- git_info$repo}
    if(is.null(branch)){branch <- git_info()$branch
    }
    return(list(ghaccount = ghaccount, ghrepo = ghrepo, branch = branch))
}
# github_credentials_helper("sjors", "hoi", "master")
