#' @rdname mod_results_section_detailed_analysis
#' @export

mod_results_section_detailed_analysis_ui <- function(id) {

  div(
    h4(class = "mb-0",
       "Detailed Analysis"),
       p(style = "font-weight: 300;",
         "Click the four tabs for more thorough VOX analysis results."),
    navset_underline(
      id = NS(id, "detailed_analysis"),
      nav_panel(
        title = "Vox Chart",
        id = NS(id, "vox_chart"),
        div(class = "card card-border mt-4",
            style = "height: 520px;",
            div(class = "card-body",
                h5(class = "mb-0 mx-3 d-flex justify-content-between",
                   "Vox Chart",
                   tag_help_link(NS(id, "link"), page = "articles/datavizandcharts.html#vox-line-chart")),
                p(class = "mx-3","Results by Verbal Episode"),
                tag_spinner(
                  plotOutput(NS(id, "analysis_results_vox"))
                )
                )
            )
        ),
      nav_panel(
        title = "Cochran's Q",
        id = NS(id, "cochrans_q"),
        div(class = "card card-border mt-4",
            style = "height: 520px;",
            div(class = "card-body",
                div(class = "row justify-content-center",
                    div(class = "col-8",
                      div(class = "ps-2",
                          h5(class = "mb-0 d-flex justify-content-between",
                             "Cochran's Q",
                             tag_help_link(NS(id, "link"), page = "articles/datavizandcharts.html#cochrans-q-test-table")),
                          p(class = "mb-3", "A test for balance in language skills"),
                          ),
                      div(class = "row d-flex align-items-center h-100",
                          div(
                            tag_spinner(
                              gt_output(NS(id, "analysis_results_cochrans_q_table"))
                            ),
                            p(class = "info-div mt-4", "Cochran's Q is a statistical test used (in this app) to verify whether the speaker has a balanced repertoire."),
                            p(class = "info-div", "A p-value less than 0.05 means we reject the null in favor of the alternative that the speaker does have an imbalance.")
                          )
                      )
                    )
                )
            )
        )
      ),
      nav_panel(
        title = "SCoRE",
        id = NS(id, "score"),
        div(class = "card card-border mt-4",
            style = "height: 520px;",
            div(class = "card-body",
                h5(class = "mb-0 mx-5 d-flex justify-content-between",
                   "SCoRE",
                   tag_help_link(NS(id, "link"), page = "articles/datavizandcharts.html#vox-pie-chart")),
                p(class = "mx-5", "A measure of balance in language skills"),
                div(class = "d-flex align-items-center",
                  div(class = "row justify-content-center my-4",
                      div(class = "col-6",
                          tag_spinner(
                            div(
                              uiOutput(NS(id, "analysis_results_speakers_score")),
                              plotOutput(NS(id, "analysis_results_vox_pie_chart"), height = "275px", width = "275px")
                              )
                            )
                        ),
                      div(class = "col-4 mt-auto info-div",
                          p("The ",em(style = "font-weight:300;", "Stimulus Control Ratio Equation"), " (SCoRE) measures the proportionality of the speaker's repertoire on a scale of 0 to 1"),
                          p("A higher number indicates balanced language assessment."),
                          p("The pie chart on the left further illustrates this balance or imbalance.")
                          )
                  )
                )
            )
        )
      ),
      nav_panel(
        title = "Prompt Hierarchy",
        id = NS(id, "prompt_hierarchy"),
        div(class = "card card-border mt-4",
            div(class = "card-body",
                h5(class = "mb-0 mx-5 d-flex justify-content-between",
                   "Prompt Hierarchy Table",
                   tag_help_link(NS(id, "link"), page = "articles/datavizandcharts.html#hierarchy-table")),
                p(class = "mt-0 mx-5", "A plan for action"),
                div(class = "d-flex justify-content-center",
                  tag_spinner(
                    uiOutput(NS(id, "analysis_results_hierarchy"))
                    )
                )
            )
        )
      )
    )
  )
 }

