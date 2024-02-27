#' Check for duplicate function definitions
#'
#' @param dir The directory where the custom functions are defined
#'
#' @return run for side-effects, if multiple functions are encountered it throws
#'   an error
#' @export
#'
check_duplicate_functions <- function(dir) {
  if(!dir.exists(dir)){
    stop(paste0("Directory ", dir, " does not exist"))
  }
  dir_norm <- normalizePath(dir)

  x <- list.files(dir_norm, full.names = TRUE, pattern = "*.[Rr]")
  fn_names_ls <- lapply(x, function(i) {
    lang_objs <- Filter(is.language, parse(i))
    fun_entries <-
      Filter(function(x)
        grepl(", function", toString(x)), lang_objs)
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
