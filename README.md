
<!-- README.md is generated from README.Rmd. Please edit that file -->

# asymptor <img src="man/figures/logo.gif" align="right" alt="" width="120" />

<!-- badges: start -->

[![R build
status](https://github.com/Bisaloo/asymptor/workflows/R-CMD-check/badge.svg)](https://github.com/Bisaloo/asymptor/actions)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Codecov test
coverage](https://codecov.io/gh/Bisaloo/asymptor/branch/main/graph/badge.svg)](https://codecov.io/gh/Bisaloo/asymptor?branch=main)
<!-- badges: end -->

The asymptor R package allows you to estimate the lower and upper bound
of asymptomatic cases in an epidemic using the capture/recapture methods
from Böhning et al.
([10.1016/j.ijid.2020.06.009](https://doi.org/10.1016/j.ijid.2020.06.009))
and Rocchetti et al.
([10.1101/2020.07.14.20153445](https://doi.org/10.1101/2020.07.14.20153445)).

## Installation

You can install the development version of asymptor from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("Bisaloo/asymptor")
```

## Example

Please see the
[vignette](https://bisaloo.github.io/asymptor/articles/example.html) for
a detailed example using the COVID-19 data from New York.

![example\_figure](https://bisaloo.github.io/asymptor/articles/example_files/figure-html/example_fig-1.png)
