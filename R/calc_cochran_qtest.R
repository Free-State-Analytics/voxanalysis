#' Cochran's Q test
#'
#' @description
#' This is heavily based on Cochran's Q Test from `RVAideMemoire` package.
#'
#' There were several dependency issues with the package, so it was re-written to be a built-in function for this package with some modification.
#'
#' @param formula A formula to pass through. The app currently uses `value ~ name | referent`.
#' @param data A `data.frame` containing `Conversing`, `Labeling`, `Echoing`, and `Requesting`. Must have `pivot_longer` applied, with `name` and `value` being the two new columns.
#' @param alpha alpha level.
#' @param p.method p method. Recommend "fdr".
#' @returns A `list`.
#' @export

calc_cochran_qtest <- function (formula, data, alpha = 0.05, p.method = "fdr")
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
