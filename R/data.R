#' Speaker Response Inputs (Example Data)
#'
#' @description
#' This data set provides an example structure for `df_input_response`, a core data frame in the VOX Analysis process used to record speaker responses during language assessments. Each entry is a binary indicator (1 or 0) that denotes whether the speaker responded to a given referent across different verbal operants.
#'
#' @format A data frame with 7 rows and 6 variables:
#' \describe{
#'   \item{date_of_evaluation}{The date on which the evaluation took place.}
#'   \item{referent}{The name of the referent associated with the response, representing the object or entity involved in the verbal episode.}
#'   \item{conversing}{Binary indicator showing if the speaker provided a conversational response to the referent (1 = Yes, 0 = No).}
#'   \item{labeling}{Binary indicator showing if the speaker could label the referent (1 = Yes, 0 = No).}
#'   \item{echoing}{Binary indicator showing if the speaker could repeat the referent's name (1 = Yes, 0 = No).}
#'   \item{requesting}{Binary indicator showing if the speaker could request the referent's name (1 = Yes, 0 = No).}
#' }
#'
#' @usage data(df_input_response_example)
#'
#' @seealso [df_input_response_previous_example] for past evaluation examples.
"df_input_response_example"

#' Previous Response Inputs (Example Data)
#'
#' @description
#' This sample data set is similar to `df_input_response_example` but includes two previous sets of evaluations. It serves as an example for generating plots or analyses that compare current responses with past evaluation dates, offering insights into the speaker's language development over time.
#'
#' Each entry is a binary indicator (1 or 0), representing whether the speaker responded to a specific referent for each verbal operant.
#'
#' @format A data frame with 7 rows and 6 variables:
#' \describe{
#'   \item{date_of_evaluation}{The date on which the evaluation was conducted.}
#'   \item{referent}{The name of the referent associated with the response, representing the object or entity involved in the verbal episode.}
#'   \item{conversing}{Binary indicator showing if the speaker provided a conversational response to the referent (1 = Yes, 0 = No).}
#'   \item{labeling}{Binary indicator showing if the speaker could label the referent (1 = Yes, 0 = No).}
#'   \item{echoing}{Binary indicator showing if the speaker could repeat the referent's name (1 = Yes, 0 = No).}
#'   \item{requesting}{Binary indicator showing if the speaker could request the referent's name (1 = Yes, 0 = No).}
#' }
#'
#' @usage data(df_input_response_previous_example)
#'
#' @seealso [df_input_response_example] for a single evaluation example.
"df_input_response_previous_example"

#' Export Data Structure (Example)
#'
#' @description
#' This data set represents the structure required for exporting evaluation data. Any data re-imported into the application to append new records must follow this format to ensure compatibility and accurate processing.
#'
#' @format A data frame with 11 columns:
#' \describe{
#'   \item{first_name}{The speaker's first name.}
#'   \item{last_name}{The speaker's last name.}
#'   \item{date_of_birth}{The speaker's date of birth.}
#'   \item{language_spoken}{The language spoken by the speaker during the evaluation.}
#'   \item{gender}{The speaker's gender.}
#'   \item{date_of_evaluation}{The date on which the evaluation was conducted.}
#'   \item{referent}{The name of the referent associated with the response, representing the object or entity involved in the verbal episode.}
#'   \item{conversing}{Binary indicator showing if the speaker provided a conversational response to the referent (1 = Yes, 0 = No).}
#'   \item{labeling}{Binary indicator showing if the speaker could label the referent (1 = Yes, 0 = No).}
#'   \item{echoing}{Binary indicator showing if the speaker could repeat the referent's name (1 = Yes, 0 = No).}
#'   \item{requesting}{Binary indicator showing if the speaker could request the referent's name (1 = Yes, 0 = No).}
#' }
#'
#' @usage data(df_output_exportable_example)
#'
#' @seealso See [df_input_response_example] for an example of individual response input data.
"df_output_exportable_example"

#' Speaker Information (Example Data)
#'
#' @description
#' This data set provides an example structure for `df_input_speaker_info`, a required input data frame used across various functions in this package. It contains essential information about the speaker, including personal details and evaluation context.
#'
#' @format A data frame with 1 row and 6 variables:
#' \describe{
#'   \item{first_name}{The speaker's first name.}
#'   \item{last_name}{The speaker's last name.}
#'   \item{date_of_birth}{The date of birth of the speaker.}
#'   \item{date_of_evaluation}{The date on which the evaluation was conducted.}
#'   \item{language_spoken}{The primary language spoken by the speaker during the evaluation.}
#'   \item{gender}{The speaker's gender.}
#' }
#'
#' @usage data(df_input_speaker_info_example)
#'
#' @seealso Other example datasets such as [df_input_response_example] for individual response information.
"df_input_speaker_info_example"

#' Summarized Response Data (Example)
#'
#' @description
#' This data set provides an example of the summarized response data, where the total occurrences of each response type (Conversing, Labeling, Echoing, and Requesting) are calculated for each evaluation date. This summary is often used as an input for plot functions and other analyses to assess patterns in response types over time.
#'
#' The summarized data can be generated using the `util_summarize_response` function. See `?util_summarize_response` for more details.
#'
#' @format A data frame with 3 rows and 5 variables:
#' \describe{
#'   \item{date_of_evaluation}{The date on which the evaluation was conducted.}
#'   \item{conversing}{The total count of positive conversing responses for the given evaluation date.}
#'   \item{labeling}{The total count of positive labeling responses for the given evaluation date.}
#'   \item{echoing}{The total count of positive echoing responses for the given evaluation date.}
#'   \item{requesting}{The total count of positive requesting responses for the given evaluation date.}
#' }
#'
#' @usage data(df_summarized_response_example)
#'
#' @seealso See [util_summarize_response] for generating this summary data frame from raw response inputs.
"df_summarized_response_example"

