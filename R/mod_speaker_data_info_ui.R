#' @rdname mod_speaker_data_info
#' @importFrom shinyjs show hide hidden
#' @import gt
#' @export

mod_speaker_data_info_ui <- function(id) {

  tagList(
    div(class = "card bg-body-tertiary text-secondary-emphasis",
        div(class = "card-body",
            div(class = "d-flex justify-content-between",
                h5("Speaker Info"),
                div(
                  actionButton(NS(id,"button_modify"), "Modify", class = "btn-sm btn-outline-secondary")
                )

            ),
            div(id = NS(id, "div_speaker_info"),
                gt_output(NS(id, "speaker_info")),
            ),
            shinyjs::hidden(
              div(id = NS(id, "div_speaker_entry"),
                  tag_speaker_input_form(id),
                  actionButton(NS(id,"button_save"), "Save", class = "btn-secondary")
              )
            )
        )
    )
  )

}
