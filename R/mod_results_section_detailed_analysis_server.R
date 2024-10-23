#' @rdname mod_results_section_detailed_analysis
#' @import gt
#' @export

mod_results_section_detailed_analysis_server <- function(
    id,
    df_input_response) {
    moduleServer(id, function(input, output, session) {

      df_summarized_response <- summarize_response(df_input_response)

      output$analysis_results_vox <- renderPlot({
        plot_vox_line(df_input_response)
      }) %>%
        bindCache(df_input_response)

      output$analysis_results_cochrans_q_table <- renderTable({
        table_cochrans_q_test(df_input_response)
      }, width = "100%", colnames = FALSE) %>%
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




