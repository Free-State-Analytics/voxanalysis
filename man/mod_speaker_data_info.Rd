% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mod_speaker_data_info_doc.R,
%   R/mod_speaker_data_info_server.R, R/mod_speaker_data_info_ui.R
\name{mod_speaker_data_info}
\alias{mod_speaker_data_info}
\alias{mod_speaker_data_info_server}
\alias{mod_speaker_data_info_ui}
\title{Speaker Data Viewing and Modification Module}
\usage{
mod_speaker_data_info_server(id, df_input_speaker_info)

mod_speaker_data_info_ui(id)
}
\arguments{
\item{id}{The namespace `id`, used to uniquely identify Shiny modules and UI components within the VOX Analysis package.}

\item{df_input_speaker_info}{A `data.frame` containing general information about a speaker (the subject of the VOX Analysis), as provided by the user. For an example, run `data("df_input_speaker_info")`.}
}
\description{
This Shiny module provides an interface for users to view and modify speaker data in VOX Analysis.
}
\examples{
if (interactive()) {
  # Load example speaker information data
  data("df_input_speaker_info_example")

  # Define the UI with speaker data viewing and modification capabilities
  ui <- page(
    useShinyjs(),
    mod_speaker_data_info_ui("speaker")
  )

  # Set up the server with initial speaker data
  server <- function(input, output, session) {
    mod_speaker_data_info_server("speaker", df_input_speaker_info_example)
  }

  # Run the Shiny app
  shinyApp(ui, server)
}

}
