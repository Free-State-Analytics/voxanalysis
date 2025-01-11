#' @rdname mod_results_section_detailed_analysis
#' @import gt
#' @export

mod_results_section_detailed_analysis_server <- function(
    id,
    df_input_response) {
    moduleServer(id, function(input, output, session) {

      df_summarized_response <- util_summarize_response(df_input_response)

      output$analysis_results_vox <- renderPlot({
        plot_vox_line(df_input_response)
      }) %>%
        bindCache(df_input_response)

      output$analysis_results_cochrans_q_table <- render_gt({
        table_cochrans_q_test(df_input_response) %>%
          gt() %>%
          tab_style(
            style = list(
              cell_text(color = "#212529")
            ),
            locations = cells_body(
              columns = everything()
            )
          ) %>%
          tab_style(
            style = list(
              cell_text(align = "right", color = "#212529")
            ),
            locations = cells_body(
              columns = 2
            )
          ) %>%
          tab_options(
            column_labels.hidden = TRUE,
            table.width = pct(100),
            table.background.color = "#FF000000",
            table_body.hlines.color = "#FF000000"
          )
      }, width = "100%") %>%
        bindCache(df_input_response)

      output$analysis_results_speakers_score <- renderUI({
        tag_kpi(calc_speakers_SCoRE(df_summarized_response), "Speaker's Score")
      }) %>%
        bindCache(df_summarized_response)

      output$analysis_results_vox_pie_chart <- renderPlot({
        plot_vox_piechart(df_summarized_response)
      }) %>%
        bindCache(df_summarized_response)

      output$analysis_results_hierarchy <- renderUI({

        tag_table_prompt_hierarchy(
          table_prompt_hierarchy(df_summarized_response)
          )

      })

    })

}




