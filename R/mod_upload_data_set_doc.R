#' A Shiny module to upload a csv file
#'
#' @description
#' A Shiny module to allow the user to upload a .csv file with a speaker's data, via a user-interface.
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @import bslib
#' @importFrom shinyjs hidden show hide
#'
#' @examples
#'
#' if (interactive()) {
#' data("df_input_speaker_info_example")
#'
#' ui <- page(
#'   mod_upload_data_set_ui("upload")
#' )
#'
#' server <- function(input, output, session) {
#'   mod_upload_data_set_server("upload", df_input_speaker_info_example, add_new_data_ind = TRUE)
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' ## Alternative
#' if (interactive()) {
#' run_example_upload_data_set_app <- function(add_new_data_ind = TRUE)
#' }
#'
#'
#' @name mod_upload_data_set
NULL
#' >null
