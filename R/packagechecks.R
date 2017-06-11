#' Place badges inside a readme.Rmd file
#' 
#' This is the main function to add badges to your readme.
#'
#' @param location folder where readme.rmd resides
#' @param status one of: "concept", "wip", "suspended", "abandoned", "active", "inactive",  or "unsupported"
#' @param githubaccount your githubname
#' @param githubrepo your githubrepositoryname
#' @param branch master, develop, etc.
#' @param name which file to place badges in, defaults to README.Rmd
#'
#' @return readme file with added badges
#' @export
#'
badgeplacer <- function(location = ".", status = "active",  
                        githubaccount = NULL, githubrepo = NULL, 
                        branch = NULL, name = "README.Rmd"){
    git_info <- search_git(location)
    if(is.null(githubaccount)){
        githubaccount <- git_info$account
    }
    if(is.null(githubrepo)){
        githubrepo  <- git_info$repo
    }
    if(is.null(branch)){
        #default to master when you can't find something.
        branch <- git_info$branch
    }
    if(branch == ""){branch <- "master"}
    badge_result <- findbadges(location, name)
    if(sum(sapply(badge_result, length))==0){message("no badges found in readme.")}
    #account <- githubcredentials(account = githubaccount,repo = githubrepo,
                               #  branch = branch)
    readme <- readLines(file.path(location,name ))
    # find yaml top content
    if(length(grep("---", readme))<2){stop("no top yaml at ", name)}
    bottomyaml <- grep("---", readme)[2]
    # action based on bagdge_result
    #if(length(sapply(bagdge_result, length))==0){
        readme <- append(readme, c(
            if(!badge_result$projectstatus_readme){
                badge_projectstatus(status)
            },
            if(!badge_result$licencebadge_readme){
                                       licbadgebuilder(badge_result$licence)   
            },
             if(!badge_result$travisbadge_readme){
                 if(badge_result$travisfile){
                     badge_travis(
                                 ghaccount = githubaccount, 
                                 ghrepo = githubrepo ,
                                 branch = branch,
                                 location = location)
                 }else message("No .travis.yml file was found, no travis badge will be created")
                                        
            },
            if(!badge_result$codecoverage_readme){
                if(badge_result$codecov_in_travisfile){
                    badge_codecov(ghaccount = githubaccount, 
                                 ghrepo = githubrepo ,
                                 branch = branch,
                                 location = location)
                }else message("There was no .travis.yml or no codecov was set up in travis, no codecovbadge created")
                                       
            },
            if(!badge_result$rversion_readme){
                badge_minimal_r_version()
            },
            if(!badge_result$cranbadge_readme){
                badge_cran(badge_result$packagename)      
            },
             if(!badge_result$packageversionbadge_readme){
                 badge_packageversion() 
             } ,
            if(!badge_result$last_change_readme)badge_last_change()
                                   ), 
                         bottomyaml)
        

    writeLines(readme, con = file.path(location,name ))
    message("badges placed at top of readme.rmd document")
}


