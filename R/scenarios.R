### scenarios

#' Add a minimum of badges to your project
#' 
#' Returns markdown to manually place in your readme.Rmd file.
#' This is a function you might want to use in the early stages of your project.
#' This function returns badges link{projectstatusbadge}, link(licencebadge), 
#' and link(last_change_badge_static).
#' @family scenarios
#' @param status one of concept, wip, suspended, abandoned, active, inactive or unsupported
#' @param licence one of GPL-3, GPL-2, MIT, or CC0.
#' @return text to put into rmd
#' @export
#' @examples 
#' minimal_badges("abandoned", "GPL-3")
minimal_badges <- function(status = "concept",licence = "search" ){
    paste0(
        projectstatusbadge(status = status),
        licencebadge(licence = licence),
        last_change_badge_static()
    )
}

#' Add dynamic content to readme
#' 
#' This function returns markdown that you must place in the readme. This is
#' dynamic content. This function returns a RMarkdown piece that does some
#' calculation and a set of badges underneath.
#' @family scenarios
#' @param status one of concept, wip, suspended, abandoned, active, inactive or unsupported
#' @param licence one of GPL-3, GPL-2, MIT, or CC0.
#' @return text to put into rmd
#' @export
#' @examples 
#' dynamic_badges_minimal("abandoned", "GPL-3") 
dynamic_badges_minimal <- function(status = "concept",licence = "search",
                                   last_change = TRUE, minimal_r_version = TRUE,
                                   travisfile= "search", codecov = "search"){
    # apply some logic to search for travis and codecov
    if(any(travisfile == "search", codecov == "search")){
        badges <- findbadges()
        travisfile <- badges$travisfile
        codecov <- badges$codecov_in_travisfile
    }
    

    paste0(
        "```{r, echo = FALSE}", 
        eval(expression("description <- readLines(\"DESCRIPTION\")")), 
        eval(expression(paste("version <- gsub(\" \", \"\", gsub(\"Version:\", \"\",",
                              "grep(\"Version:\", description, value = TRUE)))"))),
        "```",
        projectstatusbadge(status = status),
        licencebadge(licence = licence),
        if(last_change){last_change_badge()} ,
        if(minimal_r_version){minimal_r_version_badge(FALSE)},
        packageversionbadge(FALSE),
        if(travisfile){
            travisbadge()
        },
        if(codecov){
            codecovbadge()
        }
        )
    
}
#dynamic_badges_minimal()
#dynamic_badges_minimal(status = "active",last_change = FALSE,minimal_r_version = FALSE)
