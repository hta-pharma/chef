#' Unnest over user-supplied functions in endpoint definitions
#'
#' This function processes a `data.table` containing endpoint definitions by
#' unnesting the function calls in specified columns. It is tailored for
#' endpoint definition specific data structure, where endpoint definitions
#' include user-supplied functions. After unnesting, it removes any rows where
#' the function is NULL (indicating an empty function) and computes a hash for
#' each function call for identification purposes.
#'
#' @param endpoint_defs A `data.table` containing endpoint definitions with
#'   nested function calls in the columns defined by the `fn_cols` argument.
#' @param fn_cols A character vector with default names of the columns that
#'   contain the function calls. These columns are expected to be in the
#'   `endpoint_defs` data.table.
#' @param env The environment from which to evaluate the functions. The default
#'   is the parent frame from which the function is called.
#'
#' @return A `data.table` with each function call represented as a separate row,
#'   including a unique hash for each function call.
#'
#' @export
#'
unnest_endpoint_functions <- function(endpoint_defs,
                                      fn_cols = c(
                                        "data_prepare",
                                        "stat_by_strata_by_trt",
                                        "stat_by_strata_across_trt",
                                        "stat_across_strata_across_trt",
                                        "crit_endpoint",
                                        "crit_by_strata_by_trt",
                                        "crit_by_strata_across_trt"
                                      ),
                                      env = parent.frame()) {
  endpoints_long <- unnest_by_fns(endpoint_defs, fn_cols)

  # Remove any empty functions (occurs when user does not provide a function)
  endpoints_long <-
    endpoints_long[!sapply(endpoints_long$fn, is.null)]

  endpoints_long[, fn_hash := hasher(fn, fn_type, fn_name, env), by = seq_len(nrow(endpoints_long))]
  keep <-
    c("endpoint_spec_id", "fn_hash", "fn_type", "fn_name", "fn")
  endpoints_long[, .SD, .SDcols = keep]
}

hasher <- function(fn, fn_type, fn_name, env) {
  if (inherits(fn, "name")) {
    return(digest::digest(list(fn_name, fn_type, eval(fn, envir = env))))
  }

  digest::digest(list(fn_name, fn_type, eval(fn[[1]], envir = env)))
}
