#' evaluation_data_entry UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
mod_evaluation_data_entry_ui <- function(id) {
  tagList(
    div(id = NS(id, "div_date_entry"),
      class = "container d-flex align-items-center",
      style = "width: 550px;",
      div(class = "card card-border pb-3 mt-3",
          style = "width: 450px;",
          div(class = "card-body  px-4",
              h4("Provide Current Evaluation Date"),
              dateInput(NS(id, "date_of_evaluation"), label = "When did the new evaluation occur?"),
              shinyjs::hidden(
                div(id = NS(id, "same_date_message"),
                    class="text-info-emphasis",
                    p(icon("circle-exclamation"), "Note: Your previous data upload already includes this evaluation date."),
                    p('By clicking "Continue," the VOX Analysis will append your new records to the previous analysis'),
                    p("If this analysis is for a new evaluaton, please change the evaluation date above or within your uploaded data set.")
                )
              ),
              actionButton(NS(id, "button_continue"), label = "Continue", class = "btn-primary")
          )
      )
    ),
    shinyjs::hidden(
      div(id = NS(id, "div_upload_to_data_entry"),
          mod_response_entry_ui(NS(id, "upload_to_data_entry"))
      )
    )
  )
}

#' evaluation_data_entry Server Functions
#'
#' @noRd
mod_evaluation_data_entry_server <- function(id, df_input_speaker_info, df_input_response_previous) {
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

