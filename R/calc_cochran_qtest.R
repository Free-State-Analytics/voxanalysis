#' Perform Cochran's Q Test for Multiple Response Comparisons
#'
#' @description
#' This function performs Cochran's Q Test, a non-parametric test for examining differences in proportions across multiple related groups. It is based on the `RVAideMemoire` package's implementation, adapted here to avoid external dependencies and ensure seamless integration. Cochran's Q Test is commonly used in repeated measures designs or studies with binary response data.
#'
#' @param formula A formula specifying the model to use in the test. Typically, the format is `value ~ name | referent`, where `value` is the binary response variable and `name` represents different conditions or responses.
#' @param data A `data.frame` containing the binary responses for each verbal operant (e.g., `Conversing`, `Labeling`, `Echoing`, and `Requesting`). The data should be transformed with `pivot_longer` so that the binary operant names are in a `name` column, and responses are in a `value` column.
#' @param alpha Significance level for the test (e.g., 0.05).
#' @param p.method Method for p-value adjustment for multiple comparisons; VOX analysis uses `bonferroni`.
#'
#' @return A `list` containing the following components:
#'   \describe{
#'     \item{statistic}{The test statistic for Cochran's Q.}
#'     \item{p.value}{The p-value associated with the test statistic, after adjustment if `p.method` is specified.}
#'     \item{...}{Other values are returned, but not used for the purpose of the VOX Analysis app.}
#'   }
#'
#' @examples
#' # Example of Cochran's Q Test using sample response data
#' library(dplyr)
#' library(tidyr)
#' data("df_input_response_example")
#'  dat <- df_input_response_example %>%
#'     select("referent", "conversing", "labeling", "echoing", "requesting") %>%
#'    pivot_longer(
#'      cols = c("conversing", "labeling", "echoing", "requesting"),
#'      names_to = "name",
#'      values_to = "value") %>%
#'      arrange(.data$name)
#' calc_cochran_qtest(
#'   formula = value ~ name | referent,
#'   data = dat,
#'   alpha = 0.05,
#'   p.method = "bonferroni"
#' )
#'
#' @export


calc_cochran_qtest <- function (formula, data, alpha = 0.05, p.method = "bonferroni")
{
  if (missing(formula)) {
    stop("formula missing")
  }
  if ((length(formula) != 3) || (length(formula[[3]]) != 3) ||
      (formula[[3]][[1]] != as.name("|")) || (length(formula[[3]][[2]]) !=
                                              1) || (length(formula[[3]][[3]]) != 1)) {
    stop("incorrect specification for formula")
  }
  formula[[3]][[1]] <- as.name("+")
  m <- match.call()
  m$formula <- formula
  if (is.matrix(eval(m$data, parent.frame()))) {
    m$data <- as.data.frame(m$data)
  }
  m[[1]] <- as.name("model.frame")
  m$alpha <- m$p.method <- NULL
  mf <- eval(m, parent.frame())
  mf <- droplevels(mf[stats::complete.cases(mf), ])
  dname <- paste(names(mf)[1], " by ", names(mf)[2], ", block = ",
                 names(mf)[3], sep = "")
  resp <- mf[, 1]
  fact <- mf[, 2]
  block <- mf[, 3]
  if (length(stats::na.omit(unique(resp))) != 2) {
    stop(paste(names(mf)[1], "is not a binary variable"))
  }
  resp <- as.numeric(factor(resp)) - 1
  proba <- tapply(resp, fact, mean, na.rm = TRUE)
  names(proba) <- paste("proba in group ", levels(fact), sep = "")
  nval <- 0
  names(nval) <- "difference in probabilities"
  tab.length <- tapply(resp, list(block, fact), function(x) length(stats::na.omit(x)))
  if (any(tab.length != 1) | any(is.na(tab.length))) {
    stop(paste("there must be 1 observation per level of '",
               names(mf)[2], "' in each block", sep = ""))
  }
  tab <- tapply(resp, list(block, fact), function(x) sum(x))
  k <- ncol(tab)
  b <- nrow(tab)
  X.j <- colSums(tab)
  Xi. <- rowSums(tab)
  N <- sum(X.j)
  Q <- k * (k - 1) * sum((X.j - N/k)^2)/sum(Xi. * (k - Xi.))
  names(Q) <- "Q"
  p <- stats::pchisq(Q, k - 1, lower.tail = FALSE)
  names(p) <- NULL
  result <- list(method.test = "Cochran's Q test", data.name = dname,
                 statistic = Q, parameter = c(df = k - 1), alternative = "two.sided",
                 null.value = nval, p.value = p, estimate = proba, alpha = alpha)
  if (p < alpha & nlevels(fact) > 2) {
    fun.p <- function(i, j) {
      signs <- apply(tab[, c(i, j)], 1, diff)
      if (length(signs[signs != 0]) > 0) {
        stats::binom.test(length(signs[signs > 0]), length(signs[signs !=
                                                            0]), 0.5)$p.value
      }
      else {
        1
      }
    }
    result$method.multcomp <- "Wilcoxon sign test"
    result$p.adjust.method <- p.method
    result$p.value.multcomp <- stats::pairwise.table(fun.p, levels(fact),
                                              p.adjust.method = p.method)
  }
  class(result) <- "RVtest"
  return(result)
}
