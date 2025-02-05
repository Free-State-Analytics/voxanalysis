#' @rdname mod_starting_page
#' @importFrom shinyjs hidden show hide
#' @export
#'
mod_starting_page_server <- function(id) {
  moduleServer(id, function(input, output, session) {

    observeEvent(input$button_restart, {
      shinyjs::refresh()
    })

    output$icon_choice <- renderUI({
      if (input$chosen_path == 1) {
        return(
          span(style = "font-size: 70px",
               icon("keyboard"))
        )
      }
      if (input$chosen_path == 2) {
        return(
          span(style = "font-size: 70px",
               icon("file-csv"))
        )
      }
      if (input$chosen_path == 3) {
        return(
          span(class = "pt-3",
               style = "font-size: 60px",
               icon("file-csv"),
               icon("keyboard"))
        )
      }
    })

    observeEvent(input$begin, {

      util_shiny_remove_and_hide_flex("div_select_a_path")

      if (input$chosen_path == 1) {
        shinyjs::show("div_speaker_data_entry",
                      anim = TRUE,
                      animType = "fade")
        mod_speaker_data_entry_server(
          "speaker_data_entry")
      }

      if (input$chosen_path == 2) {
        shinyjs::show("div_upload_data_no_new_entries",
                      anim = TRUE,
                      animType = "fade")
        mod_upload_data_set_server(
          "upload_data_no_new_entries",
          ind_add_new_data = FALSE
        )
      }

      if (input$chosen_path == 3) {
        shinyjs::show("div_upload_data_with_new_entries",
                      anim = TRUE,
                      animType = "fade")
        mod_upload_data_set_server(
          "upload_data_with_new_entries",
          ind_add_new_data = TRUE)
      }


    })

    observeEvent(input$button_contact, {
      showModal(modalDialog(
        div(
          h4("Contact Us"),
          p("Email us at ", a("admin@shapersatwork.com", href = "mailto:admin@shapersatwork.com")),
          actionButton(NS(id, "close_email"), "Close", class = "btn btn-primary")
        ),
        easyClose = TRUE,
        footer = NULL
      ))
    })

    observeEvent(input$close_email, {
      removeModal()
    })

    observeEvent(input$button_report_bug, {
      shinyjs::runjs("window.open('https://github.com/Free-State-Analytics/voxanalysis/issues/new?template=blank-issue.md', '_blank');")
    })


  })
}
