#' Prepare (and Expand) Endpoint for Statistical Analysis
#'
#' @description Prepares the endpoint data for ingestion by the user-supplied
#'   statistical function by expanding it based on the type of statistics to be
#'   performed. It expands the data according to the specified statistical type,
#'   which determines the grouping columns used for the expansion.
#'
#' @param ep A `data.table` containing expanded endpoint definitions and
#'   associated data, typically the output from `apply_criterion_by_strata`.
#' @param fn_map A `data.table` mapping endpoint definitions to statistical
#'   functions.
#' @param type A character string specifying the type of statistics for which
#'   the data is being prepared. Valid types are "stat_by_strata_by_trt",
#'   "stat_by_strata_across_trt", and "stat_across_strata_across_trt".
#' @param data_col The name of the column in `ep` that contains the ADaM
#'   dataset.
#' @param id_col The name of the column in `ep` that contains the unique
#'   identifier for the strata.
#'
#' @return A `data.table` with expanded endpoints prepared for statistical
#'   analysis.
#' @export
prepare_for_stats <- function(ep,
                              analysis_data_container,
                              fn_map,
                              type = c(
                                "stat_by_strata_by_trt",
                                "stat_by_strata_across_trt",
                                "stat_across_strata_across_trt"
                              ),
                              data_col = "dat",
                              id_col = "strata_id") {
  type <- match.arg(type)

  crit_var <- switch(
    type,
    "stat_by_strata_by_trt" = "crit_accept_by_strata_by_trt",
    "stat_by_strata_across_trt" = "crit_accept_by_strata_across_trt",
    "stat_across_strata_across_trt" = "crit_accept_by_strata_across_trt",
    stop("Unknown stat function type")
  )


  # Return early if no endpoint rows are accepted by criterion or if no stat functions are suppied
  if(nrow(ep[get(crit_var)]) == 0 |
     nrow(fn_map[fn_type == type]) == 0){
    return(data.table::data.table(SKIP_=TRUE))
  }

  # Set of columns used for slicing the population depending on the type of stat function
  grouping_cols <- switch(
    type,
    "stat_by_strata_by_trt" = c("strata_var", "treatment_var"),
    "stat_by_strata_across_trt" = c("strata_var"),
    "stat_across_strata_across_trt" = c("strata_var", "treatment_var"),
    stop("Unknown stat function type")
  )

  if (type %in% c("stat_by_strata_by_trt", "stat_by_strata_across_trt")) {

    # Expand endpoints by treatment and/or strata
    ep_expanded <-
      expand_ep_for_stats(
        ep = ep[get(crit_var) == TRUE],
        grouping_cols = grouping_cols,
        analysis_data_container = analysis_data_container,
        data_col = data_col,
        id_col =  id_col,
        col_prefix = "stat"
      )

    # Indicate if stratum has no observations or events
    ep_expanded[, stat_event_exist := sapply(Map(intersect, event_index, cell_index), function(x) length(x) > 0)]

    # Join stat function data so that each row represent a function call
    ep_fn <-
      merge(ep_expanded,
            fn_map[fn_type == type],
            by = "endpoint_spec_id",
            allow.cartesian = TRUE)

    # Create unique id for stat function call
    ep_fn[, stat_result_id := paste(get(id_col), fn_hash, formatC(.I, width = 4, format = "d", flag = "0"),
                                    sep = "-")]

    return(ep_fn)
  } else{

    ep_fn <-
      merge(ep[get(crit_var) == TRUE],
            fn_map[fn_type == type],
            by = "endpoint_spec_id",
            allow.cartesian = TRUE)

    # For stat_across_strata_across_trt we test interaction effect between treatment and strata
    # So Treatment ~ SEX we therefore add an empty filter and an metadata containing all the levels.
    # Remove the total stratum as it is out of scope of this type of statistics
    setkey(ep_fn, key_analysis_data)
    ep_with_data <- ep_fn[analysis_data_container]
    ep_sg <- ep_with_data[get(grouping_cols[1]) != "TOTAL_", ]
    ep_sg <-
      ep_sg[, c("stat_event_exist",
                "stat_metadata",
                "stat_filter",
                "stat_result_id",
                "cell_index") :=
              c(TRUE,
                llist(c(
                  list_group_and_levels(get(data_col)[[1]], get(grouping_cols[1])),
                  list_group_and_levels(get(data_col)[[1]], get(grouping_cols[2]))
                )),
                "",
                paste0(
                  get(id_col),
                  "-",
                  fn_hash,
                  "-",
                  formatC(
                    .I,
                    width = 4,
                    format = "d",
                    flag = "0"
                  )
                ),
                llist(get(data_col)[[1]][["INDEX_"]])),
            by = 1:nrow(ep_sg)]
    ep_sg[, (data_col) := NULL]
    return(ep_sg)

  }

}


#' List Groups and Their Levels from Data
#'
#' @description This function extracts the levels of a specified grouping
#'   variable from the data, creating a list where each element corresponds to a
#'   unique level of the grouping variable.
#'
#' @param data A `data.table` containing the dataset from which to extract the
#'   levels.
#' @param grouping_col The name of the grouping variable.
#'
#' @return A list where each element represents a level of the grouping
#'   variable.
#' @noRd
list_group_and_levels <- function(
    data,
    grouping_col
){
  l = list(data[, unique(get(grouping_col))])
  names(l) = grouping_col
  return (l)
}

#' Expand Endpoint Data for Statistics
#'
#' @description Expands endpoint datatable for statistical analysis based on
#'   specified grouping columns. Creates specifications for expansion and
#'   performs the expansion to prepare the data for statistical functions.
#'
#' @param ep A `data.table` containing endpoint data to be expanded.
#' @param grouping_cols A character vector specifying the columns used for
#'   grouping in the expansion.
#' @param data_col The name of the column in `ep` that contains the ADaM
#'   dataset.
#' @param id_col The name of the column in `ep` that contains the unique
#'   identifier for the strata.
#' @param col_prefix A prefix for the resulting columns, defaults to "stat".
#'
#' @return A `data.table` with expanded endpoints prepared for statistical
#'   analysis.
#' @export
expand_ep_for_stats <- function(
    ep,
    grouping_cols,
    analysis_data_container,
    data_col,
    id_col,
    col_prefix
){

  name_expand_col = paste(col_prefix, "expand_spec", sep="_")

  ep[,"_i_" := .I]
  setkey(ep, key_analysis_data)
  ep_with_data <- ep[analysis_data_container, nomatch = NULL]
  ep_with_data[,
     stat_expand_spec := llist(
       define_expansion_cell_from_data(
         row=.SD,
         grouping_cols = grouping_cols,
         data_col = data_col,
         col_prefix = col_prefix
       )),
     by = "_i_"]

  # We remove the clinical data, otherwise the memory usage during the unnest
  # step will explode
  ep_with_data[, (data_col):=NULL]

  ep_exp <- ep_with_data %>% tidyr::unnest(col = stat_expand_spec) %>% setDT()

  setkey(ep_exp, key_analysis_data)


  ep_exp[,"_i_":= .I]
  ep_exp_with_data <- ep_exp[analysis_data_container, nomatch = NULL]
  filter_col_name = paste(col_prefix, "filter", sep="_")
  ep_exp_with_data[, cell_index := llist(create_flag(get(data_col)[[1]],
                                           singletons = c(get(filter_col_name)[[1]]))),
                   by = "_i_"]

  ep_exp_with_data[, (data_col) := NULL]
  ep_exp_with_data[, "_i_" := NULL]
  return(ep_exp_with_data)
}

#' Create Expansion Cell Containing a Data Table Based on Strata
#'
#' @description Defines an expansion cell for a `data.table` row based on the
#'   the strata. Creates a `data.table` with metadata and filter conditions for
#'   each combination of strata levels.
#'
#' @param row A single row from a data table containing endpoint data.
#' @param grouping_cols A character vector specifying the columns that point to
#'   the grouping variables in the data.
#' @param data_col The name of the column that points to the ADaM dataset.
#' @param col_prefix A prefix for the resulting columns, such as "prefix_filter"
#'   and "prefix_metadata".
#'
#' @return A nested `data.table` (double listed) to be inserted into a data table
#'   cell.
#' @export
define_expansion_cell_from_data <- function(
    row,
    grouping_cols,
    data_col,
    col_prefix
){
  if (is.character(grouping_cols)){
    grouping_cols = c(grouping_cols)
  }
  stopifnot(all(grouping_cols %in% names(row)))

  # Get the actual grouping variables.
  grouping_col_values = row[, .SD, .SDcols=grouping_cols]
  grouping_var_list = vector(mode="list", length(grouping_col_values))
  names(grouping_var_list) = grouping_col_values

  if(row[["only_strata_with_events"]]){
    dat <-  row[,get(data_col)][[1]][row[["event_index"]]]
  }else{
    dat <- row[,get(data_col)][[1]]
  }

  exp_dt <- define_expanded_ep(x = dat, group_by = grouping_var_list, col_prefix = col_prefix)
  return (exp_dt)
}

add_total_meta <- function(x, meta_col, total_meta){
  llist(c(x[[meta_col]][[1]], total_meta))
}
