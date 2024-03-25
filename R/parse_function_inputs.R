#' Parse function inputs
#'
#' This function processes a list representing a function input. If the function
#' is supplied with an argument, the argument should be specified in the form
#' `list(c(fun, arg=x))`. The function returns the input function unchanged if
#' no arguments are provided or wraps the function with its arguments using
#' `purrr::partial` if arguments are present.
#'
#' @param fn_input A list representing the function input, which may contain a
#'   function and its arguments.
#'
#' @return A function with arguments wrapped using `purrr::partial` if arguments
#'   are provided; otherwise, returns the function unchanged.
#'
#' @export

parse_function_input <- function(fn_input) {
  # returns functions with arguments wrapped in partial
  # Should include checks to ensure function and args are valid

  if (length(fn_input) == 1) {
    if (is.list(fn_input)) {
      fn_input <- fn_input[[1]]
    }
    if (!is.function(fn_input)) {
      stop("`", fn_input, "` is not a valid function")
    }
    # check it is a function
    return(fn_input)
  } else {
    # Check that arguments are valid.
    # ...

    return(purrr::partial(fn_input[[1]], !!!fn_input[-1]))
  }
}
