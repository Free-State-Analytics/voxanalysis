#' Application Home Page Module
#'
#' @description
#' This Shiny module defines the home page for the VOX Analysis application, serving as the main entry point for users. It contains the primary layout and navigation elements for accessing various sections of the app.
#'
#' @inheritParams common-params
#'
#' @import shiny
#'
#' @examples
#' if (interactive()) {
#'   # Define the UI with the application's home page
#'   ui <- page(
#'     useShinyjs(),
#'     mod_starting_page_ui("home_page")
#'   )
#'
#'   # Set up the server for the home page module
#'   server <- function(input, output, session) {
#'     mod_starting_page_server("home_page")
#'   }
#'
#'   # Run the Shiny app
#'   shinyApp(ui, server)
#' }
#'
#' @name mod_starting_page
NULL
