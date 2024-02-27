test_that("Invalid 'type' errors out ", {
  # SETUP -------------------------------------------------------------------


  # ACT ---------------------------------------------------------------------


  # EXPECT ------------------------------------------------------------------
  expect_error(prepare_for_stats(
    ep = data.table(),
    fn_map = data.table(),
    type = "x"
  ),
  regexp = "'arg' should be one of"
  )
})


test_that("Proper stat function mapping when type=stat_by_strata_by_trt", {
  # SETUP -------------------------------------------------------------------

  adam <-
    mk_adcm() %>%
    .[TRT01A %in% c("Placebo", "Xanomeline High Dose")] %>%
    .[, "INDEX_" := .I] %>%
    .[, "TOTAL_" := "total"]
  analysis_data_container <-
    data.table(dat = list(adam), key_analysis_data = "a")
  ep <-
    data.table(
      endpoint_spec_id = "1",
      strata_id = c("1-1", "1-2"),
      treatment_var = "TRT01A",
      strata_var = c("TOTAL_", "SEX"),
      key_analysis_data = "a",
      crit_accept_by_strata_by_trt = TRUE
    )
  fn_map <- data.table(
    endpoint_spec_id = "1",
    fn_hash = c("A", "B", "C", "D"),
    fn_type = c(
      "stat_by_strata_by_trt",
      "stat_by_strata_by_trt",
      "stat_by_strata_across_trt",
      "stat_across_strata_across_trt"
    ),
    fn_name = c("fun1_1", "fun1_2", "fun2_1", "fun3_1")
  )
  setkey(analysis_data_container, key_analysis_data)
  setkey(ep, key_analysis_data)

  # ACT ---------------------------------------------------------------------
  ep_prep <- prepare_for_stats(ep,
    analysis_data_container,
    fn_map,
    type = "stat_by_strata_by_trt"
  )

  # EXPECT ------------------------------------------------------------------

  # Check set of new columns
  expect_equal(
    sort(setdiff(names(ep_prep), names(ep))),
    c(
      "cell_index",
      "fn_hash",
      "fn_name",
      "fn_type",
      "stat_empty",
      "stat_filter",
      "stat_metadata",
      "stat_result_id"
    )
  )

  # Check number of rows, id var, and occurrence of fn_name
  expect_equal(nrow(ep_prep), 12)
  expect_equal(sum(ep_prep[["fn_name"]] == "fun1_1"), 6)
  expect_equal(sum(ep_prep[["fn_name"]] == "fun1_2"), 6)
  expect_equal(length(unique(ep_prep$stat_result_id)), 12)

  # Check stat_metadata
  expect_equal(
    ep_prep$stat_metadata[[1]],
    list(TOTAL_ = "total", TRT01A = "Placebo")
  )
  expect_equal(
    ep_prep$stat_metadata[[2]],
    list(TOTAL_ = "total", TRT01A = "Xanomeline High Dose")
  )
  expect_equal(ep_prep$stat_metadata[[5]], list(SEX = "F", TRT01A = "Placebo"))
  expect_equal(ep_prep$stat_metadata[[6]], list(SEX = "M", TRT01A = "Placebo"))
  expect_equal(
    ep_prep$stat_metadata[[7]],
    list(SEX = "F", TRT01A = "Xanomeline High Dose")
  )
  expect_equal(
    ep_prep$stat_metadata[[8]],
    list(SEX = "M", TRT01A = "Xanomeline High Dose")
  )

  # Check cell_index
  for (i in 1:nrow(ep_prep)) {
    expect_equal(
      ep_prep$cell_index[[i]],
      analysis_data_container$dat[[1]][eval(parse(text = ep_prep$stat_filter[[i]]))][["INDEX_"]]
    )
  }
})


test_that("Proper stat function mapping when type=stat_by_strata_across_trt", {
  # SETUP -------------------------------------------------------------------

  adam <-
    mk_adcm() %>%
    .[TRT01A %in% c("Placebo", "Xanomeline High Dose")] %>%
    .[, "INDEX_" := .I] %>%
    .[, "TOTAL_" := "total"]
  analysis_data_container <-
    data.table(dat = list(adam), key_analysis_data = "a")
  ep <-
    data.table(
      endpoint_spec_id = "1",
      strata_id = c("1-1", "1-2"),
      treatment_var = "TRT01A",
      strata_var = c("TOTAL_", "SEX"),
      key_analysis_data = "a",
      crit_accept_by_strata_across_trt = TRUE
    )
  fn_map <- data.table(
    endpoint_spec_id = "1",
    fn_hash = c("A", "B", "C", "D"),
    fn_type = c(
      "stat_by_strata_by_trt",
      "stat_by_strata_by_trt",
      "stat_by_strata_across_trt",
      "stat_across_strata_across_trt"
    ),
    fn_name = c("fun1_1", "fun1_2", "fun2_1", "fun3_1")
  )
  setkey(analysis_data_container, key_analysis_data)
  setkey(ep, key_analysis_data)

  # ACT ---------------------------------------------------------------------

  ep_prep <- prepare_for_stats(ep,
    analysis_data_container,
    fn_map,
    type = "stat_by_strata_across_trt"
  )

  # EXPECT ------------------------------------------------------------------

  # Check set of new columns
  expect_equal(
    sort(setdiff(names(ep_prep), names(ep))),
    c(
      "cell_index",
      "fn_hash",
      "fn_name",
      "fn_type",
      "stat_empty",
      "stat_filter",
      "stat_metadata",
      "stat_result_id"
    )
  )

  # Check number of rows, id var, and occurrence of fn_name
  expect_equal(nrow(ep_prep), 3)
  expect_equal(unique(ep_prep[["fn_name"]]), "fun2_1")
  expect_equal(length(unique(ep_prep$stat_result_id)), 3)

  # Check stat_metadata
  expect_equal(unlist(ep_prep$stat_metadata[[1]]), c(TOTAL_ = "total"))
  expect_equal(unlist(ep_prep$stat_metadata[[2]]), c(SEX = "F"))
  expect_equal(unlist(ep_prep$stat_metadata[[3]]), c(SEX = "M"))

  # Check cell_index
  for (i in 1:nrow(ep_prep)) {
    expect_equal(
      ep_prep$cell_index[[i]],
      analysis_data_container$dat[[1]][eval(parse(text = ep_prep$stat_filter[[i]]))][["INDEX_"]]
    )
  }
})

test_that("Proper stat function mapping when type=stat_across_strata_across_trt", {
  # SETUP -------------------------------------------------------------------

  adam <-
    mk_adcm() %>%
    .[TRT01A %in% c("Placebo", "Xanomeline High Dose")] %>%
    .[, "INDEX_" := .I] %>%
    .[, "TOTAL_" := "total"]
  analysis_data_container <-
    data.table(dat = list(adam), key_analysis_data = "a")
  ep <-
    data.table(
      endpoint_spec_id = "1",
      strata_id = c("1-1", "1-2"),
      treatment_var = "TRT01A",
      strata_var = c("TOTAL_", "SEX"),
      key_analysis_data = "a",
      crit_accept_by_strata_across_trt = TRUE
    )
  fn_map <- data.table(
    endpoint_spec_id = "1",
    fn_hash = c("A", "B", "C", "D"),
    fn_type = c(
      "stat_by_strata_by_trt",
      "stat_by_strata_by_trt",
      "stat_by_strata_across_trt",
      "stat_across_strata_across_trt"
    ),
    fn_name = c("fun1_1", "fun1_2", "fun2_1", "fun3_1")
  )

  setkey(analysis_data_container, key_analysis_data)
  setkey(ep, key_analysis_data)
  # ACT ---------------------------------------------------------------------

  ep_prep <- prepare_for_stats(ep,
    analysis_data_container,
    fn_map,
    type = "stat_across_strata_across_trt"
  )

  # EXPECT ------------------------------------------------------------------

  expect_equal(
    sort(setdiff(names(ep_prep), names(ep))),
    c(
      "cell_index",
      "fn_hash",
      "fn_name",
      "fn_type",
      "stat_empty",
      "stat_filter",
      "stat_metadata",
      "stat_result_id"
    )
  )

  # Check number of rows, id var, and occurrence of fn_name
  expect_equal(nrow(ep_prep), 1)
  expect_equal(unique(ep_prep[["fn_name"]]), "fun3_1")

  # Check stat_metadata
  expect_equal(ep_prep$stat_metadata[[1]], list(
    SEX = c("F", "M"),
    TRT01A = c("Placebo", "Xanomeline High Dose")
  ))

  # Check cell_index
  expect_equal(ep_prep$cell_index[[1]], analysis_data_container$dat[[1]][["INDEX_"]])

  # Check that filter is empty
  expect_equal(ep_prep$stat_filter[[1]], "")
})


test_that("base - dataprep: define_expansion_cell_from_data", {
  # SETUP -------------------------------------------------------------------

  x <- data.table::data.table(
    "SEX" = c("M", "M", "M", "F", "F"),
    "AGEgrp" = c(1, 2, 1, 2, 3),
    "Treatment" = c("on", "off", "on", "off", "on"),
    "value" = c(1, 0.5, 1, 0.5, 2),
    "TOTAL_" = "total"
  )

  ep_1 <- data.table::data.table(
    id = c(1, 2, 3),
    stratify_by = c("TOTAL_", "SEX", "AGEgrp"),
    dat = list(x),
    treatment_var = "Treatment"
  )

  # ACT ---------------------------------------------------------------------

  row_total_trt <- ep_1[1]
  exp_total_trt <- define_expansion_cell_from_data(
    row = row_total_trt,
    grouping_cols = c("stratify_by", "treatment_var"),
    data_col = "dat",
    col_prefix = "stat"
  )

  exp_total <- define_expansion_cell_from_data(
    row = row_total_trt,
    grouping_cols = c("stratify_by"),
    data_col = "dat",
    col_prefix = "stat"
  )

  row_sex_trt <- ep_1[2]
  exp_sex_trt <- define_expansion_cell_from_data(
    row = row_sex_trt,
    grouping_cols = c("stratify_by", "treatment_var"),
    data_col = "dat",
    col_prefix = "stat"
  )

  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(exp_total_trt), 2)
  expect_true(!any("TOTAL_" %in% exp_total_trt$stat_filter))
  expect_true("TOTAL_" %in% names(exp_total_trt$stat_metadata[[1]]))

  expect_equal(nrow(exp_total), 1)
  expect_equal(exp_total$stat_filter[[1]], 'TOTAL_ == "total"')
  expect_equal(names(exp_total$stat_metadata[[1]]), "TOTAL_")

  expect_equal(nrow(exp_sex_trt), 4)
})


test_that("base - dataprep: expand_ep_for_stats", {
  # SETUP -------------------------------------------------------------------
  x <- data.table::data.table(
    SEX = c("M", "M", "M", "F", "F"),
    AGEgrp = c(1, 2, 1, 2, 3),
    Treatment = c("on", "off", "on", "off", "on"),
    value = c(1, 0.5, 1, 0.5, 2),
    INDEX_ = 1:5,
    TOTAL_ = "total"
  )
  analysis_data_container <-
    data.table(dat = list(x), key_analysis_data = "a") %>% setkey(key_analysis_data)
  ep_fn <- data.table::data.table(
    id_xx = c(1, 2, 3),
    stratify_by = c("TOTAL_", "SEX", "AGEgrp"),
    treatment_var = "Treatment",
    fn_hash = "X",
    key_analysis_data = "a"
  )

  # ACT ---------------------------------------------------------------------


  ep_exp_stat <- expand_ep_for_stats(
    ep = ep_fn,
    id_col = "id_xx",
    grouping_cols = c("stratify_by", "treatment_var"),
    analysis_data_container = analysis_data_container,
    data_col = "dat",
    col_prefix = "stat"
  )

  # EXPECT ------------------------------------------------------------------

  ## This is more like spot tests.

  # check that empty combinations of levels result in no index.

  ep_with_filtered_data <-
    ep_exp_stat[, filt_data := llist(analysis_data_container$dat[[1]][INDEX_ %in% cell_index[[1]]]),
      by =
        1:nrow(ep_exp_stat)
    ]

  dt_empty <- ep_with_filtered_data[stat_empty == TRUE, ]
  dt_empty[, expect_equal(length(cell_index[[1]]), 0), by = 1:nrow(dt_empty)]

  exp_combinations <- uniqueN(x$SEX) * uniqueN(x$Treatment)

  expect_equal(nrow(ep_with_filtered_data[stratify_by == "SEX"]), exp_combinations)
})


test_that("base - dataprep", {
  # SETUP -------------------------------------------------------------------
  x <- data.table::data.table(
    STUDYID = "X",
    SEX = c("M", "M", "M", "F", "F"),
    AGEgrp = c(1, 2, 1, 2, 3),
    Treatment = c("on", "off", "on", "off", "on"),
    value = c(1, 0.5, 1, 0.5, 2),
    INDEX_ = 1:5,
    TOTAL_ = "total"
  )

  analysis_data_container <- data.table(
    dat = list(x), key_analysis_data =
      "a"
  )

  ep <- data.table::data.table(
    endpoint_spec_id = 1,
    id_xx = c(1, 1, 3),
    strata_var = c("TOTAL_", "SEX", "AGEgrp"),
    key_analysis_data = "a",
    treatment_var = "Treatment",
    crit_accept_by_strata_across_trt = TRUE,
    crit_accept_by_strata_by_trt = TRUE,
    crit_accept_across_strata_across_trt = TRUE
  )

  fn_map <- data.table(
    endpoint_spec_id = 1,
    fn_hash = c("A", "B", "C"),
    fn_type = c(
      "stat_by_strata_by_trt",
      "stat_by_strata_across_trt",
      "stat_across_strata_across_trt"
    ),
    fn_name = c("fun1_1", "fun2_1", "fun3_1")
  )

  setkey(analysis_data_container, key_analysis_data)
  setkey(ep, key_analysis_data)

  # ACT ---------------------------------------------------------------------
  ep_trt_sgl <- prepare_for_stats(
    ep,
    analysis_data_container,
    fn_map,
    type = "stat_by_strata_by_trt",
    data_col = "dat",
    id_col = "id_xx"
  )

  ep_sgl <- prepare_for_stats(
    ep,
    analysis_data_container,
    fn_map,
    type = "stat_by_strata_across_trt",
    data_col = "dat",
    id_col = "id_xx"
  )

  ep_sg <- prepare_for_stats(
    ep,
    analysis_data_container,
    fn_map,
    type = "stat_across_strata_across_trt",
    data_col = "dat",
    id_col = "id_xx"
  )


  # EXPECT ------------------------------------------------------------------

  # Check the expansion.
  # +1 is for the total
  exp_trt_sgl_combinations <- (1 + x[, uniqueN(SEX) + uniqueN(AGEgrp)]) * x[, uniqueN(Treatment)]
  expect_equal(nrow(ep_trt_sgl), exp_trt_sgl_combinations)

  exp_sgl_combinations <- (1 + x[, uniqueN(SEX) + uniqueN(AGEgrp)])
  expect_equal(nrow(ep_sgl), exp_sgl_combinations)

  exp_sg_combinations <- nrow(ep[strata_var != "TOTAL_", ])
  expect_equal(nrow(ep_sg), exp_sg_combinations)

  expect_error(
    prepare_for_stats(
      ep = data.table(),
      analysis_data_container,
      fn_map = data.table(),
      type = "x"
    ),
    regexp = "'arg' should be one of"
  )
})


