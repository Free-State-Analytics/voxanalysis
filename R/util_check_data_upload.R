#' Quality Check for `df_input_response`
#'
#' @description
#' This function performs a quality check to ensure that `df_input_response` conforms to the expected data model. It is particularly useful for validating data uploaded by users via the `mod_upload_data_set` module, helping maintain data consistency and integrity within the VOX Analysis app.
#'
#' The function returns either `"Good"` or `"Bad"` to indicate the quality status, providing a clear, unambiguous result.
#'
#' @inheritParams common-params
#' @import dplyr
#' @import tidyr
#'
#' @return A character string, either `"Good"` if the data passes the quality check, or `"Bad"` if it does not.
#'
#' @examples
#' # Load example data for quality checking
#' data("df_input_response_example")
#'
#' # Perform a quality check on the data
#' util_check_data_upload(df_input_response = df_input_response_example)
#'
#'
#' @export

util_check_data_upload <- function(df_input_response) {

  req(df_input_response)

  ### Check that referent order is numeric (if exists)
  if ("referent_order" %in% colnames(df_input_response)) {
    check_referent_order <- is.numeric(df_input_response$referent_order)
  } else {
    check_referent_order <- TRUE
  }


  ### This checks that all the required columns are present and that we can continue with further checks
  columns_to_check <- c("date_of_evaluation", "referent", "conversing", "labeling", "echoing", "requesting")
  check_required_columns <- df_input_response %>% select(any_of(columns_to_check))
  check_required_columns <- colnames(check_required_columns)
  check_required_columns <- length(check_required_columns) == 6

  if (check_required_columns) {
    ### This checks that all referents are numeric
    first_col_character <- is.character(df_input_response[,"referent"])

    ### This checks that all verbal operants are numeric
    last_col_numeric <- is.numeric(as.matrix(df_input_response %>% select("conversing", "labeling", "echoing", "requesting")))

    ### This checks that all verbal operants are either 1 or 0
    check_binary_entries <- df_input_response %>%
      select("conversing", "labeling", "echoing", "requesting") %>%
      summarise(across(everything(), ~ any(. < 0 | . > 1)))
    check_binary_entries <- names(check_binary_entries)[check_binary_entries == TRUE]
    check_binary_entries <- length(check_binary_entries) == 0

    ### If all the quality checks are good, it returns "good". If not, we return "bad"
    if (first_col_character & last_col_numeric & check_binary_entries & check_referent_order) {
      return("Good")
    } else {
      return("Bad")
    }
  } else {
    return("Bad")
  }
}
