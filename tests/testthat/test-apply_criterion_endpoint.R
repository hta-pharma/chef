test_that("base endpoint crit works", {
  # SETUP -------------------------------------------------------------------
  crit_endpoint <- function(dat,
                            event_index,
                            treatment_var,
                            treatment_refval,
                            period_var,
                            period_value,
                            endpoint_filter,
                            endpoint_group_metadata,
                            stratify_by,
                            subjectid_var) {
    return(F)
  }
  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX", "AGEGR2")),
    data_prepare = mk_adcm,
    crit_endpoint = list(crit_endpoint),
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
  analysis_data_container <- ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)

  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)

  # ACT ---------------------------------------------------------------------
  actual <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)
  # EXPECT ------------------------------------------------------------------
  expect_false(actual$crit_accept_endpoint)
  expect_equal(nrow(actual), nrow(ep))
})

test_that("base endpoint crit works with multiple endpoints", {
  # SETUP -------------------------------------------------------------------
  crit_endpoint <- function(dat,
                            event_index,
                            treatment_var,
                            treatment_refval,
                            period_var,
                            period_value,
                            endpoint_filter,
                            endpoint_group_metadata,
                            stratify_by,
                            subjectid_var) {
    return(F)
  }
  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX", "AGEGR2")),
    data_prepare = mk_adcm,
    group_by = list(list(CMROUTE = c())),
    crit_endpoint = list(crit_endpoint),
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

  # ACT ---------------------------------------------------------------------
  actual <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)


  # EXPECT ------------------------------------------------------------------
  expect_false(any(actual$crit_accept_endpoint))
  expect_equal(nrow(actual), nrow(ep_ev_index))
})


test_that("base endpoint crit works with naked function", {
  # SETUP -------------------------------------------------------------------
  crit_endpoint <- function(dat,
                            event_index,
                            treatment_var,
                            treatment_refval,
                            period_var,
                            period_value,
                            endpoint_filter,
                            endpoint_group_metadata,
                            stratify_by,
                            subjectid_var) {
    return(F)
  }
  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX", "AGEGR2")),
    data_prepare = mk_adcm,
    crit_endpoint = crit_endpoint,
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

  # ACT ---------------------------------------------------------------------
  actual <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)


  # EXPECT ------------------------------------------------------------------
  expect_false(actual$crit_accept_endpoint)
  expect_equal(nrow(actual), nrow(ep_ev_index))
})


test_that("crit fn has access to correct data from chef", {
  # SETUP -------------------------------------------------------------------


  # This is a weird one -> the expectations are actually embedded in
  # the crit_endpoint function. If it fails, put a browser inside the
  # crit_endpoint() to see what failed.

  crit_endpoint <- function(dat,
                            event_index,
                            treatment_var,
                            treatment_refval,
                            period_var,
                            period_value,
                            endpoint_filter,
                            endpoint_group_metadata,
                            stratify_by,
                            subjectid_var) {
    out <- all(
      nrow(dat) == 7535,
      # Same as nrows in filter adam data,
      inherits(event_index, "integer"),
      is.na(endpoint_group_metadata),
      treatment_var == "TRT01A"
    )
    return(out)
  }
  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX", "AGEGR2")),
    data_prepare = mk_adcm,
    crit_endpoint = list(crit_endpoint)
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
  analysis_data_container <- ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)

  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)


  # ACT ---------------------------------------------------------------------
  actual <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)


  # EXPECT ------------------------------------------------------------------
  expect_true(actual$crit_accept_endpoint, label = "If this fails, check expectations inside crit_endpoint function")
})

test_that("error when crit fn does not return a logical value", {
  # SETUP -------------------------------------------------------------------
  crit_endpoint <- function(dat,
                            event_index,
                            treatment_var,
                            treatment_refval,
                            period_var,
                            period_value,
                            endpoint_filter,
                            endpoint_group_metadata,
                            stratify_by,
                            subjectid_var) {
    return(NA)
  }
  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX", "AGEGR2")),
    data_prepare = mk_adcm,
    crit_endpoint = list(crit_endpoint),
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
  analysis_data_container <- ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)

  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)

  # ACT ---------------------------------------------------------------------

  # EXPECT ------------------------------------------------------------------
  expect_error(apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map),
    regexp = "The return value from the endpoint criterion function"
  )
})
