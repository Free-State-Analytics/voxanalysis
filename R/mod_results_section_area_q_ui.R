#' @rdname mod_results_section_area_q
#' @importFrom shinyjs hidden
#' @export
mod_results_section_area_q_ui <- function(id) {

  tagList(
    h4(class = "mb-0", "Primary Results"),
    p(style = "font-weight: 300;", "Does my speaker have balanced language skills?"),
    div(class = "card card-border",
        div(class = "card-body",
        div(class = "row",
            div(class = "col-5",
                navset_underline(
                  id = NS(id, "area_q_tabs"),
                  nav_panel(title = "Centroid",
                            id = NS(id, "area_q_measures"),
                            div(class = "card mt-3 border-0",
                                div(class = "card-body m-auto ",
                                    uiOutput(NS(id, "centroids"))
                                )
                            )
                  ),
                  nav_panel(title = "Info",
                            id = NS(id, "area_q_info"),
                            div(class = "card mt-3 border-0",
                              div(class = "card-body m-auto",
                                h5(class = "d-flex justify-content-between",
                                  "Area Q Plot",
                                   tag_help_link(NS(id, "link"), page = "articles/datavizandcharts.html#area-q-plot")),
                                p("The Area Q plot helps visualize variance."),
                                p("A child with normal language development will have roughly equal points on each axis."),
                                p("A child with abnormal language development will have unequal points on each axis.")
                                )
                            )
                  )
                )
            ),
            div(class = "col-7",
                tag_spinner(
                  plotOutput(NS(id, "analysis_results_area_q_plot"))
                ),
                shinyjs::hidden(
                  div(id = NS(id, "filter_date_div"),
                      class = "d-flex justify-content-end",
                      div(class = "form-select-sm ",
                          style = "max-width: 150px;",
                          selectInput(NS(id, "filter_secondary_date"),
                                      label = em("Compare to..."),
                                      choices = c(NULL))
                      )
                  )
                ),
            )
            )
            )
        )
    )
}
