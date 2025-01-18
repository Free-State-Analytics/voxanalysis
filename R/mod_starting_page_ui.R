#' @rdname mod_starting_page
#' @importFrom shinyjs hidden show hide
#' @export
#'
mod_starting_page_ui <- function(id) {

  tagList(
    div(class = "d-flex flex-row",
        div(class = "px-1 border-end",
            style = "position: sticky; top: 0; height: 100vh;",
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
                div(class = "my-5",
                  actionButton(
                    NS(id, "button_user_guide"),
                    div(
                      span(style = "font-size: 25px;",
                           icon("info")),
                      p("User Guide")
                    ),
                    class = "btn-sm btn-outline-primary border border-0",
                    onclick = "window.open('https://free-state-analytics.github.io/voxanalysis/', '_blank')"
                  )
                ),
                div(class = "my-5",
                  actionButton(
                    NS(id, "button_report_bug"),
                    div(
                      span(style = "font-size: 25px;",
                           icon("bug")),
                      p("Report Issue")
                    ),
                    class = "btn-sm btn-outline-primary border border-0",
                    onclick = "window.location.href = 'mailto:taylor.rodgers@freestateanalytics.com?subject=Bug Report for VOX Analysis&body=Please describe the issue here...';"
                  )
                ),
            )
        ),
        div(id = NS(id, "div_select_a_path"),
            class = "d-flex flex-fill justify-content-center align-items-center",
            div(class = "card card-border",
                style = "width: 550px; max-height: 400px;",
                div(class = "card-body px-4",
                    h4(class = "d-flex justify-content-between",
                       span("How would you like to generate a report?"),
                       tag_help_link(NS(id, "help_link"), page = "articles/generatingreports.html")),
                    div(class = "row",
                        div(class = "col-5 d-flex align-items-center",
                            span(class = "pt-3 ps-3",
                                 radioButtons(
                                   NS(id, "chosen_path"),
                                   label = NULL,
                                   selected = 1,
                                   choiceNames = c("Type in new data", "Upload a .csv file","Both"),
                                   choiceValues = c(1, 2, 3),
                                 )
                            )
                        ),
                        div(class = "col-7 text-primary d-flex justify-content-center ",

                            uiOutput(NS(id, "icon_choice"))
                        )
                    ),
                    actionButton(NS(id, "begin"), "Begin", class = "btn btn-primary mt-2")
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
