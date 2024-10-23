#' Group response
#'
#' @description
#' A utility function to sum the response by the type of response.
#'
#' @inherit common-params
#'
#' @examples
#' summarize_response(
#'   df_input_response = df_input_response_example
#'   )


summarize_response <- function(df_input_response) {

    dat <- df_input_response %>%
      dplyr::select("date_of_evaluation", "labeling", "echoing", "requesting", "conversing") %>%
      dplyr::group_by(.data$date_of_evaluation) %>%
      dplyr::summarize(dplyr::across(c("labeling", "echoing", "requesting", "conversing"), sum)) %>%
      dplyr::arrange(dplyr::desc(.data$date_of_evaluation))

    return(dat)

}
