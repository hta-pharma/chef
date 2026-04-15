#' Evaluate criteria for inclusion of endpoints or endpoint strata
#'
#' @param endpoints A data table with endpoint definitions.
#' @param adam_set A list of pre-processed ADaM tables.
#' @param criteria_type A string specifying the type of criteria. This can either
#' be "endpoint", "subgroup_description" or "subgroup_analysis", which apply
#' criteria on whether to include the endpoint, or by/across treatment and strata
#'  in the final submission.
#'
#' @return A data table with endpoint definitions enriched with indications of
#' whether to keep the endpoint/strata or not.
#' @export
#'
#' @examples
#' \dontrun{
#' library(data.table)
#' library(pharmaverseadam)
#'
#' # Define endpoints
#' endpoints <- data.table(
#'   endpoint_spec_id = 1:2,
#'   endpoint_label = c("Safety Events", "Efficacy Events"),
#'   crit_endpoint = list(NULL, NULL),
#'   key_analysis_data = "a"
#' )
#'
#' # Prepare ADAM data in list format
#' adam_set <- list(
#'   adcm = as.data.table(pharmaverseadam::adcm),
#'   adae = as.data.table(pharmaverseadam::adae)
#' )
#'
#' # evaluate_criteria is designed to run within a {targets} pipeline where
#' # criterion_wrapper is provided by the pipeline environment
#' result <- evaluate_criteria(
#'   endpoints = endpoints,
#'   adam_set = adam_set,
#'   criteria_type = "endpoint"
#' )
#' result[, .(endpoint_label, keep_endpoint)]
#' }
evaluate_criteria <-
  function(endpoints,
           adam_set,
           criteria_type = c("endpoint", "subgroup_description", "subgroup_analysis")) {
    checkmate::assertDataTable(endpoints)
    criterion_wrapper <- NULL # To satisfy R CMD check

    endpoints_out <- data.table::copy(endpoints)

    # Apply row-wise operations over the endpoint data to enrich data with an
    # evaluation of criteria and an updated log
    endpoints_out[, c(paste0("keep_", criteria_type), "log") := criterion_wrapper(.SD, adam_set, criteria_type),
                  by = seq_len(nrow(endpoints_out))]

    return(endpoints_out[])
  }
