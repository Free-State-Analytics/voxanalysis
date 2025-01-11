#' Custom Numeric Input for Borderless Data Entry
#'
#' @description
#' This function creates a custom numeric input field, similar to `shiny::textInput`, but with a borderless design and no up / down arrows. It is used in `tag_table_response_inputs` to facilitate smooth, minimalistic numeric input in the VOX Analysis language assessment app.
#'
#' @param input_id A unique identifier for the input element.
#' @param value A numeric value to be displayed as the default input.
#' @param align_center Logical. If `TRUE`, centers the input alignment. Defaults to `FALSE`.
#' @param placeholder A character string to display as placeholder text when the input is empty.
#'
#' @return A custom, borderless numeric input UI element without numeric increment arrows.
#'
#' @export

tag_custom_input <- function (input_id, value = 0, align_center = TRUE, placeholder = "Enter 1 or 0")
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
