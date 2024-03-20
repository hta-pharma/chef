test_that("grp level criterion works", {
  # SETUP -------------------------------------------------------------------
  ep <- rbind(
    mk_ep_0001_waiting_grps(
      data_prepare = mk_adcm,
      group_by = list(list(CMCLAS = c())),
      endpoint_label = "a"
    )
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


  # ACT ---------------------------------------------------------------------
  actual <-
    expand_over_endpoints(
      ep = ep_and_data$ep,
      analysis_data_container = ep_and_data$analysis_data_container
    )
  # EXPECT ------------------------------------------------------------------
  expected_values <-
    ep_and_data$analysis_data_container$dat[[1]][!is.na(CMCLAS)]$CMCLAS |> unique()
  expect_equal(nrow(actual), length(expected_values))
})


test_that("grp level works when only 1 level available in the data", {
  # SETUP -------------------------------------------------------------------
  ep <- rbind(
    mk_ep_0001_waiting_grps(
      data_prepare = mk_adcm,
      group_by = list(list(CMCLAS = c("UNCODED"))),
      endpoint_label = "b"
    )
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


  # ACT ---------------------------------------------------------------------
  actual <-
    expand_over_endpoints(
      ep = ep_and_data$ep,
      analysis_data_container = ep_and_data$analysis_data_container
    )

  # EXPECT ------------------------------------------------------------------

  expected_valued <-
    ep_and_data$analysis_data_container$dat[[1]]$CMCLAS |> unique()
  expect_equal(nrow(actual), 1)
  expect_true(grepl("UNCODED", actual$endpoint_group_filter))
})


test_that("grp level criterion works when group across multiple variables", {
  # SETUP -------------------------------------------------------------------
  ep <- rbind(
    mk_ep_0001_waiting_grps(
      data_prepare = mk_adcm,
      group_by = list(list(
        CMCLAS = c("UNCODED"), RACEGR1 = c()
      )),
      endpoint_label = "c"
    )
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

  # ACT ---------------------------------------------------------------------
  actual <-
    expand_over_endpoints(
      ep = ep_and_data$ep,
      analysis_data_container = ep_and_data$analysis_data_container
    )


  # EXPECT ------------------------------------------------------------------
  expected <-
    ep_and_data$analysis_data_container$dat[[1]]$RACEGR1 |>
    unique() |>
    length()
  expect_equal(NROW(actual), expected)
})


test_that("grp level criterion works when group_by is empty", {
  # SETUP -------------------------------------------------------------------
  ep <- rbind(
    mk_ep_0001_waiting_grps(
      data_prepare = mk_adcm,
      endpoint_label = "e"
    ),
    mk_ep_0001_waiting_grps(
      data_prepare = mk_adcm,
      group_by = list(list(CMCLAS = c())),
      endpoint_label = "f"
    )
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


  # ACT ---------------------------------------------------------------------

  actual <-
    expand_over_endpoints(
      ep = ep_and_data$ep,
      analysis_data_container = ep_and_data$analysis_data_container
    )

  # EXPECT ------------------------------------------------------------------

  expected <-
    ep_and_data$analysis_data_container$dat[[1]]$CMCLAS |>
    unique() |>
    length()

  expect_equal(nrow(actual), expected)
  expect_equal(nrow(actual[is.na(endpoint_group_filter)]), 1)
  expect_equal(actual[is.na(endpoint_group_filter), endpoint_id], "1-0001")
})


test_that("dynamic endpoint labels", {
  # SETUP -------------------------------------------------------------------
  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX")),
    data_prepare = mk_adcm,
    custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
    group_by = list(list(CMCLAS = c(
      "UNCODED", "NERVOUS SYSTEM"
    ))),
    endpoint_filter = "AGEGR1 == '18-64'",
    endpoint_label = "<pop_var> - <treatment_var> - <CMCLAS> - <endpoint_filter>",
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


  # ACT ---------------------------------------------------------------------
  actual <-
    expand_over_endpoints(
      ep = ep_and_data$ep,
      analysis_data_container = ep_and_data$analysis_data_container
    )


  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(actual), 2)
  expect_equal(
    actual$endpoint_label,
    c(
      "SAFFL - TRT01A - UNCODED - AGEGR1 == '18-64'",
      "SAFFL - TRT01A - NERVOUS SYSTEM - AGEGR1 == '18-64'"
    )
  )
})
