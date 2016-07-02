# git recognition part


#' Give or search for github name and repo.
#'
#' @param account accountname or search for
#' @param repo repositoryname or search for
#' @param branch master, develop etc.
#'
#' @return markdown text to be placed in readme
#' @export
#'
#' 
githubcredentials <- function(account = "search", repo = "search", branch = "master"){
    if(account == "search"){
        if(repo != "search"){stop("provide accountname and reponame please")}
        link <- git2r::remote_url(git2r::repository())
        credz <- gsub(".git", "", gsub("https://github.com/", "", link))
        ghaccount <- gsub("/[A-z]{3,}", "", credz)
        ghrepo <- gsub("[A-z]{3,}/", "", credz)
        branch <- attr(git2r::branches(flags = "local"), "names")
    }else{
        ghaccount <- account
        ghrepo <- repo
        branch <- branch    
    }
    return(
        as.list(
            c(ghaccount= ghaccount, ghrepo = ghrepo, branch= branch)
            
        )
    )
    
}
