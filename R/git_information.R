#' Return a list of remotes associated with this repo
#'
#' a function that checks the remote branches 
#' and returns their names.
#' 
#' @importFrom git2r repository remotes branches

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


# return_remotes <- function(debug = FALSE){
#     #probably a check if it is a repo?
#     if(git2r::is_empty()){stop("The repo seems to be empty")}
#     remotes <- git2r::branches(flags ="remote")
#     vars <- list()
#     for(i in seq_along(remotes)){
#         vars[[i]] <- remotes[[i]]@name
#         if(debug == TRUE){message("name is:", remotename)}
#         
#     }
#     vars
# }

#' Return the name of the repo and and username.
#' 
#' This information can be fed into the badeplacers.
# get_remote_reponame_username <- function(location = "."){
#     find_configuration <- git2r::config(location)
#     url <- find_configuration$local$remote.origin.url
#     splits <- stringr::str_split(url, pattern = "/")
#     end_nr <- grep("\\.git",x = splits[[1]])
#     endresult <- list(
#         reponame = gsub("\\.git","",splits[[1]][end_nr] ),
#         username = splits[[1]][end_nr-1]
#     )
#     endresult
# }
#get_remote_reponame_username()

#' Get the name of the current branch
# get_branch_name <- function(location = "."){
#     repo <- git2r::repository(location)
#     git2r::head(repo)@name
# }
#get_branch_name()


