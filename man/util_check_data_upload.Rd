% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/util_check_data_upload.R
\name{util_check_data_upload}
\alias{util_check_data_upload}
\title{Quality Check for `df_input_response`}
\usage{
util_check_data_upload(df_input_response)
}
\arguments{
\item{df_input_response}{A `data.frame` containing referent names and their associated responses, typically recorded by the listener. For example data, run `data("df_input_response_example")` or `data("df_input_response_previous_example")`.}
}
\value{
A character string, either `"Good"` if the data passes the quality check, or `"Bad"` if it does not.
}
\description{
This function performs a quality check to ensure that `df_input_response` conforms to the expected data model. It is particularly useful for validating data uploaded by users via the `mod_upload_data_set` module, helping maintain data consistency and integrity within the VOX Analysis app.

The function returns either `"Good"` or `"Bad"` to indicate the quality status, providing a clear, unambiguous result.
}
\examples{
# Load example data for quality checking
data("df_input_response_example")

# Perform a quality check on the data
util_check_data_upload(df_input_response = df_input_response_example)


}
