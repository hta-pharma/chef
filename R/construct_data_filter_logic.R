construct_data_filter_logic <-
  function(var_value_pairs = NULL,
           singletons = NULL) {
    pairs <- NULL
    singletons_collapsed <- NULL
    if (!is.null(var_value_pairs)) {
      if (!is.list(var_value_pairs)) {
        stop("`var_value_pairs` must be a list, with each element of length 2")
      }

      if (!all(sapply(var_value_pairs, length) == 2)) {
        stop("Not all elements of `var_value_pairs are of length 2")
      }

      # If a filter is not fully specified, ignore it in the filter
      var_value_pairs <-
        var_value_pairs[!vapply(var_value_pairs, anyNA, FUN.VALUE = logical(1L))]

      # Quote second elements
      var_value_pairs <- lapply(var_value_pairs, function(x) {
        x[2] <- paste0('"', x[2], '"') # Add " around the second element
        return(x)
      })

      pairs <- sapply(var_value_pairs, paste0, collapse = "==")
      pairs <- paste0(pairs, collapse = " & ")
    }
    if (!is.null(singletons)) {
      singletons_no_na <- singletons[!sapply(singletons, is_null_or_na)]
      if (length(singletons_no_na) > 0) {
        singletons_collapsed <- paste0(singletons_no_na, collapse = " & ")
      }
    }
    paste0(c(pairs, singletons_collapsed), collapse = " & ")
  }
is_null_or_na <- function(x) {
  is.null(x) || is.na(x)
}
