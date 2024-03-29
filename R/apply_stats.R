#' Apply Statistical Methods
#'
#' @description Applies user-supplied statistical functions to the prepared
#'   endpoint data. The results are stored in a `data.table` that is nested in
#'   the row of the endpoint definition object.
#'
#' @param ep A `data.table` containing prepared endpoint data for statistical
#'   analysis, typically the output from `prepare_for_stats`.
#' @param analysis_data_container data.table containing the analysis data.
#'   functions.
#' @param type The type of statistical function. Can be one of
#'   "stat_by_strata_by_trt", "stat_by_strata_across_trt", or "stat_across_strata_across_trt"
#'
#' @return A `data.table` with statistical results appended.
#' @export
apply_stats <-
  function(ep,
           analysis_data_container,
           type = c("stat_by_strata_by_trt",
                    "stat_by_strata_across_trt",
                    "stat_across_strata_across_trt")) {
    key_analysis_data <-
      crit_accept_by_strata_by_trt <-
      stat_result <-
      fn_callable <-
      dat <-
      treatment_var <-
      stat_metadata <-
      stat_metadata <-
      event_index <-
      cell_index <-
      fn_name <-
      stat_result_id <-
      crit_accept_by_strata_across_trt <-
      stratify_by <-
      treatment_refval <- NULL # To satisfy R CMD check
    checkmate::assert_data_table(ep)
    # If no functions are given by the user, no results table needs to be
    # produced
    nm <- names(ep)
    if (length(nm) <= 3 &&
      nm[1] == "SKIP_") {
      return(data.table(NULL))
    }
    type <- match.arg(type)
    setkey(ep, key_analysis_data)

    ep_cp <- ep[analysis_data_container]

    if (type == "stat_by_strata_by_trt") {
      if (nrow(ep_cp[crit_accept_by_strata_by_trt == TRUE]) == 0) {
        ep_cp[, stat_result := list()]
      } else {
        ep_cp[crit_accept_by_strata_by_trt == TRUE, stat_result := llist(
          try_and_validate(
            expr_ = fn_callable[[1]](
              dat = copy(dat[[1]]),
              treatment_var = treatment_var,
              treatment_value = stat_metadata[[1]][[treatment_var[[1]]]],
              stratify_by = unlist(stratify_by),
              strata_var = strata_var,
              strata_value = stat_metadata[[1]][[strata_var[[1]]]],
              event_index = unlist(event_index),
              cell_index = unlist(cell_index),
              subjectid_var = "USUBJID"
            ),
            validator = validate_stat_output,
            expr_name = fn_name
          )
        ), by = stat_result_id]
      }
    } else if (type == "stat_by_strata_across_trt") {
      if (nrow(ep_cp[crit_accept_by_strata_across_trt == TRUE]) == 0) {
        ep_cp[, stat_result := list()]
      } else {
        ep_cp[crit_accept_by_strata_across_trt == TRUE, stat_result := llist(
          try_and_validate(
            expr_ = fn_callable[[1]](
              dat = copy(dat[[1]]),
              treatment_var = treatment_var,
              treatment_refval = treatment_refval,
              strata_var = strata_var,
              strata_value = stat_metadata[[1]][[strata_var[[1]]]],
              event_index = unlist(event_index),
              cell_index = unlist(cell_index),
              subjectid_var = "USUBJID"
            ),
            validator = validate_stat_output,
            expr_name = fn_name
          )
        ), by = stat_result_id]
      }
    } else if (type == "stat_across_strata_across_trt") {
      if (nrow(ep_cp[crit_accept_by_strata_across_trt == TRUE]) == 0) {
        ep_cp[, stat_result := list()]
      } else {
        ep_cp[crit_accept_by_strata_across_trt == TRUE, stat_result := llist(
          expr_ = try_and_validate(
            fn_callable[[1]](
              dat = copy(dat[[1]]),
              treatment_var = treatment_var,
              treatment_refval = treatment_refval,
              strata_var = strata_var,
              event_index = unlist(event_index),
              subjectid_var = "USUBJID"
            ),
            validator = validate_stat_output,
            expr_name = fn_name
          )
        ), by = stat_result_id]
      }
    }

    keep <- setdiff(names(ep_cp), c("fn_callable", "dat", "tar_group"))
    ep_cp[, .SD, .SDcols = keep]
  }
