#' Provided the chance corrected R calculation
#'
#' @description
#' Calculate the chance corrected R calculation for the language assessment.
#'
#' @inheritParams common-params
#'
#' @examples
#' library(dplyr)
#' data("df_input_response_example")
#' calc_chance_corrected(df_input_response = df_input_response_example)
#'
#' @references
#' \url{https://peterstatistics.com/CrashCourse/5-ThreeVarPair/binary/MultipleBinaryPaired3c.html}
#'
#' @returns A `vector`.
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
