#' Check for duplicate function definitions
#'
#' Scans a directory for R files and identifies any function definitions that
#' appear multiple times (by name). This is useful in endpoint analysis pipelines
#' to prevent accidental function redefinitions that could cause unexpected
#' behavior. The check is case-sensitive (i.e., `func_name` and `Func_name` are
#' considered distinct).
#'
#' @param dir The directory where the custom functions are defined
#'
#' @return Run for side-effects. Returns `NULL` invisibly if no duplicates are
#'   found. If duplicate functions are detected, an error is thrown with details
#'   about which functions are duplicated.
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   # Create a temporary directory for demonstration
#'   tmp_dir <- tempdir()
#'
#'   # Valid case: no duplicate function names
#'   writeLines("
#'     compute_n_subjects <- function(dat, ...) {
#'       nrow(dat)
#'     }
#'   ", file.path(tmp_dir, "stat_functions_1.R"))
#'
#'   writeLines("
#'     compute_event_rate <- function(dat, ...) {
#'       sum(dat$is_event) / nrow(dat)
#'     }
#'   ", file.path(tmp_dir, "stat_functions_2.R"))
#'
#'   # Check passes - no duplicates found
#'   check_duplicate_functions(tmp_dir)
#'
#'   # Invalid case: duplicate function names cause error
#'   writeLines("
#'     compute_n_subjects <- function(dat, ...) {
#'       sum(!is.na(dat$id))  # Different implementation
#'     }
#'   ", file.path(tmp_dir, "stat_functions_2.R"))
#'
#'   # This will error with message about "compute_n_subjects" being duplicated
#'   check_duplicate_functions(tmp_dir)
#' }
#'
check_duplicate_functions <- function(dir) {
  if (!dir.exists(dir)) {
    stop(paste0("Directory ", dir, " does not exist"))
  }
  dir_norm <- normalizePath(dir)

  x <- list.files(dir_norm, full.names = TRUE, pattern = "*.[Rr]")
  fn_names_ls <- lapply(x, function(i) {
    lang_objs <- Filter(is.language, parse(i))
    fun_entries <-
      Filter(function(x) {
        grepl(", function", toString(x))
      }, lang_objs)
    sapply(fun_entries, function(fun_entry_i) {
      trimws(strsplit(toString(fun_entry_i), ",")[[1]][2])
    })
  })
  fn_names <- unlist(fn_names_ls)
  dup_fn_names <- fn_names[duplicated(fn_names)]
  if (length(dup_fn_names) == 0) {
    return(NULL)
  }

  stop(
    paste0(
      "\nThe following functions (found in ",
      dir,
      ") are defined multiple times:\n\n",
      paste0("-", cli::style_bold(dup_fn_names), collapse = "\n"),
      "\n\n Please change the name so there are no duplicated names, otherwise it will be unclear which function will be used in the program.\n"
    )
  )
}
