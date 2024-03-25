test_that("base case: add_event_index works", {
  # SETUP -------------------------------------------------------------------
  ep <- data.table(
    pop_var = "SAFFL",
    pop_value = "Y",
    treatment_var = "TRT01A",
    treatment_refval = "Xanomeline High Dose",
    period_var = NA_character_,
    period_value = NA_character_,
    endpoint_id = 1,
    endpoint_filter = NA,
    endpoint_group_filter = NA,
    custom_pop_filter = NA,
    key_analysis_data = "a"
  )
  dat <- data.table(
    dat = list(mk_adae() %>% .[, "INDEX_" := .I]),
    key_analysis_data = "a"
  )
  setkey(ep, key_analysis_data)
  setkey(dat, key_analysis_data)
  # ACT ---------------------------------------------------------------------
  actual <- add_event_index(ep = ep, analysis_data_container = dat)
  # EXPECT ------------------------------------------------------------------
  expect_equal(actual$event_index[[1]], dat$dat[[1]][SAFFL == "Y"][["INDEX_"]])
})



test_that("add_event_index works with period_var", {
  # SETUP -------------------------------------------------------------------
  ep <- data.table(
    pop_var = "SAFFL",
    pop_value = "Y",
    treatment_var = "TRT01A",
    treatment_refval = "Xanomeline High Dose",
    period_var = "ANL01FL",
    period_value = "Y",
    endpoint_id = 1,
    endpoint_filter = NA,
    endpoint_group_filter = NA,
    custom_pop_filter = NA,
    key_analysis_data = "a"
  )
  dat <- data.table(
    dat = list(mk_adcm() %>% .[, "INDEX_" := .I]),
    key_analysis_data = "a"
  )
  setkey(ep, key_analysis_data)
  setkey(dat, key_analysis_data)
  # ACT ---------------------------------------------------------------------
  actual <- add_event_index(ep = ep, analysis_data_container = dat)
  # EXPECT ------------------------------------------------------------------
  expect_equal(actual$event_index[[1]], dat$dat[[1]][SAFFL == "Y" &
    ANL01FL == "Y"][["INDEX_"]])
})


test_that("add_event_index works over multiple rows in ep with custom filter", {
  # SETUP -------------------------------------------------------------------
  ep <- data.table(
    pop_var = "SAFFL",
    pop_value = "Y",
    treatment_var = "TRT01A",
    treatment_refval = "Xanomeline High Dose",
    period_var = NA_character_,
    period_value = NA_character_,
    endpoint_id = 1,
    endpoint_filter = NA,
    endpoint_group_filter = NA,
    custom_pop_filter = "AGE >70",
    dat = list(mk_adcm() %>% .[, "INDEX_" := .I]),
    key_analysis_data = "a"
  )
  dat <- data.table(
    dat = list(mk_adcm() %>% .[, "INDEX_" := .I]),
    key_analysis_data = "a"
  )

  setkey(dat, key_analysis_data)
  ep <- rbindlist(list(ep, ep))
  setkey(ep, key_analysis_data)
  ep[2, `:=`(custom_pop_filter = "AGE <=70", endpoint_id = 2)]

  # ACT ---------------------------------------------------------------------
  actual <- add_event_index(ep = ep, dat)

  # EXPECT ------------------------------------------------------------------

  expect_equal(actual$event_index[[1]], dat$dat[[1]][SAFFL == "Y" &
    AGE > 70][["INDEX_"]])
  expect_equal(actual$event_index[[2]], dat$dat[[1]][SAFFL == "Y" &
    AGE <= 70][["INDEX_"]])
})


test_that("add_event_index works over expanded endpoints", {
  # SETUP -------------------------------------------------------------------
  testr::skip_on_devops()
  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX")),
    data_prepare = mk_adcm,
    group_by = list(list(CMCLAS = c()))
  )
  ep <- add_id(ep)
  ep_fn_map <- suppressWarnings(unnest_endpoint_functions(ep))
  user_def_fn <- mk_userdef_fn_dt(ep_fn_map, env = environment())
  fn_map <-
    merge(ep_fn_map[, .(endpoint_spec_id, fn_hash)], user_def_fn, by = "fn_hash")
  adam_db <-
    fetch_db_data(
      study_metadata = list(),
      fn_dt = user_def_fn
    )
  ep_and_data <- filter_db_data(ep, ep_fn_map, adam_db)
  ep_expanded <-
    expand_over_endpoints(ep = ep_and_data$ep, ep_and_data$analysis_data_container)

  # ACT ---------------------------------------------------------------------
  actual <-
    add_event_index(ep_expanded, ep_and_data$analysis_data_container)

  # EXPECT ------------------------------------------------------------------
  for (i in 1:nrow(actual)) {
    expect_equal(
      actual$event_index[[i]],
      ep_and_data$analysis_data_container$dat[[1]][SAFFL == "Y" &
        eval(parse(
          text =
            actual$endpoint_group_filter[[i]]
        ))][["INDEX_"]]
    )
  }
})


test_that("add_event_index works over expanded endpoints with endpoint filter", {
  # SETUP -------------------------------------------------------------------
  testr::skip_on_devops()
  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX")),
    data_prepare = mk_adcm,
    endpoint_filter = 'RACE %in% c("BLACK OR AFRICAN AMERICAN", "WHITE")',
    group_by = list(list(CMCLAS = c()))
  )
  ep <- add_id(ep)
  ep_fn_map <- suppressWarnings(unnest_endpoint_functions(ep))
  user_def_fn <- mk_userdef_fn_dt(ep_fn_map, env = environment())
  fn_map <-
    merge(ep_fn_map[, .(endpoint_spec_id, fn_hash)], user_def_fn, by = "fn_hash")
  adam_db <-
    fetch_db_data(
      study_metadata = list(),
      fn_dt = user_def_fn
    )
  ep_and_data <- filter_db_data(ep, ep_fn_map, adam_db)
  ep_expanded <-
    expand_over_endpoints(ep = ep_and_data$ep, ep_and_data$analysis_data_container)

  # ACT ---------------------------------------------------------------------
  actual <-
    add_event_index(ep_expanded, ep_and_data$analysis_data_container)

  # EXPECT ------------------------------------------------------------------
  for (i in 1:nrow(actual)) {
    expect_equal(
      actual$event_index[[i]],
      ep_and_data$analysis_data_container$dat[[1]][SAFFL == "Y" &
        RACE %in% c("BLACK OR AFRICAN AMERICAN", "WHITE") &
        eval(parse(
          text =
            actual$endpoint_group_filter[[i]]
        ))][["INDEX_"]]
    )
  }
})
