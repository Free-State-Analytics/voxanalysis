% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mod_download_bar_doc.R,
%   R/mod_download_bar_server.R, R/mod_download_bar_ui.R
\name{mod_download_bar}
\alias{mod_download_bar}
\alias{mod_download_bar_server}
\alias{mod_download_bar_ui}
\title{Download Bar Module for Exporting Data and Reports}
\usage{
mod_download_bar_server(
  id,
  df_input_speaker_info,
  df_input_response,
  df_summarized_response
)

mod_download_bar_ui(id)
}
\arguments{
\item{id}{The namespace `id`, used to uniquely identify Shiny modules and UI components within the VOX Analysis package.}

\item{df_input_speaker_info}{A `data.frame` containing general information about a speaker (the subject of the VOX Analysis), as provided by the user. For an example, run `data("df_input_speaker_info")`.}

\item{df_input_response}{A `data.frame` containing referent names and their associated responses, typically recorded by the listener. For example data, run `data("df_input_response_example")` or `data("df_input_response_previous_example")`.}

\item{df_summarized_response}{A `data.frame` summarizing each verbal operant (Conversing, Labeling, Echoing, Requesting) for a given evaluation date. This summary provides a condensed view of responses and can be produced using the `util_summarize_response` function.}
}
\description{
A Shiny module that provides a download interface, allowing users to export data and generate a Word document report. This module is useful for users needing an easily accessible download bar to retrieve their VOX Analysis results in structured formats for further analysis or reporting.
}
\examples{
if (interactive()) {
  # Load example data
  data("df_input_speaker_info_example")
  data("df_input_response_example")
  data("df_summarized_response_example")

  # Define the UI with the download bar
  ui <- page(
    mod_download_bar_ui("download_bar")
  )

  # Set up the server to include the download bar functionality
  server <- function(input, output, session) {
    mod_download_bar_server(
      "download_bar",
      df_input_speaker_info = df_input_speaker_info_example,
      df_input_response = df_input_response_example,
      df_summarized_response = df_summarized_response_example
    )
  }

  # Run the Shiny app
  shinyApp(ui, server)
}

}
