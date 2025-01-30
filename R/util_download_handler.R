#' Download Handlers for Generating .csv and Word Exports
#'
#' @description
#' These functions provide download handlers for exporting data in `.csv` and Word document formats:
#'
#' \itemize{
#'   \item `util_download_handler_word`: Generates a Word version of the results page, formatted for reporting and easy sharing of VOX Analysis outputs.
#'   \item `util_download_handler_dataset`: Creates a `.csv` file containing the input data provided by the user, allowing for quick data export and further analysis.
#' }
#'
#' Both functions pass parameters to `downloadHandler`, enabling customization of file output within the VOX Analysis app.
#'
#' @inheritParams common-params
#' @import shiny
#' @import bslib
#' @seealso [util_generate_word_doc_report] for generating a Word document report based on VOX Analysis data.
#' @name util_download_handler
NULL


util_download_handler_word <- function(df_input_speaker_info, df_input_response, df_summarized_response) {

  downloadHandler(
    filename = function() {
      if (!is.null(df_input_speaker_info)) {
        file_name = paste(
          df_input_speaker_info$last_name,
          df_input_speaker_info$first_name,
          "language-assessment",
          paste0(df_input_speaker_info$date_of_evaluation, ".docx"),
          sep = "-")
      } else {
        file_name = paste(Sys.Date(),"language-report.docx", sep = "-")
      }
      return(file_name)
    },
    content = function(file) {

      temp_file <-paste0("temp_report_", Sys.Date(), ".docx")

      util_generate_word_doc_report(
        df_input_speaker_info,
        df_input_response,
        file_name = temp_file)

      file.copy(temp_file, file, overwrite = TRUE)
    }
  )


}

#' @rdname util_download_handler
#' @export

util_download_handler_dataset <- function(df_input_speaker_info, df_input_response) {
  downloadHandler(
    filename = function() {
      date_to_pass <- max(df_input_response$date_of_evaluation)
      if (df_input_speaker_info$first_name != "" & df_input_speaker_info$last_name != "") {
        paste0(df_input_speaker_info$last_name,"-", df_input_speaker_info$first_name, "-", as.Date(date_to_pass), ".csv")
      }
      else {
        paste0("patient-inputs-", as.Date(date_to_pass), ".csv")
      }
    },
    content = function(file) {

      progress <- shiny::Progress$new()
      progress$set(message = "Preparing download...", value = 0)

      df_output_exportable <- crossing(
        df_input_speaker_info %>% select(-"date_of_evaluation"),
        df_input_response)
      write.csv(df_output_exportable,
                file,
                row.names=FALSE)

      progress$set(message = "Download complete.", value = 1)

    }
  )
}
