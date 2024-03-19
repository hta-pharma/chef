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
evaluate_criteria <- function(endpoints, adam_set, criteria_type = c("endpoint", "subgroup_description", "subgroup_analysis")) {
  checkmate::assertDataTable(endpoints)

  endpoints_out <- data.table::copy(endpoints)

  # Apply row-wise operations over the endpoint data to enrich data with an
  # evaluation of criteria and an updated log
  endpoints_out[, c(paste0("keep_", criteria_type), "log") := criterion_wrapper(.SD, adam_set, criteria_type),
    by = seq_len(nrow(endpoints_out))
  ]

  return(endpoints_out[])
}
