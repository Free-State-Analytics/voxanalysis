#' Custom File Upload Control
#'
#' Create a file upload control that can be used to upload one or more files.
#'
#' This is modified from `shiny::fileInput` to make the format more consistent with the VOX Analysis user-interface.
#'
#' @inheritParams shiny::fileInput
#' @inheritDotParams shiny::fileInput
#'
#' @return A UI element for file upload, similar to `shiny::fileInput`.
#'
#' @examples
#' tag_custom_file_upload("file", "Upload your file")
#'
#' @export


tag_custom_file_upload <- function (inputId, multiple = FALSE, accept = NULL,
                                    buttonLabel = "Browse...", placeholder = "No file selected", ...)
{
  restoredValue <- restoreInput(id = inputId, default = NULL)
  if (!is.null(restoredValue) && !is.data.frame(restoredValue)) {
    warning("Restored value for ", inputId, " has incorrect format.")
    restoredValue <- NULL
  }
  if (!is.null(restoredValue)) {
    restoredValue <- toJSON(restoredValue, strict_atomic = FALSE)
  }
  inputTag <- tags$input(id = inputId, name = inputId, type = "file",
                         style = "position: absolute !important; top: -99999px !important; left: -99999px !important;",
                         `data-restore` = restoredValue)
  if (multiple)
    inputTag$attribs$multiple <- "multiple"
  if (length(accept) > 0)
    inputTag$attribs$accept <- paste(accept, collapse = ",")
  div(class = "form-group shiny-input-container",
      style = "width: 100%",
      div(class = "input-group",
          tags$label(class = "input-group-btn input-group-prepend",
                     span(class = "btn btn-primary btn-file",
                          buttonLabel,
                          inputTag)
                     ),
          tags$input(type = "text",
                     class = "form-control",
                     placeholder = placeholder,
                     readonly = "readonly")
          ),
      tags$div(id = paste(inputId, "_progress", sep = ""),
               class = "progress active shiny-file-input-progress",
               tags$div(class = "progress-bar")))
}
