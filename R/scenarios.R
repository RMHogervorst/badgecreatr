### scenarios

#' Add a minimum of badges to your project
#' 
#' Returns markdown to manually place in your readme.Rmd file.
#' This is a function you might want to use in the early stages of your project.
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


