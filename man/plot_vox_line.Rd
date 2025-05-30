% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_vox_line.R
\name{plot_vox_line}
\alias{plot_vox_line}
\title{Plot a VOX Line Chart}
\usage{
plot_vox_line(
  df_input_response,
  ind_hide_heading = TRUE,
  ind_doc_version = FALSE
)
}
\arguments{
\item{df_input_response}{A `data.frame` containing referent names and their associated responses, typically recorded by the listener. For example data, run `data("df_input_response_example")` or `data("df_input_response_previous_example")`.}

\item{ind_hide_heading}{Logical. If `TRUE`, hides the heading on the chart. Defaults to `TRUE`. Does not apply if `ind_doc-version` is set to `TRUE`.}

\item{ind_doc_version}{Logical (`TRUE` or `FALSE`): Indicates whether a plot needs to be optimized for inclusion in a Word document. If `TRUE`, font sizes and other aesthetics will be adjusted to enhance Word document readability.}
}
\description{
This function generates a VOX line chart, visualizing response trends (e.g., Conversing, Labeling, Echoing, Requesting) across verbal episodes in a VOX Analysis evaluation.
}
\examples{
# Load example data
data("df_input_response_example")

# Generate a VOX line chart across verbal episodes
plot_vox_line(df_input_response = df_input_response_example)
}
