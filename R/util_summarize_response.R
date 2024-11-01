#' Summarize Responses by Type
#'
#' @description
#' This utility function aggregates responses by type (e.g., Conversing, Labeling, Echoing, Requesting) within the VOX Analysis application. It calculates the total count for each response type, providing a summary that can be used for further analysis or visualization.
#'
#' @inheritParams common-params
#'
#' @examples
#' # Load example data
#' data("df_input_response_example")
#'
#' # Summarize responses by type
#' util_summarize_response(
#'   df_input_response = df_input_response_example
#' )
#'
#' @export


util_summarize_response <- function(df_input_response) {

    dat <- df_input_response %>%
      dplyr::select("date_of_evaluation", "labeling", "echoing", "requesting", "conversing") %>%
      dplyr::group_by(.data$date_of_evaluation) %>%
      dplyr::summarize(dplyr::across(c("labeling", "echoing", "requesting", "conversing"), sum)) %>%
      dplyr::arrange(dplyr::desc(.data$date_of_evaluation))

    return(dat)

}
