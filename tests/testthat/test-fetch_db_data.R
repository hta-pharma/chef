test_that("Fetching/proccessing adam works", {
  # SETUP -------------------------------------------------------------------
  fn_dt <- suppressWarnings(
    data.table::data.table(
      fn_type = c("data_prepare"),
      fn_hash = c(digest::digest(mk_adae)),
      fn_name = c("mk_adae"),
      fn_call_char = c("mk_adae"),
      fn_callable = c(mk_adae)
    )
  )
  # ACT ---------------------------------------------------------------------
  adam <- fn_dt[, eval_data_fn(
    fn = fn_callable,
    study_metadata = list()
  ), by = seq_len(nrow(fn_dt))]


  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(adam), 1)
  expect_equal(nrow(adam$result[[1]]), 1272)
  expect_equal(setdiff("AGEGR2", names(adam$result[[1]])), character())
  expect_equal(adam$result[[1]]$`INDEX_`, seq_len(nrow(adam$result[[1]])))
})


test_that("Fetching adam data works when single data_prepare specified", {
  # SETUP -------------------------------------------------------------------
  ep <-
    rbind(suppressWarnings(
      mk_ep_0001_base(
        data_prepare = mk_adae,
        endpoint_label = "A"
      )
    ))

  ep <- add_id(ep)
  ep_long <-
    suppressWarnings(unnest_endpoint_functions(
      ep,
      fn_cols = c("data_prepare", "stat_by_strata_by_trt")
    ))
  function_dt <- mk_userdef_fn_dt(ep_long)

  # ACT -----------------------------------------------------------------
  adam <-
    fetch_db_data(study_metadata = list(), fn_dt = function_dt)

  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(adam), 1)
  expect_equal(nrow(adam$dat[[1]]), 1272)
  expect_equal(adam$fn_name, "mk_adae")
})


test_that("Only unique adam datasets are returned", {
  # SETUP -------------------------------------------------------------------
  ep <-
    rbind(
      suppressWarnings(
        mk_ep_0001_base(
          data_prepare = mk_adae,
          endpoint_label = "A"
        )
      ),
      suppressWarnings(
        mk_ep_0001_base(
          data_prepare = mk_adae,
          endpoint_label = "B"
        )
      )
    )
  ep <- add_id(ep)
  ep_long <- suppressWarnings(
    unnest_endpoint_functions(ep, fn_cols = c("data_prepare"))
  )
  function_dt <- mk_userdef_fn_dt(ep_long)

  # ACT ---------------------------------------------------------------------

  adam <- fetch_db_data(study_metadata = list(), fn_dt = function_dt)

  # EXPECT ------------------------------------------------------------------
  expect_equal(nrow(adam), 1)
  expect_equal(
    adam$fn_name,
    c("mk_adae")
  )
  expect_equal(
    intersect("AGEGR2", names(adam$dat[[1]])),
    "AGEGR2"
  )
  expect_equal(
    setdiff("TESTVAR", names(adam$dat[[1]])),
    "TESTVAR"
  )
})


test_that("Multiple, but unique adam datasets are returned", {
  # SETUP -------------------------------------------------------------------
  ep <-
    rbind(
      suppressWarnings(
        mk_ep_0001_awaiting_data(
          data_prepare = mk_adae,
          endpoint_label = "a"
        )
      ),
      suppressWarnings(
        mk_ep_0001_awaiting_data(
          data_prepare = mk_adae,
          endpoint_label = "b"
        )
      ),
      suppressWarnings(
        mk_ep_0001_awaiting_data(
          data_prepare = mk_adex,
          endpoint_label = "b"
        )
      )
    )

  ep <- add_id(ep)
  ep_long <-
    suppressWarnings(unnest_endpoint_functions(ep, fn_cols = c("data_prepare")))
  function_dt <- mk_userdef_fn_dt(ep_long)

  # ACT ---------------------------------------------------------------------

  adam <-
    fetch_db_data(study_metadata = list(), fn_dt = function_dt)

  # EXPECT ------------------------------------------------------------------

  expect_equal(nrow(adam), 2)
  expect_equal(
    adam$fn_name,
    c(
      "mk_adae",
      "mk_adex"
    )
  )
})


test_that("data_prepare with no specified input datasets error out", {
  # SETUP -------------------------------------------------------------------

  mk_adam_training_error <- function() {
  }

  ep <-
    rbind(
      suppressWarnings(
        mk_ep_0001_awaiting_data(
          data_prepare = mk_adam_training_error,
          endpoint_label = "a",
          env = environment()
        )
      ),
      suppressWarnings(
        mk_ep_0001_awaiting_data(
          data_prepare = mk_adae,
          endpoint_label = "b"
        )
      )
    )
  study_metadata <-
    c(unlist(ep$study_metadata[[1]]), list(root = "~/training"))
  ep <- add_id(ep)

  ep_long <-
    suppressWarnings(unnest_endpoint_functions(ep, fn_cols = c("data_prepare")))

  # ACT ---------------------------------------------------------------------

  # EXPECT ------------------------------------------------------------------

  # validate_usr_fn_args() will catch errors earlier than at evaluation.
  expect_error(
    function_dt <- mk_userdef_fn_dt(ep_long),
    "Function (mk_adam_training_error) of type (data_prepare) is supplied arguments it does not expect",
    fixed = TRUE
  )
})


test_that("data_prepare with internal error gives useful error msg", {
  # SETUP -------------------------------------------------------------------

  error_fn <- function(study_metadata) {
    stop("problem in function")
  }
  error_fn_2 <- function(study_metadata) {
    stop("another problem in function")
  }
  ep <-
    rbind(
      mk_ep_0001_awaiting_data(
        data_prepare = error_fn,
        endpoint_label = "a",
        env = environment()
      ),
      mk_ep_0001_awaiting_data(
        data_prepare = error_fn_2,
        endpoint_label = "c",
        env = environment()
      )
    )
  study_metadata <-
    c(unlist(ep$study_metadata[[1]]), list(root = "~/training"))
  ep <- add_id(ep)
  ep_long <-
    suppressWarnings(unnest_endpoint_functions(ep, fn_cols = c("data_prepare")))

  function_dt <- mk_userdef_fn_dt(ep_long)

  # ACT ---------------------------------------------------------------------
  # EXPECT ------------------------------------------------------------------

  expect_error(fetch_db_data(study_metadata = study_metadata, fn_dt = function_dt),
    regexp = "error_fn: problem in function"
  )
})


test_that("Fetching/proccessing adsl works", {
  mk_adam_error <- function(study_metadata) {
    nonpackage::test()
  }
  ep <-
    mk_ep_0001_awaiting_data(
      data_prepare = mk_adam_error,
      endpoint_label = "a",
      env = environment()
    )
  study_metadata <-
    c(unlist(ep$study_metadata[[1]]), list(root = "~/training"))
  ep <- add_id(ep)
  ep_long <-
    suppressWarnings(unnest_endpoint_functions(ep, fn_cols = c("data_prepare")))
  function_dt <- mk_userdef_fn_dt(ep_long)

  # ACT ---------------------------------------------------------------------
  # EXPECT ------------------------------------------------------------------

  expect_error(
    fetch_db_data(
      study_metadata =
        study_metadata, fn_dt = function_dt
    ),
    regexp = "mk_adam_error: there is no package called"
  )
})
