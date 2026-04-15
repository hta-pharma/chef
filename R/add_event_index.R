#' Create an Index Flag Based on Specified Conditions
#'
#' @description This function creates a flag index for a dataset based on
#'   specified variable-value pairs and singleton conditions. It constructs a
#'   filter string using these conditions and evaluates it within the dataset to
#'   create an index flag.
#'
#' @param dat A `data.table` object on which the filtering conditions will be
#'   applied.
#' @param var_value_pairs A list of variable-value pairs where each pair is a
#'   vector of length two, with the first element being the variable name and
#'   the second element being the value to filter for.
#' @param singletons A character vector of additional filtering conditions to be
#'   applied as singletons.
#'
#' @return An integer vector representing the index of rows in `dat` that meet
#'   the specified filtering conditions.
#'
#' @noRd

create_flag <- function(dat, var_value_pairs = NULL, singletons = NULL) {
  filter_str <-
    construct_data_filter_logic(
      var_value_pairs = var_value_pairs,
      singletons = singletons
    )

  dat[eval(parse(text = filter_str))][["INDEX_"]]
}

#' Add Event Index to Expanded Endpoints
#'
#' @description This function adds an event index to each row of the expanded
#'   endpoints `data.table`. The event index is created based on variable-value
#'   pairs and singleton conditions that define specific events of interest
#'   within the dataset. This index can be used to identify events in the
#'   user-supplied criteria and/or statistical functions
#'
#' @param ep A `data.table` that contains expanded endpoint definitions,
#'   typically the output from `expand_over_endpoints`. It assumes the inclusion
#'   of the columns `pop_var`, `pop_value`, `period_var`, `period_value`,
#'   `endpoint_filter`, `endpoint_group_filter`, and `custom_pop_filter`, which
#'   are used to define the conditions for event indexing.
#'
#' @param analysis_data_container A data.table containing the analysis data.
#'
#' @return A `data.table` similar to the input but with an additional
#'   `event_index` column, which contains the indices of events as determined by
#'   the specified conditions for each endpoint. The indices refer to the
#'   `INDEX_` column in the clinical data. This `INDEX_` column is created by
#'   chef when a user supplies a clinical dataset.
#' @export
#'
#' @examples
#' library(data.table)
#' library(pharmaverseadam)
#'
#' # Prepare clinical data with INDEX_ column
#' adcm_data <- as.data.table(pharmaverseadam::adcm)
#' adcm_data[, INDEX_ := .I]
#'
#' analysis_data_container <- data.table(
#'   dat = list(adcm_data),
#'   key_analysis_data = "a"
#' )
#' setkey(analysis_data_container, key_analysis_data)
#'
#' # Create endpoint with specific filters
#' ep <- data.table(
#'   endpoint_id = 1L,
#'   pop_var = "SAFFL",
#'   pop_value = "Y",
#'   period_var = NA_character_,
#'   period_value = NA_character_,
#'   endpoint_filter = NA_character_,
#'   endpoint_group_filter = NA_character_,
#'   custom_pop_filter = NA_character_,
#'   key_analysis_data = "a"
#' )
#' setkey(ep, key_analysis_data)
#'
#' # Add event index: identifies which rows match endpoint criteria
#' ep_with_index <- add_event_index(ep, analysis_data_container)
#'
#' # event_index contains row numbers from adcm_data matching the criteria
#' str(ep_with_index$event_index)  # integer vector of INDEX_ values
#' length(ep_with_index$event_index[[1]])  # e.g., 47 events match SAFFL="Y"

add_event_index <- function(ep, analysis_data_container) {
  event_index <-
    dat <-
    pop_var <-
    pop_value <-
    period_var <-
    period_value <-
    endpoint_filter <-
    endpoint_group_filter <- custom_pop_filter <- NULL
  ep_out <- ep[analysis_data_container]
  ep_out[, event_index := llist(
    create_flag(
      dat[[1]],
      var_value_pairs = list(
        c(pop_var[[1]], pop_value[[1]]),
        c(period_var[[1]], period_value[[1]])
      ),
      singletons = c(
        endpoint_filter[[1]],
        endpoint_group_filter[[1]],
        custom_pop_filter[[1]]
      )
    )
  ), by = endpoint_id]
  ep_out[, dat := NULL]
}
