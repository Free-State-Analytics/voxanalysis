#' @rdname mod_results_primary
#' @importFrom shinyjs hidden
#' @export
mod_results_primary_ui <- function(id) {

  div(class = "container overflow-y-auto d-flex justify-content-center",
      style = "height: 100vh; width: 100vw",
      div(
        br(),
        div(class = "row justify-content-between px-4",
            div(class = "col-7",
                h3("Results",
                   p(class="lead", "Scroll down to see analysis"))
            ),
            div(class = "col-5",
                shinyjs::hidden(
                  div(id = NS(id, "filter_date_div"),
                      class = "d-flex justify-content-end",
                      div(
                        class = "form-select-sm",
                        style = "max-width: 150px;",
                        selectInput(NS(id, "filter_primary_date"),
                                    label = "Select evaluation:",
                                    choices = NULL)
                      )
                  )
                )
            )
            ),
        div(class = "card pb-5 mb-5 bg-body-tertiary text-secondary-emphasis",
            style = "width: 625px;",
            div(class = "card-body px-4 grid gap-0 row-gap-3",
                div(class = "pb-5 g-col-12",
                  mod_results_section_area_q_ui(NS(id,"section_area_q"))
                  ),
                div(class = "py-5 g-col-12",
                  mod_results_section_detailed_analysis_ui(NS(id, "section_detailed_analysis"))
                  ),
                div(class = "pt-5 g-col-12",
                  h4(class = "mb-0",
                     "Responses by Verbal Operant"),
                  p(style = "font-weight: 300;",
                    "Down below are the responses to referants by verbal operants."),
                  uiOutput(NS(id, "table_response_results"))
                )
            )
            )
        ),
      mod_download_bar_ui(NS(id, "download_bar"))
  )

}
