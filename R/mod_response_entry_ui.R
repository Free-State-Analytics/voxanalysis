#' @rdname mod_response_entry
#' @importFrom shinyjs disabled hidden
#' @export
mod_response_entry_ui <- function(id) {
  tagList(
    div(id = NS(id, "data_entry_card"),
        class = "container d-flex align-items-center mt-5",
        style = "width: 700px;",
        div(class = "card card-border",
            style = "width: 700px;",
            div(class = "card-body px-4 pt-3",
              h3("Provide Speaker Responses"),
              h5(class = "mb-2",
                "How many verbal operants did you use in your session?"),
              selectInput(NS(id, "referent_count"), label = NULL, choices = c(6, 9, 12)),
              br(),
              h5(class = "mb-0",
                "Please provide verbal operant names and responses"),
              p(style = "font-weight: 300;",
               "Each response must be 1 or 0."),
              uiOutput(NS(id, "referent_response")),
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
