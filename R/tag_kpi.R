#' Create a KPI taglist
#'
#' @description
#' Produces a KPI taglist containing only a header and the KPI itself.
#'
#' @param metric A single value for the metric to report.
#' @param header A string value containing the header or KPI description.
#' @import shiny
#'
#' @export

tag_kpi <- function(metric, header) {

  tagList(
    h6(class = "text-muted mb-0",
       header),
    h3(metric)
  )


}
