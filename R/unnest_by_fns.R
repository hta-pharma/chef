#' Unnest data model by the supplied function columns
#'
#' This function takes a `data.table` and a vector of column names. These columns are expected to
#' contain lists of function calls. The function 'unnests' these columns such that each function call
#' is represented on its own row in the resulting `data.table`. This is useful for processing or
#' analyzing the function calls separately.
#'
#' @param dt A `data.table` object. The endpoint data model that contains nested function calls.
#' @param cols A character vector of quoted column names in `dt` that contain the nested function calls.
#'
#' @return A `data.table` in long format, where each row corresponds to a single function call
#'         from the nested lists in the specified columns.
#'
#' @export
#'
unnest_by_fns <- function(dt, cols) {
  fn <- fn_list <- fn_name <- fn_hash <- NULL # To satisfy R CMD check
  if(nrow(dt)==0){
    stop("Provided data.table to unnest was empty", call. = FALSE)
  }

  missing_cols <- setdiff(cols, colnames(dt))
  if(length(missing_cols)>0){
    stop("The following columns are not found in the provided data.table to unnest:\n-", paste0(missing_cols, collapse = "\n-"))
  }
  long <-
    data.table::melt.data.table(
      dt,
      measure.vars = cols,
      variable.name = "fn_type",
      value.name = "fn_list",
      variable.factor = FALSE,
    )

  long[, fn := purrr::map(fn_list, function(i)
    as.list(i[-1]))]
  long[, fn_name:=character()]
  long[, fn_name := purrr::map(long$fn, function(i) {

    x <- names(i)
    if (is.null(x)) {
      return(NA_character_)
    }
    return(x)
  })]
  if(nrow(long)==1){
    x <- long
  } else {
    x <- tidyr::unnest(long, c(fn, fn_name)) %>% as.data.table()
  }


  # When no fn get a name in the tidy::unnest(), the fn_name gets transformed
  # to a logical. This needs to be converted back to a character so names can be
  # assigned downstream
  x[,fn_name:=as.character(fn_name)]

  # Index rows where we have to assign function name manually. This happens
  # because when there is only one function provided the logic is different than
  # when multiple are provided
  inx <- x[, purrr::map_lgl(fn, is.name)] & x[, is.na(fn_name)]
  x[inx==TRUE, fn_name := as.character(fn)]

  # For unnamed fns supplied in style of `list(c(fn, arg))` we need a different
  # approach
  inx <- x[, is.na(fn_name)]

  if(length(inx)>0) {
    fn_names <-
      vapply(x[inx, fn], function(i) {

        if (length(i) == 3 && i[[1]] == "::") {
          return(deparse(i))
        }
        i[[2]] |> deparse()
      }, character(1L))
    x[inx, fn_name := fn_names]
  }

  keep <- setdiff(colnames(x), c(cols, "fn_list"))
  return(x[, .SD, .SDcols=keep])
}
