#' Detailed Analysis Section Module
#'
#' @description
#' This Shiny module generates a detailed analysis section for VOX Analysis, designed to be used within the `mod_results_primary` module. It provides a comprehensive view of the speaker's responses by generating multiple components:
#' \itemize{
#'   \item \strong{Vox pie chart}: Visualizes the distribution of different response types.
#'   \item \strong{Vox line chart}: Shows trends in responses over time.
#'   \item \strong{Cochran's Q test}: Performs a statistical test to assess consistency across responses.
#'   \item \strong{Prompt hierarchy table}: Displays a structured view of response prompts in a hierarchy.
#' }
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @import bslib
#'
#' @examples
#' if (interactive()) {
#'   # Load example data
#'   data("df_input_response_example")
#'
#'   # Define the UI with the detailed analysis section
#'   ui <- page(
#'     mod_results_section_detailed_analysis_ui("detailed_analysis")
#'   )
#'
#'   # Set up the server to include detailed analysis functionality
#'   server <- function(input, output, session) {
#'     mod_results_section_detailed_analysis_server(
#'       "detailed_analysis",
#'       df_input_response = df_input_response_example
#'     )
#'   }
#'
#'   # Run the Shiny app
#'   shinyApp(ui, server)
#' }
#'
#' @name mod_results_section_detailed_analysis
NULL
