#' A Shiny module to input speaker data
#'
#' @description
#' A module that allows the user to enter speaker data via a prompt.
#'
#' It subsequently triggers a data entry prompt and a report output.
#'
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @import bslib
#'
#' @examples
#'
#' if (interactive()) {
#'
#' ui <- page(
#'   useShinyjs(),
#'   mod_speaker_data_entry_ui("speaker_entry")
#' )
#'
#' server <- function(input, output, session) {
#'   mod_speaker_data_entry_server("speaker_entry")
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#'
#' ### Alternative: include previous speaker data
#' if (interactive()) {
#' data("df_input_speaker_info_example")
#'
#' ui <- page(
#'   useShinyjs(),
#'   mod_speaker_data_entry_ui("speaker_entry")
#' )
#'
#' server <- function(input, output, session) {
#'   mod_speaker_data_entry_server(
#'   "speaker_entry",
#'   df_input_speaker_info = df_input_speaker_info_example)
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @name mod_speaker_data_entry
NULL
#' >null
