test_that("Non-branching targets pipeline works",
{
  testr::skip_on_devops()
  # SETUP -------------------------------------------------------------------
  testr::create_local_project()
  crit_endpoint <- function(...) {
    return(T)
  }
  crit_sga <- function(...) {
    return(T)
  }
  crit_sgd <- function(...) {
    return(T)
  }

  mk_ep_def <- function() {
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
      custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
      group_by = list(list(RACE = c())),
      stat_by_strata_by_trt = list("n_subev" = c(n_subev)),
      stat_by_strata_across_trt = list("n_subev_trt_diff" = c(n_subev_trt_diff)),
      stat_across_strata_across_trt = list("P-interaction" = c(contingency2x2_strata_test)),
      crit_endpoint = list(crit_endpoint),
      crit_by_strata_by_trt = list(crit_sgd),
      crit_by_strata_across_trt = list(crit_sga)
    )
  }

  # This is needed because mk_adcm it is calling from a new R session, it
  # doesn't have access to the helper-* functions from chef
  n_subev <- n_subev
  n_subev_trt_diff <- n_subev_trt_diff
  contingency2x2_ptest <- contingency2x2_ptest

  use_chef(
    pipeline_dir = "pipeline",
    r_functions_dir = "R/",
    pipeline_id = "01",
    mk_endpoint_def_fn = mk_ep_def,
    mk_adam_fn = list(mk_adcm),
    mk_criteria_fn = list(crit_endpoint, crit_sga, crit_sgd)
  )

  dump("n_subev", file = "R/custom_functions.R")
  dump("n_subev_trt_diff", file = "R/custom_functions.R", append = TRUE)
  dump("contingency2x2_strata_test", file = "R/custom_functions.R", append = TRUE)
  # ACT ---------------------------------------------------------------------

  tar_make()
  # EXPECT ------------------------------------------------------------------
  x <- tar_meta() %>% as.data.table()
  expect_true(all(is.na(x$error)))
  tar_load(ep_stat)
  expect_snapshot(ep_stat)
})


test_that("Non-branching targets pipeline works no criteria fn and missing by_* functions",
{
  testr::skip_on_devops()
  # SETUP -------------------------------------------------------------------
  testr::create_local_project()

  mk_ep_def <- function() {
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
      custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
      group_by = list(list(RACE = c())),
      stat_by_strata_by_trt = list("n_subev" = c(n_subev))
    )
  }

  # This is needed because mk_adcm it is calling from a new R session, it
  # doesn't have access to the helper-* functions from chef
  n_subev <- n_subev
  n_subev_trt_diff <- n_subev_trt_diff
  contingency2x2_ptest <- contingency2x2_ptest

  use_chef(
    pipeline_dir = "pipeline",
    r_functions_dir = "R/",
    pipeline_id = "01",
    mk_endpoint_def_fn = mk_ep_def,
    mk_adam_fn = list(mk_adcm)
  )

  dump("n_subev", file = "R/custom_functions.R")
  dump("n_subev_trt_diff", file = "R/custom_functions.R", append = TRUE)
  dump("contingency2x2_ptest", file = "R/custom_functions.R", append = TRUE)
  # ACT ---------------------------------------------------------------------
  tar_make()
  # EXPECT ------------------------------------------------------------------
  x <- tar_meta() %>% as.data.table()
  expect_true(all(is.na(x$error)))
  tar_load(ep_stat_nested)
  expect_snapshot(ep_stat_nested)
})



test_that("branching after prepare for stats step works",
{
  testr::skip_on_devops()
  # SETUP -------------------------------------------------------------------
  testr::create_local_project()

  mk_ep_def <- function() {
    ep <- mk_endpoint_str(
      study_metadata = list(),
      pop_var = "SAFFL",
      pop_value = "Y",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      stratify_by = list(c("SEX")),
      data_prepare = mk_adae,
      custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
      stat_by_strata_by_trt = list("fn_1" = c(n_subev),
                                   "fn_2" = c(n_sub))
    )
  }

  # This is needed because mk_adcm it is calling from a new R session, it
  # doesn't have access to the helper-* functions from chef
  n_subev <- n_subev
  n_subev_trt_diff <- n_subev_trt_diff
  contingency2x2_ptest <- contingency2x2_ptest

  use_chef(
    pipeline_dir = "pipeline",
    r_functions_dir = "R/",
    pipeline_id = "01",
    mk_endpoint_def_fn = mk_ep_def,
    mk_adam_fn = list(mk_adae),branch_group_size = 1

  )

  dump("n_subev", file = "R/custom_functions.R")
  dump("n_sub", file = "R/custom_functions.R", append = TRUE)

  # ACT ---------------------------------------------------------------------
  tar_make()
  # EXPECT ------------------------------------------------------------------
  x <- tar_meta() %>% as.data.table()
  expect_true(all(is.na(x$error)))
  tar_load(ep_stat_nested)
  expect_snapshot(ep_stat_nested)
})

test_that("ep_fn_map is always outdated",
{
  testr::skip_on_devops()
  # SETUP -------------------------------------------------------------------
  testr::create_local_project()

  mk_ep_def <- function() {
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
      custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
      stat_by_strata_by_trt = list("n_subev" = c(n_subev)),
    )
  }

  # This is needed because mk_adcm it is calling from a new R session, it
  # doesn't have access to the helper-* functions from chef
  n_subev <- n_subev

  use_chef(
    pipeline_dir = "pipeline",
    r_functions_dir = "R/",
    pipeline_id = "01",
    mk_endpoint_def_fn = mk_ep_def,
    mk_adam_fn = list(mk_adcm)
  )

  dump("n_subev", file = "R/custom_functions.R")

  # ACT ---------------------------------------------------------------------
  tar_make(ep_fn_map)
  # EXPECT ------------------------------------------------------------------
  expect_equal(tar_outdated(names = c(ep_fn_map, ep, ep_id)), "ep_fn_map")
  x <- tar_meta() %>% as.data.table()
  expect_true(all(is.na(x$error)))
})


test_that("study_data responds to changes in source data",
{
  testr::skip_on_devops()
  # SETUP -------------------------------------------------------------------
  testr::create_local_project()
  saveRDS(data.table(runif(10)),file = "tmp_data_obj.rds")
  mk_test_fn <- function(study_metadata){
    readRDS("tmp_data_obj.rds")
  }
  mk_ep_def <- function() {
    ep <- mk_endpoint_str(
      study_metadata = list(),
      pop_var = "SAFFL",
      pop_value = "Y",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      period_var = "ANL01FL",
      period_value = "Y",
      stratify_by = list(c("SEX")),
      data_prepare = mk_test_fn,
      endpoint_label = "A",
      custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
      stat_by_strata_by_trt = list("n_subev" = c(n_subev)),
    )
  }

  # This is needed because mk_adcm it is calling from a new R session, it
  # doesn't have access to the helper-* functions from chef
  n_subev <- n_subev

  use_chef(
    pipeline_dir = "pipeline",
    r_functions_dir = "R/",
    pipeline_id = "01",
    mk_endpoint_def_fn = mk_ep_def,
    mk_adam_fn = list(mk_test_fn)
  )

  dump("n_subev", file = "R/custom_functions.R")
  tar_make(study_data)
  tar_load(study_data)
  x <- tar_meta() %>% as.data.table()
  expect_true(all(is.na(x$error)))
  before <- study_data$dat
  # ACT ---------------------------------------------------------------------
  saveRDS(data.table(runif(10)),file = "tmp_data_obj.rds")
  tar_make(study_data)

  # EXPECT ------------------------------------------------------------------
  tar_load(study_data)
  after <- study_data$dat
  expect_equal(intersect(c("study_data"), tar_outdated(names = study_data)), "study_data")
  expect_failure(expect_equal(before, after))
  x <- tar_meta() %>% as.data.table()
  expect_true(all(is.na(x$error)))
})
