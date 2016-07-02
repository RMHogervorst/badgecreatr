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
licencepaste<- function(imagelink, referlink, name= "Licence"){
    paste0("[![", name,"]","(",imagelink, ")]","(",referlink,")")
}
# tests
