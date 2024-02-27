test_that("Parse_all_user_function works on table with all valid inputs.",
          {
# SETUP -------------------------------------------------------------------
  ep <-  mk_ep_0001_base(
    endpoint_label = "a",
    data_prepare = mk_adae,
  )
  ep <- add_id(ep)
  endpoints_long <-
    suppressWarnings(unnest_endpoint_functions(ep))

  expected_names = c("fn_type",
                     "fn_hash",
                     "fn_name",
                     "fn_call_char",
                     "fn_callable")
  character_columns = c("fn_type", "fn_hash", "fn_name", "fn_call_char")


# ACT ---------------------------------------------------------------------

  function_table <- mk_userdef_fn_dt(endpoints_long)


# EXPECT ------------------------------------------------------------------
  column_types = sapply(function_table, class)

  for (col in character_columns) {
    expect_type(column_types[col], "character")
  }

  for (callable in function_table$fn_callable) {
    expect_type(callable, "closure")
  }

})

test_that("Duplicate functions are collapsed",
          {
# SETUP -------------------------------------------------------------------
  ep <- rbind(
    ep <-  mk_ep_0001_base(
      endpoint_label = "A",
      data_prepare = mk_adae
    ),
    mk_ep_0001_base(
      endpoint_label = "B",
      data_prepare = mk_adae
    )
  )
  ep <- add_id(ep)
  endpoints_long <-
    suppressWarnings(unnest_endpoint_functions(ep))


# ACT ---------------------------------------------------------------------
  function_table <- mk_userdef_fn_dt(endpoints_long)


# EXPECT ------------------------------------------------------------------
  n_unique_fun = length(unique(endpoints_long$fn_hash))

  expect_equal(n_unique_fun, nrow(function_table))

})

test_that("Parse_all_user_function works when additonal args passed to stat methods",
  {
# SETUP -------------------------------------------------------------------
  ep <-
    mk_ep_0001_base(
      endpoint_label = "a",
      data_prepare = mk_adae,
      stat_by_strata_by_trt = list(
        "n_sub" = n_sub,
        "n_subev" = n_subev
      )
    )
  ep <- add_id(ep)
  endpoints_long <-
    suppressWarnings(unnest_endpoint_functions(
      ep
    ))

  expected_names = c("fn_type",
                     "fn_hash",
                     "fn_name",
                     "fn_call_char",
                     "fn_callable")
  character_columns = c("fn_type", "fn_hash", "fn_name", "fn_call_char")

# ACT ---------------------------------------------------------------------
  function_table <- mk_userdef_fn_dt(endpoints_long)


# EXPECT ------------------------------------------------------------------


  column_types = sapply(function_table, class)

  for (col in character_columns) {
    expect_type(column_types[col], "character")
  }

  for (callable in function_table$fn_callable) {
    expect_type(callable, "closure")
  }

})


test_that("Parse_all_user_function works when passed an emptly function slot",
  {

# SETUP -------------------------------------------------------------------
  ep <-  mk_ep_0001_base(endpoint_label = "a",
                         data_prepare = mk_adae,
                         stratify_by = list(c("sex2")),)
  ep <- add_id(ep)
  endpoints_long <-
    suppressWarnings(unnest_endpoint_functions(
      ep,
    ))

  expected_names = c("fn_type",
                     "fn_hash",
                     "fn_name",
                     "fn_call_char",
                     "fn_callable")
  character_columns = c("fn_type", "fn_hash", "fn_name", "fn_call_char")

# ACT ---------------------------------------------------------------------
  function_table <- mk_userdef_fn_dt(endpoints_long)


# EXPECT ------------------------------------------------------------------
  column_types = sapply(function_table, class)

  for (col in character_columns) {
    expect_type(column_types[col], "character")
  }
  for (callable in function_table$fn_callable) {
    expect_type(callable, "closure")
  }
  expect_equal(nrow(function_table), 1)
})
