#' Expand endpoint definitions
#'
#' @description This function takes endpoint definitions and expands them based
#'   on endpoint groups. Each row in the output corresponds to a single table or
#'   figure list (TFL) definition, ensuring that each TFL has a unique
#'   definition. The expansion is done by merging the endpoint definitions with
#'   a mapping table that links these definitions to user-defined functions,
#'   which are then applied to the pre-processed ADaM datasets to create the
#'   expanded endpoints.
#'
#' @param ep A `data.table` containing endpoint definitions, where each row
#'   corresponds to a different endpoint and contains relevant attributes such
#'   as the endpoint name, type, and criteria.
#' @return A `data.table` where each row corresponds to an expanded endpoint
#'   definition
#' @export
expand_over_endpoints <- function(ep, analysis_data_container) {

  ep_with_data <- ep[analysis_data_container]
  ep_with_data[, expand_specification := llist(define_expanded_ep(dat[[1]], group_by[[1]])),
          by = 1:nrow(ep_with_data)]
  ep_with_data[["dat"]] <- NULL
  ep_expanded <-
    ep_with_data %>% tidyr::unnest(col = expand_specification) %>% setDT()

  ep_expanded_2 <- add_missing_columns(ep_expanded)
  ep_expanded_2[, endpoint_id := add_ep_id(.SD, .BY), by =
                endpoint_spec_id]

  # Complete endpoint labels by replacing keywords with values
  nm_set <- names(ep_expanded_2)
  ep_expanded_2[,endpoint_label_evaluated := apply(ep_expanded_2, 1, function(x){

    xlab <- x[["endpoint_label"]]

    # Replace keywords. Do only accept keywords which reference to either
    # character or numeric values (which excludes group_by)
    for (i in nm_set) {
      if (grepl(paste0("<", i, ">"), xlab)) {
        if (is.character(x[[i]]) || is.numeric(x[[i]])) {
          xlab <-
            xlab %>% gsub(paste0("<", i, ">"),
                          paste0(str_to_sentence_base(x[[i]]), collapse = ","),
                          .)
        }
      }
    }

    # Replace group keywords
    group_keywords <-
      stringr::str_extract_all(xlab, "(?<=<)[^<>]*(?=>)") %>% unlist()
    if (length(group_keywords) > 0) {
      for (j in group_keywords) {
        if (!is.null(x$endpoint_group_metadata[[j]])) {
          xlab <-
            xlab %>% gsub(paste0("<", j, ">"),
                          as.character(x$endpoint_group_metadata[[j]]),
                          .)
        }
      }
    }
    return(xlab)
  })]
  ep_expanded_2[["endpoint_label"]] <- NULL
  setnames(ep_expanded_2, "endpoint_label_evaluated", "endpoint_label")

  keep <-
    setdiff(
      names(ep_expanded_2),
      c(
        "data_prepare",
        "stat_by_strata_by_trt",
        "stat_by_strata_across_trt",
        "stat_across_strata_across_trt",
        "crit_endpoint",
        "crit_by_strata_by_trt",
        "crit_by_strata_across_trt",
        "fn_type",
        "fn_hash"
      )
    )

out <- ep_expanded_2[, .SD, .SDcols=keep]
setkey(out, key_analysis_data)
out[]
}


#' Define Expanded Endpoint Specifications
#'
#' @description Takes a dataset and an endpoint group specification, and it
#'   defines the expanded endpoint specifications. It creates metadata and
#'   filter strings for each endpoint group, which are used to subset the data
#'   accordingly. The function ensures that each endpoint group has the
#'   necessary information for further analysis.
#'
#' @param x A `data.table` containing the data associated with the endpoints.
#' @param group_by A list specifying the grouping for endpoints, where
#'   each element corresponds to a variable used for grouping endpoints and
#'   contains the levels for that grouping variable.
#' @param col_prefix A prefix used to create the names of the metadata and
#'   filter columns in the output `data.table`. Defaults to "endpoint_group".
#'
#' @return A `data.table` with additional columns for metadata and filter
#'   conditions for each endpoint group. If the endpoint group is empty or
#'   consists only of `NA` values, the function returns `NA`.
#' @export
#'
define_expanded_ep <- function(x, group_by, forced_group_levels = NULL, col_prefix = "endpoint_group") {
  if (!is.list(group_by) || all(is.na(group_by)))
    return(NA)

  col_name_meta = paste(col_prefix, "metadata", sep="_")
  col_name_filter = paste(col_prefix, "filter", sep="_")

  out <- index_expanded_ep_groups(x, group_by, forced_group_levels) %>%
    construct_group_filter(col_name_filter = col_name_filter)
  out[, (col_name_meta) := .(list(lapply(.SD, identity))), by=1:nrow(out), .SDcols = names(group_by)]
  out[, .SD, .SDcols = c(col_name_meta, col_name_filter)]
}

#' Index Non-Null Group Levels
#'
#' @description Takes a list representing group levels and returns a new list
#'   with only the non-null elements. It is used to filter out null values from
#'   a list of group levels, which can be necessary when defining the expanded
#'   endpoint specifications.
#'
#' @param x A list representing group levels for endpoint grouping.
#'
#' @return A list containing only the non-null elements from the input list.
#' @export
index_non_null_group_level <- function(x) {
  x[!purrr:::map_lgl(x, is.null)]
}

#' Index the expanded endpoints
#'
#' @description Creates an index for endpoint groups by expanding
#'   a single endpoint definition to include all specified levels. If multiple
#'   variables are specified for grouping, the function returns all possible
#'   combinations. It also indexes the specific combinations found in the
#'   supplied study data, indicating whether data exists for each group
#'   combination.
#'
#' @param x A dataset with study data (i.e ADaM).
#' @param group_by A list specifying the grouping for endpoints.
#' @param forced_group_levels data.table (optional). Table with group levels that must be included in the expansion, regardless of `group_by`.
#'
#' @return A data table with the same number of columns as the number of
#'   variables included in the grouping specification, plus an additional column
#'   `empty` that specifies if there are any records corresponding to the group
#'   combination. `FALSE` means >=1 record exists in the supplied study data.
#' @export
index_expanded_ep_groups <- function(x, group_by, forced_group_levels = NULL) {
  checkmate::assert_data_table(x)
  checkmate::assert_list(group_by)
  grouping_vars <- names(group_by)
  combos_all <- x[, unique(.SD), .SDcols = grouping_vars]

  # Only want rows that contains values as the other rows indicate non-events
  combos_all <- combos_all[complete.cases(combos_all)]

  # Add forced group levels (if any)
  combos_all <- add_forced_group_levels(combos_all = combos_all, forced_group_levels = forced_group_levels)

  specified_group_levels <-
    index_non_null_group_level(group_by)
  if (length(specified_group_levels) > 0) {
    var_group_levels <- names(specified_group_levels)
    if (length(var_group_levels) > 1)
      stop("Support for multiple variables specifying group levels not yet supported")
    combos_subset <-
      combos_all[tolower(get(var_group_levels)) %in% tolower(specified_group_levels[[var_group_levels]]),]
  } else {
    combos_subset <- combos_all
  }

  # Expand by all possible combinations of group-by columns in combos_subset.
  if (length(group_by) == 1) {
    return(combos_subset)
  }else{
    unique_vals <- lapply(combos_subset, unique)
    combos_expanded <- setDT(expand.grid(unique_vals, stringsAsFactors = FALSE))
    return(combos_expanded)
  }
}

construct_group_filter <- function(x, col_name_filter="endpoint_group_filter") {
  out <- copy(x)
  filter_str_vec <-
    purrr::pmap(x, create_condition_str) %>% unlist(recursive = F)
  out[, (col_name_filter) := filter_str_vec]
}

create_condition_str <- function(...) {
  lst <- list(...)
  # create the condition strings
  conditions <-
    purrr::map2_chr(names(lst), lst, ~ paste0(.x, ' == "', .y, '"'))

  # Concatenate all condition strings with ' & ' and return the result
  return(paste(conditions, collapse = ' & '))
}


#' Add Endpoint ID
#'
#' @description Adds a unique identifier to each endpoint based on
#'   the grouping ID and a sequence number.
#'
#' @param x A `data.table` containing endpoints.
#' @param grp The grouping ID used to construct the unique identifier.
#'
#' @return A character vector with unique identifiers for each endpoint.
#' @noRd
add_ep_id <- function(x, grp) {
  x[, paste0(grp, "-", formatC(
    .I,
    width = 4,
    format = "d",
    flag = "0"
  ))]
}


add_missing_columns <- function(x){
  if(length(intersect(c("endpoint_group_filter", "empty", "endpoint_group_metadata"), names(x)))==2){
    return(x)
  }
  x1 <- copy(x)
  if(length(intersect(c("endpoint_group_filter"), names(x)))==0){
    x1[, endpoint_group_filter:=NA]
  }
  if(length(intersect(c("empty"), names(x)))==0){
    x1[, empty:=NA]
  }
  if(length(intersect(c("endpoint_group_metadata"), names(x)))==0){
    x1[, endpoint_group_metadata:=list()]
  }

  x1
}

#' Add forced group levels
#'
#' @description Expand the set of unique group levels of one grouping variables in a table containing all combinations of one or more grouping variables.
#'
#' @param combos_all A data.table containing all combinations of group levels found in the analysis data.
#' @param forced_group_levels A one column data.table containing a required set of group levels of a grouping variable.
#'
#' @return A data.table containing all combinations of group levels exapnded with the forced grouping levels. 
add_forced_group_levels <- function(combos_all, forced_group_levels) {

  # If no forced group levels are present then return early
  if (is.null(forced_group_levels)) {
    return(combos_all)
  }

  # Only forced group levels on one group variable is supported, so check that forced_group_levels has one column only
  checkmate::assertDataTable(forced_group_levels, ncols = 1)

  # Check that the variable that is subject to the forced group levels is present in the analysis data 
  unsupported_forced_group_levels <- setdiff(names(forced_group_levels), names(combos_all)) |>
    length() > 0
  if (unsupported_forced_group_levels) {
    stop("Unsupported forced group levels")
  }

  actual_group_levels <- combos_all[, names(forced_group_levels), with = FALSE] |>
    unique()

  # Check that the forced group levels covers all existing group levels
  too_few_forced_group_levels <- length(setdiff(actual_group_levels[[1]], forced_group_levels[[1]])) > 0
  if (too_few_forced_group_levels) {
    stop("Fewer forced group levels than levels in the analysis data")
  }

  # Check if the forced group levels covers more than the existing group levels. If not then no need to force them.
  forced_group_levels_already_present <- setequal(actual_group_levels[[1]], forced_group_levels[[1]])
 
  # If the forced group levels cover more than the existing group levels then add them to the group level combinations
  if (!forced_group_levels_already_present) {
    cols_from_combos_all <- names(combos_all) != names(forced_group_levels)
    col_list_combos_all <- lapply(combos_all[, .SD, .SDcols = cols_from_combos_all], function(x){x})
    col_list_2 <-lapply(forced_group_levels, function(x){x}) 
    grid_list <- c(col_list_combos_all, col_list_2)
    return(expand.grid(grid_list) |> setDT())
  }

  # If the forced group levels do not cover more than the existing group levels then return the unmodified group level combinations
  return(combos_all)
}