#' @rdname mod_upload_data_set
#' @importFrom shinyjs hidden show hide
#' @export
#'
mod_upload_data_set_ui <- function(id) {

  tagList(
    div(id = NS(id, "div_data_upload"),
        class = "container d-flex align-items-center",
        style = "width: 550px;",
        div(class = "card card-border pb-3 mt-3",
            style = "width: 450px;",
            div(class = "card-body  px-4",
                h4(
                  class = "d-flex justify-content-between",
                  span("Upload Data Set"),
                  tag_help_link(NS(id, "help_link"), page = "articles/generatingreports.html#upload-data-set")
                ),
                p("Ensure proper structure with these", tags$a(href = "https://free-state-analytics.github.io/voxanalysis/articles/datamodel.html#dataupload", target = "_blank", "guidelines.") ),
                tag_custom_file_upload(
                  NS(id, "data_upload"),
                  placeholder = "Choose CSV File", accept = ".csv"),
                shinyjs::hidden(
                  p(id = NS(id, "error_message"),
                      class="text-warning-emphasis",
                      icon("circle-exclamation"),
                      "This data set cannot be uploaded. Please verify that it follows guidelines."
                  )
                ),
                shinyjs::hidden(
                  div(id = NS(id, "div_update_speaker_data"),
                      class = "mb-3",
                      mod_speaker_data_info_ui(NS(id, "speaker_info"))
                  )
                ),
                shinyjs::hidden(
                  p(id = NS(id, "same_date_message"),
                    class="text-info-emphasis",
                    icon("circle-exclamation"),
                    "Note: The data set you uploaded includes entries for today's date. Any new entries will be analyzed with these previous entries, unless you change the evaluation date in table above or the evaluation date in the source file."
                  )
                ),
                shinyjs::hidden(
                  actionButton(NS(id,"button_continue"), "Continue", class = "btn-primary")
                ),
                shinyjs::hidden(
                  div(id = NS(id, "div_run_report_buttons"),
                      div(class = "d-flex justify-content-between mt-5",
                          actionButton(NS(id,"button_run_report"), "Show Report", class = "btn-primary"),
                          span(class = "pt-2", " - or - "),
                          downloadButton(NS(id, "button_results_download"),
                                         label = "Download Report",
                                         class = "btn btn-primary")
                      )
                  )
                )
            )
        )
    ),
    shinyjs::hidden(
      div(id = NS(id, "div_upload_to_data_entry"),
          mod_response_entry_ui(NS(id, "upload_to_data_entry"))
      )
    ),
    shinyjs::hidden(
      div(id = NS(id, "div_upload_to_results"),
          mod_results_primary_ui(NS(id, "upload_to_results"))
      )
    )
  )
}
