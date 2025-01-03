#' @rdname mod_upload_data_set
#' @importFrom shinyjs hidden show hide
#' @importFrom utils read.csv
#' @export

mod_upload_data_set_server <- function(id, ind_add_new_data = FALSE) {
  moduleServer(id, function(input, output, session) {

    rv <- reactiveValues(
      df_input_speaker_info = data.frame(),
      df_input_response = data.frame()
    )

    observeEvent(
      input$data_upload, {

        shinyjs::hide("div_upload_to_results")
        shinyjs::hide("div_upload_to_data_entry")
        shinyjs::hide("button_continue")
        shinyjs::hide("div_run_report_buttons")

        result <- tryCatch(
          {
            list(
              df_to_upload = read.csv(input$data_upload$datapath),
              warning = NULL
            )
          },
          warning = function(w) {
            list(
              df_to_upload = NULL,
              warning = conditionMessage(w)
            )
          }
        )

        if (!is.null(result$warning)) {
          shinyjs::hide("div_update_speaker_data")
          shinyjs::show("error_message")
          return()
        }

        check_data_upload <- util_check_data_upload(result$df_to_upload)

        if (check_data_upload == "Bad") {
          shinyjs::hide("div_update_speaker_data")
          shinyjs::show("error_message")
          return()
        }

        if (ind_add_new_data) {
          shinyjs::hide("error_message")
          shinyjs::show("button_continue",
                        anim = TRUE,
                        animType = "fade")
        }


        if (!ind_add_new_data) {
          shinyjs::hide("error_message")
          shinyjs::show("div_run_report_buttons",
                        anim = TRUE,
                        animType = "fade")
        }

        rv$df_input_response <- result$df_to_upload %>%
          mutate(date_of_evaluation = as.Date(.data$date_of_evaluation)) %>%
          select("date_of_evaluation", "referent", "conversing", "labeling", "echoing", "requesting")
        ## Sometimes, the date that's uploaded is read as a character, causing disruption in future modules

        ### If the birthday is NA, we need to supply a date for the app to work.

        result$df_to_upload$date_of_birth <- ifelse(is.na(result$df_to_upload$date_of_birth), Sys.Date(), result$df_to_upload$date_of_birth)
        rv$df_input_speaker_info <- result$df_to_upload %>%
          filter(.data$date_of_evaluation == max(.data$date_of_evaluation)) %>%
          mutate(date_of_evaluation = as.Date(.data$date_of_evaluation),
                 date_of_birth = as.Date(.data$date_of_birth, origin = "1970-01-01")) %>%
          select(any_of(c("first_name", "last_name", "date_of_birth", "date_of_evaluation", "language_spoken", "gender"))) %>%
          distinct()

        if (ind_add_new_data && rv$df_input_speaker_info$date_of_evaluation == Sys.Date()) {
          shinyjs::show("same_date_message")
        } else {
          shinyjs::hide("same_date_message")
        }

        shinyjs::show("div_update_speaker_data")
        updated_speaker_data <- mod_speaker_data_info_server(
          "speaker_info",
          rv$df_input_speaker_info)

        observeEvent(updated_speaker_data(), {
          if (updated_speaker_data()$entries_in_progress) {
            shinyjs::disable("button_run_report")
            shinyjs::disable("button_results_download")
            shinyjs::disable("button_continue")
            shinyjs::hide("data_upload")
            rv$df_input_speaker_info <- updated_speaker_data()$df_input_speaker_info
          } else {
            shinyjs::enable("button_run_report")
            shinyjs::enable("button_results_download")
            shinyjs::enable("button_continue")
            shinyjs::show("data_upload")
            rv$df_input_speaker_info <- updated_speaker_data()$df_input_speaker_info
          }

        }, ignoreNULL = TRUE, ignoreInit = TRUE)

      }, ignoreNULL = TRUE, ignoreInit = TRUE)


    ### The code below is for the interactions with the buttons to continue the workflow.

    observeEvent(input$button_run_report, {
      ### We need to change the evaluation date in df_input_resopnse, if the use had changed it.
      if (!rv$df_input_speaker_info$date_of_evaluation %in% unique(rv$df_input_response$date_of_evaluation)) {
        rv$df_input_response <- rv$df_input_response %>%
          mutate(date_of_evaluation = rv$df_input_speaker_info$date_of_evaluation)
      }
      util_shiny_remove_and_hide_flex("div_data_upload")
      shinyjs::show("div_upload_to_results",
                    anim = TRUE,
                    animType = "fade")
      mod_results_primary_server(
        "upload_to_results",
        df_input_speaker_info = rv$df_input_speaker_info,
        df_input_response = rv$df_input_response
      )
    }, ignoreNULL = TRUE, ignoreInit = TRUE)

    output$button_results_download  <- util_download_handler_word(rv$df_input_speaker_info, rv$df_input_response)

    observeEvent(input$button_continue, {
      util_shiny_remove_and_hide_flex("div_data_upload")
      shinyjs::show("div_upload_to_data_entry",
                    anim = TRUE,
                    animType = "fade")

      df_input_response_previous <- rv$df_input_response %>%
        select("date_of_evaluation", "referent", "conversing", "labeling", "echoing", "requesting")

      mod_response_entry_server(
        "upload_to_data_entry",
        df_input_speaker_info = rv$df_input_speaker_info,
        df_input_response_previous = df_input_response_previous
      )
    }, ignoreNULL = TRUE, ignoreInit = TRUE)


  })
}

