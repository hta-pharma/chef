#' Format results
#'
#' @param ep A data.table containing the endpoint information.
#'
#' @return A data.table containing the unnested endpoint information.
#' @export
#'
format_stats_results <- function(ep){
  if(is.null(ep))return(NULL)
  out <- ep %>%
    tidyr::unnest(cols = results) %>%
    as.data.table()
  cols_to_move_suggested <- c("stratify_by", "strata_val", "fn_name", "value_qualifier", "value")
  names_out <- names(out)
  cols_to_move_actual <- intersect(cols_to_move_suggested, names_out)
  setcolorder(out, c(setdiff(names_out, cols_to_move_actual), cols_to_move_actual))
  if(length(intersect("strata_val", names_out))==0){
    return(out)
  }
  out[stratify_by=="TOTAL_", strata_val := "total"]
}
