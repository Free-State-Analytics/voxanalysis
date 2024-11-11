
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

# VOX Analysis Application & Package

*NOTE: THIS PACKAGE IS IN DEVELOPMENT. USE AT YOUR OWN DISCRETION*

The `{voxanalysis}` package provides a framework for diagnosing autism
spectrum disorder It contains both the VOX Analysis Application (see
below) and individual functions for measurements and data
visualizations.

<figure>
<img src="https://placehold.co/600x400" alt="Placeholder Image" />
<figcaption aria-hidden="true">Placeholder Image</figcaption>
</figure>

## Background

The `{voxanalysis}` package is meant to provide easily generated reports
and analysis using the VOX Analysis framework.

It was developed by Dr. Lee Mason and Dr. Alonzo Andrews, two
researchers in verbal behavior and founders of Shapers at Work, a
consulting firm that teaches behavioral specialists about autism
diagnosis.

People with autism tend to have more variation with respect to language
development.

For example, they may be good at requesting something, but not at
responding to a question. A person without autism will have a balanced
set of language skills, which means their ability to request something
is nearly the same as their ability to respond to a question.

VOX Analysis involves an in-person evaluation (i.e., play therapy),
where the listener (e.g., a behavioral analyst or clinician) elicits a
response from the speaker (i.e., the patient). (Read more on this
process here.)

Once the listener has recorded the responses, they can use the
`{voxanalysis}` package to run a generate data visualizations and
measures of variance.

## Installation

A user can install `{voxanalysis}` with:

``` r
# If devtools is not installed, first install it
install.packages("devtools")

# Install PackageName from GitHub
devtools::install_github("Free-State-Analytics/voxanalysis")
```

## Running Reports

The easiest way to generate a report is through the VOX Analysis
Application.

This Shiny application can run with:

``` r
voxanalysis::run_app()
```

A user with R programming experience can generate a MS Word version of
the report too.

Read [How to Generate
Reports](https://free-state-analytics.github.io/voxanalysis/articles/generatingreports.html)
to learn more about report generation.

## Individual Calculations and Data Visualizations

Users with more R programming experience can use individual components
from the VOX Analysis Application. All data visualizations and measures
are including in the `{voxanalysis}` package.

Read [VOX Visualizations and
Metrics](https://free-state-analytics.github.io/voxanalysis/articles/datavizandcharts.html)
to learn more about these functions.

A user with R programming experience can generate individual data
visualizations and a MS Word version of the report too.

## About the Team

The `{voxanalysis}` package was developed by Lee Mason, Alonzo Andrews,
and Taylor Rodgers.

### Dr. Lee Mason

*Coming soon*

### Dr. Alonzo Andrews

*Coming soon*

### Taylor Rodgers

*Coming soon*

## Services Offered

*Coming soon*
