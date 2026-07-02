#' Make list of lists
#'
#' Creates a nested list structure where the input elements are wrapped in
#' an outer list. This is useful for organizing function specifications in
#' analysis pipelines, particularly when using the targets framework.
#'
#' @param ... Elements to be included in the nested list
#' @return A list object containing a list where each element is defined by
#'   `...`
#' @import targets
#' @export
#' @examples
#' # Create a nested list structure for endpoint statistics configurations
#' # Common use case: grouping multiple statistical functions by analysis level
#' stats_config <- llist(
#'   n_subjects = function(dat, ...) {
#'     data.table::data.table(
#'       label = "N",
#'       description = "Number of subjects",
#'       qualifiers = NA_character_,
#'       value = nrow(dat),
#'       method = NA_character_
#'     )
#'   },
#'   mean_value = function(dat, var, ...) {
#'     data.table::data.table(
#'       label = "Mean",
#'       description = paste("Mean of", var),
#'       qualifiers = NA_character_,
#'       value = mean(dat[[var]], na.rm = TRUE),
#'       method = NA_character_
#'     )
#'   }
#' )
#'
#' # The structure enables targets to handle multiple analysis functions
#' str(stats_config)
llist <- function(...) {
  list(list(...))
}

str_to_sentence_base <- function(x) {
  paste0(toupper(substring(x, 1, 1)), substring(x, 2))
}
