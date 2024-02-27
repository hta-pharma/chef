#' Make list of lists
#'
#' @param ... Elements to be included in the nested list
#' @return A list object containing a list where each element is defined by
#'   `...`
#' @importFrom  magrittr %>%
#' @import targets
#' @export
llist <- function(...) {
  list(list(...))
}

str_to_sentence_base <- function(x){
  paste0(toupper(substring(x, 1, 1)), substring(x, 2))
}
