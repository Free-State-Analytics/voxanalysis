#' Download Bar Module for Exporting Data and Reports
#'
#' @description
#' A Shiny module that provides a download interface, allowing users to export data and generate a Word document report. This module is useful for users needing an easily accessible download bar to retrieve their VOX Analysis results in structured formats for further analysis or reporting.
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @importFrom utils write.csv
#'
#' @examples
#' if (interactive()) {
#'   # Load example data
#'   data("df_input_speaker_info_example")
#'   data("df_input_response_example")
#'   data("df_summarized_response_example")
#'
#'   # Define the UI with the download bar
#'   ui <- page(
#'     mod_download_bar_ui("download_bar")
#'   )
#'
#'   # Set up the server to include the download bar functionality
#'   server <- function(input, output, session) {
#'     mod_download_bar_server(
#'       "download_bar",
#'       df_input_speaker_info = df_input_speaker_info_example,
#'       df_input_response = df_input_response_example,
#'       df_summarized_response = df_summarized_response_example
#'     )
#'   }
#'
#'   # Run the Shiny app
#'   shinyApp(ui, server)
#' }
#'
#' @name mod_download_bar
NULL

