#' Area Q Summary Section Module
#'
#' @description
#' This Shiny module generates an Area Q summary section, intended for use within the `mod_results_primary` module. It provides a focused view of the Area Q calculations, offering insights into the spatial distribution and centroidal properties of responses in a VOX Analysis session.
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @import bslib
#'
#' @examples
#' if (interactive()) {
#'   # Load example response data
#'   data("df_input_response_example")
#'
#'   # Define the UI with the Area Q summary section
#'   ui <- page(
#'     mod_results_section_area_q_ui("section_area_q")
#'   )
#'
#'   # Set up the server to include Area Q summary functionality
#'   server <- function(input, output, session) {
#'     mod_results_section_area_q_server(
#'       "section_area_q",
#'       df_input_response_example,
#'       date_primary = max(df_input_response_example$date_of_evaluation)
#'     )
#'   }
#'
#'   # Run the Shiny app
#'   shinyApp(ui, server)
#' }
#'
#' @name mod_results_section_area_q
NULL

