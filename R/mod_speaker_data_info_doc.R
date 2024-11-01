#' Speaker Data Viewing and Modification Module
#'
#' @description
#' This Shiny module provides an interface for users to view and modify speaker data in VOX Analysis.
#'
#' @inheritParams common-params
#'
#' @import shiny
#'
#' @examples
#' if (interactive()) {
#'   # Load example speaker information data
#'   data("df_input_speaker_info_example")
#'
#'   # Define the UI with speaker data viewing and modification capabilities
#'   ui <- page(
#'     useShinyjs(),
#'     mod_speaker_data_info_ui("speaker")
#'   )
#'
#'   # Set up the server with initial speaker data
#'   server <- function(input, output, session) {
#'     mod_speaker_data_info_server("speaker", df_input_speaker_info_example)
#'   }
#'
#'   # Run the Shiny app
#'   shinyApp(ui, server)
#' }
#'
#' @name mod_speaker_data_info
NULL
