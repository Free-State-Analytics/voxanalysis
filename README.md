
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

<br>

## VOX Analysis Application & Package

The `{voxanalysis}` package enables behavioral specialists to generate
detailed reports and analyses using the VOX Analysis framework, which
was designed to assess language development in individuals with autism.

<div style="display: flex; align-items: center;">

<div style="flex: 1; padding-right: 10px;">

<br>

<p>

#### Austism and VOX Analysis

Autism spectrum disorder often presents unique language development
patterns. For instance, an individual with autism may excel at
requesting an object but struggle with responding to questions.

In contrast, people without autism typically exhibit balanced language
skills, where abilities like requesting and responding are more evenly
developed.

VOX Analysis leverages in-person evaluations (e.g., play therapy) to
measure these variations in development. During evaluations, a clinician
(the “listener”) elicits verbal responses from the individual (the
“speaker”).

By documenting these interactions, clinicians can use `{voxanalysis}` to
produce comprehensive reports, complete with data visualizations and
variance measures, that offer insights into the speaker’s language
skills and patterns.

</p>

</div>

<div style="flex: 1; text-align: center;">

<img src="man/figures/main_app.gif" alt="Main App GIF" style="max-width: 100%; height: auto;">

</div>

</div>

Developed by Dr. Lee Mason and Dr. Alonzo Andrews, co-founders of
Shapers at Work, `{voxanalysis}` is rooted in their expertise in verbal
behavior and autism diagnosis. Shapers at Work is a consulting firm
dedicated to training specialists in behavioral analysis and autism
assessment.

(Read more on the VOX Analysis process
[here](https://www.verbalbehavior.org/vox).)

<br> <br>

## Installation

A user can install `{voxanalysis}` with:

``` r
devtools::install_github("Free-State-Analytics/voxanalysis", ref = "dev")
```

<br> <br>

## Running Reports

The easiest way to generate a report is by using the VOX Analysis
Application, a Shiny app included with {voxanalysis}.

To launch the application, run:

``` r
voxanalysis::run_app()
```

For users familiar with R, `{voxanalysis}` also supports generating a
report in MS Word format.

``` r
# Load example data for report generation
data("df_input_speaker_info_example")
data("df_input_response_example")

# Generate a Word document report
util_generate_word_doc_report(
  df_input_speaker_info = df_input_speaker_info_example,
  df_input_response = df_input_response_example,
  file_name = "text.docx"
)
```

To learn more about report generation, refer to the [How to Generate
Reports](https://free-state-analytics.github.io/voxanalysis/articles/generatingreports.html)
guide.

<br> <br>

## Data Visualizations and Individual Metrics

Advanced R users can use the individual functions within `{voxanalysis}`
for data visualizations and calculations. These components are designed
to allow flexible analysis beyond the main VOX Analysis Application.

For example, a line chart that tracks language skill balance over verbal
episodes can be generated with:

``` r
library(voxanalysis)

# Load example data
data("df_input_response_example")

# Generate a VOX line chart across verbal episodes
plot_vox_line(
  df_input_response = df_input_response_example,
  ind_hide_heading = FALSE
  )
```

<br>

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

<br>

For more details on available visualization and metric functions, see
[VOX Visualizations and
Metrics](https://free-state-analytics.github.io/voxanalysis/articles/datavizandcharts.html).

<br> <br>

## About the Team

The `{voxanalysis}` package was developed by Lee Mason, Alonzo Andrews,
and Taylor Rodgers. It was a partnership between their respective
companies, Shapers at Work and Free State Analytics.

#### Dr. Lee Mason - VOX Analysis Researcher

Dr. Mason is a behavioral specialist in verbal behavior and co-founder
of Shapers at Work. \[Bio coming soon\]

#### Dr. Alonzo Andrews - VOX Analysis Researcher

Dr. Andrews served as the director of the Autism Treatment Center in San
Antonio for 24 years, where he led the delivery of behavioral services
for individuals with autism spectrum disorders. His work included
developing residential programs for children and adults, operating a
state-certified private school, and providing outpatient rehabilitation
therapies. Currently, he provides behavioral consultation for a school
district in San Antonio and has been teaching courses at the University
of Texas at San Antonio since 2013.

Alonzo has co-authored numerous publications in esteemed journals,
including *The Journal of Autism and Developmental Disorders*, The
*Analysis of Verbal Behavior*, and *Behavior Analysis in Practice*. His
clinical interests span a wide range of innovative projects, such as
biomedical interventions, video modeling, remote functional assessments,
autism-friendly architectural design, and challenging behavior
interventions. He has also worked on developing a computer-simulation
training program for caregivers of children with autism, reflecting his
commitment to advancing both research and practical applications in the
field.

#### Taylor Rodgers - Project Manager & Package Developer

Taylor Rodgers is an R Shiny developer and project manager. He is
available for R Shiny consulting and training. Contact
<taylor@taylorrodgers.com>

<br> <br>

## Training and Consulting Services

**VOX Analysis Training**: Behavioral specialists can contact Lee Mason
(<leemason@gmail.com>) for training on using the VOX Analysis framework.

**VOX Analysis Setup & Support**: For assistance with setup or
customization of the VOX Analysis Application, contact Taylor Rodgers
(<taylor@taylorrodgers.com>).

<br> <br> <br> <br>
