#' A custom numeric input for the language assessment app
#'
#' @description
#' This function is used in `tag_table_response_inputs` to produce a matrix-like data entry input.
#'
#'
#' @param input_id An id.
#' @param value A numeric value.
#' @param align_center A `TRUE` or `FALSE` to indicate whether the alignment should be centered.
#' @param placeholder A `str` value for the placeholder.
#' @export


tag_custom_input <- function (input_id, value = 0, align_center = TRUE, placeholder = "Enter value")
{

  if (align_center) {
    text_align <- "text-center"
    margin_x <- "mx-auto"
  } else {
    text_align <- ""
    margin_x <- ""
  }

  input_tag <- tags$input(
    id = input_id,
    value = value,
    type = "text",
    placeholder = placeholder,
    class = paste0("form-control form-control-sm border border-0 ", text_align))
  shiny::div(class = paste0("form-group shiny-input-container mb-0 ", margin_x),
             style = "max-width: 100px;",
             input_tag)
}
