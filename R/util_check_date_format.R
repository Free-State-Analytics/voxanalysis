#' check_date_format
#'
#' @description Verifies that date format is `%Y-%m-%"`
#'
#' @noRd
#'
util_check_date_format <- function(date_string) {

  parsed_date <- as.Date(unique(date_string), format = "%Y-%m-%d")

  if (sum(is.na(parsed_date)) > 0 || sum(format(parsed_date, "%Y-%m-%d") != unique(date_string)) > 0) {

    return(FALSE)

  } else {

    return( TRUE)
  }

}
