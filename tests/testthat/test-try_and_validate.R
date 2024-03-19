# Tested functionality: R/eval_fn.R validate_stat_output()
library(testthat)

test_that("validate_stat_output in simple cases", {
  # Example outputs
  no_dt <- 1
  wrong_names <- data.table::data.table(1)
  empty_dt <-
    data.table::data.table(
      label = character(),
      value = numeric(),
      description = character(),
      qualifiers = character()
    )
  simple_dt <- data.table::data.table()
  valid_dt <-
    data.table::data.table(
      label = "log",
      value = 1,
      description = "Natural log",
      qualifiers = NA_character_
    )

  expect_str_contains(
    validate_stat_output(no_dt),
    "Expected (data.table::data.table)"
  )

  expect_str_contains(
    validate_stat_output(wrong_names),
    "Expected columns: ("
  )

  expect_str_contains(
    validate_stat_output(empty_dt),
    "The statistical function returned a data.table with 0 rows"
  )

  # combination
  expect_str_contains(
    validate_stat_output(simple_dt),
    "Expected columns: ("
  )
  expect_str_contains(
    validate_stat_output(simple_dt),
    "The statistical function returned a data.table with 0 rows"
  )

  # correct
  expect_equal(
    validate_stat_output(valid_dt),
    NA_character_
  )
})

test_that(
  "with_error_to_debug creates a debugging session if and only if evaluation fails - no output validation.",
  {
    # SETUP -------------------------------------------------------------------


    my_fun <- function(x) {
      log10(x)
    }
    tmp <- withr::local_tempdir()
    filename <- paste(tmp, "my_fun.Rdata", sep = "/")
    # Check nothing is create when a erroneous call is wrapped.
    expect_equal(
      try_and_validate(my_fun(10), expr_name = "my_fun", debug_dir = tmp),
      my_fun(10)
    )
    expect_false(file.exists(filename))


    # ACT ---------------------------------------------------------------------


    # Check debug is created when a valid call is wrapped
    expect_error(
      try_and_validate(my_fun("a"), expr_name = "my_fun", debug_dir = tmp),
      "Failed to EVALUATE function with error",
      fixed = TRUE
    )

    # EXPECT ------------------------------------------------------------------


    expect_true(file.exists(filename))
    # Check content
    debug_env <- readRDS(filename)
    expect_equal(debug_env$fn_name, "my_fun")
    expect_equal(debug_env$arg_list, list(x = "a"))
  }
)

test_that(
  "with_error_to_debug creates a debugging session if and only if validation fails - valid calls",
  {
    # SETUP -------------------------------------------------------------------


    fn_invalid <- function(x) {
      log10(x)
    }
    fn_valid <-
      function(x) {
        data.table::data.table(
          label = "log",
          value = log10(x),
          description = "Natural log",
          qualifiers = NA_character_
        )
      }
    tmp <- withr::local_tempdir()
    filename_invalid <- paste(tmp, "fn_invalid.Rdata", sep = "/")
    filename_valid <- paste(tmp, "fn_valid.Rdata", sep = "/")

    # Ensure no error and that debug is not create without validation problems.

    # ACT ---------------------------------------------------------------------

    # EXPECT ------------------------------------------------------------------



    expect_equal(
      try_and_validate(fn_valid(10),
        debug_dir = tmp,
        validator = validate_stat_output
      ),
      fn_valid(10)
    )
    expect_length(
      dir(tmp),
      0
    )

    # Ensure error is thrown and debug created when validation fails.
    expect_error(
      try_and_validate(
        fn_invalid(10),
        expr_name = "fn_invalid",
        debug_dir = tmp,
        validator = validate_stat_output
      ),
      "Failed to VALIDATE function output with error:",
      fixed = TRUE
    )
    expect_true(file.exists(filename_invalid))
  }
)

test_that("test in a targets setting.", {
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

  stat_will_fail <- function(...) {
    stop("boohoo")
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
      stat_by_strata_by_trt = list("failing_stat" = stat_will_fail),
      stat_by_strata_across_trt = list("n_subev_trt_diff" = c(n_subev_trt_diff)),
      stat_across_strata_across_trt = list("P-interaction" = c(contingency2x2_strata_test)),
      crit_endpoint = list(crit_endpoint),
      crit_by_strata_by_trt = list(crit_sgd),
      crit_by_strata_across_trt = list(crit_sga)
    )
  }

  # This is needed because mk_adcm_01 is calling from a new R session, it
  # doesn't have access to the helper-* functions from chef
  n_subev <- n_subev
  contingency2x2_strata_test <- contingency2x2_strata_test
  n_subev_trt_diff <- n_subev_trt_diff
  # contingency2x2_ptest <- contingency2x2_ptest

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
  dump("stat_will_fail", file = "R/custom_functions.R", append = TRUE)
  dump("contingency2x2_strata_test",
    file = "R/custom_functions.R",
    append = TRUE
  )
  # ACT ---------------------------------------------------------------------

  expect_error(tar_make(),
    "Error during evaluation of: failing_stat",
    fixed = TRUE
  )

  # EXPECT ------------------------------------------------------------------
  expect_true(file.exists("debug/failing_stat.Rdata"))
})




test_that("loaded packages are included.", {
  tmp <- withr::local_tempdir()
  library(dplyr)

  my_dplyr_dependent_function <- function(x) {
    mutate(x)
  }

  # Act
  expect_error(
    try_and_validate(
      my_dplyr_dependent_function("abc"),
      expr_name = "test",
      debug_dir = tmp
    ),
    regexp = "Error in UseMethod",
    fixed = TRUE
  )
  detach("package:dplyr")
  # Expectations

  expect_false("package:dplyr" %in% search())

  filepath <- file.path(tmp, "test.Rdata")

  expect_true(file.exists(filepath))

  debug_env <- readRDS(filepath)

  expect_true("package:dplyr" %in% debug_env$ns)
})



test_that("loaded packages are included - In targets setting", {
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

  stat_will_fail <- function(...) {
    stop("boohoo")
    mutate("abc")
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
      stat_by_strata_by_trt = list("failing_stat" = stat_will_fail),
      stat_by_strata_across_trt = list("n_subev_trt_diff" = c(n_subev_trt_diff)),
      stat_across_strata_across_trt = list("P-interaction" = c(contingency2x2_strata_test)),
      crit_endpoint = list(crit_endpoint),
      crit_by_strata_by_trt = list(crit_sgd),
      crit_by_strata_across_trt = list(crit_sga)
    )
  }

  # This is needed because mk_adcm_01 is calling from a new R session, it
  # doesn't have access to the helper-* functions from chef
  n_subev <- n_subev
  contingency2x2_strata_test <- contingency2x2_strata_test
  n_subev_trt_diff <- n_subev_trt_diff
  # contingency2x2_ptest <- contingency2x2_ptest

  use_chef(
    pipeline_dir = "pipeline",
    r_functions_dir = "R/",
    pipeline_id = "01",
    mk_endpoint_def_fn = mk_ep_def,
    mk_adam_fn = list(mk_adcm),
    mk_criteria_fn = list(crit_endpoint, crit_sga, crit_sgd)
  )

  fileConn <- file("R/custom_functions.R")
  writeLines("library(dplyr)", fileConn)
  close(fileConn)

  dump("n_subev", file = "R/custom_functions.R", append = TRUE)
  dump("n_subev_trt_diff", file = "R/custom_functions.R", append = TRUE)
  dump("stat_will_fail", file = "R/custom_functions.R", append = TRUE)
  dump("contingency2x2_strata_test",
    file = "R/custom_functions.R",
    append = TRUE
  )

  # ACT ---------------------------------------------------------------------

  expect_error(tar_make(),
    "Error during evaluation of: failing_stat",
    fixed = TRUE
  )

  # EXPECT ------------------------------------------------------------------
  filepath <- "debug/failing_stat.Rdata"

  expect_true(file.exists(filepath))

  debug_env <- readRDS(filepath)

  expect_true("package:dplyr" %in% debug_env$ns)
})
