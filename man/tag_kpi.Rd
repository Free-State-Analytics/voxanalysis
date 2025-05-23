% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tag_kpi.R
\name{tag_kpi}
\alias{tag_kpi}
\title{Create a KPI Taglist}
\usage{
tag_kpi(metric, header)
}
\arguments{
\item{metric}{A single numeric or character value representing the metric to display.}

\item{header}{A character string containing the header or description of the KPI.}
}
\value{
A Shiny `tagList` containing the KPI header and its corresponding metric value, formatted for display.
}
\description{
This function generates a KPI (Key Performance Indicator) taglist, displaying a header and the KPI value in a minimalistic format. The taglist is designed for the VOX Analysis app to prominently display metrics with a clean layout, making it suitable for dashboard-style reporting.
}
