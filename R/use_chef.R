#' Build a pipeline from a template
#'
#' @details Sets up the directory structure and helper files required for making
#'   a chef analysis pipeline.
#'
#'   This function needs be run in the home directory of the project file (such
#'   as the .Rproj) associated with the analysis project. If the project file is
#'   located in a different directory, you will have to manually set up the
#'   required files.
#'
#' @param pipeline_dir Character string ending with `/`. The directory where the
#'   targets pipeline scripts are to be stored. Keep in mind, wherever these
#'   pipeline scripts are stored, the {targets} cache files will also be stored
#'   (these cache files will not be under version control and thus only exist on
#'   your "machine").
#' @param r_functions_dir Character string ending with `/`. The directory where
#'   all the R scripts for the project are to be stored. This will include your
#'   `mk_adam_*()` and criterion functions for example, and any other functions
#'   that are used in the pipelines.
#' @param pipeline_id Character sting. Alphanumeric only
#' @param mk_endpoint_def_fn If you would like to use an existing
#'   `mk_endpoint_def_*()` function as the starting point for the pipeline,
#'   supply the unquoted function name here. This assumes there are no arguments
#'   to the function call and the functions have to be available from the global
#'   enironment (i.e if you type `my_fun()` into the console, it would find the
#'   function and try to run in)
#' @param mk_adam_fn List of functions used for making adam dataset. This is
#'   useful if you want to supply already existing functions. This must be a
#'   list, and each element must be an unquoted function name (e.g.
#'   `my_adam_fn`). The functions have to be available from the global
#'   enironment (i.e if you type `my_adam_fun()` into the console, it would find
#'   the function and try to run in). If no functions are supplied, then the
#'   default functions will be written. If you do not want any functions to be
#'   written, set `mk_adam_fn = NA`.
#' @param mk_criteria_fn List of functions used for making the criteria for
#'   endpoint/analysis inclusion. This is useful if you want to supply already
#'   existing functions that are not part of the {chefcriterion} package. This
#'   must be a list, and each element must be an unquoted function name (e.g.
#'   `my_criteria_fn`). The functions have to be available from the global
#'   environment (i.e if you type `my_criteria_fn()` into the console, it would
#'   find the function and try to run in).
#' @param branch_group_size Numeric.
#' @param env Environment.
#'
#' @return Nothing, run for side effects.
#' @export
use_chef <-
  function(pipeline_dir = "pipeline/",
           r_functions_dir = "R/",
           pipeline_id,
           mk_endpoint_def_fn = NULL,
           mk_adam_fn = NULL,
           mk_criteria_fn = NULL,
           branch_group_size = 100,
           env = parent.frame()) {
    file_name <- paste0("pipeline_", pipeline_id, ".R")
    mk_ep_def_template <- "template-mk_endpoint_def.R"

    # Create directories if none exist
    pipeline_dir_norm <-
      normalizePath(pipeline_dir, mustWork = FALSE)
    r_functions_dir_norm <-
      normalizePath(r_functions_dir, mustWork = FALSE)
    if (!dir.exists(pipeline_dir_norm)) {
      dir.create(pipeline_dir_norm)
    }
    if (!dir.exists(r_functions_dir_norm)) {
      dir.create(r_functions_dir_norm)
    }

    # Write packages.R file in script_dir if none exists
    pkg_file_path <-
      paste0(r_functions_dir, "/packages.R")
    pkg_file_path_norm <-
      normalizePath(pkg_file_path, mustWork = FALSE)
    pkg_file_exists <- file.exists(pkg_file_path_norm)
    if (!pkg_file_exists) {
      usethis::use_template("packages_template.R",
        package = "chef",
        save_as = pkg_file_path
      )
    }

    # Write the pipeline scaffold
    pipeline_dir <- gsub("\\/", "", pipeline_dir)
    pipeline_path <-
      normalizePath(paste0(pipeline_dir, "/", file_name), mustWork = FALSE)

    usethis::use_template(
      template = "template-pipeline.R",
      data = list(
        mk_endpoint_def_fn = paste0("mk_endpoint_def_", pipeline_id, "()"),
        r_script_dir = r_functions_dir,
        branch_group_size = branch_group_size
      ),
      package = "chef",
      save_as = pipeline_path,
      open = TRUE
    )

    handle_mk_fn(
      fn = substitute(mk_adam_fn),
      pipeline_id = pipeline_id,
      r_functions_dir = r_functions_dir,
      type = "mk_adam",
      env = env
    )
    if (!is.null(mk_criteria_fn)) {
      handle_mk_fn(
        fn = substitute(mk_criteria_fn),
        pipeline_id = pipeline_id,
        r_functions_dir = r_functions_dir,
        type = "mk_criterion",
        env = env
      )
    }

    handle_mk_fn(
      fn = substitute(mk_endpoint_def_fn),
      pipeline_id = pipeline_id,
      r_functions_dir = r_functions_dir,
      type = "mk_endpoint_def",
      env = env
    )

    # Configure the yaml file to include the added pipeline
    file_name_naked <- gsub(pattern = ".R", "", file_name)
    targets::tar_config_set(
      script = normalizePath(paste0(pipeline_dir, "/", file_name), mustWork = FALSE),
      store = normalizePath(paste0(pipeline_dir, "/", file_name_naked), mustWork = FALSE),
      project = file_name_naked
    )

    stage_pipeline(pipeline_id = pipeline_id)
  }

#' Run a {targets} pipeline
#'
#' @description A wrapper for targets::tar_make() that ensures the correct
#'   pipeline is run, and the correct cache location is used for that pipeline.
#'   Relies on the _targets.yaml file existing in the home directory of the
#'   project.
#' @param pipeline_id A character string that will function as the pipeline ID.
#'   Must not contain non-alphanumeric characters
#' @param pipeline_name Usually leave blank, only for special cases if you use a
#'   custom naming convention for your pipelines (not recommended). If used,
#'   leave `pipeline_id` blank and enter your custom pipeline name here.
#'
#' @return Nothing, run for side effects
#' @export

run_pipeline <- function(pipeline_id = NULL,
                         pipeline_name = NULL) {
  nm <- pipeline_name
  if (!is.null(pipeline_id)) {
    nm <- paste0("pipeline_", pipeline_id)
  }

  stage_pipeline(pipeline_name = nm)
  targets::tar_make()
}

#' Stage a {targets} pipeline so that you can work interactively with it
#'
#' @description To interact with a {targets} pipeline (e.g., run the pipeline,
#'   load the completed targets from cache into memory), targets needs to know
#'   which pipeline you want to work with. `This function` is a thin wrapper
#'   apound a Sys.setenv() call, and depends on the _targets.yaml file being set
#'   up correctly (this happens automatically when you run use_pipeline() to set
#'   up a new pipeline
#' @param pipeline_id A character string. Must not contain non-alphanumeric
#'   characters
#' @param pipeline_name Usually leave blank, only for special cases if you use a
#'   custom naming convention for your pipelines (not recommended). If used,
#'   leave `pipeline_id` blank and enter your custom pipeline name here.
#'
#' @return Nothing, run for side effects
#' @export
#'
stage_pipeline <-
  function(pipeline_id = NULL,
           pipeline_name = NULL) {
    nm <- pipeline_name
    if (!is.null(pipeline_id)) {
      nm <- paste0("pipeline_", pipeline_id)
    }

    Sys.setenv(TAR_PROJECT = nm)
  }
