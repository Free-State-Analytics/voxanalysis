#' Create a KPI Taglist
#'
#' @description
#' This function generates a KPI (Key Performance Indicator) taglist, displaying a header and the KPI value in a minimalistic format. The taglist is designed for the VOX Analysis app to prominently display metrics with a clean layout, making it suitable for dashboard-style reporting.
#'
#' @param metric A single numeric or character value representing the metric to display.
#' @param header A character string containing the header or description of the KPI.
#' @import shiny
#'
#' @return A Shiny `tagList` containing the KPI header and its corresponding metric value, formatted for display.
#'
#' @export

tag_kpi <- function(metric, header) {

  tagList(
    h6(class = "text-muted mb-0",
       header),
    h3(metric)
  )


}
