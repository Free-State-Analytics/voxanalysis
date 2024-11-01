#' Helper Functions to Demonstrate Application and Module Combinations
#'
#' @description
#' This set of helper functions allows users to easily run and test various combinations of VOX Analysis applications and modules. Each function includes example data, providing a straightforward way to demonstrate different functionalities without requiring additional setup.
#'
#' @inheritParams common-params
#'
#' @examples
#' # Run the results page application
#' if (interactive()) {
#'   run_example_results_app()
#' }
#'
#' # Run the response input page application
#' if (interactive()) {
#'   run_example_response_entry_app()
#' }
#'
#' # Run the upload data page application
#' # Set ind_add_new_data = TRUE to include the response entry page
#' if (interactive()) {
#'   run_example_upload_data_set_app(ind_add_new_data = FALSE)
#' }
#'
#' # Run the speaker data entry application
#' if (interactive()) {
#'   run_example_speaker_data_entry_app()
#' }
#'
#' @name run_example
NULL

#' @rdname run_example
#' @import shiny
#' @import bslib
#' @importFrom shinyjs useShinyjs
#' @export
run_example_results_app <- function() {
  df_input_speaker_info_example <- voxanalysis::df_input_speaker_info_example
  df_input_response_previous_example <- voxanalysis::df_input_response_previous_example

  ui <- page(
    useShinyjs(),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),
    mod_results_primary_ui("primary")
  )

  server <- function(input, output, session) {
    mod_results_primary_server(
      "primary",
      df_input_speaker_info = df_input_speaker_info_example,
      df_input_response = df_input_response_previous_example
    )
  }

  shinyApp(ui, server)

}

#' @rdname run_example
#' @import shiny
#' @import bslib
#' @importFrom shinyjs useShinyjs
#' @export
run_example_response_entry_app <- function() {
  df_input_speaker_info_example <- voxanalysis::df_input_speaker_info_example
  ui <- page(
    useShinyjs(),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),
    mod_response_entry_ui("data_entry")
  )
  server <- function(input, output, session) {
    mod_response_entry_server("data_entry", df_input_speaker_info_example)
  }
  shinyApp(ui, server)
}

#' @rdname run_example
#' @import shiny
#' @import bslib
#' @importFrom shinyjs useShinyjs
#' @export
run_example_upload_data_set_app <- function(ind_add_new_data = TRUE) {
  ui <- page(
    useShinyjs(),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),
    mod_upload_data_set_ui("upload")
  )

  server <- function(input, output, session) {
    mod_upload_data_set_server("upload", ind_add_new_data = ind_add_new_data)
  }

  shinyApp(ui, server)

}

#' @rdname run_example
#' @import shiny
#' @import bslib
#' @importFrom shinyjs useShinyjs
#' @export
run_example_speaker_data_entry_app <- function() {

  ui <- page(
    useShinyjs(),
    mod_speaker_data_entry_ui("speaker_entry")
  )

  server <- function(input, output, session) {
    mod_speaker_data_entry_server("speaker_entry")
  }

  shinyApp(ui, server)

}
