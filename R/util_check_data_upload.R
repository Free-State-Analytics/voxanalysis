#' Quality check df_input_response
#'
#' @description
#' A helpful function to ensure that `df_input_response` follows the right data model.
#'
#' This is particular useful with quality checking data the user uploaded via `mod_upload_data_set`.
#'
#' Returns `Good` or `Bad` to avoid ambiguity.
#'
#' @inheritParams common-params
#' @import dplyr
#' @import tidyr
#'
#' @examples
#' data("df_input_response_example")
#' util_check_data_upload(df_input_response = df_input_response_example)
#'
#' @export



util_check_data_upload <- function(df_input_response) {

  req(df_input_response)

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
    if (first_col_character & last_col_numeric & check_binary_entries) {
      return("Good")
    } else {
      return("Bad")
    }
  } else {
    return("Bad")
  }
}
