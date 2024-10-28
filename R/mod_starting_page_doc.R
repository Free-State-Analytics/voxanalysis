#' A module for the application's home page
#'
#' @description
#' A Shiny module containing the home page for the application (basically the entire app).
#'
#'
#' @inheritParams common-params
#'
#' @import shiny
#'
#' @examples
#'
#' if (interactive()) {
#' ui <- page(
#'    useShinyjs(),
#'    mod_starting_page_ui("home_page")
#' )
#'
#' server <- function(input, output, session) {
#'    mod_starting_page_server("home_page")
#' }
#' shinyApp(ui, server)
#' }
#'
#'
#' @name mod_starting_page
NULL
#' >null
