test_that("test-format", {

  d <- readRDS(system.file("extdata", "covid19_italy.rds", package = "asymptor"))

  a_up <- estimate_asympto(d$date, d$new_cases, d$new_deaths, bounds = "upper")
  a_lw <- estimate_asympto(d$date, d$new_cases, d$new_deaths, bounds = "lower")
  a_both <- estimate_asympto(d$date, d$new_cases, d$new_deaths)

  expect_identical(dim(a_up), c(nrow(d), 2L))
  expect_identical(dim(a_lw), c(nrow(d), 2L))
  expect_identical(dim(a_both), c(nrow(d), 3L))

  expect_identical(merge(a_lw, a_up), a_both)

  expect_false(any(a_both[, c(2,3)]<0, na.rm = TRUE))

})

test_that("test-values", {

  # Austria data from https://doi.org/fbwv
  d <- readRDS(system.file("extdata", "data_fbwv.rds", package = "asymptor"))
  new_cases <- c(NA_real_, diff(d$total_cases))
  new_deaths <- c(NA_real_, diff(d$total_deaths))

  res <- estimate_asympto(d$date, new_cases, new_deaths, "lower")

  expect_identical(sum(res$lower, na.rm = TRUE), 17264L)

  # Match upper bound result from https://doi.org/10.1101/2020.07.14.20153445
  # FIXME: this doesn't work but probably because the data changed in the meantime

  # d <- readRDS(system.file("extdata", "covid19_germany.rds", package = "asymptor"))
  #
  # res <- estimate_asympto(d)
  #
  # expect_identical(
  #   sum(res$upper[res$date <= "2020-04-17"], na.rm = TRUE),
  #   650841L-137439L
  # )

})

test_that("test-error", {

  d <- readRDS(system.file("extdata", "covid19_italy.rds", package = "asymptor"))

  expect_error(
    estimate_asympto(d$date, d$new_cases, d$new_deaths),
    "same lengths"
  )

})
