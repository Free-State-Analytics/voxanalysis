#' Helper functions to run and test various applications / modules
#'
#' @description
#' A series of helper functions to allow easy demonstration of various application / module combos.
#'
#' Example data is included within the functions.
#'
#' @inheritParams common-params
#'
#' @examples
#' # Runs the results page
#' if (interactive()) {
#'   run_example_results_app()
#' }
#'
#'
#' # Runs the response input page
#' if (interactive()) {
#'   run_example_response_entry_app()
#' }
#'
#' # Runs the upload data page. Change add_new_data_ind = TRUE to include response_entry page
#'
#' if (interactive()) {
#'   run_example_upload_data_set_app(add_new_data_ind = FALSE)
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
run_example_upload_data_set_app <- function(add_new_data_ind = TRUE) {
  ui <- page(
    useShinyjs(),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),
    mod_upload_data_set_ui("upload")
  )

  server <- function(input, output, session) {
    mod_upload_data_set_server("upload", add_new_data_ind = add_new_data_ind)
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
