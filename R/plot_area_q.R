#' Area Q Plot
#'
#' @description
#' This function generates an Area Q plot to visualize response types (e.g., Conversing, Labeling, Echoing, Requesting) for VOX Analysis. The plot can display data for a single evaluation (e.g., a play therapy session) or compare multiple evaluations over time to reveal changes in language development patterns. This flexibility allows users to analyze individual sessions or observe trends across multiple sessions.
#'
#' @inheritParams common-params
#' @import ggplot2
#' @import ggradar
#' @import dplyr
#' @export
#'
#' @examples
#' # Load example data
#' data("df_summarized_response_example")
#'
#' # Generate an Area Q plot for selected dates
#' plot_area_q(
#'   df_summarized_response = df_summarized_response_example[1:2, ],
#'   date_primary = "2024-08-23"
#' )

plot_area_q <- function(df_summarized_response, date_primary, ind_doc_version = FALSE) {

  if (nrow(df_summarized_response) > 1 && is.null(date_primary)) {
    stop("date_primary is required when df_summarized_response has more than one row.")
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

  print(dat_for_plot)

  if (nrow(dat_for_plot) != 1) {
    dat_for_plot <- dat_for_plot %>%
      mutate(priority = ifelse(.data$date_of_evaluation == as.Date(date_primary), 1, 2)) %>%
      arrange(desc(.data$priority)) %>%
      select(-"priority")
    colors <- c("#AFCFCF", "#439393")
    names(colors) <- c(dat_for_plot$date_of_evaluation[1], dat_for_plot$date_of_evaluation[2])
  } else {
    colors <- "#439393"
  }

  if (ind_doc_version) {
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
      p <- ggradar(
        dat_for_plot,
        values.radar = c(0, grid_size / 2, grid_size),
        grid.min = 0,
        grid.mid = grid_size / 2,
        grid.max = grid_size,
        axis.label.size = 3.5,
        group.colours = colors,
        legend.position = "bottom")

    }

  return(p)

}
