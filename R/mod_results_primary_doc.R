#' A Shiny module to generate a summary report based on the response inputs
#'
#' @description
#' A module that generates a UI and server function to generate a summary report.
#'
#' Can operate independently of other modules.
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @import bslib
#'
#' @examples
#' data("df_input_speaker_info_example")
#' data("df_input_response_example")
#'
#' ui <- page(
#'   mod_results_primary_ui("data_input")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   mod_results_primary_server(
#'     "data_input",
#'     df_input_speaker_info = df_input_speaker_info_example,
#'     df_input_response = df_input_response_example)
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' ### Alternative
#' run_example_results_app()
#'
#' @name mod_results_primary
NULL
#' >null
