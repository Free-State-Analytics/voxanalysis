#' @rdname mod_results_primary
#' @importFrom shinyjs show
#' @export

mod_results_primary_server <- function(
    id,
    df_input_speaker_info,
    df_input_response) {

  moduleServer(id, function(input, output, session) {

    updateSelectInput(session,
                      "filter_primary_date",
                      choices = sort(as.Date(unique(df_input_response$date_of_evaluation)), decreasing = TRUE))

    if (length(unique(df_input_response$date_of_evaluation)) != 1) {
      shinyjs::show("filter_date_div")
    }

    observeEvent(input$filter_primary_date, {
      mod_results_section_area_q_server(
        "section_area_q",
        df_input_response,
        input$filter_primary_date)
    }, ignoreInit = TRUE)

    df_input_response_filtered <- reactive({
      df_input_response_filtered <-  df_input_response %>%
        filter(.data$date_of_evaluation == as.Date(input$filter_primary_date))
      return(df_input_response_filtered)
    }) %>% bindCache(input$filter_primary_date)

    observeEvent(df_input_response_filtered(), {
      mod_results_section_detailed_analysis_server(
        "section_detailed_analysis",
        df_input_response_filtered())
    }, ignoreInit = TRUE)

    output$table_response_results <- renderUI({
      tag_table_response_results(
        df_input_response %>%
          filter(.data$date_of_evaluation == as.Date(input$filter_primary_date)))
    }) %>% bindCache(input$filter_primary_date)

    mod_download_bar_server(
      "download_bar",
      df_input_speaker_info,
      df_input_response)

  })

}
