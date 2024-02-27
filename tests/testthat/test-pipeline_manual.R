test_that("Manual pipeline works", {
  testr::skip_on_devops()

  crit_endpoint <- function(dat,
                            event_index,
                            treatment_var,
                            treatment_refval,
                            period_var,
                            period_value,
                            endpoint_filter,
                            endpoint_group_metadata,
                            stratify_by,
                            subjectid_var,
                            ...) {
    return(T)
  }
  crit_sgd <- function(dat,
                       event_index,
                       treatment_var,
                       treatment_refval,
                       period_var,
                       period_value,
                       endpoint_filter,
                       endpoint_group_metadata,
                       stratify_by,
                       strata_var,
                       subjectid_var,
                       ...) {
    return(T)
  }
  crit_sga <- function(dat,
                       event_index,
                       treatment_var,
                       treatment_refval,
                       period_var,
                       period_value,
                       endpoint_filter,
                       endpoint_group_metadata,
                       stratify_by,
                       strata_var,
                       subjectid_var,
                       ...) {
    return(T)
  }

  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX")),
    data_prepare = mk_adcm,
    custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
    endpoint_label = "Example: <pop_var> - <treatment_var> on <RACE>",
    group_by = list(list(RACE = c())),
    stat_by_strata_by_trt = list(
      "n_subev" = n_subev,
      c("p_subev" = p_subev, a="USUBJID")
    ),
    stat_by_strata_across_trt = list("n_subev_trt_diff" = n_subev_trt_diff),
    stat_across_strata_across_trt = list("P-interaction" = contingency2x2_strata_test),
    crit_endpoint = list(crit_endpoint),
    crit_by_strata_by_trt = list(crit_sgd),
    crit_by_strata_across_trt = list(crit_sga)
  )

  study_metadata <- list()
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

  ep_prep_by_strata_by_trt <-
    prepare_for_stats(ep_crit_by_strata_across_trt,
      analysis_data_container,
      fn_map,
      type = "stat_by_strata_by_trt"
    )


  ep_prep_by_strata_across_trt <-
    prepare_for_stats(ep_crit_by_strata_across_trt,
      analysis_data_container,
      fn_map,
      type = "stat_by_strata_across_trt"
    )

  ep_prep_across_strata_across_trt <-
    prepare_for_stats(ep_crit_by_strata_across_trt,
      analysis_data_container,
      fn_map,
      type = "stat_across_strata_across_trt"
    )

  ep_stat_by_strata_by_trt <-
    apply_stats(ep_prep_by_strata_by_trt, analysis_data_container, type = "stat_by_strata_by_trt")
  ep_stat_by_strata_across_trt <-
    apply_stats(ep_prep_by_strata_across_trt,
      analysis_data_container,
      type = "stat_by_strata_across_trt"
    )
  ep_stat_across_strata_across_trt <-
    apply_stats(ep_prep_across_strata_across_trt,
      analysis_data_container,
      type = "stat_across_strata_across_trt"
    )

  ep_stat_eval <-
    rbind(
      ep_stat_by_strata_by_trt,
      ep_stat_by_strata_across_trt,
      ep_stat_across_strata_across_trt
    ) |>
    tidyr::unnest(cols = stat_result, names_sep = "_") |>
    as.data.table()

  ep_stat <- rbind(ep_stat_eval, ep_crit_by_strata_across_trt[!(crit_accept_endpoint)],
                   fill = TRUE) |>
    setorder(endpoint_id, stat_result_id, stat_result_label)

  expect_equal(nrow(ep_stat), 54)
})
