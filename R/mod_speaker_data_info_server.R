#' @rdname mod_speaker_data_info
#' @importFrom shinyjs show hide hidden
#' @import gt
#' @export


mod_speaker_data_info_server <- function(id, df_input_speaker_info) {
  moduleServer(id, function(input, output, session) {

    updateTextInput(
      inputId = "last_name",
      value = df_input_speaker_info$last_name
    )

    updateTextInput(
      inputId = "first_name",
      value = df_input_speaker_info$first_name
    )

    updateDateInput(
      inputId = "date_of_evaluation",
      value = df_input_speaker_info$date_of_evaluation
    )

    updateDateInput(
      inputId = "date_of_birth",
      value = df_input_speaker_info$date_of_birth
    )

    updateTextInput(
      inputId = "language_spoken",
      value = df_input_speaker_info$language_spoken
    )

    updateTextInput(
      inputId = "gender",
      value = df_input_speaker_info$gender
    )

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


    output$speaker_info <- render_gt({

      df_input_speaker_info() %>%
        select("first_name", "last_name", "date_of_birth", "date_of_evaluation", "language_spoken", "gender") %>%
        rename(
          `First Name` = "first_name",
          `Last Name` = "last_name",
          `Date of Birth` = "date_of_birth",
          `Date of Evaluation` =  "date_of_evaluation",
          Language = "language_spoken",
          Gender =  "gender") %>%
        mutate(across(everything(), as.character)) %>%
        pivot_longer(everything()) %>%
        gt() %>%
        tab_style(
          style = list(
            cell_text(color = "#212529")
          ),
          locations = cells_body(
            columns = everything()
          )
        ) %>%
        tab_style(
          style = list(
            cell_text(align = "right", color = "#212529")
          ),
          locations = cells_body(
            columns = value
          )
        ) %>%
        tab_options(
          column_labels.hidden = TRUE,
          table.width = pct(100),
          table.background.color = "#FF000000",
          table_body.hlines.color = "#FF000000"
        )
    }, width = "100%")

    observeEvent(input$button_modify, {

      util_shiny_remove_and_hide_flex("div_speaker_info")
      shinyjs::show("div_speaker_entry",
                    anim = TRUE,
                    animType = "fade")
      rv$entries_in_progress = TRUE
      shinyjs::hide("button_modify")
    })

    observeEvent(input$button_save, {

      util_shiny_remove_and_hide_flex("div_speaker_entry")
      shinyjs::show("div_speaker_info",
                    anim = TRUE,
                    animType = "fade")
      rv$entries_in_progress = FALSE
      shinyjs::show("button_modify")
    })

    rv <- reactiveValues(
      entries_in_progress = FALSE
    )

    return(reactive(
      list(
        df_input_speaker_info= df_input_speaker_info(),
        entries_in_progress = rv$entries_in_progress)
    )
    )

  })
}
