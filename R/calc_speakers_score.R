#' Calculate the Speaker's SCoRE (Stimulus Control Ratio Equation)
#'
#' @description
#' This function calculates the Speaker's SCoRE, a metric used in VOX Analysis to evaluate the balance of language development. SCoRE reflects the consistency and reliability of the speaker's responses (e.g., Conversing, Labeling, Echoing, and Requesting) within an evaluation session. This score aids the listener or user in analyzing the speaker's engagement with each verbal operant during verbal episodes.
#'
#' @inheritParams common-params
#' @import dplyr
#' @import tidyr
#' @import stringr
#'
#' @return A numeric vector containing the SCoRE values, representing the degree of language engagement and response reliability across verbal episodes.
#'
#' @examples
#' library(dplyr)
#' data("df_summarized_response_example")
#'
#' # Filter the data to a single evaluation date for accurate SCoRE calculation
#' dat <- df_summarized_response_example %>%
#'   filter(date_of_evaluation == max(date_of_evaluation))
#'
#' # Calculate the Speaker's SCoRE
#' calc_speakers_SCoRE(df_summarized_response = dat)
#'
#' @export


calc_speakers_SCoRE <- function(df_summarized_response) {

  dat <- df_summarized_response %>%
    select("conversing", "labeling", "echoing", "requesting") %>%
    pivot_longer(everything())
  dat <- dat %>%
    mutate(total = sum(dat$value),
           perc = .data$value / .data$total,
           agreement = ifelse(.data$perc <= .25, .data$perc, .25),
           disagreement = ifelse(.data$perc > .25, .data$perc, .25)
    )

  round(sum(dat$agreement) / sum(dat$disagreement), 2)

}
