#' Render Word Document Report
#'
#' @description
#' This function generates a Word document report using the `printable_report.qmd` template found in the `inst` folder of the package. The report provides a formatted summary of VOX Analysis data, making it suitable for sharing and documentation purposes.
#'
#' @inheritParams common-params
#' @param file_name A character string specifying the name of the exported file, including the `.docx` extension.
#' @import quarto
#' @import dplyr
#'
#' @examples
#' \dontrun{
#' # Load example data for report generation
#' data("df_input_speaker_info_example")
#' data("df_input_response_example")
#'
#' # Generate a Word document report
#' util_generate_word_doc_report(
#'   df_input_speaker_info = df_input_speaker_info_example,
#'   df_input_response = df_input_response_example,
#'   file_name = "text.docx"
#' )
#' }
#' @seealso [util_download_handler] for handling .csv and Word exports within the VOX Analysis app.
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



