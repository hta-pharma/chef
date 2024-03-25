#' Handle creation of endpoint def function
#'
#' @param pipeline_id The pipeline ID
#' @param fn_list fn in list format
#' @param type Type of mk_* function: mk_endpoint_def (default), mk_criterion,
#'   or mk_adam.
#' @param r_functions_dir The directory where the custom R scripts go
#'
#' @keywords internal
handle_mk_fn <-
  function(fn,
           pipeline_id,
           r_functions_dir,
           type = c("mk_endpoint_def", "mk_criterion", "mk_adam"),
           env) {
    type <- match.arg(type)

    if (is.null(fn)) {
      if (type != "mk_endpoint_def") {
        nm <- paste0(type, "_scaffold.R")
      } else {
        nm <- paste0(type, ".R")
      }
      path <- paste0(r_functions_dir, nm)
      template <- paste0("template-", type, ".R")
      return(invisible(
        usethis::use_template(
          template = template,
          package = "chef",
          save_as = path,
          open = TRUE
        )
      ))
    }
    if (length(fn) == 1) {
      return(
        lapply(
          fn,
          handle_mk_fn_,
          type = type,
          pipeline_id = pipeline_id,
          r_functions_dir = r_functions_dir,
          path,
          nm,
          env = env
        )
      )
    }
    lapply(
      fn[-1],
      handle_mk_fn_,
      type = type,
      pipeline_id = pipeline_id,
      r_functions_dir = r_functions_dir,
      path,
      nm,
      env = env
    )
  }

handle_mk_fn_ <-
  function(fn,
           type,
           pipeline_id,
           r_functions_dir,
           path,
           nm,
           env) {
    nm <- paste0(fn, ".R")
    if (type == "mk_endpoint_def") {
      nm <- "mk_endpoint_def.R"
      cli::cli_alert_info(paste0("Renaming \"", fn, "\" to \"", nm, "\""))
    }
    path <- paste0(r_functions_dir, nm)
    fn_bod <- NULL
    fn_evaled <- eval(fn, envir = env)
    if (inherits(fn_evaled, "purrr_function_partial")) {
      fn_out <- paste0(deparse(fn_evaled), "()")
    } else {
      if (!is.function(fn_evaled)) {
        stop(
          type,
          "_fn must be a call to a function defining the endpoints"
        )
      }
      fn_bod <- deparse(fn_evaled)
      fn_bod[1] <- gsub("\\s+", "", fn_bod[1])
      fn_out <-
        c(paste0(gsub(".R", "", nm), " <- "), fn_bod)
    }


    path_normalized <-
      normalizePath(path, mustWork = FALSE)
    if (!file.exists(path_normalized)) {
      file.create(path_normalized)

      writeLines(fn_out, path_normalized)
    } else {
      overwrite <-
        usethis::ui_yeah("Overwrite pre-existing file {path}?")
      if (overwrite) {
        file.remove(path_normalized)
        file.create(path_normalized)
        writeLines(fn_out, path_normalized)
      }
    }

    # Open file for user
    usethis::edit_file(path)
    return(invisible(normalizePath(path, mustWork = FALSE)))
  }
