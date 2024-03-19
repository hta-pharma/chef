test_that("Errors on empty data table", {
  dt <- data.table::data.table()
  expect_error(unnest_by_fns(dt, cols = c()), "Provided")
})


test_that("Errors when provided cols do not exist in data.table", {
  dt <- data.table::data.table(a = rnorm(10), b = rnorm(10))
  expect_error(
    unnest_by_fns(dt, cols = c("c", "d")),
    "The following columns are not found"
  )
})


test_that("Expload data model based on fn's works", {
  # SETUP -------------------------------------------------------------------
  ep <- mk_ep_0001_base(data_prepare = mk_adae)

  # ACT ---------------------------------------------------------------------
  actual <- unnest_by_fns(ep, cols = c("data_prepare"))

  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(actual), 1)
  expect_equal(actual$fn[[1]], substitute(mk_adae))
  expect_equal(actual$fn_name, "mk_adae")
})

test_that("Duplicate fn's get their own row", {
  # SETUP -------------------------------------------------------------------
  ep <- rbind(
    mk_ep_0001_base(data_prepare = mk_adae),
    mk_ep_0001_base(data_prepare = mk_adae)
  )
  # ACT ---------------------------------------------------------------------
  actual <- unnest_by_fns(ep, cols = c("data_prepare"))

  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(actual), 2)
  expect_equal(actual$fn[[1]], substitute(mk_adae))
  expect_equal(actual$fn_name, sort(rep(c("mk_adae"), 2), decreasing = TRUE))
})


test_that("Unnamed naked fns get nammed", {
  # SETUP -------------------------------------------------------------------
  ep <- mk_ep_0001_base(data_prepare = mk_adae, stat_by_strata_by_trt = n_sub)
  # ACT ---------------------------------------------------------------------
  actual <- unnest_by_fns(ep, cols = c("data_prepare", "stat_by_strata_by_trt"))

  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(actual), 2)
  expect_equal(actual$fn[[1]], substitute(mk_adae))
  expect_equal(actual$fn[[2]], substitute(n_sub))
})

test_that("Unnamed fns enclosed in list() get nammed", {
  # SETUP -------------------------------------------------------------------
  ep <- mk_ep_0001_base(data_prepare = mk_adae, stat_by_strata_by_trt = list(n_sub))
  # ACT ---------------------------------------------------------------------
  actual <- unnest_by_fns(ep, cols = c("data_prepare", "stat_by_strata_by_trt"))

  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(actual), 2)
  expect_equal(actual$fn[[1]], substitute(mk_adae))
  expect_equal(actual$fn[[2]], substitute(n_sub))
})

test_that("Unnamed fns in style pkg::fn enclosed in list() get nammed", {
  # SETUP -------------------------------------------------------------------
  ep <-
    mk_ep_0001_base(
      data_prepare = mk_adae,
      stat_by_strata_by_trt = list(
        n_sub,
        stats::AIC,
        c(stats::BIC, x = "1"),
        c("rst" = n_sub),
        c("gtgsr" = stats::acf)
      )
    )

  # ACT ---------------------------------------------------------------------
  actual <- unnest_by_fns(ep, cols = c("data_prepare", "stat_by_strata_by_trt"))

  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(actual), 6)
  expect_equal(
    actual$fn_name,
    c(
      "mk_adae",
      "n_sub",
      "stats::AIC",
      "stats::BIC",
      "n_sub",
      "stats::acf"
    )
  )
})

test_that("Multiple unnamed fns enclosed in list() get nammed", {
  # SETUP -------------------------------------------------------------------
  ep <- mk_ep_0001_base(data_prepare = mk_adae, stat_by_strata_by_trt = list(n_sub, n_subev))
  # ACT ---------------------------------------------------------------------
  actual <- unnest_by_fns(ep, cols = c("data_prepare", "stat_by_strata_by_trt"))

  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(actual), 3)
  expect_equal(actual$fn[[1]], substitute(mk_adae))
  expect_equal(actual$fn[[2]], substitute(n_sub))
  expect_equal(actual$fn[[3]], substitute(n_subev))
})

test_that("Unnamed fns supplied in following style: list(c(fn, arg), fn) get nammed", {
  # SETUP -------------------------------------------------------------------
  ep <-
    mk_ep_0001_base(
      data_prepare = mk_adae,
      stat_by_strata_by_trt = list(
        c(n_sub, subject_var = "USUBJID"),
        c("rst" = n_subev),
        c("rst" = n_subev, subject_var = "gta")
      )
    )
  # ACT ---------------------------------------------------------------------
  actual <- unnest_by_fns(ep, cols = c("data_prepare", "stat_by_strata_by_trt"))

  # EXPECT ------------------------------------------------------------------

  expect_equal(nrow(actual), 4)
  expect_equal(actual$fn_name, c("mk_adae", "n_sub", "n_subev", "n_subev"))
})
