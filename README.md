
<!-- README.md is generated from README.Rmd. Please edit that file -->

# VOX Analysis

*NOTE: THIS PACKAGE IS IN DEVELOPMENT. MANY KEY FUNCTIONS HAVE NOT BEEN
QUALITY TESTED YET. PACKAGE WEBSITE AND DOCUMENTATION MAY BE
INCOMPLETE.*

`voxanalysis` is an R package and R Shiny application for autism
spectrum diagnosis. It provides a user-interface that allows for user
inputs following the VOX Analysis evaluation process defined here. Its
data visualization functions are also available for analysts to use for
custom requirements.

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Installation

You can install the development version of `{voxanalysis}` like so:

``` r
# If devtools is not installed, first install it
install.packages("devtools")

# Install PackageName from GitHub
devtools::install_github("Free-State-Analytics/voxanalysis")
```

## Run

You can launch the application by running:

``` r
voxanalysis::run_app()
```

## About

You are reading the doc about version : 0.0.0.9000.

This README has been compiled on 2024-11-04 12:52:09.

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> ℹ Loading voxanalysis
#> ── R CMD check results ───────────────────────────── voxanalysis 0.0.0.9000 ────
#> Duration: 1m 21.8s
#> 
#> 0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```

``` r
covr::package_coverage()
#> Error in loadNamespace(x): there is no package called 'covr'
```
