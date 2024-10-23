#' A custom html table to report prompt hierarchy
#'
#' @description
#' A custom HTML table to report the prompt hierarchy on the results page of the application.
#' @inheritParams common-params

tag_table_prompt_hierarchy <- function(table_prompt_hierarchy) {

  req(table_prompt_hierarchy)

  row_names <- table_prompt_hierarchy$Percent
  body_creation <- lapply(1:length(row_names), function(i) {
    tags$tr(class = "tr matrix-input border" ,
            tags$td(class = "fw-normal ps-3 text-body", row_names[i]),
            tags$td(class = "text-center", table_prompt_hierarchy[i,"Conversing"]),
            tags$td(class = "text-center", table_prompt_hierarchy[i,"Labeling"]),
            tags$td(class = "text-center", table_prompt_hierarchy[i,"Echoing"]),
            tags$td(class = "text-center", table_prompt_hierarchy[i,"Requesting"])
    )
  })

  tag_to_return <- tags$table(
     class = "table border",
     tags$thead(class = "table-input",
       tags$tr(class = "table-input border bg-primary-subtle",
         tags$th(scope="col", class = "ps-3 text-body", "Percent"),
         tags$th(scope="col", class = "text-center text-body", "Conversing"),
         tags$th(scope="col", class = "text-center text-body", "Labeling"),
         tags$th(scope="col", class = "text-center text-body", "Echoing"),
         tags$th(scope="col", class = "text-center text-body", "Requesting"))
     ),
     tags$tbody(class = "tbody matrix-input", body_creation)
  )

  return(tag_to_return)

}
