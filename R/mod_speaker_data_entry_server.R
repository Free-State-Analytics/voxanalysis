#' @rdname mod_speaker_data_entry
#' @importFrom shinyjs hidden show hide
#' @export
#'
mod_speaker_data_entry_server <- function(
    id) {

  moduleServer(id, function(input, output, session) {

    df_input_speaker_info <- reactive({

      data.frame(
        last_name = input$last_name,
        first_name = input$first_name,
        date_of_birth = input$date_of_birth,
        date_of_evaluation = input$date_of_evaluation,
        language_spoken = input$language_spoken,
        gender = input$gender
      )

    })

    observeEvent(df_input_speaker_info(), {

      data_to_check <- df_input_speaker_info() %>%
        select(-c("date_of_birth", "date_of_evaluation")) %>%
        pivot_longer(everything())

      bad_entries <- data_to_check %>%
        filter(str_detect(.data$value, ",") |
                 str_detect(.data$value, ";") |
                 str_detect(.data$value, "\"") |
                 str_detect(.data$value, "\'"))

      if (nrow(bad_entries) > 0) {
        shinyjs::show("warning_message")
        return()
      } else {
        shinyjs::hide("warning_message")
      }

      missing_entries <- data_to_check %>%
        filter(.data$name %in% c("first_name", "last_name")) %>%
        filter(.data$value == "" |
                 is.null(.data$value))

      if (nrow(missing_entries) == 0) {
        shinyjs::enable("button_continue")
        return()
      } else {
        shinyjs::disable("button_continue")
      }

    })


      observeEvent(input$button_continue, {
          util_shiny_remove_and_hide_flex("div_speaker_info_entry")
          shinyjs::show("div_new_entry",
                        anim = TRUE,
                        animType = "fade")
          mod_response_entry_server(
            "new_entry",
            df_input_speaker_info = df_input_speaker_info()
          )
      }, ignoreInit = TRUE, ignoreNULL = TRUE)

  })
}

