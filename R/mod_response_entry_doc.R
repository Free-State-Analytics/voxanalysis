#' A Shiny module to enter speaker data and render a report
#'
#'
#' @description
#' A module that generates a UI and server function to allow the user to enter speaker data and render a report.
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @importFrom shinyjs useShinyjs
#' @import bslib
#'
#' @examples
#' if (interactive()) {
#' data("df_input_speaker_info_example")
#'
#' ui <- page(
#'   useShinyjs(),
#'   mod_response_entry_ui("data_entry")
#' )
#'
#' server <- function(input, output, session) {
#'   mod_response_entry_server("data_entry", df_input_speaker_info_example)
#' }
#'
#' }
#' shinyApp(ui, server)
#'
#' if (interactive()) {
#' ### Alternative
#' run_example_measurment_entry_app()
#' }
#'
#' @name mod_response_entry
NULL
#' >NULL
