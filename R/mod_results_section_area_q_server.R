#' @rdname mod_results_section_area_q
#' @importFrom shinyjs show
#' @export

mod_results_section_area_q_server <- function(
    id,
    df_input_response,
    v_primary_date) {
  moduleServer(id, function(input, output, session) {

    if (length(unique(df_input_response$date_of_evaluation)) != 1) {
      shinyjs::show("filter_date_div")
      dates_to_pass <- df_input_response %>%
        filter(.data$date_of_evaluation != as.Date(v_primary_date))
      dates_to_pass <- unique(dates_to_pass$date_of_evaluation)
      updateSelectInput(session,
                        "filter_secondary_date",
                        choices = sort(as.Date(dates_to_pass), decreasing = TRUE))
    } else {
      dates_to_pass <- unique(df_input_response$date_of_evaluation)
      updateSelectInput(session,
                        "filter_secondary_date",
                        choices = as.Date(dates_to_pass))
    }

    rct_summarize_response <- eventReactive(input$filter_secondary_date, {
      if (length(unique(df_input_response$date_of_evaluation)) != 1) {
        data_to_return <- summarize_response(
          df_input_response %>%
            filter(.data$date_of_evaluation %in% c(as.Date(v_primary_date), as.Date(input$filter_secondary_date)))
        )
      } else {
        data_to_return <- summarize_response(
          df_input_response
        )
      }
      return(data_to_return)

    }, ignoreNULL = TRUE)

    output$analysis_results_area_q_plot <- renderPlot({
      plot_area_q(rct_summarize_response(), v_primary_date)
    }) %>% bindCache(v_primary_date, input$filter_secondary_date)

    output$centroids <- renderUI({

      centroids_metrics <- calc_centroid(df_input_response %>%
                                           filter(.data$date_of_evaluation == as.Date(v_primary_date)))

      div(class = "info-div",
        tag_kpi(paste0("(", centroids_metrics$centroid[1], ", ", centroids_metrics$centroid[2], ")"), "Centroid"),
        br(),
        tag_kpi(centroids_metrics$distance, "Centroidal distance"),
        br(),
        tag_kpi(centroids_metrics$moment, "First moment of area (Q)")
      )

    }) %>%
      bindCache(v_primary_date)


  })

}
