#' check_date_format
#'
#' @description Verifies that date format is `%Y-%m-%"`
#'
#' @noRd
#'
util_check_date_format <- function(date_string) {
  parsed_date <- as.Date(date_string, format = "%Y-%m-%d")
  !anyNA(parsed_date) && format(parsed_date, "%Y-%m-%d") == date_string
}
