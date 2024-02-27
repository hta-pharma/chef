#' Validate the user supplied functions arguments.
#'
#' Checks whether the expected function arguments are supplied.
#' Throws a meaningful error in case the expected and supplied arguments are mismatched.
#'
#' @param fn (function) A non-primitive function
#' @param fn_type (character) giving the type of user def function.
#' @param fn_name (character) a custom name to use in error msg: will otherwise derive a name from function symbol.
#'
#' @return NA if function complies or throws an error.
#'
validate_usr_fn_args <- function(fn,
                                 fn_type = c(
                                   "data_prepare",
                                   "stat_by_strata_by_trt",
                                   "stat_by_strata_across_trt",
                                   "stat_across_strata_across_trt",
                                   "crit_endpoint",
                                   "crit_by_strata_by_trt",
                                   "crit_by_strata_across_trt"
                                 ),
                                 fn_name = NA_character_) {
  fn_type <- match.arg(fn_type)

  if (!is.function(fn)) {
    stop(sprintf("fn=(%s) is not a function", deparse(fn)))
  }
  if (is.primitive(fn)) {
    stop(sprintf("fn=(%s) is a primitive and thus have no formals", deparse(fn)))
  }

  if (is.na(fn_name)) {
    fn_name <- deparse(substitute(fn))
  }

  supplied_args <- switch(fn_type,
    data_prepare =
      c("study_metadata"),
    stat_by_strata_by_trt =
      c(
        "dat",
        "event_index",
        "cell_index",
        "stratify_by",
        "strata_var",
        "strata_value",
        "treatment_var",
        "treatment_value",
        "subjectid_var"
      ),
    stat_by_strata_across_trt =
      c(
        "dat",
        "event_index",
        "cell_index",
        "strata_var",
        "strata_value",
        "treatment_var",
        "treatment_refval",
        "subjectid_var"
      ),

    stat_across_strata_across_trt =
      c(
        "dat",
        "event_index",
        "strata_var",
        "treatment_var",
        "treatment_refval",
        "subjectid_var"
      ),
    crit_endpoint =
      c(
        "dat",
        "event_index",
        "subjectid_var",
        "treatment_var",
        "treatment_refval",
        "period_var",
        "period_value",
        "endpoint_filter",
        "endpoint_group_metadata",
        "stratify_by"
      ),
    crit_by_strata_by_trt =
      c(
        "dat",
        "event_index",
        "subjectid_var",
        "treatment_var",
        "treatment_refval",
        "period_var",
        "period_value",
        "endpoint_filter",
        "endpoint_group_metadata",
        "stratify_by",
        "strata_var"
      ),
    crit_by_strata_across_trt =
      c(
        "dat",
        "event_index",
        "subjectid_var",
        "treatment_var",
        "treatment_refval",
        "period_var",
        "period_value",
        "endpoint_filter",
        "endpoint_group_metadata",
        "stratify_by",
        "strata_var"
      ),
    stop("Mismatch")
  )
  supplied_args <- sort(supplied_args)

  args_all <- names(formals(fn))
  args_all_no_dots <- args_all[args_all != "..."]

  non_default_args <- sort(get_non_defaulted_args(fn))
  defaulted_args <- sort(setdiff(args_all, non_default_args))

  if (is.null(non_default_args)) {
    non_default_args <- list()
  }

  if (identical(supplied_args, args_all_no_dots)) {
    return(NA_character_)
  }



  # Supplied arguments:
  #   .....
  # Expected arguments: (required, [optional])
  # dat, missing_arg, [defaulted_arg]

  expected_not_supplied <- setdiff(non_default_args, supplied_args)
  if (length(expected_not_supplied) != 0) {
    stop(
      sprintf(
        "Function (%s) of type (%s) expects argument(s) which is not supplied:\n\t%s",
        fn_name,
        fn_type,
        paste(expected_not_supplied, collapse = ", ")
      ),
      sprintf(
        "\nSupplied arguments:\n\t%s",
        paste(supplied_args, collapse = ", ")
      ),
      sprintf(
        "\nExpected arguments: (required, [optional])\n\t%s [%s]",
        paste(non_default_args, collapse = ", "),
        paste(defaulted_args, collapse = ", ")
      )
    )
  }

  supplied_not_expected <- setdiff(supplied_args, args_all_no_dots)
  if (length(supplied_not_expected) != 0) {
    if ("..." %in% args_all) {
      # Handled via bypassing to dots
      return(NA_character_)
    }
    stop(
      sprintf(
        "Function (%s) of type (%s) is supplied arguments it does not expect:\n\t%s",
        fn_name,
        fn_type,
        paste(supplied_not_expected, collapse = ", ")
      ),
      sprintf(
        "\nSupplied arguments:\n\t%s",
        paste(supplied_args, collapse = ", ")
      ),
      sprintf(
        "\nExpected arguments: (required, [optional])\n\t%s [%s]",
        paste(non_default_args, collapse = ", "),
        paste(defaulted_args, collapse = ", ")
      ),
      sprintf(
        "\nEither state all supplied args explicitely or (recommended) use dots (...) as a passthrough."
      )
    )
  }
}

get_non_defaulted_args <- function(fn) {
  fn <- formals(fn)
  non_defaulted_args <- c()
  for (n in names(fn)) {
    if (identical(n, "...")) {
      next
    }

    if (!nzchar(fn[[n]]) & is.name(fn[[n]])) {
      non_defaulted_args <- c(non_defaulted_args, n)
    }
  }
  return(non_defaulted_args)
}
