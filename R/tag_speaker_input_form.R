#' Generate Namespaced Speaker Input Form
#'
#' This function creates a tag list of input fields with namespaced IDs.
#' The IDs are dynamically generated based on a provided namespace prefix, allowing these inputs to be used within a Shiny module or application with a consistent naming structure.
#'
#' @param ns_prefix A character string representing the namespace prefix to be applied to each input field's ID.
#'
#' @return A tagList containing multiple Shiny input elements with namespaced IDs, including:
#' \itemize{
#' \item first_name: A required text input for the speaker's first name.
#' \item last_name: A required text input for the speaker's last name.
#' \item date_of_birth: A required date input for the speaker's date of birth.
#' \item date_of_evaluation: A required date input for the speaker's date of evaluation.
#' \item language_spoken: An optional text input for the speaker's language spoken.
#' \item gender: An optional text input for the speaker's gender.
#' }
#'
#' Each required field is indicated with an asterisk, as noted in the form text.
#'
#'
#' @export

tag_speaker_input_form <- function(ns_prefix, ind_evaluation_date = TRUE) {

  if (ind_evaluation_date) {
    tags_to_return <- tagList(
      textInput(paste0(ns_prefix, "-first_name"), "First Name *"),
      textInput(paste0(ns_prefix, "-last_name"), "Last Name *"),
      dateInput(paste0(ns_prefix, "-date_of_birth"), "Date of Birth *"),
      dateInput(paste0(ns_prefix, "-date_of_evaluation"), "Date of Evaluation *"),
      textInput(paste0(ns_prefix, "-language_spoken"), "Language Spoken", placeholder = "(Optional)"),
      textInput(paste0(ns_prefix, "-gender"), "Gender", placeholder = "(Optional)"),
      p(class = "text-secondary", "* indicates required field to continue")
    )
  } else {
    tags_to_return <- tagList(
      textInput(paste0(ns_prefix, "-first_name"), "First Name *"),
      textInput(paste0(ns_prefix, "-last_name"), "Last Name *"),
      dateInput(paste0(ns_prefix, "-date_of_birth"), "Date of Birth *"),
      shinyjs::hidden(dateInput(paste0(ns_prefix, "-date_of_evaluation"), "Date of Evaluation *")),
      textInput(paste0(ns_prefix, "-language_spoken"), "Language Spoken", placeholder = "(Optional)"),
      textInput(paste0(ns_prefix, "-gender"), "Gender", placeholder = "(Optional)"),
      p(class = "text-secondary", "* indicates required field to continue")
    )
  }

  return(tags_to_return)

}
