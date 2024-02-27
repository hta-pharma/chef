#' Filter adam data
#'
#' @param ep_unnest data.table. An unnested endpoint definition table
#' @param adam_db data.table. A table containing the adam datasets associated
#'   with each data_prepare
#'
#' @return a data.table with the filtered adam data.
#' @export
#'
join_adam <-
  function(ep,
           ep_fn_map,
           adam_db,
           filter_pop = TRUE,
           filter_period = TRUE,
           filter_trt = TRUE,
           filter_user_defined = TRUE) {
    checkmate::assert_data_table(ep)
    checkmate::assert_data_table(adam_db)


    ep_adam <-
      merge(ep, ep_fn_map[fn_type == "data_prepare"], by = "endpoint_spec_id")

    ep_adam <-
      merge(ep_adam,
            adam_db[, .(fn_hash, dat)],
            by = "fn_hash",
            all.x = TRUE,
            all.y = FALSE)
    # We no longer need to track the data generating (aka ADaM) functions.
    # Tracking it, in fact, might increase risk of triggering a unneccessary
    # re-run in targets if the fn hash changes without any data change
    keep_cols <-
      setdiff(names(ep_adam),
              c("fn_type", "fn", "fn_name", "fn_hash", "fn_callable"))
    ep_adam[, .SD, .SDcols = keep_cols]


  }

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
