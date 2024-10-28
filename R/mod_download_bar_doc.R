#' A module for a download bar
#'
#' @description
#' A Shiny module to allow a user to download the exportable data set and word doc report.
#'
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @importFrom utils write.csv
#'
#' @examples
#' if (interactive()) {
#' data("df_input_speaker_info_example")
#' data("df_input_response_example")
#' data("df_summarized_response_example")
#'
#' ui <- page(
#'   mod_download_bar_ui("download_bar")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   mod_download_bar_server(
#'     "download_bar",
#'     df_input_speaker_info = df_input_speaker_info_example,
#'     df_input_response = df_input_response_example,
#'     df_summarized_response = df_summarized_response_example)
#'
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @name mod_download_bar
NULL
#' >null
