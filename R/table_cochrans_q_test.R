#' Create Summary Table with Cochran's Q Test and Supporting Statistics
#'
#' @description
#' This function generates a `data.frame` containing the results of Cochran's Q test, chance-corrected R, and corresponding p-values. The resulting table is intended for integration into VOX analysis application.
#'
#' @inheritParams common-params
#' @import dplyr
#' @import tidyr
#'
#' @export
#'
#' @examples
#' # Load example response data
#' data("df_input_response_example")
#'
#' # Generate a summary table with Cochran's Q test and supporting statistics
#' table_cochrans_q_test(df_input_response = df_input_response_example)

table_cochrans_q_test <- function(df_input_response) {

  if (length(unique(df_input_response$referent)) < nrow(df_input_response) ) {
    stop("Cochran's Q cannot be calculated. There are duplicate referent values found in the data set.")
  }

  chance_corrected <- calc_chance_corrected(df_input_response)

  dat <- df_input_response %>%
    select("referent", "conversing", "labeling", "echoing", "requesting") %>%
    pivot_longer(
      cols = c("conversing", "labeling", "echoing", "requesting"),
      names_to = "name",
      values_to = "value") %>%
    arrange(.data$name)
  coch <- calc_cochran_qtest(value ~ name | referent, dat, p.method = "bonferroni")

  data.frame(
    label = c("Cochran's Q", "Chance-corrected R", "P-value"),
    value = c(round(coch$statistic, 2), chance_corrected, round(coch$p.value,2))
  )


}
