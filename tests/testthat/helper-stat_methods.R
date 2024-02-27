# stat_by_strata_by_trt -----------------------------------------------

# Number of subjects
n_sub <- function(dat,
                  cell_index,
                  subjectid_var,
                  ...) {
  stat <- dat[J(cell_index)] |>
    uniqueN(by = c(subjectid_var))

  return(data.table(
    label = "N",
    description = "Number of subjects",
    qualifiers = NA_character_,
    value = stat
  ))
}

# Number of subjects with events
n_subev <- function(dat,
                    event_index,
                    cell_index,
                    subjectid_var,
                    ...) {
  stat <- dat[J(intersect(cell_index, event_index))] |>
    uniqueN(by = c(subjectid_var))

  return(data.table(
    label = "n",
    description = "Number of subjects with events",
    qualifiers = NA_character_,
    value = stat
  ))
}

# Proportion of subjects with events
p_subev <- function(dat,
                    event_index,
                    cell_index,
                    subjectid_var,
                    ...) {
  n_sub <- dat[J(cell_index)] |>
    uniqueN(by = c(subjectid_var))

  n_subev <- dat[J(intersect(cell_index, event_index))] |>
    uniqueN(by = c(subjectid_var))

  out <-
    data.table(
      label = "(%)",
      description = "Proportion of subjects with events",
      qualifiers = NA_character_,
      value = n_subev / n_sub * 100
    )


  return(out)
}

# Summary statistics
summary_stats <- function(dat,
                          event_index,
                          cell_index,
                          subjectid_var,
                          var,
                          var_type = c("cont", "cat"),
                          ...) {

  # Check argument
  var_type <- match.arg(var_type)

  # Filter analysis data to cell specific content
  dat_cell <- dat[J(intersect(cell_index, event_index))] |>
    unique(by = c(subjectid_var))

  # Return statistics depending on the type of variable (continuous or categorical)
  if (var_type == "cont") {
    stat <- dat_cell %>%
      dplyr::summarize(
        mean = mean(get(var)),
        median = median(get(var)),
        sd = sd(get(var)),
        min = min(get(var)),
        max = max(get(var)),
        n_nonmiss = sum(!is.na(get(var))),
        n_miss = sum(is.na(get(var)))
      )
  } else {
    stat <- dat_cell %>%
      dplyr::summarize(
        n_nonmiss = sum(!is.na(get(var))),
        n_miss = sum(is.na(get(var)))
      )
  }

  return(data.table(
    label = names(stat),
    description = "Summary statistics",
    qualifiers = NA_character_,
    value = as.list(stat)
  ))
}


# stat_by_strata_across_trt -------------------------------------------------------

# Absolute difference in number of subjects with event between treatment arms
n_subev_trt_diff <- function(dat,
                             event_index,
                             cell_index,
                             treatment_var,
                             subjectid_var,
                             ...) {
  stat <- dat[J(intersect(cell_index, event_index))] %>%
    unique(., by = c(subjectid_var, treatment_var)) %>%
    .[, .(value = .N), by = treatment_var] %>%
    .[, .(value = abs(diff(value)))] %>%
    .[["value"]]

  # In case stat is invalid, e.g. if obs. only exists in one treatment arm then replace stat with NA
  stat <- ifelse(length(stat) == 0, NA, stat)

  out <-
    data.table(
      label = "n_trt_diff",
      description = "Absolute difference in number of subjects with events between treatment arms",
      qualifiers = NA_character_,
      value = stat
    )


  return(out)
}

# Contingency 2x2 table for total number of events (Fisher's exact test for count data)
contingency2x2_ptest <- function(dat,
                                 event_index,
                                 cell_index,
                                 treatment_var,
                                 ...) {

  # Test a 2x2 contingency table ie. is there a link between treatment and total number of events
  dat_cell <- dat[J(cell_index), ]
  dat_cell[, is_event := INDEX_ %in% event_index]

  count_table <-
    dat_cell[, .SD, .SDcols = c("is_event", treatment_var)] %>%
    table()

  res <- fisher.test(count_table,
    conf.int = T
  )

  # Prepare output
  out <- data.table::data.table(
    label = c("Pval_independency", "CI_upper", "CI_lower"),
    description = "Fisher's exact test for count data",
    qualifiers = NA_character_,
    value = c(res$p.value, res$conf.int[1], res$conf.int[2])
  )
  return(out)
}


# stat_across_strata_across_trt -------------------------------------------------------------

# Cochran-mante-haenszel test for odds ratios across strata
contingency2x2_strata_test <- function(dat,
                                       event_index,
                                       strata_var,
                                       treatment_var,
                                       subjectid_var,
                                       ...) {

  # Test a 2x2 contingency table i.e. is there a link between treatment and
  # patients with events over multiple strata
  dt_unique_subjects <- dat %>%
    unique(by = subjectid_var)
  dt_unique_subjects[, is_event := INDEX_ %in% event_index]
  cont_table <- dt_unique_subjects[,
    .SD,
    .SDcols = c("is_event", treatment_var, strata_var)
  ] %>%
    table()

  res <- stats::mantelhaen.test(cont_table, conf.int)

  # Prepare output
  out <- data.table::data.table(
    label = c("Pval_independency", "CI_lower", "CI_upper"),
    description = "Cochran-mante-haenszel test for odds ratios across strata",
    qualifiers = NA_character_,
    value = c(res$p.value, res$conf.int[[1]], res$conf.int[[2]])
  )
  return(out)
}
