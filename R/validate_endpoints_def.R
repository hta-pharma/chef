#' Validate user inputs to endpoint definition
#'
#' @param endpoint_base Endpoint definition data.table
#'
#' @return Run for side effects. If there is a validation error it stops the
#'   program, otherwise the function returns a 'TRUE'
#' @export
#'
validate_endpoints_def <- function(endpoint_base) {
  col_name <- col_class <- class_nested <- NULL # To satisfy R CMD check
  checkmate::assertDataTable(endpoint_base)


  # Check that all columns exist
  col_names <- c(
    "study_metadata",
    "pop_var",
    "pop_value",
    "treatment_var",
    "treatment_refval",
    "period_var",
    "period_value",
    "endpoint_filter",
    "group_by",
    "stratify_by",
    "endpoint_label",
    "data_prepare",
    "stat_by_strata_by_trt",
    "stat_by_strata_across_trt",
    "stat_across_strata_across_trt",
    "crit_endpoint",
    "crit_by_strata_by_trt",
    "crit_by_strata_across_trt",
    "only_strata_with_events"
  )

  missing_cols <- setdiff(col_names, names(endpoint_base))
  if (length(missing_cols) > 0) {
    stop(
      paste0(
        "The endpoint definition is missing the following column(s):\n-",
        paste0(cli::style_bold(missing_cols), collapse = "\n-"),
        ". \n\n Please check you endpoint_definition function"
      ),
      call. = FALSE
    )

  }

  validate_period_specification  <-
    function(period_var, period_value) {
      arg_list <- list(period_var = period_var, period_value = period_value)
      if (!anyNA(arg_list)) {
        return(invisible(TRUE))
      }
      if (all(is.na(arg_list))){
        return(invisible(TRUE))
      }


  missing_arg <-
    arg_list[vapply(arg_list, is.na, logical(1L))] |> names()
  non_missing_arg <-
    arg_list[!vapply(arg_list, is.na, logical(1L))] |> names()
  stop(
    "`",non_missing_arg,"`",
    " is supplied in the endpoint specification, but ",
    "`",missing_arg,"`",
    " is not. Either both need to be provided (non-`NA` values), or both need to be empty",
    call. = FALSE

  )
}

  validate_period_specification(endpoint_base$period_var, endpoint_base$period_value)

  col_class_expected <- build_expected_col_classes()
  col_class_actual <- build_actual_col_classes(endpoint_base)

  missmatch <-
    col_class_actual[!col_class_expected, on = .(col_name, col_class)]


  if (nrow(missmatch) > 0) {
    stop(
      paste0(
        "The following columns in the endpoint definition data.table have the incorrect class:\n-",
        paste0(cli::style_bold(
          missmatch$col_name), collapse = "\n-"),
        ". \n\n Please check the endpoint_definition function"
      )
    )
  }
  col_class_expected[grepl("data_prepare|stat_by_strata_by_trt|analysis_stats", col_name), class_nested :=
                       "function"]
  check_fn_calls(col_class_expected, endpoint_base)


  return(TRUE)
}

build_expected_col_classes <- function() {
  col_class_expected_vec <- c(
    study_metadata = "list",
    pop_var = "character",
    pop_value = "character",
    treatment_var = "character",
    treatment_refval = "character",
    period_var = "character",
    period_value = "character",
    custom_pop_filter="character",
    endpoint_filter = "character",
    group_by = "list",
    group_by = "character",
    stratify_by = "list",
    endpoint_label = "character",
    data_prepare = "list",
    stat_by_strata_by_trt = "list",
    stat_by_strata_across_trt = "list",
    stat_across_strata_across_trt = "list",
    crit_endpoint = "list",
    crit_by_strata_by_trt = "list",
    crit_by_strata_across_trt = "list",
    only_strata_with_events = "logical"
  )
  data.table::data.table(col_name = names(col_class_expected_vec),
                         col_class = col_class_expected_vec)
}

build_actual_col_classes <- function(endpoint_base) {
  col_class_actual <-
    data.table(
      col_name = names(endpoint_base),
      col_class = purrr::map_chr(endpoint_base, class)
    )
}

check_fn_calls <- function(col_class_expected, ep_def) {
  class_nested <- NULL # To satisfy R CMD check
  fn_inx <- col_class_expected[class_nested == "function"]
  lapply(fn_inx$col_name, function(i)
    lapply(ep_def[[i]], error_not_fn, i))
}

error_not_fn <- function(x, i) {
  if(is.null(x)|| is.null(x[[1]]))return(message("No functions provided for: ", i))
  if (!is.call(x)) {
    stop(
      "The argument to ",
      i,
      ": ",
      x,
      " is not a function. This needs to be an unquoted function object, such that `is.function(object)` evaluates to TRUE"
    )
  }
}
