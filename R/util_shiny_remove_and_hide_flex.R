#' Remove Flex Classes for Compatibility with `shinyjs::hide()`
#'
#' @description
#' When an HTML tag has the `d-flex flex-fill` classes applied, it can interfere with the functionality of `shinyjs::hide()`. This utility function removes these classes from the specified tag, ensuring `shinyjs::hide()` works as expected to hide the element.
#'
#' @param inputId The ID of the HTML tag to modify and hide.
#' @importFrom shinyjs hide
#'
#' @export


util_shiny_remove_and_hide_flex <- function(inputId) {

  shinyjs::hide(inputId)
  shinyjs::removeClass(inputId, "d-flex flex-fill")
}
