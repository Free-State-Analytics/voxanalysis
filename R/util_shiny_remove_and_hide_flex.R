#' Removes flex classes from interfering with hide function
#'
#' @description
#' Whenever a class of `d-flex flex-fill` is used in an HTML tag `class`, `shinyjs::hide()` does not work.
#'
#' This utility function removes the classes and hides the tag.
#'
#' @param inputId The tag ID
#' @importFrom shinyjs hide
#' @export



util_shiny_remove_and_hide_flex <- function(inputId) {

  shinyjs::hide(inputId)
  shinyjs::removeClass(inputId, "d-flex flex-fill")
}
