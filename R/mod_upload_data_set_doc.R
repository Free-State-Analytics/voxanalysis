#' CSV File Upload Module for Speaker Data
#'
#' @description
#' This Shiny module provides a user interface for uploading a `.csv` file containing speaker data for VOX Analysis. It enables users to import external data for analysis, with options to modify the speaker data
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @import bslib
#' @importFrom shinyjs hidden show hide
#'
#' @examples
#' if (interactive()) {
#'   # Load example speaker data
#'
#'   # Define the UI with the file upload module
#'   ui <- page(
#'     useShinyjs(),
#'     mod_upload_data_set_ui("upload")
#'   )
#'
#'   # Set up the server to handle file uploads
#'   server <- function(input, output, session) {
#'     mod_upload_data_set_server(
#'       "upload",
#'       ind_add_new_data = TRUE
#'     )
#'   }
#'
#'   # Run the Shiny app
#'   shinyApp(ui, server)
#' }
#'
#' # Alternative: Run a pre-configured example app for file upload
#' if (interactive()) {
#'   run_example_upload_data_set_app(ind_add_new_data = TRUE)
#' }
#'
#' @name mod_upload_data_set
NULL
