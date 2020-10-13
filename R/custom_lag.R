#' Lag a vector
#'
#' @param x Vector (of any class).
#' @param k Integer to specify the lag (defaults to 1).
#'
#' @return A lagged vector (not a time series as opposed to [stats::lag()]).
#' The behaviour of this `lag()` function is closer to that of `dplyr::lag()`.
#'
# @examples
# c(custom_lag(c(1,3,5), 1))
#
# c(custom_lag(LETTERS, 5))
#
custom_lag <- function(x, k = 1) {

  c(rep_len(NA, k), x[seq_len(length(x) - k)])

}
