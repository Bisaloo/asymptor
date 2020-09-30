test_that("estimate_asympto", {

  d <- readRDS(system.file("extdata", "covid19_italy.rds", package = "asymptor"))

  a_up <- estimate_asympto(d, bounds = "upper")
  a_lw <- estimate_asympto(d, bounds = "lower")
  a_both <- estimate_asympto(d)

  expect_identical(dim(a_up), c(nrow(d), 2L))
  expect_identical(dim(a_lw), c(nrow(d), 2L))
  expect_identical(dim(a_both), c(nrow(d), 3L))

  expect_identical(merge(a_lw, a_up), a_both)

  expect_false(any(a_both[, c(2,3)]<0, na.rm = TRUE))

  d_nc <- d[, c("date", "new_cases", "new_deaths")]

  expect_error(
    estimate_asympto(d_nc),
    "recoveries"
  )

  expect_identical(
    estimate_asympto(d_nc, bounds = "lower"),
    a_lw
  )
})
