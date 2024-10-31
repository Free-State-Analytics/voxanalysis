#' Prompt Hierachy Table
#'
#' @description
#' Produces a data.frame with the prompt hierarchy
#'
#' @inherit common-params
#' @import dplyr
#' @import tidyr
#' @import stringr
#'
#' @examples
#' data("df_summarized_response_example")
#'  ## Table only works with one date at a time
#' dat <- df_summarized_response_example %>%
#'     filter(date_of_evaluation == max(date_of_evaluation))
#' table_prompt_hierarchy(df_summarized_response = dat)
#'
#' @export

table_prompt_hierarchy <- function(df_summarized_response) {

  if (length(unique(df_summarized_response$date_of_evaluation)) != 1) {
    stop("The df_summarized_response input should only have one row of data for this function.")
  }

  initial_data <- df_summarized_response %>%
    transmute(Conversing = .data$conversing,
                     Labeling = .data$labeling,
                     Echoing = .data$echoing,
                     Requesting = .data$requesting) %>%
    pivot_longer(everything()) %>%
    mutate(
      perc = round(.data$value / sum(.data$value), 3),
      initials = str_trunc(.data$name, 1, "right", ellipsis = "")
    )

  hierarchy <- data.frame(Conversing = c("CELR", "CEL", "CER", "CLR", "CE", "CL", "CR", "C"),
                          Labeling = c("LERC", "LER", "LRC", "LEC", "LE", "LR", "LC", "L"),
                          Echoing = c("ELRC", "ELR", "ERC", "ELC", "EL", "ER", "EC", "E"),
                          Requesting = c("RELC", "REL", "RLC", "REC", "RE", "RL", "RC", "R")
  )

  hierarchy_filter <- colnames(hierarchy)
  data_to_return <- merge(hierarchy[hierarchy_filter[1]], initial_data)
  to_match <- data_to_return[,hierarchy_filter[1]]
  data_to_return <- data_to_return %>%
    mutate(matcher = str_detect(to_match, .data$initials)) %>%
    filter(.data$matcher == TRUE) %>%
    group_by(across(all_of(hierarchy_filter[1]))) %>%
    summarize(Perc = sum(.data$perc)) %>%
    select("Perc", "Conversing")

  for (i in 2:4) {

    additional_data <- merge(hierarchy[hierarchy_filter[i]], initial_data)
    to_match <- additional_data[,hierarchy_filter[i]]
    additional_data <- additional_data %>%
      mutate(matcher = str_detect(to_match, .data$initials)) %>%
      filter(.data$matcher == TRUE) %>%
      group_by(across(all_of(hierarchy_filter[i]))) %>%
      summarize(Perc = sum(.data$perc)) %>%
      select("Perc", matches(hierarchy_filter[i]))

    data_to_return <- data_to_return %>%
      full_join(additional_data, relationship = "many-to-many", by = join_by("Perc"))

  }

  data_to_return <- data_to_return %>%
    mutate(
      Percent = round(.data$Perc*100, 1),
      Labeling = replace_na(.data$Labeling, "-"),
      Echoing = replace_na(.data$Echoing, "-"),
      Requesting = replace_na(.data$Requesting, "-"),
      Conversing = replace_na(.data$Conversing, "-")) %>%
    select("Percent", "Conversing", "Labeling", "Echoing", "Requesting") %>%
    arrange(desc(.data$Percent))

  missing_initials <- initial_data %>%
    filter(.data$value == 0)

  if (nrow(missing_initials) > 0) {

    for (m in 1:nrow(missing_initials)) {

      cols_to_filter <- colnames(data_to_return)[colnames(data_to_return) !=  missing_initials$name[m] & colnames(data_to_return) != "Percent"]
      cols_to_filter

      for (n in 1:length(cols_to_filter)) {
        matcher <- data_to_return %>%
          select("Percent", cols_to_filter[n]) %>%
          as.data.frame()
        to_match <- data_to_return[,2]
          mutate(matcher = str_detect(to_match, missing_initials$initials[m])) %>%
            pull(matcher)

        data_to_return <- data_to_return[!matcher,]
      }

    }

  }

  return(data_to_return)


}
