
<!-- README.md is generated from README.Rmd. Please edit that file -->

# asymptor <img src="man/figures/logo.gif" align="right" alt="" width="120" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version-ago/asymptor)](https://CRAN.R-project.org/package=asymptor)
[![R build
status](https://github.com/Bisaloo/asymptor/workflows/R-CMD-check/badge.svg)](https://github.com/Bisaloo/asymptor/actions)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
[![Codecov test
coverage](https://codecov.io/gh/Bisaloo/asymptor/branch/main/graph/badge.svg)](https://app.codecov.io/gh/Bisaloo/asymptor?branch=main)
<!-- badges: end -->

The asymptor R package allows you to estimate the lower and upper bound
of asymptomatic cases in an epidemic using the capture/recapture methods
from [Böhning et al. (2020)](https://doi.org/10.1016/j.ijid.2020.06.009)
and [Rocchetti et
al. (2020)](https://doi.org/10.1101/2020.07.14.20153445).

**Please note there is currently some discussion about the validity of
the methods implemented in this package. You should read carefully the
original articles, alongside this answer from [Li et al.
(2022)](https://doi.org/10.48550/arXiv.2209.11334) before using this
package in your project.**

## Installation

You can install the stable version of this package from CRAN:

``` r
install.packages("asymptor")
```

or the development version from [GitHub](https://github.com/bisaloo),
via my [r-universe](https://bisaloo.r-universe.dev/):

``` r
install.packages("asymptor", repos = "https://bisaloo.r-universe.dev")
```

## Example

Let’s start by loading some example data from the COVID-19 epidemic in
Italy:

``` r
d <- readRDS(system.file("extdata", "covid19_italy.rds", package = "asymptor"))
head(d)
#>         date new_cases new_deaths
#> 1 2020-01-02         0          0
#> 2 2020-01-03         0          0
#> 3 2020-01-04         0          0
#> 4 2020-01-05         0          0
#> 5 2020-01-06         0          0
#> 6 2020-01-07         0          0
```

We can estimate the lower and upper bound of asymptomatic cases with:

``` r
library(asymptor)
estimate_asympto(d$date, d$new_cases, d$new_deaths)
```

Or, with a tidyverse-compatible syntax:

``` r
library(dplyr)
d %>%
  mutate(asympto_cases = estimate_asympto(date, new_cases, new_deaths))
```

Please refer to the
[vignette](https://hugogruson.fr/asymptor/articles/example.html) for a
detailed example using the COVID-19 data from Italy.

![example_figure](https://hugogruson.fr/asymptor/articles/example_files/figure-html/example_fig-1.png)
