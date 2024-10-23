#' @rdname mod_starting_page
#' @importFrom shinyjs hidden show hide
#' @export
#'
mod_starting_page_ui <- function(id) {

  tagList(
    div(class = "d-flex flex-row",
        style = "height: 100vh;",
        div(class = "px-1 border-end",
            div(class = "text-primary text-center mt-5",
                div(class = "my-5",
                    actionButton(
                      NS(id, "button_restart"),
                      div(
                        span(style = "font-size: 25px;",
                             icon("arrow-rotate-left")),
                        p("Start Over")),
                      class = "btn-sm btn-outline-primary border border-0"
                    )
                ),
                span(lass = "my-5",
                     style = "font-size: 25px;",
                     icon("info")
                )
            )
        ),
        div(id = NS(id, "div_select_a_path"),
            class = "d-flex flex-fill justify-content-center align-items-center",
            div(class = "card border-0",
                style = "max-width: 750px; max-height: 400px;",
                div(class = "card-body",
                    h3("How would you like to generate a report?"),
                    div(class = "row",
                        div(class = "col-5 d-flex align-items-center",
                            span(class = "pt-4",
                                 radioButtons(
                                   NS(id, "chosen_path"),
                                   label = NULL,
                                   selected = 1,
                                   choiceNames = c("Upload a .csv file", "Type in new data", "Both"),
                                   choiceValues = c(1, 2, 3),
                                 )
                            )
                        ),
                        div(class = "col-7 text-primary d-flex justify-content-center ",

                            uiOutput(NS(id, "icon_choice"))
                        )
                    ),
                    actionButton(NS(id, "begin"), "Begin", class = "btn btn-primary")
                )
            )
        ),
        shinyjs::hidden(
          div(id = NS(id, "div_upload_data_no_new_entries"),
              class = "d-flex flex-fill justify-content-center",
              mod_upload_data_set_ui(
                NS(id, "upload_data_no_new_entries")
              )
          )
        ),
        shinyjs::hidden(
          div(id = NS(id, "div_speaker_data_entry"),
              class = "d-flex flex-fill justify-content-center",
              mod_speaker_data_entry_ui(
                NS(id, "speaker_data_entry")
              )
          )
        ),
        shinyjs::hidden(
          div(id = NS(id, "div_upload_data_with_new_entries"),
              class = "d-flex flex-fill justify-content-center",
              mod_upload_data_set_ui(
                NS(id, "upload_data_with_new_entries")
              )
          )
        )

    )
  )



}
