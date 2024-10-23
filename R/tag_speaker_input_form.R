
tag_speaker_input_form <- function(ns_prefix) {

  tagList(
    textInput(paste0(ns_prefix, "-first_name"), "First Name *"),
    textInput(paste0(ns_prefix, "-last_name"), "Last Name *"),
    dateInput(paste0(ns_prefix, "-date_of_birth"), "Date of Birth *"),
    dateInput(paste0(ns_prefix, "-date_of_evaluation"), "Date of Evaluation *"),
    textInput(paste0(ns_prefix, "-language_spoken"), "Language Spoken", placeholder = "(Optional)"),
    textInput(paste0(ns_prefix, "-gender"), "Gender", placeholder = "(Optional)"),
    p(class = "text-secondary", "* indicates required field to continue")
  )

}
