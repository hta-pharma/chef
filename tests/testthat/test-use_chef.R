test_that("use_chef makes top-level dirs and files", {
  # SETUP -------------------------------------------------------------------
  testr::skip_on_devops()
  testr::create_local_project()

  # ACT ---------------------------------------------------------------------
  use_chef(pipeline_id = "001")

  # EXPECT ------------------------------------------------------------------
  actual <- list.dirs()
  expect_equal(actual, c(".", "./R", "./pipeline"))
  expect_equal(list.files(), sort(c("R", "_targets.yaml", "pipeline")))
})

test_that("use_chef makes top-level dirs and fils when in Rproj", {
  # SETUP -------------------------------------------------------------------
  testr::skip_on_devops()
  testr::create_local_project(rstudio = TRUE)
  # ACT ---------------------------------------------------------------------
  use_chef(pipeline_id = "001")

  # EXPECT ------------------------------------------------------------------
  actual <- list.dirs()
  expect_equal(actual, c(".", "./R", "./pipeline"))
  proj_files <- list.files(pattern = "\\.Rproj$")
  actual <- setdiff(list.files(), proj_files)
  expect_equal(actual, sort(c("R", "_targets.yaml", "pipeline")))
})


test_that("use_chef writes default R files", {
  # SETUP -------------------------------------------------------------------
  testr::skip_on_devops()
  testr::create_local_project()

  # ACT ---------------------------------------------------------------------
  use_chef(pipeline_id = "001")

  # EXPECT ------------------------------------------------------------------
  expect_equal(
    list.files("R/"),
    sort(c("mk_adam_scaffold.R", "mk_endpoint_def.R", "packages.R"))
  )
  expect_equal(
    list.files("pipeline/"),
    c("pipeline_001.R")
  )
})

test_that("use_chef writes ammnog crit functions", {
  # SETUP -------------------------------------------------------------------
  testr::skip_on_devops()
  testr::create_local_project()
  crit_endpoint <- function() {
    "check"
  }
  # ACT ---------------------------------------------------------------------
  use_chef(pipeline_id = "001", mk_criteria_fn = crit_endpoint)

  # EXPECT ------------------------------------------------------------------
  actual <- list.files("R/")
  expect_equal(
    actual,
    c(
      "crit_endpoint.R",
      "mk_adam_scaffold.R",
      "mk_endpoint_def.R",
      "packages.R"
    )
  )
  x <- readLines("R/crit_endpoint.R")
  expect_true(any(grepl("\"check\"", x = x)))
})

test_that("use_chef writes custom mk_endpoint_def fn, and uses standard name", {
  # SETUP -------------------------------------------------------------------
  testr::skip_on_devops()
  testr::create_local_project()
  mk_endpoint_custom <- function() {
    "check"
  }
  # ACT ---------------------------------------------------------------------
  use_chef(pipeline_id = "001", mk_endpoint_def_fn = mk_endpoint_custom)

  # EXPECT ------------------------------------------------------------------

  actual <- list.files("R/")
  expect_equal(
    actual,
    c("mk_adam_scaffold.R", "mk_endpoint_def.R", "packages.R")
  )
  x <- readLines("R/mk_endpoint_def.R")
  expect_true(any(grepl("\"check\"", x = x)))
})


test_that("use_chef writes custom mk_adam fn", {
  # SETUP -------------------------------------------------------------------
  testr::skip_on_devops()
  testr::create_local_project()
  mk_adam_custom <- function() {
    "check"
  }
  # ACT ---------------------------------------------------------------------
  use_chef(pipeline_id = "001", mk_adam_fn = mk_adam_custom)

  # EXPECT ------------------------------------------------------------------
  actual <- list.files("R/")
  expect_equal(
    actual,
    c(
      "mk_adam_custom.R",
      "mk_endpoint_def.R",
      "packages.R"
    )
  )
  x <- readLines("R/mk_adam_custom.R")
  expect_true(any(grepl("\"check\"", x = x)))
})

test_that("use_chef writes multiple mk_adam fn's", {
  # SETUP -------------------------------------------------------------------
  testr::skip_on_devops()
  testr::create_local_project()
  mk_adam_custom <- function() {
    "check"
  }
  mk_adam_custom_2 <- function() {
    "check_2"
  }
  # ACT ---------------------------------------------------------------------
  use_chef(
    pipeline_id = "001",
    mk_adam_fn = list(mk_adam_custom, mk_adam_custom_2)
  )

  # EXPECT ------------------------------------------------------------------
  actual <- list.files("R/")
  expect_equal(
    actual,
    c(
      "mk_adam_custom.R",
      "mk_adam_custom_2.R",
      "mk_endpoint_def.R",
      "packages.R"
    )
  )
  x <- readLines("R/mk_adam_custom.R")
  expect_true(any(grepl("\"check\"", x = x)))

  x <- readLines("R/mk_adam_custom_2.R")
  expect_true(any(grepl("\"check_2\"", x = x)))
})


test_that("use_chef set-up in README works", {
  # SETUP -------------------------------------------------------------------
  testr::skip_on_devops()
  testr::create_local_project()
  mk_endpoint_definition <- function() {
    mk_endpoint_str(
      study_metadata = list(),
      pop_var = "SAFFL",
      pop_value = "Y",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      period_var = "ANL01FL",
      period_value = "Y",
      stratify_by = list(c("AGEGR2")),
      data_prepare = mk_adcm,
      endpoint_label = "A",
      custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
      stat_by_strata_by_trt = list("n_subev" = c(n_subev))
    )
  }
  # ACT ---------------------------------------------------------------------
  chef::use_chef(
    pipeline_id = "01",
    mk_endpoint_def_fn = mk_endpoint_definition,
    mk_adam_fn = list(mk_adcm),
  )

  # EXPECT ------------------------------------------------------------------
  expect_equal(list.files(), sort(c("_targets.yaml", "R", "pipeline")))
  expect_equal(list.files("./R"), sort(
    c(
      "mk_adcm.R",
      "mk_endpoint_def.R",
      "packages.R"
    )
  ))
})
test_that("use_chef with custom pipeline_dir names works", {
  # SETUP -------------------------------------------------------------------
  testr::skip_on_devops()
  testr::create_local_project()
  mk_endpoint_definition <- function() {
    mk_endpoint_str(
      study_metadata = list(),
      pop_var = "SAFFL",
      pop_value = "Y",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      period_var = "ANL01FL",
      period_value = "Y",
      stratify_by = list(c("AGEGR2")),
      data_prepare = mk_adcm,
      endpoint_label = "A",
      custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
      stat_by_strata_by_trt = list("n_subev" = c(n_subev))
    )
  }
  # ACT ---------------------------------------------------------------------
  chef::use_chef(
    pipeline_dir = "pipeline",
    pipeline_id = "01",
    mk_endpoint_def_fn = mk_endpoint_definition,
    mk_adam_fn = list(mk_adcm),
  )
  # EXPECT ------------------------------------------------------------------
  expect_equal(list.files(path = "./pipeline"), "pipeline_01.R")
})
