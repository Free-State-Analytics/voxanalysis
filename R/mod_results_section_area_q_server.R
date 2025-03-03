#' @rdname mod_results_section_area_q
#' @importFrom shinyjs show
#' @export

mod_results_section_area_q_server <- function(
    id,
    df_input_response,
    date_primary) {
  moduleServer(id, function(input, output, session) {

    if (length(unique(df_input_response$date_of_evaluation)) > 1) {
      shinyjs::show("filter_date_div")
      dates_to_pass <- df_input_response %>%
        filter(.data$date_of_evaluation != as.Date(date_primary)) %>%
        arrange(desc(.data$date_of_evaluation))
      dates_to_pass <- unique(dates_to_pass$date_of_evaluation)
      updateSelectInput(session,
                        "filter_secondary_date",
                        choices = c("None", as.character(dates_to_pass)),
                        selected = "None")
    } else {
      dates_to_pass <- unique(df_input_response$date_of_evaluation)
      updateSelectInput(session,
                        "filter_secondary_date",
                        choices =  c("None", as.character(dates_to_pass)),
                        selected = "None")
    }

    rct_summarize_response <- eventReactive(input$filter_secondary_date, {

      if (input$filter_secondary_date == "None") {
        data_to_return <- df_input_response %>%
          filter(.data$date_of_evaluation == as.Date(date_primary))
        data_to_return <- util_summarize_response(data_to_return)
      } else {
        data_to_return <- util_summarize_response(
          df_input_response %>%
            filter(.data$date_of_evaluation %in% c(as.Date(date_primary), as.Date(input$filter_secondary_date)))
        )
      }
      return(data_to_return)

    }, ignoreNULL = TRUE)

    output$analysis_results_area_q_plot <- renderPlot({
      plot_area_q(rct_summarize_response(), date_primary)
    }) %>% bindCache(date_primary, input$filter_secondary_date)

    output$centroids <- renderUI({

      if (util_check_for_ones_zeros(df_input_response, ind_check_only_for_zero = TRUE)) {
        return(tag_div_ones_zeros())
      }

      centroids_metrics <- calc_centroid(df_input_response %>%
                                           filter(.data$date_of_evaluation == as.Date(date_primary)))

      div(class = "info-div",
          tag_kpi(paste0("(", centroids_metrics$centroid[1], ", ", centroids_metrics$centroid[2], ")"), "Centroid"),
          br(),
          tag_kpi(centroids_metrics$distance, "Centroidal distance"),
          br(),
          tag_kpi(centroids_metrics$moment, "First moment of area (Q)")
      )

    }) %>%
      bindCache(date_primary)


  })

}
