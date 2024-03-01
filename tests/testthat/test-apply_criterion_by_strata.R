test_that("Complete definition of sgd and sga critaria in ep", {
  # SETUP -------------------------------------------------------------------

  crit_sgd_dummy <-
    function(dat,
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
      ifelse(strata_var %in% c("TOTAL_", "SEX"), TRUE, FALSE)
    }

  crit_sga_dummy <-
    function(dat,
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
      ifelse(strata_var %in% c("SEX", "AGEGR1"), TRUE, FALSE)
    }

  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX", "AGEGR1")),
    data_prepare = mk_adcm,
    crit_by_strata_by_trt = list(crit_sgd_dummy),
    crit_by_strata_across_trt = list(crit_sga_dummy)
  )
  ep <- add_id(ep)
  ep_fn_map <-
    suppressWarnings(unnest_endpoint_functions(ep))
  user_def_fn <-
    mk_userdef_fn_dt(ep_fn_map, env = environment())
  fn_map <-
    merge(ep_fn_map[, .(endpoint_spec_id, fn_hash)], user_def_fn, by = "fn_hash")
  adam_db <-
    fetch_db_data(study_metadata = list(), fn_dt = user_def_fn)

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


  # ACT ---------------------------------------------------------------------

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

  # EXPECT ------------------------------------------------------------------

  # Check number of rows
  expect_equal(nrow(crit_accept_by_strata_by_trt), 3)
  expect_equal(nrow(crit_accept_by_strata_across_trt), 3)

  # Check set of added columns
  expect_equal(
    setdiff(
      names(crit_accept_by_strata_by_trt),
      names(ep_crit_endpoint)
    ),
    c("strata_var", "strata_id", "crit_accept_by_strata_by_trt")
  )
  expect_equal(setdiff(
    names(crit_accept_by_strata_by_trt),
    names(crit_accept_by_strata_across_trt)
  ), character(0))
  expect_equal(
    setdiff(
      names(crit_accept_by_strata_across_trt),
      names(crit_accept_by_strata_by_trt)
    ),
    "crit_accept_by_strata_across_trt"
  )

  # Check data consistency
  expect_equal(
    crit_accept_by_strata_by_trt[["strata_id"]],
    crit_accept_by_strata_across_trt[["strata_id"]]
  )
  expect_equal(
    crit_accept_by_strata_by_trt[["crit_accept_by_strata_by_trt"]],
    crit_accept_by_strata_across_trt[["crit_accept_by_strata_by_trt"]]
  )

  # Check column types
  expect_equal(typeof(crit_accept_by_strata_across_trt[["strata_id"]]), "character")
  expect_equal(typeof(crit_accept_by_strata_across_trt[["crit_accept_by_strata_by_trt"]]), "logical")
  expect_equal(typeof(crit_accept_by_strata_across_trt[["crit_accept_by_strata_across_trt"]]), "logical")

  # Check criteria evaluation
  expect_true(crit_accept_by_strata_by_trt[strata_var == "SEX"][["crit_accept_by_strata_by_trt"]])
  expect_true(crit_accept_by_strata_by_trt[strata_var == "TOTAL_"][["crit_accept_by_strata_by_trt"]])
  expect_false(crit_accept_by_strata_by_trt[strata_var == "AGEGR1"][["crit_accept_by_strata_by_trt"]])
  expect_false(crit_accept_by_strata_across_trt[strata_var == "AGEGR1"][["crit_accept_by_strata_across_trt"]])
  expect_true(crit_accept_by_strata_across_trt[strata_var == "SEX"][["crit_accept_by_strata_across_trt"]])
  expect_true(crit_accept_by_strata_across_trt[strata_var == "TOTAL_"][["crit_accept_by_strata_across_trt"]])

  # Check uniqueness of id column
  expect_equal(any(duplicated(crit_accept_by_strata_by_trt[["strata_id"]])), FALSE)
})

test_that("Multiple eps", {
  # SETUP -------------------------------------------------------------------

  crit_sgd_dummy <-
    function(dat,
             event_index,
             treatment_var,
             treatment_refval,
             period_var,
             period_value,
             endpoint_filter,
             endpoint_group_metadata,
             stratify_by,
             strata_var,
             subjectid_var) {
      ifelse(strata_var %in% c("AGEGR1", "RACE"), TRUE, FALSE)
    }

  crit_sga_dummy <-
    function(dat,
             event_index,
             treatment_var,
             treatment_refval,
             period_var,
             period_value,
             endpoint_filter,
             endpoint_group_metadata,
             stratify_by,
             strata_var,
             subjectid_var) {
      ifelse(strata_var == "RACE", TRUE, FALSE)
    }

  ep1 <- mk_ep_0001_base(
    stratify_by = list(c("SEX", "AGEGR1")),
    data_prepare = mk_adcm,
    crit_by_strata_by_trt = list(crit_sgd_dummy),
    crit_by_strata_across_trt = list(crit_sga_dummy)
  )
  ep2 <- mk_ep_0001_base(
    stratify_by = list(c("RACE")),
    data_prepare = mk_adcm,
    crit_by_strata_by_trt = list(crit_sgd_dummy),
    crit_by_strata_across_trt = list(crit_sga_dummy)
  )
  ep <- rbind(ep1, ep2)
  ep <- add_id(ep)
  ep_fn_map <-
    suppressWarnings(unnest_endpoint_functions(ep))
  user_def_fn <-
    mk_userdef_fn_dt(ep_fn_map, env = environment())
  fn_map <-
    merge(ep_fn_map[, .(endpoint_spec_id, fn_hash)], user_def_fn, by = "fn_hash")
  adam_db <-
    fetch_db_data(study_metadata = list(), fn_dt = user_def_fn)
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


  # ACT ---------------------------------------------------------------------
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

  # EXPECT ------------------------------------------------------------------

  # Check number of rows
  expect_equal(nrow(crit_accept_by_strata_by_trt), 5)
  expect_equal(nrow(crit_accept_by_strata_across_trt), 5)

  # Check set of added columns
  expect_equal(
    setdiff(
      names(crit_accept_by_strata_by_trt),
      names(ep_crit_endpoint)
    ),
    c("strata_var", "strata_id", "crit_accept_by_strata_by_trt")
  )
  expect_equal(setdiff(
    names(crit_accept_by_strata_by_trt),
    names(crit_accept_by_strata_across_trt)
  ), character(0))
  expect_equal(
    setdiff(
      names(crit_accept_by_strata_across_trt),
      names(crit_accept_by_strata_by_trt)
    ),
    "crit_accept_by_strata_across_trt"
  )

  # Check data consistency
  expect_equal(
    crit_accept_by_strata_by_trt[["strata_id"]],
    crit_accept_by_strata_across_trt[["strata_id"]]
  )
  expect_equal(
    crit_accept_by_strata_by_trt[["crit_accept_by_strata_by_trt"]],
    crit_accept_by_strata_across_trt[["crit_accept_by_strata_by_trt"]]
  )

  # Check column types
  expect_equal(typeof(crit_accept_by_strata_across_trt[["strata_id"]]), "character")
  expect_equal(typeof(crit_accept_by_strata_across_trt[["crit_accept_by_strata_by_trt"]]), "logical")
  expect_equal(typeof(crit_accept_by_strata_across_trt[["crit_accept_by_strata_across_trt"]]), "logical")

  # Check criteria evaluation
  expect_false(crit_accept_by_strata_by_trt[strata_var == "SEX"][["crit_accept_by_strata_by_trt"]])
  expect_true(any(crit_accept_by_strata_by_trt[strata_var == "TOTAL_"][["crit_accept_by_strata_by_trt"]]))
  expect_true(crit_accept_by_strata_by_trt[strata_var == "AGEGR1"][["crit_accept_by_strata_by_trt"]])
  expect_true(crit_accept_by_strata_by_trt[strata_var == "RACE"][["crit_accept_by_strata_by_trt"]])
  expect_true(crit_accept_by_strata_across_trt[strata_var == "RACE"][["crit_accept_by_strata_across_trt"]])
  expect_equal(
    crit_accept_by_strata_by_trt[["crit_accept_by_strata_by_trt"]],
    crit_accept_by_strata_across_trt[["crit_accept_by_strata_by_trt"]]
  )

  # Check uniqueness of id column
  expect_equal(any(duplicated(crit_accept_by_strata_by_trt[["strata_id"]])), FALSE)
})


test_that("Invalid inputs", {
  # SETUP -------------------------------------------------------------------

  crit_sgd_dummy <-
    function(dat,
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
      TRUE
    }

  crit_sga_dummy <-
    function(dat,
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
      FALSE
    }

  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX", "AGEGR1")),
    data_prepare = mk_adcm,
    crit_by_strata_by_trt = list(crit_sgd_dummy),
    crit_by_strata_across_trt = list(crit_sga_dummy)
  )
  ep <- add_id(ep)
  ep_fn_map <-
    suppressWarnings(unnest_endpoint_functions(ep))
  user_def_fn <-
    mk_userdef_fn_dt(ep_fn_map, env = environment())
  fn_map <-
    merge(ep_fn_map[, .(endpoint_spec_id, fn_hash)], user_def_fn, by = "fn_hash")
  adam_db <-
    fetch_db_data(study_metadata = list(), fn_dt = user_def_fn)
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

  # ACT ---------------------------------------------------------------------

  # EXPECT ------------------------------------------------------------------

  # Throw error when evaluating non-existing criterion type
  expect_error(
    ep_dummy <- apply_criterion_by_strata(ep_crit_endpoint,
      analysis_data_container,
      fn_map,
      type = "criterion_notexist"
    )
  )

  # Throw error when evaluating by_strata_across_trt criterion before sgd criterion
  expect_error(
    apply_criterion_by_strata(ep_crit_endpoint,
      analysis_data_container,
      fn_map,
      type = "crit_by_strata_across_trt"
    )
  )
})


test_that("Rejected endpoints are not expanded", {
  # SETUP -------------------------------------------------------------------

  crit_fn <-
    function(dat,
             event_index,
             treatment_var,
             treatment_refval,
             period_var,
             period_value,
             endpoint_filter,
             endpoint_group_metadata,
             stratify_by,
             strata_var,
             subjectid_var) {
      TRUE
    }

  ep <- data.table(
    endpoint_spec_id = rep(1, 2),
    endpoint_id = 3:4,
    treatment_var = rep("A1", 2),
    treatment_refval = rep("B", 2),
    period_var = NA_character_,
    period_value = NA_character_,
    endpoint_filter = NA_character_,
    endpoint_group_metadata = NA_character_,
    stratify_by = list(c("TOTAL_", "SEX")),
    event_index = list(c(1, 6)),
    crit_accept_endpoint = c(TRUE, FALSE),
    key_analysis_data = rep("A", 2)
  )
  analysis_data_container <-
    data.table(dat = list(data.table()), key_analysis_data = "A") |>
    setkey(key_analysis_data)
  fn_map <-
    data.table(
      fn_hash = "1",
      endpoint_spec_id = 1,
      fn_type = "crit_by_strata_by_trt",
      fn_name = "A",
      fn_call_char = "crit_fn",
      fn_callable = list(crit_fn)
    )

  # ACT ---------------------------------------------------------------------
  actual <-
    apply_criterion_by_strata(ep,
      analysis_data_container,
      fn_map,
      type = "by_strata_by_trt"
    )

  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(actual), 3)
  expect_equal(nrow(actual[endpoint_id == 3]), 2)
  expect_equal(nrow(actual[is.na(strata_var)]), 1)
  expect_equal(nrow(actual[(crit_accept_by_strata_by_trt)]), 2)
  expect_equal(nrow(actual[!(crit_accept_by_strata_by_trt)]), 1)
})

test_that("Rejected endpoints are not expanded when all endpoints are rejected", {
  # SETUP -------------------------------------------------------------------

  crit_fn <-
    function(dat,
             event_index,
             treatment_var,
             treatment_refval,
             period_var,
             period_value,
             endpoint_filter,
             endpoint_group_metadata,
             stratify_by,
             strata_var,
             subjectid_var) {
      TRUE
    }

  ep <- data.table(
    endpoint_spec_id = rep(1, 2),
    endpoint_id = 3:4,
    treatment_var = rep("A1", 2),
    treatment_refval = rep("B", 2),
    period_var = NA_character_,
    period_value = NA_character_,
    endpoint_filter = NA_character_,
    endpoint_group_metadata = NA_character_,
    stratify_by = list(c("TOTAL_", "SEX")),
    event_index = list(c(1, 6)),
    crit_accept_endpoint = c(FALSE, FALSE),
    key_analysis_data = rep("A", 2)
  )
  analysis_data_container <-
    data.table(dat = list(data.table()), key_analysis_data = "A") |>
    setkey(key_analysis_data)
  fn_map <-
    data.table(
      fn_hash = "1",
      endpoint_spec_id = 1,
      fn_type = "crit_by_strata_by_trt",
      fn_name = "A",
      fn_call_char = "crit_fn",
      fn_callable = list(crit_fn)
    )

  # ACT ---------------------------------------------------------------------
  actual <-
    apply_criterion_by_strata(ep,
      analysis_data_container,
      fn_map,
      type = "by_strata_by_trt"
    )

  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(actual), 2)
  expect_equal(nrow(actual[endpoint_id == 3]), 1)
  expect_equal(nrow(actual[is.na(strata_var)]), 2)
  expect_false(any(actual$crit_accept_by_strata_by_trt))
})


test_that("strata_var remains a character variable when some endpoint have been rejected", {
  # SETUP -------------------------------------------------------------------

  crit_fn <-
    function(dat,
             event_index,
             treatment_var,
             treatment_refval,
             period_var,
             period_value,
             endpoint_filter,
             endpoint_group_metadata,
             stratify_by,
             strata_var,
             subjectid_var) {
      TRUE
    }

  ep <- data.table(
    endpoint_spec_id = rep(1, 3),
    endpoint_id = 1:3,
    treatment_var = rep("A1", 3),
    treatment_refval = rep("B", 3),
    period_var = NA_character_,
    period_value = NA_character_,
    endpoint_filter = NA_character_,
    endpoint_group_metadata = NA_character_,
    stratify_by = list(c("TOTAL_", "SEX")),
    event_index = list(c(1, 6)),
    crit_accept_endpoint = c(FALSE, FALSE, TRUE),
    key_analysis_data = rep("A", 3)
  )
  analysis_data_container <-
    data.table(dat = list(data.table()), key_analysis_data = "A") |>
    setkey(key_analysis_data)
  fn_map <-
    data.table(
      fn_hash = "1",
      endpoint_spec_id = 1,
      fn_type = "crit_by_strata_by_trt",
      fn_name = "A",
      fn_call_char = "crit_fn",
      fn_callable = list(crit_fn)
    )

  # ACT ---------------------------------------------------------------------
  actual <-
    apply_criterion_by_strata(ep,
                              analysis_data_container,
                              fn_map,
                              type = "by_strata_by_trt"
    )

  # EXPECT ------------------------------------------------------------------

  # Check that expandsion is correct
  expect_equal(nrow(actual), 4)
  expect_equal(nrow(actual[endpoint_id == 1]), 1)
  expect_equal(nrow(actual[endpoint_id == 3]), 2)
  expect_equal(nrow(actual[is.na(strata_var)]), 2)

  # Check that the column type is correct
  expect_equal(typeof(actual[["strata_var"]]), "character")

})
