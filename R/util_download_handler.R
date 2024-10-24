#' Download handlers for producing .csv and Word exports
#'
#' @description
#' `util_download_handler_word` and `util_download_handler_dataset` pass params on to `downloadHandler`.
#'
#' `util_download_handler_word` generates a Word version of the results page.
#'
#' `util_download_handler_dataset` generates a `.csv` with the inputs provided by the user.
#'
#' @inheritParams common-params
#'
#' @import shiny
#' @import bslib
#' @name util_download_handler
NULL

#' @rdname util_download_handler
#' @export

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


      showModal(
        modalDialog(tagList(p(em("Downloading report...")), p(style = "font-size: .75rem;","(This may take a minute)")), footer = NULL)
      )
      on.exit(removeModal())

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
      df_output_exportable <- crossing(
        df_input_speaker_info %>% select(-"date_of_evaluation"),
        df_input_response)
      write.csv(df_output_exportable,
                file,
                row.names=FALSE)
    }
  )
}
