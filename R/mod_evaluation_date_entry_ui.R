#' @rdname mod_evaluation_date_entry
#' @importFrom shinyjs show hide hidden
#' @export

mod_evaluation_date_entry_ui <- function(id) {
  tagList(
    div(id = NS(id, "div_date_entry"),
      class = "container d-flex align-items-center h-100",
      style = "width: 550px;",
      div(class = "card card-border pb-3 mt-3",
          style = "width: 450px;",
          div(class = "card-body  px-4",
              h4("Provide Current Evaluation Date"),
              dateInput(NS(id, "date_of_evaluation"), label = "When did the new evaluation occur?"),
              shinyjs::hidden(
                div(id = NS(id, "same_date_message"),
                    class="text-info-emphasis",
                    p(icon("circle-exclamation"), "Note: Your previous data upload already includes this evaluation date."),
                    p('By clicking "Continue," the VOX Analysis will append your new records to the previous analysis'),
                    p("If this analysis is for a new evaluaton, please change the evaluation date above or within your uploaded data set.")
                )
              ),
              actionButton(NS(id, "button_continue"), label = "Continue", class = "btn-primary")
          )
      )
    ),
    shinyjs::hidden(
      div(id = NS(id, "div_upload_to_data_entry"),
          class = "h-100",
          mod_response_entry_ui(NS(id, "upload_to_data_entry"))
      )
    )
  )
}
