test_that("Keep only explicit strata levels", {

  ep <-
    chef::mk_endpoint_str(
      data_prepare = mk_adae,
      study_metadata = list(),
      pop_var = "SAFFL",
      pop_value = "Y",
      custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose') & !is.na(AESOC)",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      group_by = list(list(AESOC = c())),
      stratify_by = list(c("RACE")),
      stat_by_strata_by_trt = list(n_sub, n_subev), # need renaming to conform with chefStats
      endpoint_label = "AESOC: <AESOC>"
    )

  ep <- add_id(ep)

  ep_fn_map <-
    suppressWarnings(unnest_endpoint_functions(ep))
  user_def_fn <-
    mk_userdef_fn_dt(ep_fn_map, env = environment())

  fn_map <-
    merge(ep_fn_map[, .(endpoint_spec_id, fn_hash)], user_def_fn, by = "fn_hash")

  adam_db <-
    fetch_db_data(
      study_metadata = ep$study_metadata[[1]],
      fn_dt = user_def_fn
    )

  ep_and_data <- filter_db_data(ep, ep_fn_map, adam_db)
  ep_data_key <- ep_and_data$ep
  analysis_data_container <- ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)

  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)

  ep_crit_endpoint <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)
  ep_crit_by_strata_by_trt <-
    apply_criterion_by_strata(ep_crit_endpoint, analysis_data_container, fn_map)
  ep_crit_by_strata_across_trt <-
    apply_criterion_by_strata(ep_crit_by_strata_by_trt,
                              analysis_data_container,
                              fn_map,
                              type = "by_strata_across_trt"
    )

  ##
  ep_crit_by_strata_across_trt <- ep_crit_by_strata_across_trt[grepl("SURGICAL AND MEDICAL PROCEDURES", endpoint_group_filter)]#  & strata_var != "TOTAL_"]
  ep_crit_by_strata_across_trt[["only_explicit_strata"]] <- TRUE
  ##

  ep_prep_by_strata_by_trt <-
    prepare_for_stats(ep_crit_by_strata_across_trt,
                      analysis_data_container,
                      fn_map,
                      type = "stat_by_strata_by_trt")

  # Check actual strata for metabolism
  dt1 <- unique(analysis_data_container[["dat"]][[1]][,c("AESOC","AEDECOD")])
  nrow(dt1)
  table(dt1[["AESOC"]])
  dt2 <- analysis_data_container[["dat"]][[1]][AESOC == "Metabolism and nutrition disorders"]
  unique(dt2[["AEDECOD"]])
  length(unique(dt2[["AEDECOD"]]))

  # Look at pipeline expansion on metabolism
  ep_prep_by_strata_by_trt[, index := mapply(intersect, event_index, cell_index)]
  dt3 <- ep_prep_by_strata_by_trt[fn_name == "chefStats::n_event",c("index","event_index", "cell_index","endpoint_group_filter", "strata_var", "stat_filter", "fn_name")]
  View(dt3)
  View(dt3[lengths(index) != 0,])

  ep_prep_by_strata_across_trt <-
    prepare_for_stats(ep_crit_by_strata_across_trt,
                      analysis_data_container,
                      fn_map,
                      type = "stat_by_strata_across_trt")

  ep_prep_across_strata_across_trt <-
    prepare_for_stats(ep_crit_by_strata_across_trt,
                      analysis_data_container,
                      fn_map,
                      type = "stat_across_strata_across_trt")

  ep_stat_by_strata_by_trt <-
    apply_stats(ep_prep_by_strata_by_trt, analysis_data_container, type = "stat_by_strata_by_trt")
  ep_stat_by_strata_across_trt <-
    apply_stats(ep_prep_by_strata_across_trt, analysis_data_container, type = "stat_by_strata_across_trt")
  ep_stat_across_strata_across_trt <-
    apply_stats(ep_prep_across_strata_across_trt,
                analysis_data_container,
                type = "stat_across_strata_across_trt")

  ep_stat <-
    rbind(ep_stat_by_strata_by_trt,
          ep_stat_by_strata_across_trt,
          ep_stat_across_strata_across_trt) %>%
    tidyr::unnest(cols = stat_result, names_sep = "_") %>%
    as.data.table()


})
