#' A module for an Area Q summary section
#'
#' @description
#' A Shiny module that generates an Area Q summary section, intended to be used in `mod_results_primary`.
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @import bslib
#' @importFrom shinycssloaders withSpinner
#'
#' @examples
#'
#' if (interactive()) {
#' data("df_input_response_example")
#'
#' ui <- page(
#'   mod_results_section_area_q_ui("section_area_q")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   mod_results_section_area_q_server(
#'     "section_area_q",
#'     df_input_response_example,
#'     v_primary_date = max(df_input_response_example$date_of_evaluation))
#'
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @name mod_results_section_area_q
NULL
#' >null
