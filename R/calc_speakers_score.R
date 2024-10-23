#' Calculate the speaker's SCoRE
#'
#' @description
#' Produces a data.frame with the prompt hierarchy
#'
#' @inherit common-params
#' @import dplyr
#' @import tidyr
#' @import stringr
#'
#' @examples
#' data("df_summarized_response_example")
#'  ## Function only works with one date at a time
#' dat <- df_summarized_response_example %>%
#'     filter(date_of_evaluation == max(date_of_evaluation))
#' calc_speakers_SCoRE(df_summarized_response = dat)
#'
#'



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
