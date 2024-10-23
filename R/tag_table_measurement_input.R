#' A custom html table to allow the user to type in response
#'
#' @description
#' This function generate an html table, which uses various tags and classes, as well as `tag_custom_input`, to allow for data entry.
#'
#' Data that is collected during the session will be made available to on the server-side via `input`.
#'
#' @param ns_prefix The namespace. Pass `session$ns(id)` to make the user inputs available in the session via `input`. This will ensure that the inputs are accessible in the same module.
#' @param row_count The number of rows to include


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
               tags$tr(class = "table-input border bg-primary-subtle",
                 tags$th(scope="col", class = "ps-3 text-body", "Referent Name"),
                 tags$th(scope="col", class = "text-center text-body", "Conversing"),
                 tags$th(scope="col", class = "text-center text-body", "Labeling"),
                 tags$th(scope="col", class = "text-center text-body", "Echoing"),
                 tags$th(scope="col", class = "text-center text-body", "Requesting"))
             ),
             tags$tbody(class = "tbody matrix-input", body_creation)
  )


}
