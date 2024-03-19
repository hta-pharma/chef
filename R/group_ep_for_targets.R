#' Group endpoints for targets pipeline
#'
#' @param ep A data.table containing the endpoint specification
#' @param n_per_group Number of endpoints per group.
#'
#' @return A data.table containing the endpoint specification with grouping
#' column.
#' @export
#'
group_ep_for_targets <- function(ep, n_per_group){
  targets_group <- NULL # To satisfy R CMD check
  x <- copy(ep)
  n_rows <- nrow(x)
  x[, targets_group :=(.I-1) %/% n_per_group]
  x[]
}
