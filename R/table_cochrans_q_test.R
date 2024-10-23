#' Create summary table with cochran's q test and supporting tests
#'
#' @description
#' Produces data.frame with cochran's q test, chance-corrected R, and p-value.
#'
#' @inherit common-params
#' @import dplyr
#' @import tidyr
#'
#' @export
#'
#' @examples
#' data("df_input_response_example")
#' table_cochrans_q_test(df_input_response = df_input_response_example)
#'
#'

table_cochrans_q_test <- function(df_input_response) {

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
