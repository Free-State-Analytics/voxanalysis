#' Render Word Document Report
#'
#' @description
#' This function generates a Word document report using the `printable_report.qmd` template found in the `inst` folder of the package. The report provides a formatted summary of VOX Analysis data, making it suitable for sharing and documentation purposes.
#'
#' @inheritParams common-params
#' @param file_name A character string specifying the name of the exported file, including the `.docx` extension.
#' @import quarto
#' @import dplyr
#' @import flextable
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

  if (shiny::isRunning()) { ### Only run inside shiny app
    progress <- shiny::Progress$new()
    progress$set(message = "Preparing report download...", value = 0)
    Sys.sleep(1)
  }


  df_summarized_response <- util_summarize_response(df_input_response) %>%
    slice_max(.data$date_of_evaluation, n = 2)

  if (shiny::isRunning()) { ### Only run inside shiny app
    progress$set(message = "Compiling data...", value = 0.3)
    Sys.sleep(1)
  }

  params <- list(
    df_input_speaker_info = df_input_speaker_info,
    df_input_response = df_input_response,
    df_summarized_response = df_summarized_response
  )

  qmd_file <- system.file("reports", "printable_report.qmd", package = "voxanalysis")

  if (qmd_file == "") stop("Quarto file not found in installed package!")

  if (shiny::isRunning()) { ### Only run inside shiny app
    progress$set(message = "Rendering report...", detail = "(this may take up to a minute)", value = .5)
  }

  quarto_render(
    qmd_file,
    execute_params = params,
    output_file = file_name
  )

  if (shiny::isRunning()) { ### Only run inside shiny app
    progress$set(message = "Downloading...", detail = "", value = .9)
    Sys.sleep(1)
    progress$set(message = "Download complete.", value = 1)
  }

}



