#' Calculate the Chance-Corrected R for Language Assessment
#'
#' @description
#' This function computes the chance-corrected R value, a measure used in the VOX analysis to evaluate agreement while accounting for chance. The R value adjusts for potential randomness in scoring or response patterns, providing a more accurate assessment of inter-rater or inter-response agreement.
#'
#' @inheritParams common-params
#'
#' @examples
#' library(dplyr)
#' data("df_input_response_example")
#' calc_chance_corrected(df_input_response = df_input_response_example)
#'
#' @references
#' For more information on chance-corrected measures in agreement assessments, see:
#' \url{https://peterstatistics.com/CrashCourse/5-ThreeVarPair/binary/MultipleBinaryPaired3c.html}
#'
#' @return A numeric vector containing the chance-corrected R value for the provided data. This value can help assess consistency in language evaluations by controlling for chance agreement.
#' @export

calc_chance_corrected <- function(df_input_response) {
  dat <- df_input_response  %>%
    select("conversing", "labeling", "echoing", "requesting")
  dat <-  as.matrix(dat)

  #Chance corrected measure of effect size:
  b <- dim(dat)[1]
  k <- dim(dat)[2]
  res <- 0
  for (i in 1:k) {
    for (j in 1:(b-1)) {
      for (l in (j+1):b) {
        res <- res+abs(dat[j,i]-dat[l,i])
      }
    }
  }
  delta <- 1/(k*choose(b,2))*res
  pi <- rowSums(dat)/k
  spi <- 0
  spi2 <- 0
  for (i in 1:b){
    spi <- spi+pi[i]
    spi2 <- spi2+pi[i]*(1-pi[i])
  }
  mudelta <- 2/(b*(b-1))*(spi*(b-spi)-spi2)
  r <- 1 - delta / mudelta
  return(as.vector(r))

}
