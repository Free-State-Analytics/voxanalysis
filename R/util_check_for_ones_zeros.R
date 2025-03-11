#' Check if `df_input_response` is all 1s or 0s
#'
#' @description
#' This function performs a quality check to determine whether `df_input_response` has only 1s or 0s as entries.
#'
#' @inheritParams common-params
#' @param ind_check_only_for_zero Only evaluate if they are all zeros
#' @import dplyr
#' @import tidyr
#'
#' @examples
#' # Load example data, which has both 1s and 0s
#' data("df_input_response_example")
#'
#' # This will return FALSE
#' util_check_for_ones_zeros(df_input_response = df_input_response_example)
#'
#' # Create data frame with all 0s
#' df_zeroed <- data.frame(
#'   date_of_evaluation = rep('2024-08-23', 6),
#'   referent = c('Apple', 'Ball', 'Tablet', 'Pencil', 'Army Man', 'Mouse'),
#'   conversing = rep(0, 6),
#'   labeling = rep(0, 6),
#'   echoing = rep(0, 6),
#'   requesting = rep(0, 6)
#'  )
#'
#' # This will return TRUE
#' util_check_for_ones_zeros(df_input_response = df_zeroed)
#'
#' # Create data frame with all 1s
#' df_ones <- data.frame(
#'   date_of_evaluation = rep('2024-08-23', 6),
#'   referent = c('Apple', 'Ball', 'Tablet', 'Pencil', 'Army Man', 'Mouse'),
#'   conversing = rep(1, 6),
#'   labeling = rep(1, 6),
#'   echoing = rep(1, 6),
#'   requesting = rep(1, 6)
#'  )
#'
#' # This will return TRUE
#' util_check_for_ones_zeros(df_input_response = df_ones)
#'
#'
#' @export

util_check_for_ones_zeros <- function(df_input_response, ind_check_only_for_zero = FALSE) {

  req(df_input_response)

  total_positives <- df_input_response %>%
    select("conversing",
           "labeling",
           "echoing",
           "requesting")
  total_positives <- sum(as.matrix(total_positives))

  if (ind_check_only_for_zero) {
    check_df_input_response <- total_positives == 0
  } else {
    check_df_input_response <- total_positives == 0 | total_positives == (nrow(df_input_response)*4)
  }
  return(check_df_input_response)

}
