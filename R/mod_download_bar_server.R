#' @rdname mod_download_bar
#' @export


mod_download_bar_server <- function(
    id,
    df_input_speaker_info,
    df_input_response,
    df_summarized_response) {

  moduleServer(id, function(input, output, session) {
      output$results_save_data <- util_download_handler_dataset(df_input_speaker_info, df_input_response)
      output$results_download <- util_download_handler_word(df_input_speaker_info, df_input_response)
  })

}
