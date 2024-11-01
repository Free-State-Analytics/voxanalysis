#' Speaker Data Entry Module
#'
#' @description
#' This Shiny module provides a user interface for entering speaker data, triggering a data entry prompt followed by a report output. It can be used to collect speaker information for VOX Analysis.
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @import bslib
#'
#' @examples
#' if (interactive()) {
#'   # Basic usage example
#'   ui <- page(
#'     useShinyjs(),
#'     mod_speaker_data_entry_ui("speaker_entry")
#'   )
#'
#'   server <- function(input, output, session) {
#'     mod_speaker_data_entry_server("speaker_entry")
#'   }
#'
#'   shinyApp(ui, server)
#' }
#' @name mod_speaker_data_entry
NULL
