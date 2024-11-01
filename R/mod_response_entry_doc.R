#' Speaker Data Entry and Report Generation Module
#'
#' @description
#' This Shiny module provides a user interface and server function that allows users to enter speaker data for a VOX Analysis and generate a corresponding report. The module is designed to streamline data entry and report generation within the analysis workflow.
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @importFrom shinyjs useShinyjs
#' @import bslib
#'
#' @examples
#' if (interactive()) {
#'   # Load example speaker information data
#'   data("df_input_speaker_info_example")
#'
#'   # Define the UI with data entry and report functionality
#'   ui <- page(
#'     useShinyjs(),
#'     mod_response_entry_ui("data_entry")
#'   )
#'
#'   # Set up the server to include data entry functionality
#'   server <- function(input, output, session) {
#'     mod_response_entry_server("data_entry", df_input_speaker_info_example)
#'   }
#'
#'   # Run the Shiny app
#'   shinyApp(ui, server)
#' }
#'
#' if (interactive()) {
#'   # Alternative example using a pre-built app function
#'   run_example_measurement_entry_app()
#' }
#'
#' @name mod_response_entry
NULL

