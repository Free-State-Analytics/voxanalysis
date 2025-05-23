#' @rdname mod_response_entry
#' @importFrom shinyjs disabled hidden
#' @export
mod_response_entry_ui <- function(id) {
  tagList(
    div(id = NS(id, "data_entry_card"),
        class = "container d-flex align-items-center h-100",
        style = "width: 700px;",
        div(class = "card card-border pb-3 mt-3",
            style = "width: 700px;",
            div(class = "card-body px-4 pt-3",
              h4(
                class = "d-flex justify-content-between",
                span("Provide Speaker Responses"),
                tag_help_link(NS(id, "help_link"), page = "articles/generatingreports.html#provide-speaker-responses")
                ),
              h5(class = "mb-3",
                "How many referents did you use in your evaluation?"),
              selectInput(NS(id, "referent_count"), label = NULL, choices = c(6, 9, 12)),
              br(),
              h5(class = "mb-4", "Please provide referent names and responses."),
              # p(style = "font-weight: 300;",
              #  "Each response must be 1 or 0."),
              uiOutput(NS(id, "referent_response")),
              shinyjs::hidden(
                p(id = NS(id, "duplicate_referent_message"),
                  class="text-warning-emphasis",
                  icon("circle-exclamation"),
                  'Two referents have the same name. Please rename one to proceed.'
                )
              ),
              shinyjs::hidden(
                div(id = NS(id, "prevoius_data_duplicate_referent_message"),
                  class="text-warning-emphasis",
                  p(icon("circle-exclamation"),
                    'The referent(s) ', em(class="text-warning", textOutput(outputId = NS(id, "duplicate_referent_values"), inline = TRUE)), ' appear multiple times for this evaluation date in your data upload.'),
                  p('This will cause inaccurate VOX Analysis results unless the names are changed.'),
                  p('Change the referent name(s) above to something else, or add a number (e.g., "[referent name] 2") to differentiate them.')
                  )
              ),
              shinyjs::disabled(
                actionButton(NS(id, "button_generate"),
                             "Run Report",
                             class = "btn-primary"))
              )
            )
        ),
    shinyjs::hidden(
      div(id = NS(id, "results_primary_div"),
        mod_results_primary_ui(NS(id, "results_primary"))
      )
    )
  )
}
