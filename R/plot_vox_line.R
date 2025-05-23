#' Plot a VOX Line Chart
#'
#' @description
#' This function generates a VOX line chart, visualizing response trends (e.g., Conversing, Labeling, Echoing, Requesting) across verbal episodes in a VOX Analysis evaluation.
#'
#' @inheritParams common-params
#' @param ind_hide_heading Logical. If `TRUE`, hides the heading on the chart. Defaults to `TRUE`. Does not apply if `ind_doc-version` is set to `TRUE`.
#' @import ggplot2
#' @import dplyr
#' @import tidyr
#'
#' @export
#'
#' @examples
#' # Load example data
#' data("df_input_response_example")
#'
#' # Generate a VOX line chart across verbal episodes
#' plot_vox_line(df_input_response = df_input_response_example)


plot_vox_line <- function(df_input_response, ind_hide_heading = TRUE, ind_doc_version = FALSE) {

  if ("referent_order" %in% colnames(df_input_response)) {
    response_inputs <- df_input_response %>%
      arrange(.data$referent_order) %>%
      transmute(
        .data$referent,
        Conversing = .data$conversing,
        Labeling = .data$labeling,
        Echoing = .data$echoing,
        Requesting = .data$requesting)
  } else {
    response_inputs <- df_input_response %>%
      transmute(
        .data$referent,
        Conversing = .data$conversing,
        Labeling = .data$labeling,
        Echoing = .data$echoing,
        Requesting = .data$requesting)
  }


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
                 names_to = "type", values_to = "value") %>%
    inner_join(session_mapping, by = join_by("episodes", "type")) %>%
    group_by(.data$session, .data$type) %>%
    summarize(value = sum(.data$value),
              .groups = 'drop') %>%
    as.data.frame()

  by_session$type <- factor(by_session$type, levels = c("Conversing", "Labeling", "Echoing", "Requesting"))

  p <- ggplot(by_session, aes(.data$session, y = .data$value)) +
    geom_rect(
      data = by_session %>% filter(.data$value == max(.data$value)) %>% slice_head(),
      aes(xmin = 0, xmax = 4, ymin = 0, ymax = .data$value + .35),
      linewidth = 1,
      alpha = .15,
      fill = "#D3D3D3"
    )+
    geom_text(
      data = by_session %>% filter(.data$value == max(.data$value)) %>% slice_head(),
      aes(x = 2, y = .data$value + .5, label = "Episode #1"),
      family = "Lato",
      size.unit = "pt",
      size = ifelse(ind_doc_version, 10, 13)
    ) +
    geom_rect(
      data = by_session %>% filter(.data$value == max(.data$value)) %>% slice_head(),
      aes(xmin = 4, xmax = 8, ymin = 0, ymax = .data$value + .35),
      linewidth = 1,
      alpha = .25,
      fill = "#D3D3D3"
    ) +
    geom_text(
      data = by_session %>% filter(.data$value == max(.data$value)) %>% slice_head(),
      aes(x = 6, y = .data$value + .5, label = "Episode #2"),
      family = "Lato",
      size.unit = "pt",
      size = ifelse(ind_doc_version, 10, 13)
    )

  if (max(by_session$session) > 8) {
    p <- p +
      geom_rect(
        data = by_session %>% filter(.data$value == max(.data$value)) %>% slice_head(),
        aes(xmin = 8, xmax = 12, ymin = 0, ymax = .data$value + .35),
        linewidth = 1,
        alpha = .15,
        fill = "#D3D3D3"
      ) +
      geom_text(
        data = by_session %>% filter(.data$value == max(.data$value)) %>% slice_head(),
        aes(x = 10, y = .data$value + .5, label = "Episode #3"),
        family = "Lato",
        size.unit = "pt",
        size = ifelse(ind_doc_version, 10, 13)
      )
  }

  if (max(by_session$session) > 12) {
    p <- p +
      geom_rect(
        data = by_session %>% filter(.data$value == max(.data$value)) %>% slice_head(),
        aes(xmin = 12, xmax = 16, ymin = 0, ymax = .data$value + .35),
        linewidth = 1,
        alpha = .25,
        fill = "#D3D3D3"
      ) +
      geom_text(
        data = by_session %>% filter(.data$value == max(.data$value)) %>% slice_head(),
        aes(x = 14, y = .data$value + .5, label = "Episode #4"),
        family = "Lato",
        size.unit = "pt",
        size = ifelse(ind_doc_version, 10, 13)
      )
  }

  p <- p +
    geom_line(aes(color = .data$type), linewidth = 2) +
    geom_point(aes(fill = .data$type), size = 7, pch = 21, color = "white", stroke = 1) +
    geom_text(
      aes(label = .data$value),
      colour = "white",
      fontface = "bold",
      size.unit = "pt",
      size = ifelse(ind_doc_version, 10, 13)) +
    scale_color_manual(values = plot_color_mapping, name = NULL) +
    scale_fill_manual(values = plot_color_mapping, name = NULL) +
    expand_limits(x = 0,  y = 0) +
    coord_cartesian(ylim = c(0, max(by_session$value)), clip = "off") +
    scale_x_continuous(breaks = seq(from = 0, to = max(by_session$session), by = 4)) +
    xlab("Session") +
    ylab("Response")

   if (ind_doc_version) {
     p <- p +
       hrbrthemes::theme_ipsum(
         base_family = "Lato",
         plot_margin = margin(50, 30, 30, 30),
         grid = "Xx"
       )
   } else {
     if (!ind_hide_heading) {
       p <- p +
         labs(title = "VOX Chart",
              subtitle = "Results by Verbal Episode") +
         hrbrthemes::theme_ipsum(
           base_family = "Lato",
           plot_title_margin = 5,
           subtitle_margin = 50,
           plot_margin = margin(10, 30, 30, 30),
           grid = "Xx",
           axis_text_size = 13,
           axis_title_size = 13
         ) #+
       # theme(
       #   plot.margin = margin(30, 30, 30, 30)
       # )
     } else {
       p <- p +
         hrbrthemes::theme_ipsum(
           base_family = "Lato",
           plot_margin = margin(50, 30, 30, 30),
           grid = "Xx",
           axis_text_size = 13,
           axis_title_size = 13
         ) +
         theme(
           legend.position = "bottom"
         )
     }
   }

  ### add background

  return(p)

}
