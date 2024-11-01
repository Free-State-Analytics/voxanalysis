#' Plot a Vox Line Chart
#'
#' @description
#' Produces a Vox line chart
#'
#' @inherit common-params
#' @param hide_heading A logical indicator to hide the heading. It defaults to TRUE.
#' @import ggplot2
#' @import dplyr
#' @import tidyr
#'
#' @export
#'
#' @examples
#' data("df_input_response_example")
#' plot_vox_line(df_input_response = df_input_response_example)
#'
#'

plot_vox_line <- function(df_input_response, hide_heading = TRUE, ind_doc_version = FALSE) {

  response_inputs <- df_input_response %>%
    transmute(
      .data$referent,
      Conversing = .data$conversing,
      Labeling = .data$labeling,
      Echoing = .data$echoing,
      Requesting = .data$requesting)

  row_count <- nrow(response_inputs)

  episodes <- c()
  for (i in 1:(row_count/3)) {
    episodes <- c(episodes, rep(i, 3))
  }

  if (length(episodes) != row_count) {
    new_length = row_count - length(episodes)
    new_number = ceiling(row_count/3)
    episodes <- c(episodes, rep(new_number, new_length))
  }

  response_inputs <- cbind(
    episodes = episodes,
    response_inputs
  )

  session_mapping <- data.frame(
    episodes = rep(1:4, each = 4),
    session = c(1, 2, 3, 4,
                5, 8, 7, 6,
                9, 10, 12, 11,
                13, 15, 14, 16),
    type = rep(c("Labeling", "Echoing", "Requesting", "Conversing"), 4)
  )

  by_session <- response_inputs %>%
    pivot_longer(cols = c("Labeling", "Echoing", "Requesting", "Conversing"),
                 names_to = "type") %>%
    inner_join(session_mapping, by = join_by("episodes", "type")) %>%
    group_by(.data$session, .data$type) %>%
    summarize(value = sum(.data$value),
              .groups = 'drop') %>%
    as.data.frame()

  by_session$type <- factor(by_session$type, levels = c("Conversing", "Labeling", "Echoing", "Requesting"))

  p <- ggplot(by_session, aes(.data$session, y = .data$value))

 if (ind_doc_version) {
   p <- p +
     geom_line(aes(color = .data$type), linewidth = .75) +
     geom_point(aes(fill = .data$type), size = 5, pch = 21, color = "white", stroke = 1) +
     geom_text(aes(label = .data$value), colour = "white", fontface = "bold") +
     scale_color_manual(values = plot_color_mapping, name = NULL) +
     scale_fill_manual(values = plot_color_mapping, name = NULL) +
     xlab(NULL) +
     ylab("Response") +
     ggthemes::theme_pander(
       base_size = 7,
       nomargin = FALSE
     )
 } else {
   p <- p +
     geom_line(aes(color = .data$type), linewidth = 2) +
     geom_point(aes(fill = .data$type), size = 7, pch = 21, color = "white", stroke = 1) +
     geom_text(aes(label = .data$value), colour = "white", fontface = "bold") +
     scale_color_manual(values = plot_color_mapping, name = NULL) +
     scale_fill_manual(values = plot_color_mapping, name = NULL) +
     xlab(NULL) +
     ylab("Response") +
     ggthemes::theme_pander(
     #  base_family = "Lato",
       nomargin = FALSE
     )
 }


  if (!hide_heading) {
    p <- p +
      labs(title = "VOX Chart",
              subtitle = "Results by Verbal Episode")
  }

  return(p)

}
