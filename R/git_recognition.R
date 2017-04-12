# git recognition part


#' Give or search for github name and repo.
#' If you don't put anything here, leaving everything empty,
#' this function will check the git repository for information.
#'
#' @param account accountname 
#' @param repo repositoryname 
#' @param branch master, develop etc.
#'
#' @return markdown text to be placed in readme
githubcredentials <- function(account = NULL, repo = NULL, branch = NULL){
    if(is.null(account)|is.null(repo)){
        #if(repo != "search"){stop("provide accountname and reponame please")}
        link <- git2r::remote_url(git2r::repository())
        credentials <- gsub(".git", "", gsub("https://github.com/", "", link))
        ghaccount <- gsub("/[A-z]{3,}", "", credentials)
        ghrepo <- gsub("[A-z]{3,}/", "", credentials)
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
