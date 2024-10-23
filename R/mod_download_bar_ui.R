#' @rdname mod_download_bar
#' @export

mod_download_bar_ui <- function(id) {
  div(class = "position-fixed bottom-0 start-50 translate-middle-x bg-light-subtle border-top w-100",
      style = "max-height: 75px;",
      div(class = "d-flex justify-content-center",
          downloadButton(NS(id, "results_download"), label = "Download Report", class = "btn btn-link text-reset"),
          downloadButton(NS(id, "results_save_data"), label = "Save Data", class = "btn btn-link text-reset"),
      )
  )
}
