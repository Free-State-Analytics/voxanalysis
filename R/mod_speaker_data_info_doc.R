#' A module to view and modify the speaker data
#'
#' @description
#' A module that allows the user to view and modify speaker data.
#'
#'
#' @inheritParams common-params
#'
#' @import shiny
#'
#' @examples
#'
#' if (interactive()) {
#' data("df_input_speaker_info_example")
#' ui <- page(
#'    useShinyjs(),
#'    mod_speaker_data_info_ui("speaker")
#' )
#'
#' server <- function(input, output, session) {
#'    mod_speaker_data_info_server("speaker", df_input_speaker_info_example)
#' }
#' shinyApp(ui, server)
#' }
#'
#'
#' @name mod_speaker_data_info
NULL

