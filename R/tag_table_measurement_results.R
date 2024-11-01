#' Custom HTML Table for Reporting Responses
#'
#' @description
#' This function creates a custom HTML table to display response data in a static, non-interactive format. Unlike `tag_table_response_input`, this table is not intended for data entry or modification by the user in a Shiny session. It provides a read-only view, ideal for reporting or summarizing response data within the VOX Analysis application.
#'
#' @inheritParams common-params
#'
#' @seealso [tag_table_response_input] for an interactive version that allows data entry.
#' @return An HTML table for displaying response data in a static format.
#'
#' @export


tag_table_response_results <- function(df_input_response) {

  req(df_input_response)

  row_names <- df_input_response$referent
  body_creation <- lapply(1:length(row_names), function(i) {
    tags$tr(class = "tr matrix-input border" ,
            tags$td(class = "fw-normal ps-3 text-body", row_names[i]),
            tags$td(class = "text-center", style = "opacity: .35", df_input_response[i,"conversing"]),
            tags$td(class = "text-center", style = "opacity: .35", df_input_response[i,"labeling"]),
            tags$td(class = "text-center", style = "opacity: .35", df_input_response[i,"echoing"]),
            tags$td(class = "text-center", style = "opacity: .35", df_input_response[i,"requesting"])
    )
  })

  tag_to_return <- tags$table(
     class = "table border",
     tags$thead(class = "table-input",
       tags$tr(class = "table-input border bg-primary-subtle",
         tags$th(scope="col", class = "ps-3 text-body", "Referent Name"),
         tags$th(scope="col", class = "text-center text-body", "Conversing"),
         tags$th(scope="col", class = "text-center text-body", "Labeling"),
         tags$th(scope="col", class = "text-center text-body", "Echoing"),
         tags$th(scope="col", class = "text-center text-body", "Requesting"))
     ),
     tags$tbody(class = "tbody matrix-input", body_creation)
  )

  return(tag_to_return)

}
