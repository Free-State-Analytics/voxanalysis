#' Custom HTML Table for Response Data Entry
#'
#' @description
#' This function generates a custom HTML table with editable fields, allowing users to enter responses directly into the table. It uses `tag_custom_input` along with various HTML tags and CSS classes to create a seamless data entry experience. Data entered in the table is accessible on the server side via the `input` object, enabling real-time data capture within a Shiny session.
#'
#' @param ns_prefix The namespace prefix. Pass `session$ns(id)` to ensure that user inputs are accessible in the same module via `input`.
#' @param row_count The number of rows to include in the table.
#'
#' @seealso [tag_table_response_report] for a static, read-only version of the response table.
#' @return An HTML table with custom input fields for each cell, styled for data entry in Shiny applications.
#'
#' @export

tag_table_response_input <- function(ns_prefix, row_count) {

  req(ns_prefix)

  body_creation <- lapply(1:row_count, function(i) {

    num <- ifelse(str_length(i) == 1, paste0("0",i), i)

    tags$tr(class = "tr matrix-input border",
            tags$td(class = "td ps-3",
                    tag_custom_input(
                      paste0(ns_prefix, "referent_input", num),
                      value = "",
                      placeholder = "Enter name",
                      align_center = FALSE)),
            tags$td(tag_custom_input(paste0(ns_prefix, "conversing_input", num), value = "")),
            tags$td(tag_custom_input(paste0(ns_prefix, "labeling_input", num), value = "")),
            tags$td(tag_custom_input(paste0(ns_prefix, "echoing_input", num), value = "")),
            tags$td(tag_custom_input(paste0(ns_prefix, "requesting_input", num), value = ""))
    )
  })

  tags$table(class = "table border",
             tags$thead(class = "table-input",
               tags$tr(class = "table-input border bg-primary",
                 tags$th(scope="col", class = "ps-3 text-white", "Referent Name"),
                 tags$th(scope="col", class = "text-center text-white", "Conversing"),
                 tags$th(scope="col", class = "text-center text-white", "Labeling"),
                 tags$th(scope="col", class = "text-center text-white", "Echoing"),
                 tags$th(scope="col", class = "text-center text-white", "Requesting"))
             ),
             tags$tbody(class = "tbody matrix-input", body_creation)
  )


}
