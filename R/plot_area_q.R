#' Area Q Plot
#'
#' @description
#' Produces an area Q plot over time for the data set provided.
#'
#' @inherit common-params
#' @import ggplot2
#' @import ggradar
#' @import dplyr
#' @export
#' @examples
#' data("df_summarized_response_example")
#' plot_area_q(df_summarized_response = df_summarized_response_example[1:2,], v_primary_date = "2024-08-23")
#'



plot_area_q <- function(df_summarized_response, v_primary_date, doc_version_ind = FALSE) {

  if (nrow(df_summarized_response) > 1 && is.null(v_primary_date)) {
    stop("v_primary_date is required when df_summarized_response has more than one row.")
  }

  if (nrow(df_summarized_response) > 2) {
    stop("df_summarized_response must be limited to two rows.")
  }

  grid_size <- max(df_summarized_response[c("labeling", "echoing", "requesting", "conversing")])

  dat_for_plot <- df_summarized_response %>%
    rename(Labeling = "labeling",
           Echoing = "echoing",
           Requesting = "requesting",
           Conversing = "conversing")

  if (nrow(dat_for_plot) != 1) {
    dat_for_plot <- dat_for_plot %>%
      mutate(priority = ifelse(.data$date_of_evaluation == as.Date(v_primary_date), 1, 2)) %>%
      arrange(desc(.data$priority)) %>%
      select(-"priority")
    colors <- c("#33808040", "#338080E6")
    names(colors) <- c(dat_for_plot$date_of_evaluation[1], dat_for_plot$date_of_evaluation[2])
  } else {
    colors <- "#338080E6"
  }

  if (doc_version_ind) {
        p <- ggradar(
      dat_for_plot,
      values.radar = c(0, grid_size / 2, grid_size),
      grid.min = 0,
      grid.mid = grid_size / 2,
      grid.max = grid_size,
      axis.label.size = 3.5,
      group.colours = colors,
      legend.position = "bottom"
    )
    p <- ggradar(
      dat_for_plot,
      base.size = 9,
      values.radar = c(0, grid_size / 2, grid_size),
      grid.min = 0,
      grid.mid = grid_size / 2,
      grid.max = grid_size,
      grid.line.width = .25,
      group.line.width = .75,
      group.point.size = 3,
      axis.label.size = 2,
      legend.text.size = 9,
      grid.label.size = 2,
      group.colours = colors,
      legend.position = "bottom"
    )
  } else {

  }

  return(p)

}
