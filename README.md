
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `voxanalysis`

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

This README has been compiled on 2024-10-28 12:40:26.

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> ℹ Loading voxanalysis
#> ── R CMD check results ───────────────────────────── voxanalysis 0.0.0.9000 ────
#> Duration: 1m 18.5s
#> 
#> ❯ checking examples ... ERROR
#>   Running examples in ‘voxanalysis-Ex.R’ failed
#>   The error most likely occurred in:
#>   
#>   > base::assign(".ptime", proc.time(), pos = "CheckExEnv")
#>   > ### Name: calc_centroid
#>   > ### Title: Calculate the centroid, centroidal distance, and area Q
#>   > ### Aliases: calc_centroid
#>   > 
#>   > ### ** Examples
#>   > 
#>   > data("df_input_response_example")
#>   > calc_centroid(df_input_response_example)
#>   Error in calc_centroid(df_input_response_example) : 
#>     could not find function "calc_centroid"
#>   Execution halted
#> 
#> ❯ checking for missing documentation entries ... WARNING
#>   Undocumented code objects:
#>     ‘df_summarized_response_example’
#>   Undocumented data sets:
#>     ‘df_summarized_response_example’
#>   All user-level objects in a package should have documentation entries.
#>   See chapter ‘Writing R documentation files’ in the ‘Writing R
#>   Extensions’ manual.
#> 
#> ❯ checking Rd \usage sections ... WARNING
#>   Undocumented arguments in documentation object 'mod_response_entry'
#>     ‘df_input_response_previous’
#>   
#>   Undocumented arguments in documentation object 'mod_results_section_area_q'
#>     ‘v_primary_date’
#>   
#>   Undocumented arguments in documentation object 'mod_results_section_detailed_analysis'
#>     ‘df_input_response’
#>   
#>   Undocumented arguments in documentation object 'mod_upload_data_set'
#>     ‘add_new_data_ind’
#>   
#>   Undocumented arguments in documentation object 'plot_area_q'
#>     ‘v_primary_date’ ‘doc_version_ind’
#>   
#>   Undocumented arguments in documentation object 'plot_vox_line'
#>     ‘doc_version_ind’
#>   
#>   Undocumented arguments in documentation object 'plot_vox_piechart'
#>     ‘doc_version_ind’
#>   
#>   Undocumented arguments in documentation object 'run_example'
#>     ‘add_new_data_ind’
#>   
#>   Undocumented arguments in documentation object 'tag_custom_input'
#>     ‘align_center’ ‘placeholder’
#>   
#>   Undocumented arguments in documentation object 'tag_table_prompt_hierarchy'
#>     ‘table_prompt_hierarchy’
#>   
#>   Undocumented arguments in documentation object 'util_generate_word_doc_report'
#>     ‘file_name’ ‘temp_file’
#>   
#>   Functions with \usage entries need to have the appropriate \alias
#>   entries, and all their arguments documented.
#>   The \usage entries must correspond to syntactically valid R code.
#>   See chapter ‘Writing R documentation files’ in the ‘Writing R
#>   Extensions’ manual.
#> 
#> ❯ checking for unstated dependencies in examples ... WARNING
#>   Warning: parse error in file 'lines':
#>   1: unexpected '}'
#>   400: run_example_upload_data_set_app <- function(add_new_data_ind = TRUE)
#>   401: }
#>        ^
#> 
#> ❯ checking top-level files ... NOTE
#>   Non-standard file/directory found at top level:
#>     ‘temp_report_2024-10-24.docx’
#> 
#> ❯ checking R code for possible problems ... NOTE
#>   mod_speaker_data_entry_server : <anonymous>: no visible binding for
#>     global variable ‘value’
#>   mod_speaker_data_entry_server : <anonymous>: no visible binding for
#>     global variable ‘name’
#>   mod_speaker_data_info_server : <anonymous>: no visible binding for
#>     global variable ‘value’
#>   mod_upload_data_set_server : <anonymous>: no visible global function
#>     definition for ‘read.csv’
#>   mod_upload_data_set_server : <anonymous>: no visible binding for global
#>     variable ‘date_of_evaluation’
#>   mod_upload_data_set_server : <anonymous>: no visible binding for global
#>     variable ‘date_of_birth’
#>   table_prompt_hierarchy: no visible binding for global variable ‘.’
#>   tag_custom_file_upload: no visible global function definition for
#>     ‘toJSON’
#>   Undefined global functions or variables:
#>     . date_of_birth date_of_evaluation name read.csv toJSON value
#>   Consider adding
#>     importFrom("utils", "read.csv")
#>   to your NAMESPACE file.
#> 
#> ❯ checking Rd line widths ... NOTE
#>   Rd file 'plot_area_q.Rd':
#>     \examples lines wider than 100 characters:
#>        plot_area_q(df_summarized_response = df_summarized_response_example[1:2,], v_primary_date = "2024-08-23")
#>   
#>   These lines will be truncated in the PDF manual.
#> 
#> 1 error ✖ | 3 warnings ✖ | 3 notes ✖
#> Error: R CMD check found ERRORs
```

``` r
covr::package_coverage()
#> Error in loadNamespace(x): there is no package called 'covr'
```
