#' Fetch ADaM tables from a source based on endpoint
#' specifications
#'
#' This function reads the set of ADaM tables required to produce the specified
#' endpoints from the input. It uses the user-supplied preprocessing functions
#' specified for each endpoint to identify and process the necessary ADaM
#' tables. It validates the preprocessing functions and applies them to the
#' study metadata to obtain the data tables. If any preprocessing functions
#' result in errors, the function stops and reports the errors.
#'
#' @param study_metadata Study metadata that is passed to the `mk_adam*` functions.
#' @param fn_dt A `data.table` containing the parsed user-supplied functions.
#' @param env Advanced parameter for specifying the evaluation environment, defaults to `parent.frame()`.
#'
#' @return A list of ADaM tables with additional columns from `fn_dt` including function type, hash, name,
#'         character representation of the call, and the callable itself.
#'
#' @import data.table
#' @export
#'
fetch_db_data <-
  function(study_metadata,
           fn_dt,
           env = parent.frame()) {
    fn_dt[fn_type == "data_prepare", purrr::map2(fn_callable, fn_name, validate_mk_adam_fn)]

    adam <- fn_dt[fn_type == "data_prepare"]
    adam[, c("dat", "error_flag", "error_msg") := eval_data_fn(
                                                          study_metadata = study_metadata,
                                                          fn = fn_callable), by =
           seq_len(nrow(adam))]
    adam[, error_flag  := unlist(error_flag)]
    if (sum(adam$error_flag) > 0)
      throw_error_adam(adam)

    return(adam[, .(fn_type, fn_hash, fn_name, fn_call_char, fn_callable, dat)])
  }


#' Throw an error for ADaM functions that resulted in an error
#'
#' This helper function checks for errors in the ADaM functions' output. If any
#' errors are found, it stops the execution and reports the errors, indicating
#' which functions caused them.
#'
#' @param x A `data.table` with error flags and messages from the ADaM functions.
#'
#' @noRd
throw_error_adam <- function(x) {
  errors <- x[error_flag == TRUE, .(fn_call_char, error_msg)]
  stop(
    "The following functions contained errors. Try running these functions interactively to debug\n",
    paste0(
      cli::style_bold(errors$fn_call_char),
      ": ",
      errors$error_msg,
      collapse = "\n"
    ),
    call. = FALSE
  )
}


#' Validate mk_adam* functions
#'
#' This function checks if the user-supplied ADaM preprocessing functions have
#' the correct formals (arguments). Specifically, it verifies that the
#' `study_metadata` argument is present, as it is required for all `mk_adam*`
#' functions. If a function does not meet this requirement, the function stops
#' and provides an informative error message.
#'
#' @param fn The function to validate.
#' @param fn_nm The name of the function to validate.
#'
#' @noRd
validate_mk_adam_fn <- function(fn, fn_nm) {
  x <- methods::formalArgs(fn)
  if (is.null(x)) {
    stop(
      "'",
      fn_nm,
      "()' has no arguments defined. All mk_adam* functions are required to take study_metadata as an argument. ",
      "Please re-write the function accordingly",
      call. = FALSE
    )
  }
}
