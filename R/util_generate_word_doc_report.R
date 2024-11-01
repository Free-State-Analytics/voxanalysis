#' Render Word Doc Report
#'
#' @description
#' Produces a word doc report using the `printable_report.qmd` found in the `inst` folder.
#'
#'
#' @inherit common-params
#' @param file_name The name of the file to be exported.
#' @import quarto
#' @import dplyr
#'
#' @examples
#'
#' \dontrun{
#' data("df_input_speaker_info_example")
#' data("df_input_response_example")
#' util_generate_word_doc_report(
#'   df_input_speaker_info = df_input_speaker_info_example,
#'   df_input_response = df_input_response_example,
#'   file_name = "text.docx")
#' }
#'
#' @export

util_generate_word_doc_report <- function(
    df_input_speaker_info = NULL,
    df_input_response,
    file_name) {

  df_summarized_response <- util_summarize_response(df_input_response) %>%
      slice_max(.data$date_of_evaluation,
                n = 2)

  params <- list(
    df_input_speaker_info = df_input_speaker_info,
    df_input_response = df_input_response,
    df_summarized_response = df_summarized_response
  )

  quarto_render(
    "inst/reports/printable_report.qmd",
    execute_params = params,
    output_file = file_name
  )

}



