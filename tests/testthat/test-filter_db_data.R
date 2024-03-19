test_that("base case: filter_db_data works with pop filter and no custom filter", {
  # SETUP -------------------------------------------------------------------

  adam <- mk_adcm() %>% .[, "INDEX_" := .I]
  pop_var <- "SAFFL"
  pop_value <- "Y"
  period_var <- NA_character_
  period_value <- NA_character_
  custom_pop_filter <- NA_character_

  ep <-
    data.table(
      pop_var = pop_var,
      pop_value = pop_value,
      period_var = period_var,
      period_value = period_value,
      custom_pop_filter = custom_pop_filter,
      endpoint_spec_id = 1
    )
  ep_fn_map <-
    data.table(
      endpoint_spec_id = 1,
      fn_type = "data_prepare",
      fn_hash = "a"
    )
  adam_db <-
    data.table(
      fn_type = "data_prepare",
      fn_hash = "a",
      dat = list(adam)
    )

  # ACT ---------------------------------------------------------------------

  actual <- filter_db_data(ep, ep_fn_map, adam_db)$analysis_data_container
  # EXPECT ------------------------------------------------------------------
  expect_equal(actual$dat[[1]], adam[SAFFL == "Y"])
})


test_that("base case: filter_db_data works with both pop filter and custom filter", {
  # SETUP -------------------------------------------------------------------
  adam <- mk_adcm() %>% .[, "INDEX_" := .I]
  pop_var <- "SAFFL"
  pop_value <- "Y"
  period_var <- "ANL01FL"
  period_value <- "Y"
  custom_pop_filter <- "CMSEQ >= 60"

  ep <-
    data.table(
      pop_var = pop_var,
      pop_value = pop_value,
      period_var = period_var,
      period_value = period_value,
      custom_pop_filter = custom_pop_filter,
      endpoint_spec_id = 1
    )
  ep_fn_map <-
    data.table(
      endpoint_spec_id = 1,
      fn_type = "data_prepare",
      fn_hash = "a"
    )
  adam_db <-
    data.table(
      fn_type = "data_prepare",
      fn_hash = "a",
      dat = list(adam)
    )
  # ACT ---------------------------------------------------------------------
  actual <- filter_db_data(ep, ep_fn_map, adam_db)$analysis_data_container

  # EXPECT ------------------------------------------------------------------
  expect_equal(actual$dat[[1]], adam[SAFFL == "Y" & CMSEQ >= 60])
})

test_that(
  "base case: filter_db_data throws error when pop_var or pop_value has not been specified",
  {
    # SETUP -------------------------------------------------------------------

    adam <- mk_adcm() %>% .[, "INDEX_" := .I]
    pop_var <- NULL
    pop_value <- NULL
    period_var <- "ANL01FL"
    period_value <- "Y"
    custom_pop_filter <- "CMSEQ >= 60"

    ep <-
      data.table(
        pop_var = pop_var,
        pop_value = pop_value,
        period_var = period_var,
        period_value = period_value,
        custom_pop_filter = custom_pop_filter,
        endpoint_spec_id = 1
      )
    ep_fn_map <-
      data.table(
        endpoint_spec_id = 1,
        fn_type = "data_prepare",
        fn_hash = "a"
      )
    adam_db <-
      data.table(
        fn_type = "data_prepare",
        fn_hash = "a",
        dat = list(adam)
      )

    # ACT ---------------------------------------------------------------------

    # EXPECT ------------------------------------------------------------------

    expect_error(filter_db_data(ep, ep_fn_map, adam_db))
  }
)


test_that("filter_db_data works with >1 row in ep dataset", {
  # SETUP -------------------------------------------------------------------
  adam <- mk_adcm() %>% .[, "INDEX_" := .I]
  pop_var <- "SAFFL"
  pop_value <- "Y"
  period_var <- "ANL01FL"
  period_value <- "Y"
  custom_pop_filter <- "CMSEQ >= 60"

  ep <-
    data.table(
      pop_var = pop_var,
      pop_value = pop_value,
      period_var = period_var,
      period_value = period_value,
      custom_pop_filter = custom_pop_filter,
      endpoint_spec_id = 1
    )

  ep <- rbind(ep, ep)
  ep[2, custom_pop_filter := "CMSEQ >= 75"]
  ep_fn_map <-
    data.table(
      endpoint_spec_id = 1,
      fn_type = "data_prepare",
      fn_hash = "a"
    )
  adam_db <-
    data.table(
      fn_type = "data_prepare",
      fn_hash = "a",
      dat = list(adam)
    )
  # ACT ---------------------------------------------------------------------
  actual <- filter_db_data(ep, ep_fn_map, adam_db)

  # EXPECT ------------------------------------------------------------------
  expect_equal(actual$analysis_data_container$dat[[1]], adam[SAFFL == "Y" &
    CMSEQ >= 60])
  expect_equal(actual$analysis_data_container$dat[[2]], adam[SAFFL == "Y" &
    CMSEQ >= 75])
})


test_that("data keys are same for same data, different for different data", {
  # SETUP -------------------------------------------------------------------
  adam <- mk_adcm() %>% .[, "INDEX_" := .I]
  pop_var <- "SAFFL"
  pop_value <- "Y"
  period_var <- "ANL01FL"
  period_value <- "Y"
  custom_pop_filter <- "CMSEQ >= 60"

  ep <-
    data.table(
      pop_var = pop_var,
      pop_value = pop_value,
      period_var = period_var,
      period_value = period_value,
      custom_pop_filter = custom_pop_filter,
      endpoint_spec_id = 1
    )

  ep <- rbind(ep, ep, ep)
  ep[2, custom_pop_filter := "CMSEQ >= 75"]
  ep_fn_map <-
    data.table(
      endpoint_spec_id = 1,
      fn_type = "data_prepare",
      fn_hash = "a"
    )
  adam_db <-
    data.table(
      fn_type = "data_prepare",
      fn_hash = "a",
      dat = list(adam)
    )
  # ACT ---------------------------------------------------------------------
  actual <-
    filter_db_data(ep, ep_fn_map, adam_db)
  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(actual$analysis_data_container), 2)
  expect_equal(nrow(actual$ep), 3)
})


test_that("output tables are keyed properly", {
  # SETUP -------------------------------------------------------------------
  adam <- mk_adcm() %>% .[, "INDEX_" := .I]
  pop_var <- "SAFFL"
  pop_value <- "Y"
  period_var <- "ANL01FL"
  period_value <- "Y"
  custom_pop_filter <- "CMSEQ >= 60"

  ep <-
    data.table(
      pop_var = pop_var,
      pop_value = pop_value,
      period_var = period_var,
      period_value = period_value,
      custom_pop_filter = custom_pop_filter,
      endpoint_spec_id = 1
    )

  ep <- rbind(ep, ep, ep)
  ep[2, custom_pop_filter := "CMSEQ >= 75"]
  ep_fn_map <-
    data.table(
      endpoint_spec_id = 1,
      fn_type = "data_prepare",
      fn_hash = "a"
    )
  adam_db <-
    data.table(
      fn_type = "data_prepare",
      fn_hash = "a",
      dat = list(adam)
    )
  # ACT ---------------------------------------------------------------------
  actual <-
    filter_db_data(ep, ep_fn_map, adam_db)
  # EXPECT ------------------------------------------------------------------
  expect_equal(key(actual$analysis_data_container), "key_analysis_data")
  expect_equal(key(actual$ep), "key_analysis_data")
})
