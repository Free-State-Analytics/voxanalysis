#' A module for a  detailed analysis section
#'
#' @description
#' A Shiny module to generate a detailed analysis section, intended to be used in `mod_results_primary`.
#'
#' This module will generate Vox pie chart, Vox line chart, Cochran's Q test, and prompt hierarchy table.
#'
#'
#' @param id The namespace id.
#'
#' @import shiny
#' @import bslib
#' @importFrom shinycssloaders withSpinner
#'
#' @examples
#'
#' if (interactive()) {
#' data("df_input_speaker_info_example")
#' data("df_input_response_example")
#' data("df_input_response_previous_example")
#'
#' ui <- page(
#'   mod_results_section_detailed_analysis_ui("detailed_analysis")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   mod_results_section_detailed_analysis_server(
#'     "detailed_analysis",
#'     df_input_speaker_info = df_input_speaker_info_example,
#'     df_input_response = df_input_response_example,
#'     df_input_response_previous = df_input_response_previous_example)
#'
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#'
#' @name mod_results_section_detailed_analysis
NULL
#' >null
