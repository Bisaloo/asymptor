test_that("test-format", {

  d <- readRDS(system.file("extdata", "covid19_italy.rds", package = "asymptor"))

  a_up <- estimate_asympto(d, bounds = "upper")
  a_lw <- estimate_asympto(d, bounds = "lower")
  a_both <- estimate_asympto(d)

  expect_identical(dim(a_up), c(nrow(d), 2L))
  expect_identical(dim(a_lw), c(nrow(d), 2L))
  expect_identical(dim(a_both), c(nrow(d), 3L))

  expect_identical(merge(a_lw, a_up), a_both)

  expect_false(any(a_both[, c(2,3)]<0, na.rm = TRUE))

})

test_that("test-values", {

  # Austria data from https://doi.org/fbwv
  d <- readRDS(system.file("extdata", "data_fbwv.rds", package = "asymptor"))
  d$new_cases <- c(NA_real_, diff(d$total_cases))
  d$new_deaths <- c(NA_real_, diff(d$total_deaths))

  res <- estimate_asympto(d, "lower")

  expect_identical(sum(res$lower, na.rm = TRUE), 17264L)

})
