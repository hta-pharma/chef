#' Apply Endpoint Criterion
#'
#' @description Applies the user-supplied criteria functions to each endpoint to
#'   determine eligibility based on the criteria. The result is a logical column
#'   added to the data indicating whether each endpoint meets the criteria.
#'
#' @param ep A `data.table` containing expanded endpoint definitions and
#'   associated data, typically the output from `add_event_index`.
#' @param analysis_data_container data.table containing the analysis data.
#' @param fn_map A `data.table` mapping endpoint definitions to criterion
#'   functions.
#'
#' @return A `data.table` with an additional logical column `crit_accept_endpoint`
#'   indicating whether each endpoint meets the defined criteria.
#' @export
#'
#' @examples
#' library(data.table)
#' library(pharmaverseadam)
#'
#' # Create a simple criterion function: keep endpoint if n events >= 5
#' min_events_fn <- function(dat, event_index, ...) {
#'   length(event_index) >= 5
#' }
#'
#' # Prepare endpoint with event index
#' adcm_data <- as.data.table(pharmaverseadam::adcm)
#' adcm_data[, INDEX_ := .I]
#'
#' analysis_data_container <- data.table(
#'   dat = list(adcm_data),
#'   key_analysis_data = "a"
#' )
#' setkey(analysis_data_container, key_analysis_data)
#'
#' ep <- data.table(
#'   endpoint_id = "1-0001",
#'   endpoint_spec_id = 1L,
#'   pop_var = "SAFFL",
#'   pop_value = "Y",
#'   period_var = NA_character_,
#'   period_value = NA_character_,
#'   endpoint_filter = NA_character_,
#'   endpoint_group_filter = NA_character_,
#'   custom_pop_filter = NA_character_,
#'   stratify_by = list(),
#'   treatment_var = "TRT01A",
#'   treatment_refval = "Xanomeline High Dose",
#'   event_index = list(1:20),  # Simulated event indices
#'   key_analysis_data = "a"
#' )
#' setkey(ep, key_analysis_data)
#'
#' # Create function map linking endpoint to criterion
#' fn_map <- data.table(
#'   endpoint_spec_id = 1L,
#'   fn_type = "crit_endpoint",
#'   fn_callable = list(min_events_fn),
#'   fn_name = "min_events"
#' )
#'
#' # Apply endpoint criterion
#' ep_filtered <- apply_criterion_endpoint(ep, analysis_data_container, fn_map)
#'
#' # Result: crit_accept_endpoint = TRUE (20 events >= 5)
#' ep_filtered[, .(endpoint_id, crit_accept_endpoint)]
apply_criterion_endpoint <- function(ep, analysis_data_container, fn_map) {
  fn_type <-
    crit_accept_endpoint <-
    fn_callable <-
    event_index <-
    treatment_var <-
    treatment_refval <-
    period_var <-
    endpoint_filter <-
    endpoint_group_metadata <-
    stratify_by <-
    key_analysis_data <-
    dat <- period_value <- NULL # To satisfy R CMD check

  ep_with_data <- ep[analysis_data_container]
  ep_with_crit <-
    merge(ep_with_data, fn_map[fn_type == "crit_endpoint"], by = "endpoint_spec_id", all.x = TRUE)
  ep_with_crit[, crit_accept_endpoint := TRUE]
  ep_with_crit[!is.na(fn_type), crit_accept_endpoint := eval_criteria_endpoint(
    fn_type,
    fn = fn_callable[[1]],
    dat = dat[[1]],
    event_index = event_index[[1]],
    treatment_var = treatment_var[[1]],
    treatment_refval = treatment_refval[[1]],
    period_var = period_var[[1]],
    period_value = period_value[[1]],
    endpoint_filter = endpoint_filter[[1]],
    endpoint_group_metadata = endpoint_group_metadata[[1]],
    stratify_by = stratify_by[[1]],
    subjectid_var = "USUBJID"
  ), by = endpoint_id]

  keep <-
    setdiff(
      names(ep_with_crit),
      c(
        "fn_type",
        "fn_hash",
        "fn_call_char",
        "fn_callable",
        "fn_name",
        "dat"
      )
    )

  ep_with_crit <- ep_with_crit[, .SD, .SDcols = keep]
  setkey(ep_with_crit, key_analysis_data)
  ep_with_crit[]
}


#' Apply criterion by strata
#'
#' @description Applies by_strata_by_trt and by_strata_across_trt
#'   functions to the endpoints data to determine eligibility for strata
#'   statistics. It adds a logical column to the data indicating
#'   whether each row meet the criteria.
#'
#' @param ep A `data.table` containing endpoint data with applied endpoint
#'   criteria, typically the output from `apply_criterion_endpoint`.
#' @param analysis_data_container data.table containing the analysis data.
#' @param fn_map A `data.table` mapping endpoint definitions to by-strata
#'   criteria functions.
#' @param type The type of criterion to apply, either
#'   "by_strata_by_trt" or "by_strata_across_trt".
#'
#' @return A `data.table` with one row per stratum for each endpoint, with an
#'   additional logical column indicating whether each row meets the criteria.
#' @export
#'
#' @examples
#' library(data.table)
#' library(pharmaverseadam)
#'
#' # Create endpoint with stratification that already passed endpoint criteria
#' ep <- data.table(
#'   endpoint_id = "1-0001",
#'   endpoint_spec_id = 1L,
#'   crit_accept_endpoint = TRUE,
#'   stratify_by = list(c("SEX")),
#'   strata_var = c("M", "F"),  # Two strata plus TOTAL
#'   event_index = list(1:20),
#'   treatment_var = "TRT01A",
#'   treatment_refval = "Xanomeline High Dose",
#'   endpoint_filter = NA_character_,
#'   endpoint_group_filter = NA_character_,
#'   endpoint_group_metadata = list(),
#'   custom_pop_filter = NA_character_,
#'   period_var = NA_character_,
#'   period_value = NA_character_,
#'   key_analysis_data = "a"
#' )
#'
#' # Prepare data container
#' adcm_data <- as.data.table(pharmaverseadam::adcm)
#' adcm_data[, INDEX_ := .I]
#'
#' analysis_data_container <- data.table(
#'   dat = list(adcm_data),
#'   key_analysis_data = "a"
#' )
#' setkey(analysis_data_container, key_analysis_data)
#' setkey(ep, key_analysis_data)
#'
#' # Create strata-level criterion: keep strata if >= 3 subjects
#' min_subgroup_size <- function(dat, event_index, stratify_by, strata_var, ...) {
#'   # This is a simplified example; actual implementation evaluates actual data
#'   length(event_index) >= 3
#' }
#'
#' fn_map <- data.table(
#'   endpoint_spec_id = 1L,
#'   fn_type = "crit_by_strata_by_trt",
#'   fn_callable = list(min_subgroup_size),
#'   fn_name = "min_subgroup_size"
#' )
#'
#' # Apply strata criteria
#' ep_strata <- apply_criterion_by_strata(
#'   ep = ep,
#'   analysis_data_container = analysis_data_container,
#'   fn_map = fn_map,
#'   type = "by_strata_by_trt"
#' )
#'
#' # Result: multiple rows per endpoint (one per stratum)
#' ep_strata[, .(endpoint_id, strata_var, crit_accept_by_strata_by_trt)]
apply_criterion_by_strata <-
  function(ep,
           analysis_data_container,
           fn_map,
           type = c(
             "by_strata_by_trt",
             "by_strata_across_trt"
           )) {
    key_analysis_data <-
      strata_id <-
      fn_type <-
      crit_accept_endpoint <-
      fn_callable <-
      dat <-
      event_index <-
      treatment_var <-
      treatment_refval <-
      period_value <-
      endpoint_filter <-
      endpoint_group_metadata <-
      stratify_by <- period_var <- NULL # To satisfy R CMD check
    type <- match.arg(type)
    ep_ <- copy(ep)
    output_variable_name <- "crit_accept_by_strata_across_trt"
    upstream_criterion_variable <- "crit_accept_by_strata_by_trt"
    if (type == "by_strata_by_trt") {
      output_variable_name <- "crit_accept_by_strata_by_trt"
      upstream_criterion_variable <- "crit_accept_endpoint"
      ep_ <- unnest_ep_by_strata(ep_)
      setkey(ep_, key_analysis_data)
      ep_[, strata_id := add_ep_id(.SD, .BY), by = endpoint_id]
    }
    match_type <- paste0("crit_", type)
    ep_with_data <- ep_[analysis_data_container]
    ep_with_crit <-
      merge(ep_with_data, fn_map[fn_type == match_type], by = "endpoint_spec_id", all.x = TRUE)
    if (nrow(ep_with_data) == 0) {
      stop("No functions matched")
    }

    # Inherit criterion evaluation from upstream criterion
    # The total stratum is always included.
    ep_with_crit[, (output_variable_name) := get(upstream_criterion_variable) | (crit_accept_endpoint & strata_var == "TOTAL_")]
    # Evaluate criterion function for eligible rows (total stratum is always not eligible)

    ep_with_crit[is_eligible_for_crit_eval(fn_type, get(upstream_criterion_variable), strata_var),
      (output_variable_name) := eval_criteria_subgroup(
        fn_type,
        fn = fn_callable[[1]],
        dat = dat[[1]],
        event_index = event_index[[1]],
        treatment_var = treatment_var[[1]],
        treatment_refval = treatment_refval[[1]],
        period_var = period_var[[1]],
        period_value = period_value[[1]],
        endpoint_filter = endpoint_filter[[1]],
        endpoint_group_metadata = endpoint_group_metadata[[1]],
        stratify_by = stratify_by[[1]],
        strata_var = strata_var[[1]],
        subjectid_var = "USUBJID"
      ),
      by = strata_id
    ]

    cols_to_remove <- c(
      "fn_type",
      "fn_hash",
      "fn_call_char",
      "fn_callable",
      "fn_name",
      "dat"
    )

    ep_with_crit[, (cols_to_remove) := NULL]
    setkey(ep_with_crit, key_analysis_data)
    ep_with_crit[]
  }



#' Unnest endpoint specification by stratification level
#'
#' @description Unnests only those endpoints where the endpoint criterion has
#'   been met. Others remain "nested" as they will not be analyzed
#' @param ep data.table containing endpoint specification data model
#'
#' @return data.table object of endpoint specification expanded over relevant
#'   endpoints
#'
#' @noRd
unnest_ep_by_strata <- function(ep) {
  crit_accept_endpoint <-
    strata_var <- stratify_by <- NULL # To satisfy R CMD check
  ep_accepted <- ep[(crit_accept_endpoint)]
  ep_accepted[, strata_var := stratify_by]
  ep_unnested <-
    tidyr::unnest(ep_accepted, col = strata_var) |>
    setDT()
  ep_rejected <-
    ep[!(crit_accept_endpoint)][, strata_var := NA_character_]
  if (nrow(ep_unnested) == 0) {
    return(ep_rejected)
  }
  if (nrow(ep_rejected) == 0) {
    return(ep_unnested)
  }
  return(data.table::rbindlist(list(ep_unnested, ep_rejected)))
}



#' Check Eligibility for Applying Criteria
#'
#' @description This helper function determines if a stratum is eligible for
#'   applying criteria.
#'
#' @param fn_type The type of function being applied.
#' @param upstream_criterion_variable The result of the upstream criterion
#'   check.
#' @param strata The strata being evaluated.
#'
#' @return A logical value indicating eligibility.
#' @noRd
is_eligible_for_crit_eval <- function(fn_type,
                                      upstream_criterion_variable,
                                      strata) {
  !is.na(fn_type) &
    upstream_criterion_variable &
    strata != "TOTAL_"
}
