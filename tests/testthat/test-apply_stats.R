test_that("base: stat_by_strata_by_trt", {
  # SETUP -------------------------------------------------------------------

  skip_on_devops()
  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX")),
    data_prepare = mk_adcm,
    stat_by_strata_by_trt = list(n_sub = n_sub)
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
      study_metadata = list(),
      fn_dt = user_def_fn
    )
  ep_and_data <- filter_db_data(ep, ep_fn_map, adam_db)
  ep_data_key <- ep_and_data$ep
  analysis_data_container <-
    ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)
  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)
  ep_crit_endpoint <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)
  crit_accept_by_strata_by_trt <-
    apply_criterion_by_strata(ep_crit_endpoint,
      analysis_data_container,
      fn_map,
      type = "by_strata_by_trt"
    )
  crit_accept_by_strata_across_trt <-
    apply_criterion_by_strata(crit_accept_by_strata_by_trt,
      analysis_data_container,
      fn_map,
      type = "by_strata_across_trt"
    )

  ep_crit_by_strata_by_trt <- prepare_for_stats(
    crit_accept_by_strata_across_trt,
    analysis_data_container,
    fn_map,
    type = "stat_by_strata_by_trt"
  )

  # ACT ---------------------------------------------------------------------

  actual <-
    apply_stats(ep_crit_by_strata_by_trt,
      analysis_data_container,
      type = "stat_by_strata_by_trt"
    )

  # EXPECT ------------------------------------------------------------------

  expect_equal(nrow(actual), 9)
  expect_equal(setdiff(names(actual), names(ep_crit_by_strata_by_trt)), "stat_result")

  for (i in 1:nrow(actual)) {
    stats <- actual[["stat_result"]][[i]]
    expect_true(is.data.table(stats))
    expect_equal(nrow(stats), 1)
    expect_same_items(names(stats), c("label", "description", "qualifiers", "value"))
  }
})


test_that("validate: by_strata_by_trt returns same value as manual calculation with period flag", {
  # SETUP -------------------------------------------------------------------
  skip_on_devops()
  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX")),
    data_prepare = mk_adcm,
    endpoint_filter = "AOCCPFL=='Y'",
    stat_by_strata_by_trt = list(n_subev = n_subev),
    period_var = "ANL01FL",
    period_value = "Y"
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
      study_metadata = list(),
      fn_dt = user_def_fn
    )
  ep_and_data <- filter_db_data(ep, ep_fn_map, adam_db)
  ep_data_key <- ep_and_data$ep
  analysis_data_container <-
    ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)
  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)
  ep_crit_endpoint <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)
  crit_accept_by_strata_by_trt <-
    apply_criterion_by_strata(ep_crit_endpoint,
      analysis_data_container,
      fn_map,
      type = "by_strata_by_trt"
    )
  crit_accept_by_strata_across_trt <-
    apply_criterion_by_strata(crit_accept_by_strata_by_trt,
      analysis_data_container,
      fn_map,
      type = "by_strata_across_trt"
    )

  ep_crit_by_strata_by_trt <- prepare_for_stats(
    crit_accept_by_strata_across_trt,
    analysis_data_container,
    fn_map,
    type = "stat_by_strata_by_trt"
  )


  # ACT ---------------------------------------------------------------------
  actual <-
    apply_stats(ep_crit_by_strata_by_trt,
      analysis_data_container,
      type = "stat_by_strata_by_trt"
    )

  # EXPECT ------------------------------------------------------------------
  expected_counts <- pharmaverseadam::adcm %>%
    as.data.table() %>%
    .[SAFFL == "Y" & ANL01FL == "Y" & AOCCPFL == "Y"] %>%
    unique(., by = c("SUBJID")) %>%
    .[, .N, by = TRT01A] %>%
    .[["N"]]

  actual_counts <-
    actual[strata_var == "TOTAL_" & fn_name == "n_subev"] %>%
    .[, stat_result] %>%
    rbindlist() %>%
    .[["value"]]

  expect_equal(actual_counts, expected_counts, label = "Event counts match")
})

test_that("by_strata_by_trt returns same value as manual calculation without period flag", {
  # SETUP -------------------------------------------------------------------
  skip_on_devops()
  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX")),
    data_prepare = mk_adcm,
    endpoint_filter = "AOCCPFL=='Y'",
    stat_by_strata_by_trt = list(n_subev = n_subev),
    period_var = "ANL01FL",
    period_value = "Y"
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
      study_metadata = list(),
      fn_dt = user_def_fn
    )
  ep_and_data <- filter_db_data(ep, ep_fn_map, adam_db)
  ep_data_key <- ep_and_data$ep
  analysis_data_container <-
    ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)
  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)
  ep_crit_endpoint <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)
  crit_accept_by_strata_by_trt <-
    apply_criterion_by_strata(ep_crit_endpoint,
      analysis_data_container,
      fn_map,
      type = "by_strata_by_trt"
    )
  crit_accept_by_strata_across_trt <-
    apply_criterion_by_strata(crit_accept_by_strata_by_trt,
      analysis_data_container,
      fn_map,
      type = "by_strata_across_trt"
    )

  ep_crit_by_strata_by_trt <- prepare_for_stats(
    crit_accept_by_strata_across_trt,
    analysis_data_container,
    fn_map,
    type = "stat_by_strata_by_trt"
  )


  # ACT ---------------------------------------------------------------------
  actual <-
    apply_stats(ep_crit_by_strata_by_trt,
      analysis_data_container,
      type = "stat_by_strata_by_trt"
    )

  # EXPECT ------------------------------------------------------------------
  expected_counts <- pharmaverseadam::adcm %>%
    as.data.table() %>%
    .[SAFFL == "Y" & AOCCPFL == "Y"] %>%
    unique(., by = c("SUBJID")) %>%
    .[, .N, by = TRT01A] %>%
    .[["N"]]

  actual_counts <-
    actual[strata_var == "TOTAL_" & fn_name == "n_subev"] %>%
    .[, stat_result] %>%
    rbindlist() %>%
    .[["value"]]

  expect_equal(actual_counts, expected_counts, label = "Event counts match")
})


test_that("validate: n_sub return correct value", {
  # SETUP -------------------------------------------------------------------
  skip_on_devops()
  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX")),
    data_prepare = mk_adcm,
    stat_by_strata_by_trt = list(n_sub = n_sub)
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
      study_metadata = list(),
      fn_dt = user_def_fn
    )
  ep_and_data <- filter_db_data(ep, ep_fn_map, adam_db)
  ep_data_key <- ep_and_data$ep
  analysis_data_container <-
    ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)
  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)
  ep_crit_endpoint <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)
  crit_accept_by_strata_by_trt <-
    apply_criterion_by_strata(ep_crit_endpoint,
      analysis_data_container,
      fn_map,
      type = "by_strata_by_trt"
    )
  crit_accept_by_strata_across_trt <-
    apply_criterion_by_strata(crit_accept_by_strata_by_trt,
      analysis_data_container,
      fn_map,
      type = "by_strata_across_trt"
    )

  ep_crit_by_strata_by_trt <- prepare_for_stats(
    crit_accept_by_strata_across_trt,
    analysis_data_container,
    fn_map,
    type = "stat_by_strata_by_trt"
  )


  # ACT ---------------------------------------------------------------------

  actual <-
    apply_stats(ep_crit_by_strata_by_trt,
      analysis_data_container,
      type = "stat_by_strata_by_trt"
    )

  # EXPECT ------------------------------------------------------------------

  adsl <- pharmaverseadam::adsl |> setDT()
  expected_counts <- adsl[TRT01A == "Placebo" & SAFFL == "Y"] |>
    unique(by = "USUBJID") |>
    nrow()

  actual_counts <-
    actual[strata_var == "TOTAL_" & fn_name == "n_sub"][, stat_result] |>
    rbindlist()


  expect_equal(actual_counts$value[[1]], expected_counts, label = "Event counts match")
})


test_that("apply_stats stat_by_strata_across_trt", {
  # SETUP -------------------------------------------------------------------
  skip_on_devops()

  ep <- mk_ep_0001_base(
    custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
    stratify_by = list(c("SEX")),
    data_prepare = mk_adcm,
    endpoint_filter = "AOCCPFL=='Y'",
    stat_by_strata_across_trt = list(n_subev_trt_diff = n_subev_trt_diff)
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
      study_metadata = list(),
      fn_dt = user_def_fn
    )
  ep_and_data <- filter_db_data(ep, ep_fn_map, adam_db)
  ep_data_key <- ep_and_data$ep
  analysis_data_container <-
    ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)
  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)
  ep_crit_endpoint <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)
  crit_accept_by_strata_by_trt <-
    apply_criterion_by_strata(ep_crit_endpoint,
      analysis_data_container,
      fn_map,
      type = "by_strata_by_trt"
    )
  crit_accept_by_strata_across_trt <-
    apply_criterion_by_strata(crit_accept_by_strata_by_trt,
      analysis_data_container,
      fn_map,
      type = "by_strata_across_trt"
    )

  ep_crit_by_strata_by_trt <- prepare_for_stats(
    crit_accept_by_strata_across_trt,
    analysis_data_container,
    fn_map,
    type = "stat_by_strata_across_trt"
  )

  # ACT ---------------------------------------------------------------------
  actual <-
    apply_stats(
      ep_crit_by_strata_by_trt,
      analysis_data_container,
      type = "stat_by_strata_across_trt"
    )

  # EXPECT ------------------------------------------------------------------

  expect_equal(nrow(actual), 3)
  expect_equal(setdiff(names(actual), names(ep_crit_by_strata_by_trt)), "stat_result")

  for (i in 1:nrow(actual)) {
    stats <- actual[["stat_result"]][[i]]
    expect_true(is.data.table(stats))
    expect_equal(nrow(stats), 1)

    expect_same_items(names(stats), c("label", "description", "qualifiers", "value"))
  }
})


test_that("apply_stats stat_across_strata_across_trt when no across_strata_across_trt fn supplied", {
  # SETUP -------------------------------------------------------------------
  skip_on_devops()
  ep <- mk_endpoint_str(
    study_metadata = list(),
    pop_var = "SAFFL",
    pop_value = "Y",
    treatment_var = "TRT01A",
    treatment_refval = "Xanomeline High Dose",
    period_var = "ANL01FL",
    period_value = "Y",
    stratify_by = list(c("SEX")),
    data_prepare = mk_adcm,
    endpoint_label = "A",
    stat_by_strata_by_trt = list("n_events" = n_subev)
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
      study_metadata = list(),
      fn_dt = user_def_fn
    )
  ep_and_data <- filter_db_data(ep, ep_fn_map, adam_db)
  ep_data_key <- ep_and_data$ep
  analysis_data_container <-
    ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)
  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)
  ep_crit_endpoint <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)
  crit_accept_by_strata_by_trt <-
    apply_criterion_by_strata(ep_crit_endpoint,
      analysis_data_container,
      fn_map,
      type = "by_strata_by_trt"
    )
  crit_accept_by_strata_across_trt <-
    apply_criterion_by_strata(crit_accept_by_strata_by_trt,
      analysis_data_container,
      fn_map,
      type = "by_strata_across_trt"
    )

  ep_crit_by_strata_by_trt <- prepare_for_stats(
    crit_accept_by_strata_across_trt,
    analysis_data_container,
    fn_map,
    type = "stat_across_strata_across_trt"
  )


  # ACT ---------------------------------------------------------------------
  actual <-
    apply_stats(
      ep_crit_by_strata_by_trt,
      analysis_data_container,
      "stat_across_strata_across_trt"
    )

  # EXPECT ------------------------------------------------------------------

  expect_equal(actual, data.table(NULL))
})

test_that("apply_stats: with all FALSE for criteria", {
  # SETUP -------------------------------------------------------------------

  skip_on_devops()

  crit_false <- function(...) FALSE

  ep <- mk_endpoint_str(
    study_metadata = list(),
    pop_var = "SAFFL",
    pop_value = "Y",
    treatment_var = "TRT01A",
    treatment_refval = "Xanomeline High Dose",
    period_var = "ANL01FL",
    period_value = "Y",
    stratify_by = list(c("SEX")),
    data_prepare = mk_adcm,
    endpoint_label = "A",
    stat_by_strata_by_trt = list("n_events" = n_subev),
    crit_by_strata_by_trt = crit_false
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
      study_metadata = list(),
      fn_dt = user_def_fn
    )
  ep_and_data <- filter_db_data(ep, ep_fn_map, adam_db)
  ep_data_key <- ep_and_data$ep
  analysis_data_container <-
    ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)
  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)
  ep_crit_endpoint <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)
  crit_accept_by_strata_by_trt <-
    apply_criterion_by_strata(ep_crit_endpoint,
      analysis_data_container,
      fn_map,
      type = "by_strata_by_trt"
    )
  crit_accept_by_strata_across_trt <-
    apply_criterion_by_strata(crit_accept_by_strata_by_trt,
      analysis_data_container,
      fn_map,
      type = "by_strata_across_trt"
    )

  ep_prep_by_strata_by_trt <- prepare_for_stats(
    crit_accept_by_strata_across_trt,
    analysis_data_container,
    fn_map,
    type = "stat_by_strata_by_trt"
  )

  # ACT ---------------------------------------------------------------------

  actual <-
    apply_stats(ep_prep_by_strata_by_trt,
      analysis_data_container,
      type = "stat_by_strata_by_trt"
    )

  # EXPECT ------------------------------------------------------------------

  expect_equal(
    nrow(actual),
    nrow(ep_prep_by_strata_by_trt)
  )
  expect_true(
    all(unlist(lapply(actual$stat_results, is.null)))
  )
})


test_that("Complex application of stats functions", {
  # SETUP -------------------------------------------------------------------

  # Statistical function across strata and treatment arms (does not make much
  # sense since the stats will invariant to the strata)
  n_sub_total <- function(dat,
                          subjectid_var,
                          ...) {
    stat <- dat %>%
      unique(., by = c(subjectid_var)) %>%
      nrow()

    return(data.table(
      label = "N",
      description = "Number of subjects",
      qualifiers = NA_character_,
      value = stat
    ))
  }

  # Endpoint specification
  ep_spec <- mk_endpoint_str(
    data_prepare = mk_adcm,
    treatment_var = "TRT01A",
    treatment_refval = "Xanomeline High Dose",
    pop_var = "SAFFL",
    pop_value = "Y",
    custom_pop_filter = "TRT01A %in% c('Xanomeline High Dose', 'Placebo')",
    period_var = "ANL01FL",
    period_value = "Y",
    group_by = list(list(CMCLAS = c())),
    stratify_by = list(c("AGEGR2", "SEX")),
    stat_by_strata_by_trt = list(n_subev),
    stat_by_strata_across_trt = list(n_subev),
    stat_across_strata_across_trt = list(n_sub_total),
    endpoint_label = "Test: <CMCLAS> - <treatment_var>"
  )

  study_metadata <- list()
  ep <- add_id(ep_spec)
  ep_fn_map <- suppressWarnings(unnest_endpoint_functions(ep))
  user_def_fn <- mk_userdef_fn_dt(ep_fn_map, env = environment())
  fn_map <- merge(ep_fn_map[, .(endpoint_spec_id, fn_hash)], user_def_fn, by = "fn_hash")
  adam_db <- fetch_db_data(
    study_metadata = ep$study_metadata[[1]],
    fn_dt = user_def_fn
  )
  ep_and_data <- filter_db_data(ep, ep_fn_map, adam_db)
  ep_data_key <- ep_and_data$ep
  analysis_data_container <-
    ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)
  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)
  ep_crit_endpoint <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)
  crit_accept_by_strata_by_trt <-
    apply_criterion_by_strata(ep_crit_endpoint,
      analysis_data_container,
      fn_map,
      type = "by_strata_by_trt"
    )
  crit_accept_by_strata_across_trt <-
    apply_criterion_by_strata(crit_accept_by_strata_by_trt,
      analysis_data_container,
      fn_map,
      type = "by_strata_across_trt"
    )

  ep_prep_by_strata_by_trt <- prepare_for_stats(
    crit_accept_by_strata_across_trt,
    analysis_data_container,
    fn_map,
    type = "stat_by_strata_by_trt"
  )

  ep_prep_by_strata_across_trt <-
    prepare_for_stats(crit_accept_by_strata_across_trt,
      analysis_data_container,
      fn_map,
      type = "stat_by_strata_across_trt"
    )

  ep_prep_across_strata_across_trt <-
    prepare_for_stats(crit_accept_by_strata_across_trt,
      analysis_data_container,
      fn_map,
      type = "stat_across_strata_across_trt"
    )

  # ACT ---------------------------------------------------------------------

  ep_stat_by_strata_by_trt <- apply_stats(ep_prep_by_strata_by_trt,
    analysis_data_container,
    type = "stat_by_strata_by_trt"
  )


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

  ep_stat <-
    rbind(
      ep_stat_by_strata_by_trt,
      ep_stat_by_strata_across_trt,
      ep_stat_across_strata_across_trt
    ) %>%
    tidyr::unnest(cols = stat_result) %>%
    as.data.table()

  # EXPECT ------------------------------------------------------------------

  # Number of statistics
  expect_equal(nrow(ep_stat), 153)
  expect_equal(sum(ep_stat$fn_type == "stat_by_strata_by_trt"), 90)
  expect_equal(sum(ep_stat$fn_type == "stat_by_strata_across_trt"), 45)
  expect_equal(sum(ep_stat$fn_type == "stat_across_strata_across_trt"), 18)

  # stat_by_strata_by_trt statistics
  expect_equal(
    ep_stat[ep_stat$fn_type == "stat_by_strata_by_trt" &
      ep_stat$endpoint_group_filter == 'CMCLAS == "SYSTEMIC HORMONAL PREPARATIONS, EXCL."'][["value"]],
    c(2, 8, 1, 1, 2, 6, 2, 0, 6, 2)
  )
  expect_equal(
    ep_stat[ep_stat$fn_type == "stat_by_strata_by_trt" &
      ep_stat$endpoint_group_filter == 'CMCLAS == "RESPIRATORY SYSTEM"'][["value"]],
    c(1, 1, 0, 1, 1, 0, 0, 1, 0, 1)
  )

  # stat_by_strata_across_trt statistics
  expect_equal(
    ep_stat[ep_stat$fn_type == "stat_by_strata_across_trt" &
      ep_stat$endpoint_group_filter == 'CMCLAS == "SYSTEMIC HORMONAL PREPARATIONS, EXCL."'][["value"]],
    c(10, 3, 7, 8, 2)
  )
  expect_equal(
    ep_stat[ep_stat$fn_type == "stat_by_strata_across_trt" &
      ep_stat$endpoint_group_filter == 'CMCLAS == "RESPIRATORY SYSTEM"'][["value"]],
    c(2, 1, 1, 0, 2)
  )

  # stat_across_strata_across_trt statistics
  expect_true(all(ep_stat[ep_stat$fn_type == "stat_across_strata_across_trt"][["value"]] == 158))
})
