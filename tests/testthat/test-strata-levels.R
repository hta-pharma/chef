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
      stat_by_strata_across_trt = list(n_subev),
      endpoint_label = "AESOC: <AESOC>",
      only_strata_with_events = TRUE
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
  # ep_crit_by_strata_across_trt <- ep_crit_by_strata_across_trt[grepl("SURGICAL AND MEDICAL PROCEDURES", endpoint_group_filter)]#  & strata_var != "TOTAL_"]
  # ep_crit_by_strata_across_trt[["only_strata_with_events"]] <- T
  ##

  ep_prep_by_strata_by_trt <-
    prepare_for_stats(ep_crit_by_strata_across_trt,
                      analysis_data_container,
                      fn_map,
                      type = "stat_by_strata_by_trt")

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
