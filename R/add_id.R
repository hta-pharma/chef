#' Add ID to user-defined endpoint groups
#'
#' @param ep A `data.table` containing endpoint definitions.
#'
#' @return data.table
#' @export
add_id <- function(ep){
  endpoint_spec_id <- NULL
  x <- copy(ep)
  x[, endpoint_spec_id := .I]
  x[]
}
