#' Summary Report Generation Module
#'
#' @description
#' This Shiny module provides a user interface and server function to generate a summary report based on response inputs. It is designed to work independently of other modules, allowing users to create a comprehensive summary report for a VOX Analysis session.
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @import bslib
#'
#' @examples
#' if (interactive()) {
#'   # Load example data
#'   data("df_input_speaker_info_example")
#'   data("df_input_response_example")
#'
#'   # Define the UI with the summary report generation module
#'   ui <- page(
#'     mod_results_primary_ui("data_input")
#'   )
#'
#'   # Set up the server to include summary report functionality
#'   server <- function(input, output, session) {
#'     mod_results_primary_server(
#'       "data_input",
#'       df_input_speaker_info = df_input_speaker_info_example,
#'       df_input_response = df_input_response_example
#'     )
#'   }
#'
#'   # Run the Shiny app
#'   shinyApp(ui, server)
#' }
#'
#' if (interactive()) {
#'   # Alternative example using a pre-built app function
#'   run_example_results_app()
#' }
#'
#' @name mod_results_primary
NULL
