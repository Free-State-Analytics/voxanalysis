#' @rdname mod_response_entry
#' @importFrom shinyjs disable enable hide show
#' @export
mod_response_entry_server <- function(id, df_input_speaker_info, df_input_response_previous = NULL) {
  moduleServer(id, function(input, output, session) {

    output$referent_response <- renderUI({
      tag_table_response_input(session$ns(""), input$referent_count)
    })


    df_input_response <- reactive({
      df_input_response <- reactiveValuesToList(input) %>%
        as.data.frame() %>%
        select(contains(c("referent_input", "conversing", "labeling", "echoing", "requesting")))
      req(length(df_input_response) != 0)

      df_input_response <- df_input_response %>%
        pivot_longer(everything()) %>%
        separate(.data$name, into = c("response", "row_number"), sep = "_input") %>%
        pivot_wider(names_from = "response", values_from = "value") %>%
        arrange(.data$row_number)

      if (is.null(df_input_response_previous)) {
        suppressWarnings(
          df_input_response <- df_input_response %>%
            mutate(date_of_evaluation = as.Date(unique(df_input_speaker_info$date_of_evaluation))) %>%
            mutate(across(c( "conversing", "labeling", "echoing", "requesting"), as.numeric)) %>%
            select("date_of_evaluation", "referent", "conversing", "labeling", "echoing", "requesting") %>%
            as.data.frame()
        )

      } else {
        suppressWarnings(
          df_input_response <- df_input_response %>%
            mutate(date_of_evaluation = as.Date(df_input_speaker_info$date_of_evaluation)) %>%
            mutate(across(c( "conversing", "labeling", "echoing", "requesting"), as.numeric)) %>%
            select("date_of_evaluation", "referent", "conversing", "labeling", "echoing", "requesting") %>%
            as.data.frame()
        )
      }

      return(df_input_response)

    })

    observeEvent(df_input_response(), {
      suppressWarnings(
        wrong_digits_check <- reactiveValuesToList(input) %>%
          as.data.frame() %>%
          select(contains(c("referent", "conversing", "labeling", "echoing", "requesting"))) %>%
          pivot_longer(everything()) %>%
          filter(!grepl("referent", .data$name)) %>%
          filter(.data$value != "") %>%
          filter(is.na(as.numeric(.data$value)) | as.numeric(.data$value) > 1 | as.numeric(.data$value) < 0)
      )

      for (i in 1:nrow(wrong_digits_check)) {
        updateTextInput(session, wrong_digits_check[i, "name"], value = "")
      }
    }, ignoreNULL = TRUE)

    observeEvent(df_input_response(), {
      check_for_button_enable <- df_input_response() %>%
        filter(.data$referent == "" |
                 is.na(.data$conversing) |
                 is.na(.data$labeling) |
                 is.na(.data$echoing) |
                 is.na(.data$requesting))
      check_for_button_enable <- nrow(check_for_button_enable) > 0
      if (check_for_button_enable) {
        shinyjs::disable("button_generate")
      } else {
        shinyjs::enable("button_generate")
      }
    }, ignoreInit = TRUE)


    observeEvent(input$button_generate, {

      df_input_response_to_pass <- df_input_response()

      if (!is.null(df_input_response_previous)) {
        df_input_response_to_pass <- rbind(
          df_input_response_to_pass,
          df_input_response_previous
        )
      }
      util_shiny_remove_and_hide_flex("data_entry_card")
      # shinyjs::hide("data_entry_card")
      shinyjs::show("results_primary_div",
                    anim = TRUE,
                    animType = "fade")
      mod_results_primary_server(
        "results_primary",
        df_input_speaker_info,
        df_input_response = df_input_response_to_pass
      )
    }, ignoreInit = TRUE)

  })
}
