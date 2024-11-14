#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    useShinyjs(),
    # Leave this function for adding external resources
    golem_add_external_resources(),
    page(
      mod_starting_page_ui("voxanalysis")
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "voxanalysis"
    ),
    tags$link(
      href = "https://fonts.googleapis.com/css2?family=Quicksand:wght@300..700&family=Source+Sans+3:ital,wght@0,200..900;1,200..900&display=swap",
      rel = "stylesheet"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
