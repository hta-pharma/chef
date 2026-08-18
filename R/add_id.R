#' Add ID to user-defined endpoint groups
#'
#' Adds a sequential identifier (`endpoint_spec_id`) to each row of an endpoint
#' definition table. These IDs track endpoint specifications through the analysis
#' pipeline and enable mapping of results back to original endpoint definitions.
#'
#' @param ep A `data.table` containing endpoint definitions.
#'
#' @return data.table with an additional `endpoint_spec_id` column containing
#'   sequential integers starting from 1.
#'
#' @export
#'
#' @examples
#' library(data.table)
#'
#' # Typical endpoint definition table from chef workflows
#' endpoints <- data.table(
#'   endpoint_label = c("Primary Efficacy", "Safety", "Tolerability"),
#'   analysis_type = c("efficacy", "adverse_event", "adverse_event"),
#'   custom_pop_filter = c("AGE >= 18", "SAFFL=='Y'", "SAFFL=='Y'")
#' )
#'
#' # Add sequential IDs for tracking through analysis pipeline
#' endpoints_with_ids <- add_id(endpoints)
#'
#' endpoints_with_ids
#'
#' # The endpoint_spec_id column now uniquely identifies each endpoint
#' # and can be used to map statistical results back to endpoint definitions
add_id <- function(ep){
  endpoint_spec_id <- NULL
  x <- copy(ep)
  x[, endpoint_spec_id := .I]
  x[]
}
