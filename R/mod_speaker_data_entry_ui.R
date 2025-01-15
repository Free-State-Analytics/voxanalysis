#' @rdname mod_speaker_data_entry
#' @importFrom shinyjs hidden show hide
#' @export
#'
mod_speaker_data_entry_ui <- function(id) {
  tagList(
    div(id = NS(id, "div_speaker_info_entry"),
        class = "container d-flex align-items-center",
        style = "width: 400px;",
        div(class = "card card-border pb-3 mt-3",
            div(class = "card-body px-4",
                h4("Provide Speaker Info"),
                h4(
                  class = "d-flex justify-content-between",
                  span("Provide Speaker Info"),
                  tag_help_link(NS(id, "help_link"), page = "articles/generatingreports.html#provide-speaker-info")
                ),
                tag_speaker_input_form(id),
                shinyjs::hidden(
                  p(id = NS(id, "warning_message"),
                    class = "text-warning-emphasis",
                    icon("circle-exclamation"),
                    'Fields cannot contain a comma, semi-colon, or quotation marks.')
                ),
                shinyjs::disabled(actionButton(NS(id, "button_continue"), "Continue", class = "btn btn-primary"))
            )
        )),
    shinyjs::hidden(
      div(id = NS(id, "div_new_entry"),
          class = "d-flex flex-fill justify-content-center",
          mod_response_entry_ui(NS(id, "new_entry"))
          )
    )
  )
}
