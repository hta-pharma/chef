test_that("Unnest all functions", {
  # SETUP -------------------------------------------------------------------

  crit_ep_dummy <- function(...) {
    return(T)
  }
  crit_sgd_dummy <- function(...){
    return(T)
  }
  crit_sga_dummy <- function(...){
    return(T)
  }

  ep <- mk_ep_0001_base(
    data_prepare = mk_adae,
    stat_by_strata_by_trt = list("n_sub" = n_sub,
                                 "n_subev" = n_subev),
    stat_by_strata_across_trt = list("n_subev_trt_diff" = n_subev_trt_diff),
    stat_across_strata_across_trt = list("P-interaction" = contingency2x2_strata_test),
    crit_endpoint = list(crit_ep_dummy),
    crit_by_strata_by_trt = list(crit_sgd_dummy),
    crit_by_strata_across_trt = list(crit_sga_dummy)
  )

  ep <- add_id(ep)


  # ACT ---------------------------------------------------------------------

  ep_fn <- suppressWarnings(unnest_endpoint_functions(ep))

  # EXPECT ------------------------------------------------------------------

  # Check number of functions
  expect_equal(nrow(ep_fn), 8)

  # Check column types
  expect_equal(typeof(ep_fn[["endpoint_spec_id"]]), "integer")
  expect_equal(typeof(ep_fn[["fn_hash"]]), "character")
  expect_equal(typeof(ep_fn[["fn_type"]]), "character")
  expect_equal(typeof(ep_fn[["fn_name"]]), "character")
  expect_equal(typeof(ep_fn[["fn"]]), "list")

  # Check that content of each fn is language
  # expect_equal(all(unlist(lapply(ep_fn[["fn"]], function(x){typeof(x) == "language"}))), TRUE)
  # ** Temporary **
  # Check that content of each fn is language or symbol
  expect_equal(all(unlist(lapply(ep_fn[["fn"]], function(x){typeof(x) %in% c("language", "symbol")}))), TRUE)

  # Check uniqueness of fn_hash
  expect_equal(anyDuplicated(ep_fn[["fn_hash"]]), 0)

  # Check that set of fn_types and

  # Check that fn_type matches fn
  lookup <- c(
    "mk_adae" = "data_prepare",
    "n_sub" = "stat_by_strata_by_trt",
    "n_subev" = "stat_by_strata_by_trt",
    "n_subev_trt_diff" = "stat_by_strata_across_trt",
    "P-interaction" = "stat_across_strata_across_trt",
    "crit_ep_dummy" = "crit_endpoint",
    "crit_sgd_dummy" = "crit_by_strata_by_trt",
    "crit_sga_dummy" = "crit_by_strata_across_trt"
  )
  expect_equal(all(apply(ep_fn, 1,
                         function(x) {
                           return(x[["fn_type"]] == lookup[[x[["fn_name"]]]])
                         })), TRUE)
})


test_that("Unnest criterion functions", {
  # SETUP -------------------------------------------------------------------

  crit_ep_dummy <- function(...) {
    return(T)
  }
  crit_sgd_dummy <- function(...){
    return(T)
  }
  crit_sga_dummy <- function(...){
    return(T)
  }

  ep <- mk_ep_0001_base(
    data_prepare = mk_adae,
    stat_by_strata_by_trt = list(
      "n_sub" = n_sub,
      "n_subev" = n_subev),
    stat_by_strata_across_trt = list("n_subev_trt_diff" = n_subev_trt_diff),
    stat_across_strata_across_trt = list("P-interaction" = contingency2x2_ptest),
    crit_endpoint = list(crit_ep_dummy),
    crit_by_strata_by_trt = list(crit_sgd_dummy),
    crit_by_strata_across_trt = list(crit_sga_dummy)
  )

  ep <- add_id(ep)

  fn_cols <- c("crit_endpoint", "crit_by_strata_by_trt",
               "crit_by_strata_across_trt")


  # ACT ---------------------------------------------------------------------

  ep_fn <- suppressWarnings(unnest_endpoint_functions(ep, fn_cols=fn_cols))

  # EXPECT ------------------------------------------------------------------

  # Check number of functions
  expect_equal(nrow(ep_fn), 3)

  # Check column types
  expect_equal(typeof(ep_fn[["endpoint_spec_id"]]), "integer")
  expect_equal(typeof(ep_fn[["fn_hash"]]), "character")
  expect_equal(typeof(ep_fn[["fn_type"]]), "character")
  expect_equal(typeof(ep_fn[["fn_name"]]), "character")
  expect_equal(typeof(ep_fn[["fn"]]), "list")

  # Check that content of each fn is language
  # expect_equal(all(unlist(lapply(ep_fn[["fn"]], function(x){typeof(x) == "language"}))), TRUE)
  # ** Temporary **
  # Check that content of each fn is language or symbol
  expect_equal(all(unlist(lapply(ep_fn[["fn"]], function(x){typeof(x) %in% c("language", "symbol")}))), TRUE)

  # Check uniqueness of fn_hash
  expect_equal(anyDuplicated(ep_fn[["fn_hash"]]), 0)

  # Check that set of fn_types and

  # Check that fn_type matches fn
  lookup <- c(
    "crit_ep_dummy" = "crit_endpoint",
    "crit_sgd_dummy" = "crit_by_strata_by_trt",
    "crit_sga_dummy" = "crit_by_strata_across_trt"
  )
  expect_equal(all(apply(ep_fn, 1,
                         function(x) {
                           return(x[["fn_type"]] == lookup[[x[["fn_name"]]]])
                         })), TRUE)
})


test_that("Unnest statistical functions", {
  # SETUP -------------------------------------------------------------------

  ep <- mk_ep_0001_base(
    data_prepare = mk_adae,
    stat_by_strata_by_trt = list("n_sub" = n_sub,
                                     "n_subev" = n_subev),
    stat_by_strata_across_trt = list("n_subev_trt_diff" = n_subev_trt_diff),
    stat_across_strata_across_trt = list("P-interaction" = contingency2x2_strata_test)
  )

  ep <- add_id(ep)

  fn_cols <- c("stat_by_strata_by_trt", "stat_by_strata_across_trt", "stat_across_strata_across_trt")


  # ACT ---------------------------------------------------------------------

  ep_fn <- suppressWarnings(unnest_endpoint_functions(ep, fn_cols=fn_cols))

  # EXPECT ------------------------------------------------------------------

  # Check number of functions
  expect_equal(nrow(ep_fn), 4)

  # Check column types
  expect_equal(typeof(ep_fn[["endpoint_spec_id"]]), "integer")
  expect_equal(typeof(ep_fn[["fn_hash"]]), "character")
  expect_equal(typeof(ep_fn[["fn_type"]]), "character")
  expect_equal(typeof(ep_fn[["fn_name"]]), "character")
  expect_equal(typeof(ep_fn[["fn"]]), "list")

  # Check that content of each fn is language
  # expect_equal(all(unlist(lapply(ep_fn[["fn"]], function(x){typeof(x) == "language"}))), TRUE)
  # ** Temporary **
  # Check that content of each fn is language or symbol
  expect_equal(all(unlist(lapply(ep_fn[["fn"]], function(x){typeof(x) %in% c("language", "symbol")}))), TRUE)

  # Check uniqueness of fn_hash
  expect_equal(anyDuplicated(ep_fn[["fn_hash"]]), 0)

  # Check that set of fn_types and

  # Check that fn_type matches fn
  lookup <- c(
    "n_sub" = "stat_by_strata_by_trt",
    "n_subev" = "stat_by_strata_by_trt",
    "n_subev_trt_diff" = "stat_by_strata_across_trt",
    "P-interaction" = "stat_across_strata_across_trt"
  )
  expect_equal(all(apply(ep_fn, 1,
                         function(x) {
                           return(x[["fn_type"]] == lookup[[x[["fn_name"]]]])
                         })), TRUE)
})

test_that("Unnest adam and adsl functions", {
  # SETUP -------------------------------------------------------------------

  ep <- mk_ep_0001_base(
    data_prepare = mk_adae
  )

  ep <- add_id(ep)

  fn_cols <- c("data_prepare")


  # ACT ---------------------------------------------------------------------

  ep_fn <- suppressWarnings(unnest_endpoint_functions(ep, fn_cols=fn_cols))

  # EXPECT ------------------------------------------------------------------

  # Check number of functions
  expect_equal(nrow(ep_fn), 1)

  # Check column types
  expect_equal(typeof(ep_fn[["endpoint_spec_id"]]), "integer")
  expect_equal(typeof(ep_fn[["fn_hash"]]), "character")
  expect_equal(typeof(ep_fn[["fn_type"]]), "character")
  expect_equal(typeof(ep_fn[["fn_name"]]), "character")
  expect_equal(typeof(ep_fn[["fn"]]), "list")

  # Check that content of each fn is language
  # expect_equal(all(unlist(lapply(ep_fn[["fn"]], function(x){typeof(x) == "language"}))), TRUE)
  # ** Temporary **
  # Check that content of each fn is language or symbol
  expect_equal(all(unlist(lapply(ep_fn[["fn"]], function(x){typeof(x) %in% c("language", "symbol")}))), TRUE)

  # Check uniqueness of fn_hash
  expect_equal(anyDuplicated(ep_fn[["fn_hash"]]), 0)

  # Check that set of fn_types and

  # Check that fn_type matches fn
  lookup <- c(
    "mk_adae" = "data_prepare"
  )
  expect_equal(all(apply(ep_fn, 1,
                         function(x) {
                           return(x[["fn_type"]] == lookup[[x[["fn_name"]]]])
                         })), TRUE)
})
