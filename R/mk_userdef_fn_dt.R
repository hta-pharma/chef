#' Parse functions supplied by user
#'
#' This function takes a `data.table` containing user-supplied function
#' definitions and parses them into a structured format. The input `data.table`
#' is expected to have specific columns that include the function type, the
#' function itself, the name of the function, and a unique hash for the
#' function. The output is a list of `data.table` objects, where each
#' `data.table` corresponds to a unique function type and contains detailed
#' information about each function, including a character representation and the
#' callable function itself.
#'
#' @param x A `data.table` object representing the endpoint definition data
#'   model, which should contain the following columns:
#'    * fn_type: Character vector specifying the type of function.
#'    * fn: List of callables (length 1) representing the function to be called.
#'    * fn_name: Character vector with the name of the function.
#'    * fn_hash: Character vector with a unique hash for each function.
#' @param env The environment from which to evaluate the functions. The default
#'   is the parent frame from which the function is called.
#'
#' @return A `data.table` with each row containing a parsed function definition. The columns include:
#'   * fn_type: Character vector with the type of function.
#'   * fn_hash: Character vector with the unique hash of the function.
#'   * fn_name: Character vector with the name of the function.
#'   * fn_call_char: Character vector with the function call as a string.
#'   * fn_callable: List of callables representing the parsed function.
#'
#' @export
#'
mk_userdef_fn_dt <- function(x, env = parent.frame()) {
  # Take only the unique rows based on the hash.
  unique_hash_table <- unique(x, by = "fn_hash")

  # Run the function over all rows
  functions_table <- unique_hash_table[,
    generate_function_table_row(fn_type, fn, fn_name, fn_hash, env),
    by = seq_len(nrow(unique_hash_table))
  ]

  # Validate functions by their expected inputs.
  functions_table[,
    validate_usr_fn_args(fn = fn_callable[[1]], fn_type = fn_type, fn_name = fn_name),
    by = seq_len(nrow(functions_table))
  ]

  # Drop the column used for the running.

  return(functions_table[, !"seq_len"])
}


#' Generate a row for the function table
#'
#' This helper function is used within `mk_userdef_fn_dt` to process each unique
#' function definition in the input `data.table` and create a new row with the
#' parsed function information. It handles null functions by creating empty
#' entries and for non-null functions creates a character representation
#' and a callable function.
#'
#' @param fn_type The type of the function as a character string.
#' @param fn A list containing the function to be called.
#' @param fn_name The name of the function as a character string.
#' @param fn_hash The unique hash of the function as a character string.
#' @param env The environment in which to evaluate the function.
#'
#' @return A `data.table` row with the function's details.
generate_function_table_row <- function(fn_type, fn, fn_name, fn_hash, env) {
  if (is.null(fn[[1]])) {
    out_row <- data.table::data.table(
      fn_type = as.character(fn_type),
      fn_hash = fn_hash,
      fn_name = fn_name,
      fn_call_char = "",
      fn_callable = list(NULL)
    )
    return(out_row)
  }
  out_row <- data.table::data.table(
    fn_type = as.character(fn_type),
    fn_hash = fn_hash,
    fn_name = fn_name,
    fn_call_char = as.character(fn),
    fn_callable = parse_function_input(eval(fn[[1]], envir = env))
  )

  return(out_row)
}
