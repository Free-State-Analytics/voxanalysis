

tag_help_link <- function(id, page) {
  actionLink(
    id,
    tags$i(class = "fa-solid fa-circle-question text-info"),
    onclick = paste0("window.open('https://free-state-analytics.github.io/voxanalysis/", page, "', '_blank')")
  )
}
