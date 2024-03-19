test_that("No specification of pop_var", {
  # SETUP -------------------------------------------------------------------
  # ACT ---------------------------------------------------------------------
  # EXPECT ------------------------------------------------------------------
  expect_error(
    mk_endpoint_str(
      pop_value = "Y",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      period_var = "ANL01FL",
      period_value = "Y",
      data_prepare = mk_adae
    )
  )
})

test_that("No specification of pop_value", {
  # SETUP -------------------------------------------------------------------
  # ACT ---------------------------------------------------------------------
  # EXPECT ------------------------------------------------------------------
  expect_error(
    mk_endpoint_str(
      pop_var = "SAFFL",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      period_var = "ANL01FL",
      period_value = "Y",
      data_prepare = mk_adae
    )
  )
})

test_that("No specification of treatment_var", {
  # SETUP -------------------------------------------------------------------
  # ACT ---------------------------------------------------------------------
  # EXPECT ------------------------------------------------------------------
  expect_error(
    mk_endpoint_str(
      pop_var = "SAFFL",
      pop_value = "Y",
      treatment_refval = "Xanomeline High Dose",
      period_var = "ANL01FL",
      period_value = "Y",
      data_prepare = mk_adae
    )
  )
})

test_that("No specification of treatment_refval", {
  # SETUP -------------------------------------------------------------------
  # ACT ---------------------------------------------------------------------
  # EXPECT ------------------------------------------------------------------
  expect_error(
    mk_endpoint_str(
      pop_var = "SAFFL",
      pop_value = "Y",
      treatment_var = "TRT01A",
      period_var = "ANL01FL",
      period_value = "Y",
      data_prepare = mk_adae
    )
  )
})

test_that("No specification of period_var", {
  # SETUP -------------------------------------------------------------------
  # ACT ---------------------------------------------------------------------
  actual <- mk_endpoint_str(
    pop_var = "SAFFL",
    pop_value = "Y",
    treatment_var = "TRT01A",
    treatment_refval = "Xanomeline High Dose",
    data_prepare = mk_adae
  )
  # EXPECT ------------------------------------------------------------------
  expect_s3_class(actual, "data.table")
  expect_equal(nrow(actual), 1)
})


test_that("No specification of data_prepare", {
  # SETUP -------------------------------------------------------------------
  # ACT ---------------------------------------------------------------------
  # EXPECT ------------------------------------------------------------------
  expect_error(
    mk_endpoint_str(
      pop_var = "SAFFL",
      pop_value = "Y",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      period_var = "ANL01FL",
      period_value = "Y"
    )
  )
})

test_that("Specification of non-existing data_prepare", {
  # SETUP -------------------------------------------------------------------
  # ACT ---------------------------------------------------------------------
  # EXPECT ------------------------------------------------------------------
  expect_error(
    mk_endpoint_str(
      pop_var = "SAFFL",
      pop_value = "Y",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      period_var = "ANL01FL",
      period_value = "Y",
      data_prepare = mk_adae_notexist
    )
  )
})

test_that("Specification of non-existing stat_by_strata_by_trt function", {
  # SETUP -------------------------------------------------------------------
  # ACT ---------------------------------------------------------------------
  # EXPECT ------------------------------------------------------------------
  expect_error(
    mk_endpoint_str(
      pop_var = "SAFFL",
      pop_value = "Y",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      period_var = "ANL01FL",
      period_value = "Y",
      data_prepare = mk_adae,
      stat_by_strata_by_trt = list(
        "N_subjects" = n_subj_notexist
      )
    )
  )
})

test_that("Specification of non-existing stat_by_strata_by_trt function", {
  # SETUP -------------------------------------------------------------------
  # ACT ---------------------------------------------------------------------
  # EXPECT ------------------------------------------------------------------
  expect_error(
    mk_endpoint_str(
      pop_var = "SAFFL",
      pop_value = "Y",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      period_var = "ANL01FL",
      period_value = "Y",
      data_prepare = mk_adae,
      stat_by_strata_across_trt = list(
        "N_subjects" = n_subj_notexist
      )
    )
  )
})

test_that("Specification of non-existing stat_across_strata_across_trt function", {
  # SETUP -------------------------------------------------------------------
  # ACT ---------------------------------------------------------------------
  # EXPECT ------------------------------------------------------------------
  expect_error(
    mk_endpoint_str(
      pop_var = "SAFFL",
      pop_value = "Y",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      period_var = "ANL01FL",
      period_value = "Y",
      data_prepare = mk_adae,
      stat_across_strata_across_trt = list(
        "N_subjects" = n_subj_notexist
      )
    )
  )
})


test_that("naked functions are correctly stored", {
  # SETUP -------------------------------------------------------------------
  crit_fn <- function(...) {
    return(F)
  }
  # ACT ---------------------------------------------------------------------
  # EXPECT ------------------------------------------------------------------

  actual <- mk_endpoint_str(
    pop_var = "SAFFL",
    pop_value = "Y",
    treatment_var = "TRT01A",
    treatment_refval = "Xanomeline High Dose",
    period_var = "ANL01FL",
    period_value = "Y",
    data_prepare = mk_adae,
    crit_endpoint = crit_fn,
    crit_by_strata_by_trt = crit_fn,
    crit_by_strata_across_trt = crit_fn,
    stat_by_strata_by_trt = crit_fn,
  )

  expected <- mk_endpoint_str(
    pop_var = "SAFFL",
    pop_value = "Y",
    treatment_var = "TRT01A",
    treatment_refval = "Xanomeline High Dose",
    period_var = "ANL01FL",
    period_value = "Y",
    data_prepare = mk_adae,
    crit_endpoint = list(crit_fn),
    crit_by_strata_by_trt = list(crit_fn),
    crit_by_strata_across_trt = list(crit_fn),
    stat_by_strata_by_trt = list(crit_fn)
  )
  expect_equal(actual$crit_endpoint, expected$crit_endpoint)
  expect_equal(actual$crit_by_strata_across_trt, expected$crit_by_strata_across_trt)
  expect_equal(actual$crit_by_strata_by_trt, expected$crit_by_strata_by_trt)
  expect_equal(actual$stat_by_strata_by_trt, expected$stat_by_strata_by_trt)
})


# test_that("Specification of non-existing crit_endpoint function", {
#   # SETUP -------------------------------------------------------------------
#   # ACT ---------------------------------------------------------------------
#   # EXPECT ------------------------------------------------------------------
#   expect_error(
#     mk_endpoint_str(
#       pop_var = "SAFFL",
#       pop_value = "Y",
#       treatment_var = "TRT01A",
#       treatment_refval = "Xanomeline High Dose",
#       period_var = "ANL01FL",
#       period_value = "Y",
#       data_prepare = mk_adae,
#       crit_endpoint = list(c(criterion_notexist))
#   ))
# })

# test_that("Specification of non-existing crit_by_strata_by_trt function", {
#   # SETUP -------------------------------------------------------------------
#   # ACT ---------------------------------------------------------------------
#   # EXPECT ------------------------------------------------------------------
#   expect_error(
#     mk_endpoint_str(
#       pop_var = "SAFFL",
#       pop_value = "Y",
#       treatment_var = "TRT01A",
#       treatment_refval = "Xanomeline High Dose",
#       period_var = "ANL01FL",
#       period_value = "Y",
#       data_prepare = mk_adae,
#       crit_by_strata_by_trt = list(c(criterion_notexist))
#   ))
# })

# test_that("Specification of non-existing crit_by_strata_across_trt function", {
#   # SETUP -------------------------------------------------------------------
#   # ACT ---------------------------------------------------------------------
#   # EXPECT ------------------------------------------------------------------
#   expect_error(
#     mk_endpoint_str(
#       pop_var = "SAFFL",
#       pop_value = "Y",
#       treatment_var = "TRT01A",
#       treatment_refval = "Xanomeline High Dose",
#       period_var = "ANL01FL",
#       period_value = "Y",
#       data_prepare = mk_adae,
#       crit_by_strata_across_trt = list(c(criterion_notexist))
#   ))
# })

# test_that("Invalid arguments to existing stat_by_strata_by_trt function", {
#   # SETUP -------------------------------------------------------------------
#   # ACT ---------------------------------------------------------------------
#   # EXPECT ------------------------------------------------------------------
#   expect_error(
#     mk_endpoint_str(
#       pop_var = "SAFFL",
#       pop_value = "Y",
#       treatment_var = "TRT01A",
#       treatment_refval = "Xanomeline High Dose",
#       period_var = "ANL01FL",
#       period_value = "Y",
#       data_prepare = mk_adae,
#       stat_by_strata_by_trt = list(
#         "N_subjects" = c(n_sub, subjectid_var2="USUBJID"))
#   ))
# })

# test_that("Invalid arguments to existing stat_by_strata_across_trt function", {
#   # SETUP -------------------------------------------------------------------
#   # ACT ---------------------------------------------------------------------
#   # EXPECT ------------------------------------------------------------------
#   expect_error(
#     mk_endpoint_str(
#       pop_var = "SAFFL",
#       pop_value = "Y",
#       treatment_var = "TRT01A",
#       treatment_refval = "Xanomeline High Dose",
#       period_var = "ANL01FL",
#       period_value = "Y",
#       data_prepare = mk_adae,
#       stat_by_strata_across_trt = list(
#         "N_subjects" = c(n_sub, subjectid_var2="USUBJID")
#   ))
# })

# test_that("Invalid arguments to existing stat_across_strata_across_trt function", {
#   # SETUP -------------------------------------------------------------------
#   # ACT ---------------------------------------------------------------------
#   # EXPECT ------------------------------------------------------------------
#   expect_error(
#     mk_endpoint_str(
#       pop_var = "SAFFL",
#       pop_value = "Y",
#       treatment_var = "TRT01A",
#       treatment_refval = "Xanomeline High Dose",
#       period_var = "ANL01FL",
#       period_value = "Y",
#       data_prepare = mk_adae,
#       stat_across_strata_across_trt = list(
#         "N_subjects" = c(n_sub, subjectid_var2="USUBJID")
#   ))
# })

# test_that("Invalid arguments to existing crit_endpoint function", {
#   # SETUP -------------------------------------------------------------------
#   # ACT ---------------------------------------------------------------------
#   # EXPECT ------------------------------------------------------------------
#   expect_error(
#     mk_endpoint_str(
#       pop_var = "SAFFL",
#       pop_value = "Y",
#       treatment_var = "TRT01A",
#       treatment_refval = "Xanomeline High Dose",
#       period_var = "ANL01FL",
#       period_value = "Y",
#       data_prepare = mk_adae,
#       crit_endpoint = list(c(crit_ep_dummy, var1 = "test"))
#     ))
# })

# test_that("Invalid arguments to existing crit_by_strata_by_trt function", {
#   # SETUP -------------------------------------------------------------------
#   # ACT ---------------------------------------------------------------------
#   # EXPECT ------------------------------------------------------------------
#   expect_error(
#     mk_endpoint_str(
#       pop_var = "SAFFL",
#       pop_value = "Y",
#       treatment_var = "TRT01A",
#       treatment_refval = "Xanomeline High Dose",
#       period_var = "ANL01FL",
#       period_value = "Y",
#       data_prepare = mk_adae,
#       crit_by_strata_by_trt = list(c(crit_sgd_dummy, var1 = "test"))
#     ))
# })

# test_that("Invalid arguments to existing crit_by_strata_across_trt function", {
#   # SETUP -------------------------------------------------------------------
#   # ACT ---------------------------------------------------------------------
#   # EXPECT ------------------------------------------------------------------
#   expect_error(
#     mk_endpoint_str(
#       pop_var = "SAFFL",
#       pop_value = "Y",
#       treatment_var = "TRT01A",
#       treatment_refval = "Xanomeline High Dose",
#       period_var = "ANL01FL",
#       period_value = "Y",
#       data_prepare = mk_adae,
#       crit_by_strata_across_trt = list(c(crit_sga_dummy, var1 = "test"))
#     ))
# })

test_that("Column types of endpoint specification with complete function specification", {
  # SETUP -------------------------------------------------------------------

  expected_cols <- c(
    "study_metadata", "pop_var", "pop_value", "treatment_var",
    "treatment_refval", "period_var", "period_value", "custom_pop_filter",
    "endpoint_filter", "group_by", "stratify_by", "endpoint_label",
    "data_prepare", "stat_by_strata_by_trt", "stat_by_strata_across_trt",
    "stat_across_strata_across_trt", "crit_endpoint", "crit_by_strata_by_trt",
    "crit_by_strata_across_trt", "only_strata_with_events"
  )

  chr_cols <- c(
    "pop_var", "pop_value", "treatment_var", "treatment_refval",
    "period_var", "period_value", "custom_pop_filter",
    "endpoint_filter", "endpoint_label"
  )

  fn_cols <- c(
    "data_prepare", "stat_by_strata_by_trt",
    "stat_by_strata_across_trt", "stat_across_strata_across_trt", "crit_endpoint",
    "crit_by_strata_by_trt", "crit_by_strata_across_trt"
  )

  crit_ep_dummy <- function(...) {
    return(T)
  }
  crit_sgd_dummy <- function(...) {
    return(T)
  }
  crit_sga_dummy <- function(...) {
    return(T)
  }

  # ACT ---------------------------------------------------------------------

  ep <- mk_ep_0001_base(
    data_prepare = mk_adae,
    group_by = list(list(RACE = c())),
    stat_by_strata_by_trt = list(
      "n_sub" = n_sub,
      "n_subev" = n_subev
    ),
    stat_by_strata_across_trt = list("n_sub" = n_sub),
    stat_across_strata_across_trt = list("n_subev" = n_subev),
    crit_endpoint = list(c(crit_ep_dummy, var1 = "test")),
    crit_by_strata_by_trt = list(c(crit_sgd_dummy, var1 = "test")),
    crit_by_strata_across_trt = list(c(crit_sga_dummy, var1 = "test")),
    endpoint_label = "This is a test"
  )

  # EXPECT ------------------------------------------------------------------

  # Check set of output columns
  expect_equal(setdiff(names(ep), expected_cols), character(0))

  # Check character columns
  for (i in chr_cols) {
    # Check column type is character
    expect_equal(typeof(ep[[i]]), "character", info = paste("Column:", i))
  }

  # Check endpoint label
  expect_equal(ep[["endpoint_label"]], "This is a test")

  # Check named list columns
  nlst_cols <- c("study_metadata", "group_by")
  for (i in nlst_cols) {
    # Check column type is list
    # expect_equal(typeof(ep[[i]]), "list", info = paste("Column:", i))

    # ** Temporary **
    # Check column type is list or NA
    expect_equal(typeof(ep[[i]]) %in% c("list", "character"), TRUE, info = paste("Column:", i))
  }

  # Check that group_by entries are named or the list content is NULL
  # expect_equal(all(lapply(ep[["group_by"]],
  #                         function(x){length(names(x))>0 | identical(x, list(NULL))})), TRUE,
  #              info = paste("Column:", i))

  # ** Temporary **
  # Check that group_by entries are named or is a character NA
  expect_equal(
    unlist(lapply(
      ep[["group_by"]],
      function(x) {
        length(names(x)) > 0 | identical(x, NA_character_)
      }
    )), TRUE,
    info = paste("Column:", i)
  )

  # Check unnamed list columns
  lst_cols <- c("stratify_by")
  for (i in lst_cols) {
    # Check column type is list
    expect_equal(typeof(ep[[i]]), "list", info = paste("Column:", i))
    # Check that list entries are character
    expect_equal(
      all(unlist(lapply(
        ep[[i]],
        function(x) {
          is.character(x)
        }
      ))), TRUE,
      info = paste("Column:", i)
    )
  }

  # Check function columns
  for (i in fn_cols) {
    # Check column type is list of length 1
    expect_equal(typeof(ep[[i]]), "list", info = paste("Column:", i))

    # Check that content of each list is language
    expect_equal(typeof(ep[[i]][[1]]), "language", info = paste("Column:", i))
  }

  # Check that lists of statistical functions are named
  expect_equal(typeof(names(eval(ep[["stat_by_strata_by_trt"]][[1]]))), "character")
  expect_equal(typeof(names(eval(ep[["stat_by_strata_across_trt"]][[1]]))), "character")
  expect_equal(typeof(names(eval(ep[["stat_across_strata_across_trt"]][[1]]))), "character")
})

test_that("Column types of minimal endpoint specification", {
  # SETUP -------------------------------------------------------------------

  expected_cols <- c(
    "study_metadata", "pop_var", "pop_value", "treatment_var",
    "treatment_refval", "period_var", "period_value", "custom_pop_filter",
    "endpoint_filter", "group_by", "stratify_by", "endpoint_label",
    "data_prepare", "stat_by_strata_by_trt", "stat_by_strata_across_trt",
    "stat_across_strata_across_trt", "crit_endpoint", "crit_by_strata_by_trt",
    "crit_by_strata_across_trt", "only_strata_with_events"
  )

  chr_cols <- c(
    "pop_var", "pop_value", "treatment_var", "treatment_refval",
    "period_var", "period_value", "custom_pop_filter",
    "endpoint_filter", "endpoint_label"
  )

  fn_cols <- c(
    "data_prepare", "stat_by_strata_by_trt",
    "stat_by_strata_across_trt", "stat_across_strata_across_trt", "crit_endpoint",
    "crit_by_strata_by_trt", "crit_by_strata_across_trt"
  )

  # ACT ---------------------------------------------------------------------

  ep <- mk_ep_0001_base(data_prepare = mk_adae)

  # EXPECT ------------------------------------------------------------------

  # Check set of output columns
  expect_equal(setdiff(names(ep), expected_cols), character(0))

  # Check character columns
  for (i in chr_cols) {
    # Check column type is character
    expect_equal(typeof(ep[[i]]), "character", info = paste("Column:", i))
  }

  # Check endpoint label
  expect_equal(ep[["endpoint_label"]], NA_character_)

  # Check named list columns
  nlst_cols <- c("study_metadata", "group_by")
  for (i in nlst_cols) {
    # Check column type is list
    # expect_equal(typeof(ep[[i]]), "list", info = paste("Column:", i))

    # ** Temporary **
    # Check column type is list or NA
    expect_equal(typeof(ep[[i]]) %in% c("list", "character"), TRUE, info = paste("Column:", i))
  }

  # Check that group_by entries are named or the list content is NULL
  # expect_equal(all(lapply(ep[["group_by"]],
  #                         function(x){length(names(x))>0 | identical(x, list(NULL))})), TRUE,
  #              info = paste("Column:", i))

  # ** Temporary **
  # Check that group_by entries are named or is a character NA
  expect_equal(
    unlist(lapply(
      ep[["group_by"]],
      function(x) {
        length(names(x)) > 0 | identical(x, NA_character_)
      }
    )), TRUE,
    info = paste("Column:", i)
  )

  # Check unnamed list columns
  lst_cols <- c("stratify_by")
  for (i in lst_cols) {
    # Check column type is list
    expect_equal(typeof(ep[[i]]), "list", info = paste("Column:", i))
    # Check that list entries are character
    expect_equal(
      all(unlist(lapply(
        ep[[i]],
        function(x) {
          is.character(x)
        }
      ))), TRUE,
      info = paste("Column:", i)
    )
  }

  # Check function columns
  for (i in fn_cols) {
    # Check column type is list of length 1
    expect_equal(typeof(ep[[i]]), "list", info = paste("Column:", i))

    # Check that content of each list is language
    # expect_equal(typeof(ep[[i]][[1]]), "language", info = paste("Column:", i))

    # ** Temporary **
    # Check that content of each list is language or NULL
    expect_equal(typeof(ep[[i]][[1]]) %in% c("language", "NULL"), TRUE, info = paste("Column:", i))
  }
})
