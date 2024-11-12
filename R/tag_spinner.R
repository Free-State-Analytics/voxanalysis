#' Add a Spinner to a UI Element
#'
#' Wraps a Shiny UI element with a spinner to indicate loading or processing activity.
#'
#' @param tag_to_pass The Shiny UI element to wrap with a spinner. Required.
#' @param color A character string specifying the spinner color in hexadecimal format. Default is `"#cce5f3"`.
#'
#' @return A UI element wrapped with a spinner.
#' @import shinycssloaders
#' @export
#'
#' @examples
#' \dontrun{
#' tag_spinner(shiny::textOutput("output_id"))
#' }
tag_spinner <- function(tag_to_pass, color = "#cce5f3") {
  req(tag_to_pass)

  withSpinner(
    tag_to_pass,
    type = getOption("spinner.type", default = 4),
    color = getOption("spinner.color", default = color)
  )
}
