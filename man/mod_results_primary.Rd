% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mod_results_primary_doc.R,
%   R/mod_results_primary_server.R, R/mod_results_primary_ui.R
\name{mod_results_primary}
\alias{mod_results_primary}
\alias{mod_results_primary_server}
\alias{mod_results_primary_ui}
\title{Summary Report Generation Module}
\usage{
mod_results_primary_server(id, df_input_speaker_info, df_input_response)

mod_results_primary_ui(id)
}
\arguments{
\item{id}{The namespace `id`, used to uniquely identify Shiny modules and UI components within the VOX Analysis package.}

\item{df_input_speaker_info}{A `data.frame` containing general information about a speaker (the subject of the VOX Analysis), as provided by the user. For an example, run `data("df_input_speaker_info")`.}

\item{df_input_response}{A `data.frame` containing referent names and their associated responses, typically recorded by the listener. For example data, run `data("df_input_response_example")` or `data("df_input_response_previous_example")`.}
}
\description{
This Shiny module provides a user interface and server function to generate a summary report based on response inputs. It is designed to work independently of other modules, allowing users to create a comprehensive summary report for a VOX Analysis session.
}
\examples{
if (interactive()) {
  # Load example data
  data("df_input_speaker_info_example")
  data("df_input_response_example")

  # Define the UI with the summary report generation module
  ui <- page(
    mod_results_primary_ui("data_input")
  )

  # Set up the server to include summary report functionality
  server <- function(input, output, session) {
    mod_results_primary_server(
      "data_input",
      df_input_speaker_info = df_input_speaker_info_example,
      df_input_response = df_input_response_example
    )
  }

  # Run the Shiny app
  shinyApp(ui, server)
}

if (interactive()) {
  # Alternative example using a pre-built app function
  run_example_results_app()
}

}
