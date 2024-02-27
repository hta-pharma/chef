#' Add ID to user-defined endpoint groups
#'
#' @param ep
#'
#' @return data.table
#' @export
add_id <- function(ep){
  x <- copy(ep)
  x[, endpoint_spec_id := .I]
  x[]
}
