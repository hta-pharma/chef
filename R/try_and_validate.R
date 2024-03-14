#' Try and Validate Wrapper for Statistical Functions
#'
#' @description Attempts to execute a statistical function and validates its
#'   output. If the function fails or the output is invalid, it provides
#'   meaningful error messages and sets up a debugging environment.
#'
#' @param expr_ The expression of type `call` to be evaluated, typically a call
#'   to a statistical function.
#' @param expr_name The name of the expression, used for debugging purposes.
#' @param debug_dir The directory where debugging information will be stored.
#' @param validator A function used to validate the output of the expression.
#' @param stage_debugging A flag indicating whether to stage debugging
#'   information in case of errors.
#'
#' @return The result of the evaluated expression if successful and valid.
#' @export
try_and_validate <- function(expr_,
                             expr_name = NA_character_,
                             #TODO Allow forwarding of meaning full names.
                             debug_dir = "debug",
                             validator = function(expr_result) {
                               NA_character_
                             },
                             stage_debugging = TRUE) {
  # Capture expression information
  expr_sub = substitute(expr_)
  if (!identical(class(expr_sub), "call")) {
    stop(sprintf(
      "Expr_(%s) must be of class `call`. Found: (%s)",
      expr_sub,
      class(expr_sub)
    ))
  }

  expr_list = as.list(expr_sub) # un evaluated call list
  # Find the function definition in the calling env.
  if (rlang::is_call_simple(expr_sub)) {
    expr_fn <- get(expr_list[[1]], envir = parent.frame())
  } else {
    expr_fn <- eval(expr_list[[1]], envir = parent.frame())
  }

  # Execute expression and evaluate ------------------------------------------


  expr_result <- try(expr = expr_, silent = TRUE)
  if (inherits(expr_result, "try-error")) {
    err_msg <- paste0("Failed to EVALUATE function with error:",
                      "\n ", expr_result[[1]])

  } else if (!is.na(validator_err <-
                    validator(expr_result))) {
    #validate output
    err_msg <-
      paste("Failed to VALIDATE function output with error:",
            validator_err,
            sep = "\n")
  } else {
    # Return valid result
    return(expr_result)
  }

  # Handle errors and stage debugging. --------------------------------------

  # Match arguments with formals if possible
  if (is.primitive(expr_fn)) {
    expr_call_char = deparse(expr_sub)
    expr_arg_list = expr_list[-1]
  } else {
    expr_matched = match.call(definition = expr_fn,
                              call = expr_sub)
    expr_call_char = deparse(expr_matched)
    expr_arg_list <- as.list(expr_matched)[-1]
  }
  # Find a name if unset.
  if (is.na(expr_name)) {
    expr_name <- expr_call_char
  }


  # Prepare error message.
  full_error <-
    paste(sprintf("\nError during evaluation of: %s", expr_name),
          err_msg,
          sep = "\n")

  if (!stage_debugging) {
    stop(full_error)
  }

  debug_file <- stage_debug(
    fn_name = expr_name,
    fn = expr_fn,
    arg_list = lapply(expr_arg_list, eval, envir = parent.frame()),
    err_msg = full_error,
    debug_dir = debug_dir
  )

  full_error <- paste(
    full_error,
    "---",
    sprintf(
      "Debugging session created: Launch with:\n chef::load_debug_session('%s')",
      debug_file
    ),
    "---",
    sep = "\n"
  )
  stop(full_error)

}


#' Stage Debugging Environment
#'
#' @description Prepares a debugging environment by saving the function and
#'   arguments that caused an error. This environment can later be loaded to
#'   debug the function call.
#'
#' @param fn_name The name of the function that caused the error.
#' @param fn The function that caused the error.
#' @param arg_list A list of arguments passed to the function.
#' @param err_msg The error message generated when the function failed.
#' @param debug_dir The directory where the debugging information will be
#'   stored.
#'
#' @return The path to the saved debugging environment file. Also writes a RDS
#'   file to disk in the debug_dir.
#' @noRd
stage_debug <-
  function(fn_name, fn, arg_list, err_msg, debug_dir = "debug") {
    # Initiate a new environment with the variables.
    debug_env <- rlang::new_environment()


    debug_env[["fn_name"]] <- fn_name
    debug_env[["fn"]] <- fn
    debug_env[["arg_list"]] <- arg_list
    debug_env[["err_msg"]] <- err_msg
    debug_env[["ns"]] <- search()

    dir.create(debug_dir, showWarnings = FALSE, recursive = FALSE)
    norm_dir = normalizePath(debug_dir)
    filepath = file.path(norm_dir, paste0(fn_name, ".Rdata"))

    saveRDS(debug_env, file = filepath) #Set dynamically

    return(filepath)
  }


#' Load Debugging Session
#'
#' @description Loads a previously staged debugging session from an RDS file
#'   created by chef::with_stats_validation, setting up the environment to
#'   debug the function call interactively.
#'
#' @param debug_file The path to the RDS file containing the debugging
#'   environment.
#'
#' @return None; this function is used for its side effects.
#' @export
#'
load_debug_session <- function(debug_file) {
  # Get debug env.
  debug_env <- readRDS(debug_file)
  cli::cli_h1("Launching debug session for: {.val {debug_env$fn_name}}")
  #message(paste0("Launching debug session for: ", debug_env$fn_name))

  cli::cli_h3("Original error msg:")
  cli::cli_par()
  cli::cli_verbatim(debug_env$err_msg)
  cli::cli_text("──")
  cli::cli_end()
  #message(paste("Original error msg:", debug_env$err_msg, sep="\n" ))


  if (is.primitive(debug_env$fn)) {
    cli::cli_alert_danger(
      "The inspected function ({.val {deparse(debug_env$fn)}}) is a primitive and cannot be inspected using debugonce.\
      You can still load the debug environemnt and inspect inputs and function: readRDS({.path {debug_file}})",
      wrap = TRUE
    )
    cli::cli_alert_info("Debug session ended")
    return()
  }

  cli::cli_par()
  cli::cli_alert_info(
    "The function will be called once while debugonce() is active.\
    The input will be equal to those from the failed execution.
    "
  )
  cli::cli_end()

  extra_libraries <- setdiff(debug_env$ns, search())
  if (length(extra_libraries) > 0) {
    cli::cli_alert_warning("The following libraries was available at runtime but isn't currently.")
    cli::cli_li(extra_libraries)
  }

  cli::cli_h1("Remember to implementet changes in the source code!")


  debugonce(debug_env$fn)
  try(rlang::exec(debug_env$fn, !!!debug_env$arg_list))

  cli::cli_alert_info("Debug session ended")
}

#' Validate Output from Criterion Functions
#'
#' @description Validates the output of criterion functions to ensure it is a
#'   logical value. This is used to confirm that the criterion functions are
#'   returning expected results.
#'
#' @param output The output from a criterion function.
#'
#' @return An error message if validation fails, otherwise NA.
validate_crit_output <- function(output) {
  if (!(isTRUE(output) |
        isFALSE(output))) {
    paste(
      "The return value from the endpoint criterion function must be a logical of length 1, i.e.",
      "TRUE or FALSE"
    )
  }
  return(NA_character_)
}

#' Validate Output from Statistical Functions
#'
#' @description Validates the output of statistical functions to ensure it
#'   conforms to expected structure. The expected structure includes specific
#'   column names and non-empty results.
#'
#' @param output The output from a statistical function.
#'
#' @return An error message if validation fails, otherwise NA.
#' @export
validate_stat_output <- function(output) {
  # if not a DT return early
  if (!data.table::is.data.table(output)) {
    err_msg <- paste0("Expected (data.table::data.table) Found: ", class(output))
    return(err_msg)
  }

  # if DT check if compliant
  err_messages <- c()
  expected_sorted = sort(c("label","description", "qualifiers", "value"))
  actual_sorted   = sort(names(output))
  if (!identical(expected_sorted, actual_sorted)) {
    actual_diff <- setdiff(actual_sorted, expected_sorted)
    expected_diff <- setdiff(expected_sorted, actual_sorted)

    # Create the error message with the differences highlighted
    err_msg <- paste0(
      "Expected columns: ( ",
      paste(expected_sorted, collapse = ", "),
      " )",
      "\nFound columns: ( ",
      paste(actual_sorted, collapse = ", "),
      " )"
    )
    if (length(actual_diff) > 0) {
      err_msg <- paste0(err_msg,
                        "\n\tExtra items in actual: ( ",
                        paste(actual_diff, collapse = ", "),
                        " )")
    }
    if (length(expected_diff) > 0) {
      err_msg <- paste0(
        err_msg,
        "\n\tMissing items in actual: ( ",
        paste(expected_diff, collapse = ", "),
        " )"
      )
    }
    err_messages <- c(err_messages, err_msg)
  }
  if (nrow(output) == 0) {
    err_msg <-
      "The statistical function returned a data.table with 0 rows"
    err_messages <- c(err_messages, err_msg)
  }
  # If any errors return combined error messages
  if (length(err_messages) != 0) {
    return(paste(err_messages, collapse = "\n"))
  }

  # all checks succeeded:
  return(NA_character_)
}
