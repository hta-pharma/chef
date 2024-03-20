eval_data_fn <- function(fn_list, ...) {
  out <- lapply(fn_list, function(fn_) {
    x <- tryCatch(
      {
        fn_(...) # apply the function i
      },
      error = function(e) {
        return(e)
      }
    )

    if (inherits(x, "simpleError") || inherits(x, "error")) {
      return(list(
        result = NULL,
        error_flag = TRUE,
        error_message = conditionMessage(x)
      ))
    }

    x[, "TOTAL_" := "total"]
    x[, "INDEX_" := .I]
    setkey(x, "INDEX_")

    return(list(
      result = x,
      error_flag = FALSE,
      error_message = NULL
    ))
  })

  purrr::transpose(out)
}

#' Evaluate Endpoint Criteria
#'
#' @description Evaluates the specified criteria function for an
#'   endpoint to determine if it meets the criteria.
#'
#' @param fn The criteria function to evaluate.
#' @param ... Additional parameters passed to the criteria function.
#'
#' @return A logical value indicating whether the endpoint meets the criteria.
#' @noRd
eval_criteria_endpoint <- function(fn, ...) {
  dots <- list(...)
  result <- fn(
    dat = dots$dat,
    event_index = dots$event_index,
    treatment_var = dots$treatment_var,
    treatment_refval = dots$treatment_refval,
    period_var = dots$period_var,
    period_value = dots$period_value,
    endpoint_filter = dots$endpoint_filter,
    endpoint_group_metadata = dots$endpoint_group_metadata,
    stratify_by = dots$stratify_by,
    subjectid_var = dots$subjectid_var
  )

  if (!(isTRUE(result) |
    isFALSE(result))) {
    stop(
      "The return value from the endpoint criterion function must be a logical of length 1, i.e.",
      "TRUE or FALSE"
    )
  }
  result
}

#' Evaluate by strata criteria
#'
#' @description Evaluates the specified criterion function for a
#'   strata to determine if it meets the criterion.
#'
#' @param fn The criteria function to evaluate.
#' @param ... Additional parameters passed to the criteria function.
#'
#' @return A logical value indicating whether the strata meets the criteria.
#' @noRd
eval_criteria_subgroup <- function(fn, ...) {
  dots <- list(...)

  result <- fn(
    dat = dots$dat,
    event_index = dots$event_index,
    treatment_var = dots$treatment_var,
    treatment_refval = dots$treatment_refval,
    period_var = dots$period_var,
    period_value = dots$period_value,
    endpoint_filter = dots$endpoint_filter,
    endpoint_group_metadata = dots$endpoint_group_metadata,
    strata_var = dots$strata_var,
    subjectid_var = dots$subjectid_var
  )
  if (!(isTRUE(result) |
    isFALSE(result))) {
    stop(
      "The return value from the endpoint criterion function must be a logical of length 1, i.e.",
      "TRUE or FALSE"
    )
  }
  result
}

reshape_results_by_subgroup_level <- function(x) {
  melt(
    as.data.table(x),
    measure.vars = names(x),
    variable.factor = FALSE,
    variable.name = "value_qualifier"
  )
}
