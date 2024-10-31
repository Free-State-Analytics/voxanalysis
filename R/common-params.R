#' Common parameters
#'
#' @description
#' Common parameters found throughout the language assessment package.
#'
#' @param id The namespace id.
#' @param df_input_response A `data.frame` containing the referent names and their response. Run `data("df_input_response_example")` or `data("df_input_response_previous_example")` for example.
#' @param df_summarized_response A `data.frame` that sums each verbal operant column (i.e., conversing, echoing, etc.) for a given evaluation date. See `util_summarize_response` for how to produce.
#' @param df_input_response_previous A `data.frame` similar to `df_summarized_response`. It is used to distinguish past evaluations that were uploaded by the end user.
#' @param df_input_speaker_info A `data.frame` that contains general info about a speaker, provided by the user. Run `data("df_input_speaker_info")` to produce an example.
#' @param date_primary A single entry `vector` containing a date. This field helps a function or module where multiple evaluation dates are present. The date chosen as primary will determine which will be calculated or highlighted in the function.
#' @param ind_doc_version `TRUE` or `FALSE` value to indicate whether a plot needs to be rendered for a Word doc. Passing `TRUE` will change various font sizes and other aesthetic parameters of the plot to make it more Word-friendly.
#' @param ind_add_new_data `TRUE` or `FALSE` value to indicate whether a user workflow should include `mod_speaker_data_entry`. In other words, `TRUE` will be passed by the user behavior, because they indicated that they wanted to hand-type new data entries.
#' @name common-params
#'
NULL
