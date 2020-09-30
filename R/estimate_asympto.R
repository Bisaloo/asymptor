#' Estimate the proportion of asymptomatic cases by capture/recapture
#'
#' @param df A data.frame containing three columns containing `date`, the daily
#'   number of `new_cases`, and the daily number of `new_deaths`.
#' @param bounds `"lower"`, `"upper"`, or both `c("lower, "upper"`) (the
#'   default), telling which bounds of the number of asymptomatic cases are
#'   computed.
# @param sd If `TRUE` (defaults to `FALSE`), returns the standard deviation
#'   associated with the lower and upper bounds.
# @param unbiased If `TRUE` (the default), returns the unbiased version of the
#'   estimation. `FALSE` is never the recommended setting excepted for testing
#'   or debugging purpose.
#'
#' @return A `data.frame` with two or three columns (depending on the value of
#'   the `bounds` argument):
#'   * `date`: the original `date` column from your input dataset `df`
#'   * `lower`: the lower bound of asymptomatic cases
#'   * `upper`: the upper bound of asymptomatic cases
#'
#' @export
#'
#' @references Böhning D., Rocchetti I., Maruotti A., Holling H. (2020),
#'   Estimating the undetected infections in the Covid-19 outbreak by harnessing
#'   capture–recapture methods, International Journal of Infectious Diseases,
#'   97, p197-201, \doi{10.1016/j.ijid.2020.06.009}.
#' @references Rocchetti I., Böhning D., Holling H., Maruotti A., (2020),
#'   Estimating the size of undetected cases of the SARS-CoV-2 outbreak in
#'   Europe: An upperbound estimator, medRxiv,
#'   \doi{10.1101/2020.07.14.20153445}.
#'
#' @example
#'
#' d <- readRDS(system.file("extdata", "covid19_italy.rds", package = "asymptor"))
#' head(d)
#'
#' estimate_asympto(d)
#'
estimate_asympto <- function(df, bounds = c("lower", "upper")) {

  # It's good to allow the user to get only "lower" since they might not have
  # data with the number of recoveries, which is required to compute the "upper"
  # bound.
  bounds <- match.arg(bounds, several.ok = TRUE)

  res <- as.data.frame(df$date)

  f <- function(k) {
    if (k == 1) {
      df$new_cases
    } else {
      custom_lag(df$new_cases, k-1) - rowSums(vapply(0:(k-2), function(i) custom_lag(df$new_deaths, i), numeric(nrow(df))))
    }
  }

  f1 <- f(1)
  f2 <- f(2)

  # f0 is also the lower bound
  f0 <- f1*(f1-1)/(1+pmax(0, f2))

  if ("lower" %in% bounds) {
    res <- cbind(res, as.integer(round(f0)))
  }

  if ("upper" %in% bounds) {
#    current <- cumsum(with(df, new_cases-new_deaths-new_recoveries))
    current <- f1+f2+f(3)

    p <- function(k) {
      rowSums(vapply(seq_len(k), f, numeric(nrow(df)))) / current
    }

    pi0 <- f0 / (f1+f2+f0)

    pi <- function(k) {
      pi0 + (1-pi0) * p(k)
    }

    pi0_ub <- (p(2)-p(1))/(1-pi(1)/pi(2)+p(2)-p(1))

    upb <- current * pi0_ub / (1-pi0_ub)

    if (any(f0 < 0, upb < 0, na.rm = TRUE)) {
      warning(
        "Number of asymptomatic cases is negative for some dates. ",
        "Manually setting to 0", call. = FALSE
      )
      f0[f0 < 0] <- 0
      upb[upb < 0] <- 0
    }

    res <- cbind(res, as.integer(round(upb)))
  }

  colnames(res) <- c("date", bounds)

  return(res)

}
