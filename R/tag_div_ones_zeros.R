#' A `taglist` containing warning message regarding all 1s and 0s for responses
#'
#' @description
#' This `taglist` provides a warning message to inform the user that a measure or data visualizations can't be produced because only 1s and 0s were entered.
#'
#' @param output_name Name of the output (i.e., Cochran's Q, Area Q)
#'
#' @return A
#'
#' @seealso [util_check_for_ones_zeros] for generating the input data frame that defines the prompt hierarchy.
#'
#' @export


tag_div_ones_zeros <- function(output_name = "This measure") {

  tag_to_return <-  div(class="text-warning-emphasis",
                        p(icon("circle-exclamation"), paste0(output_name, " is not meaningful.")),
                        p('The responses you provided were idential (either all 1s or 0s).'),
                        p("Please provide a dataset with more variation.")
  )

  return(tag_to_return)

}
