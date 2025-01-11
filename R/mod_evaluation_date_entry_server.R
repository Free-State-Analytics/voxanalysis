#' @rdname mod_evaluation_date_entry
#' @importFrom shinyjs show hide hidden
#' @export

mod_evaluation_date_entry_server <- function(id, df_input_speaker_info, df_input_response_previous) {
  moduleServer(id, function(input, output, session) {

    df_input_speaker_info_update <- reactive({

      df_input_speaker_info %>%
        mutate(
          date_of_evaluation = input$date_of_evaluation
        ) %>%
        as.data.frame()

    })

    observeEvent(input$date_of_evaluation, {

      if (input$date_of_evaluation %in% unique(df_input_response_previous$date_of_evaluation)) {
        shinyjs::show("same_date_message")
      } else {
        shinyjs::hide("same_date_message")
      }

      if (length(input$date_of_evaluation) < 1) {
        shinyjs::disable("button_continue")
      } else {
        shinyjs::enable("button_continue")
      }
    })

    observeEvent(input$button_continue, {

      util_shiny_remove_and_hide_flex("div_date_entry")

      shinyjs::show("div_upload_to_data_entry",
                    anim = TRUE,
                    animType = "fade")

      mod_response_entry_server(
        "upload_to_data_entry",
        df_input_speaker_info = df_input_speaker_info_update(),
        df_input_response_previous = df_input_response_previous
      )
    }, ignoreNULL = TRUE, ignoreInit = TRUE)

  })
}

