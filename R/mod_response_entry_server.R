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
            mutate(across(c( "conversing", "labeling", "echoing", "requesting"), as.numeric))  %>%
            mutate(referent_order = 1:nrow(df_input_response)) %>%
            select("date_of_evaluation", "referent", "referent_order", "conversing", "labeling", "echoing", "requesting") %>%
            as.data.frame()
        )

      } else {
        suppressWarnings(

          {
            df_input_response <- df_input_response %>%
              mutate(date_of_evaluation = as.Date(df_input_speaker_info$date_of_evaluation)) %>%
              mutate(across(c( "conversing", "labeling", "echoing", "requesting"), as.numeric))

            ### If evaluation date is the same as previous entry, we need to update referent_order accordingly by starting at the end of the max order
            if (df_input_speaker_info$date_of_evaluation %in% df_input_response_previous$date_of_evaluation) {

              starting_referent_order <- df_input_response_previous %>%
                filter(.data$date_of_evaluation == df_input_speaker_info$date_of_evaluation) %>%
                pull(.data$referent_order)
              starting_referent_order <- max(starting_referent_order) + 1
              ending_referent_order <- nrow(df_input_response) + starting_referent_order - 1

              df_input_response <- df_input_response %>%
                mutate(referent_order = starting_referent_order:ending_referent_order) %>%
                select("date_of_evaluation", "referent", "referent_order", "conversing", "labeling", "echoing", "requesting") %>%
                as.data.frame()

            } else {
              df_input_response <- df_input_response %>%
                mutate(referent_order = 1:nrow(df_input_response)) %>%
                select("date_of_evaluation", "referent", "referent_order", "conversing", "labeling", "echoing", "requesting") %>%
                as.data.frame()
            }
          }

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

      ### Check for duplicate referents
      check_for_duplicate_referents <- df_input_response() %>%
        filter(.data$referent != "") %>%
        group_by(.data$referent) %>%
        summarize(n = n())
      check_for_duplicate_referents <- check_for_duplicate_referents %>% filter(.data$n > 1)
      check_for_duplicate_referents <- nrow(check_for_duplicate_referents) > 0


      ### Check for duplicate referents from previous data set, if the evaluation date is the same

      if (!is.null(df_input_response_previous) && df_input_speaker_info$date_of_evaluation %in%  df_input_response_previous$date_of_evaluation) {
        referents_from_current <- df_input_response() %>%
          filter(.data$referent != "") %>%
          pull(.data$referent)
        referents_from_previous <- df_input_response_previous %>%
          filter(.data$date_of_evaluation == df_input_speaker_info$date_of_evaluation,
                 .data$referent %in% referents_from_current) %>%
          pull(.data$referent)
        check_for_duplicate_referents_previous <- length(referents_from_previous) > 0
        output$duplicate_referent_values <- renderText({
          paste0('"',paste(referents_from_previous, collapse = ", "), '"')
        })

      } else {
        check_for_duplicate_referents_previous <- FALSE
      }

      ### Check for missing values
      check_for_missing_values <- df_input_response() %>%
        filter(.data$referent == "" |
                 is.na(.data$conversing) |
                 is.na(.data$labeling) |
                 is.na(.data$echoing) |
                 is.na(.data$requesting))
      check_for_missing_values <- nrow(check_for_missing_values) > 0

      if (check_for_duplicate_referents) {
        shinyjs::show("duplicate_referent_message")
      } else {
        shinyjs::hide("duplicate_referent_message")
      }

      if (check_for_duplicate_referents_previous) {
        shinyjs::show("prevoius_data_duplicate_referent_message")
      } else {
        shinyjs::hide("prevoius_data_duplicate_referent_message")
      }

      if (check_for_missing_values | check_for_duplicate_referents | check_for_duplicate_referents_previous) {
        shinyjs::disable("button_generate")
      } else {
        shinyjs::enable("button_generate")
      }
    }, ignoreInit = TRUE)


    observeEvent(input$button_generate, {

      df_input_response_to_pass <- df_input_response()

      if (!is.null(df_input_response_previous) ) {

        df_input_response_to_pass <- rbind(
          df_input_response_to_pass,
          df_input_response_previous
        ) %>%
          arrange(.data$date_of_evaluation,
                  .data$referent_order)
          # group_by(.data$date_of_evaluation) %>%
          # mutate(referent_order = row_number()) %>%
          # ungroup() %>%
          # as.data.frame()
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
