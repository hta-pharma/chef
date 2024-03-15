#' Filter applying to a data.table
#'
#' @param adam_dt data.table::data.table
#' @param filter_string character
#' @param type character
#'
#' @return data.table::data.table
#'
#' @export
#'
apply_dt_filter <- function(adam_dt, filter_string, type=c("filter", "flag")) {
  type <- match.arg(type)
  if(type=="filter"){
    return(adam_dt[eval(parse(text = filter_string))])
  }
  out <- copy(adam_dt)
  out[, event_flag:=FALSE]
  out[eval(parse(text = filter_string)), event_flag :=TRUE]
  return(out)

}
