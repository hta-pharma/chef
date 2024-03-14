#' Make an endpoint specification record
#'
#' @param study_metadata List. Metadata describing the clinical study.
#' @param pop_var Character.
#' @param pop_value Character.
#' @param custom_pop_filter Character.
#' @param treatment_var Character.
#' @param treatment_refval Character.
#' @param period_var Character.
#' @param period_value Character.
#' @param endpoint_filter Character.
#' @param group_by Character.
#' @param stratify_by List.
#' @param endpoint_label Character.
#' @param data_prepare List.
#' @param stat_by_strata_by_trt List.
#' @param stat_by_strata_across_trt List.
#' @param stat_across_strata_across_trt List.
#' @param crit_endpoint List.
#' @param crit_by_strata_by_trt List.
#' @param crit_by_strata_across_trt List.
#' @param only_strata_with_events Boolean.
#' @param env Environment.
#'
#' @return A data.table containing the endpoint specification.
#' @export
#'
mk_endpoint_str <- function(study_metadata = NULL,
                            pop_var = NULL,
                            pop_value = NULL,
                            custom_pop_filter = NA_character_,
                            treatment_var = NULL,
                            treatment_refval = NULL,
                            period_var = NA_character_,
                            period_value = NA_character_,
                            endpoint_filter = NA_character_,
                            group_by = NA_character_,
                            stratify_by = NULL,
                            endpoint_label = NA_character_,
                            data_prepare = NULL,
                            stat_by_strata_by_trt = NULL,
                            stat_by_strata_across_trt = NULL,
                            stat_across_strata_across_trt = NULL,
                            crit_endpoint = NULL,
                            crit_by_strata_by_trt = NULL,
                            crit_by_strata_across_trt = NULL,
                            only_strata_with_events = FALSE,
                            env = parent.frame()) {
  if (!is.function(data_prepare)) {
    stop("Argument 'data_prepare' needs to be an unquoted function name")
  }
  data_prepare  <- substitute(list(data_prepare))

  if (is.function(crit_endpoint)) {
    crit_endpoint <- substitute(list(crit_endpoint))
  } else{
    crit_endpoint <- substitute(crit_endpoint)
  }

  if (is.function(crit_by_strata_across_trt)) {
    crit_by_strata_across_trt <- substitute(list(crit_by_strata_across_trt))
  } else{
    crit_by_strata_across_trt <- substitute(crit_by_strata_across_trt)
  }

  if (is.function(crit_by_strata_by_trt)) {
    crit_by_strata_by_trt <- substitute(list(crit_by_strata_by_trt))
  } else{
    crit_by_strata_by_trt <- substitute(crit_by_strata_by_trt)
  }


  if (is.function(stat_by_strata_by_trt)) {
    stat_by_strata_by_trt <- substitute(list(stat_by_strata_by_trt))
  } else{
    stat_by_strata_by_trt <- substitute(stat_by_strata_by_trt)
  }


  if (is.function(stat_by_strata_across_trt)) {
    stat_by_strata_across_trt <- substitute(list(stat_by_strata_across_trt))
  } else{
    stat_by_strata_across_trt <- substitute(stat_by_strata_across_trt)
  }

  if (is.function(stat_across_strata_across_trt)) {
    stat_across_strata_across_trt <- substitute(list(stat_across_strata_across_trt))
  } else{
    stat_across_strata_across_trt <- substitute(stat_across_strata_across_trt)
  }

  if (!is.na(group_by) && group_by == "") {
    group_by <- NA_character_
  }

  # Add Total as a strata
  stratify_by[[1]] <- c("TOTAL_", stratify_by[[1]])

  x <- data.table::data.table(
    study_metadata = list(study_metadata),
    pop_var = pop_var,
    pop_value = pop_value,
    treatment_var = treatment_var,
    treatment_refval = treatment_refval,
    period_var = period_var,
    period_value = period_value,
    custom_pop_filter=custom_pop_filter,
    endpoint_filter = endpoint_filter,
    group_by = group_by,
    stratify_by = stratify_by,
    endpoint_label = endpoint_label,
    data_prepare = list(substitute(data_prepare)),
    stat_by_strata_by_trt = list(substitute(stat_by_strata_by_trt)),
    stat_by_strata_across_trt = list(substitute(stat_by_strata_across_trt)),
    stat_across_strata_across_trt = list(substitute(stat_across_strata_across_trt)),
    crit_endpoint = list(substitute(crit_endpoint)),
    crit_by_strata_by_trt = list(substitute(crit_by_strata_by_trt)),
    crit_by_strata_across_trt = list(substitute(crit_by_strata_across_trt)),
    only_strata_with_events = only_strata_with_events
  )
  validate_endpoints_def(x)
  x
}
