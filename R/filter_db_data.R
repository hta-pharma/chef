#' Filter study data based on endpoint specifications
#'
#' This function filters ADaM datasets according to the specifications for each
#' endpoint. It merges endpoint definitions with a mapping of endpoints to
#' function hashes and then with the actual ADaM datasets. Custom filtering
#' logic is applied to each dataset to produce the output dataset.
#'
#' @param ep A `data.table` containing endpoint definitions.
#' @param ep_fn_map A `data.table` mapping endpoint definitions to function
#'   hashes and types.
#' @param adam_db A list of ADaM tables obtained from `fetch_db_data`.
#'
#' @return A `data.table` with filtered datasets for each endpoint in the study.
#'
#' @export
filter_db_data <- function(ep, ep_fn_map, adam_db) {
  fn_type <-
    endpoint_spec_id <-
    dat <-
    fn_hash <-
    dat_analysis <-
    pop_var <-
    pop_value <-
    custom_pop_filter <-
    key_analysis_data <- NULL # To satisfy R CMD check

  ep_adam <-
    merge(ep,
          ep_fn_map[fn_type == "data_prepare", .(endpoint_spec_id, fn_hash, fn_type)],
          by = "endpoint_spec_id")

  ep_adam <-
    merge(ep_adam,
          adam_db[, .(fn_hash, dat)],
          by = "fn_hash",
          all.x = TRUE,
          all.y = FALSE)


  ep_adam[, dat_analysis := llist(
    filter_adam_db(
      dat[[1]],
      pop_var = pop_var,
      pop_value = pop_value,
      custom_pop_filter = custom_pop_filter
    )
  ), by = seq_len(nrow(ep_adam))]

  # We no longer need to keep track of the total data set as all analyses are
  # based of the at-risk population
  ep_adam[, dat := NULL]
  setnames(ep_adam, "dat_analysis", "dat")

  ep_adam[,
          key_analysis_data := digest::digest(list(fn_hash,
                                                   pop_var,
                                                   pop_value,
                                                   custom_pop_filter)),
          by = 1:nrow(ep_adam)]
  setkey(ep_adam, key_analysis_data)
  # The data container only keeps one row per unique analysis dataset
  analysis_data_container <- ep_adam[, .(dat, key_analysis_data)]
  analysis_data_container <-
    analysis_data_container[, unique(analysis_data_container, by = "key_analysis_data")]

  ep_adam[["dat"]] <- NULL
  return(list(ep = ep_adam,
              analysis_data_container = analysis_data_container))
}


#' Title
#'
#' @param dat A data.table containing the analysis data.
#' @param pop_var Population flag variable.
#' @param pop_value A character containing the acceptance value of population
#' flag value.
#' @param custom_pop_filter A character string containing a custom population
#' filter.
#'
#' @return  A data.table containing the filtered analysis data.
filter_adam_db <-
  function(dat,
           pop_var,
           pop_value,
           custom_pop_filter) {
    if (is.na(custom_pop_filter)) {
      custom_pop_filter <- NULL
    }
    filter_str <-
      construct_data_filter_logic(
        var_value_pairs = list(c(pop_var, pop_value)),
        singletons = custom_pop_filter)
    apply_dt_filter(dat, filter_str, type = "filter")
  }


#' Apply filtering logic to a data.table
#'
#' This utility function applies a specified filter to a `data.table`. The
#' filter can be applied to either subset the data (type = "filter") or to
#' create a new flag column within the data (type = "flag").
#'
#' @param adam_dt A `data.table` object to which the filter will be applied.
#' @param filter_string A character string representing the filtering logic,
#'   which will be evaluated within the `data.table`.
#' @param type A character string specifying the type of operation to perform:
#'   "filter" to subset the data or "flag" to create a flag column.
#'
#' @return A `data.table` that has been filtered according to the specified
#'   logic, or with an added flag column.
#'
#' @export
#'
apply_dt_filter <-
  function(adam_dt,
           filter_string,
           type = c("filter", "flag")) {
    event_flag <- NULL # To satisfy R CMD check
    type <- match.arg(type)
    if (type == "filter") {
      return(adam_dt[eval(parse(text = filter_string))])
    }
    out <- copy(adam_dt)
    out[, event_flag := FALSE]
    out[eval(parse(text = filter_string)), event_flag := TRUE]
    return(out)

  }
