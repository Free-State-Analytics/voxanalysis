#' Plot a VOX Pie Chart
#'
#' @description
#' This function generates a VOX pie chart that visualizes the distribution of response types (Conversing, Labeling, Echoing, Requesting) for a single evaluation date.
#'
#' @inheritParams common-params
#' @param ind_doc_version Logical. If `TRUE`, adjusts font sizes for Word document compatibility. Defaults to `FALSE`.
#' @import ggplot2
#' @import dplyr
#' @import tidyr
#'
#' @export
#'
#' @examples
#' # Load example data
#' library(dplyr)
#' data("df_summarized_response_example")
#'
#' # Filter to a single evaluation date, as the pie chart works with one date at a time
#' dat <- df_summarized_response_example %>%
#'     filter(date_of_evaluation == max(date_of_evaluation))
#'
#' # Generate the VOX pie chart
#' plot_vox_piechart(df_summarized_response = dat)
#'
#'

plot_vox_piechart <- function(df_summarized_response, ind_doc_version = FALSE) {

   if (length(unique(df_summarized_response$date_of_evaluation)) != 1) {
     stop("The df_summarized_response input should only have one row of data for this function.")
   }

    dat <- df_summarized_response %>%
      transmute(Conversing = .data$conversing,
                Labeling = .data$labeling,
                Echoing = .data$echoing,
                Requesting = .data$requesting) %>%
      pivot_longer(everything()) %>%
      mutate(total = sum(.data$value),
             perc = round(.data$value / .data$total, 2) * 100,
             name = factor(.data$name, levels = c("Conversing", "Labeling", "Echoing", "Requesting"))
      ) %>%
      arrange(desc(.data$name)) %>%
      mutate(
        ypos = cumsum(.data$value) - .data$value/2)

    p <- ggplot(dat, aes(x = 0, y = .data$value, fill = .data$name)) +
      geom_bar(stat = "identity", width = 1, color = "white") +
      coord_polar("y", start = 0, direction = -1) +
      theme_void() +
      theme(legend.position = "none") +
      scale_fill_manual(values = plot_color_mapping)

    if (ind_doc_version) {
      p <- p + geom_text(aes(y = .data$ypos,
                             label = paste0(.data$name,":","\n", .data$value, " (", .data$perc, "%)")),
                         color = "white", size = 3)
    } else {
      p <- p + geom_text(aes(y = .data$ypos,
                             label = paste0(.data$name,":","\n", .data$value, " (", .data$perc, "%)")),
                         color = "white", size = 4)
    }

    return(p)

}
