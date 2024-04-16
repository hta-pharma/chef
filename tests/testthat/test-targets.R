test_that("Base case: targets pipeline works", {
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
  dump("contingency2x2_strata_test",
       file = "R/custom_functions.R",
       append = TRUE)
  # ACT ---------------------------------------------------------------------
  tar_make()
  # EXPECT ------------------------------------------------------------------
  x <- tar_meta() %>% as.data.table()
  expect_true(all(is.na(x$error)))
  tar_load(ep_stat)
  expect_equal(NROW(ep_stat), 36)
  expect_equal(NCOL(ep_stat), 37)
  expect_snapshot(ep_stat$stat_result_value)
})

test_that("targets pipeline works no criteria fn and missing by_* functions",
          {
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
            tar_load(ep_stat)
            expect_equal(NROW(ep_stat), 18)
            expect_equal(NCOL(ep_stat), 37)
            expect_snapshot(ep_stat$stat_result_value)
          })

test_that("branching after prepare for stats step works", {
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
    mk_adam_fn = list(mk_adae)
  )
  dump("n_subev", file = "R/custom_functions.R")
  dump("n_sub", file = "R/custom_functions.R", append = TRUE)

  # ACT ---------------------------------------------------------------------
  tar_make()

  # EXPECT ------------------------------------------------------------------
  x <- tar_meta() %>% as.data.table()
  expect_true(all(is.na(x$error)))
  tar_load(ep_stat)
  expect_equal(NROW(ep_stat), 12)
  expect_equal(NCOL(ep_stat), 37)
  expect_snapshot(ep_stat$stat_result_value)
})

test_that("ep_fn_map is always outdated", {
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


test_that("study_data responds to changes in source data", {
  # SETUP -------------------------------------------------------------------
  testr::create_local_project()
  saveRDS(data.table(runif(10)), file = "tmp_data_obj.rds")
  mk_test_fn <- function(study_metadata) {
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
  saveRDS(data.table(runif(10)), file = "tmp_data_obj.rds")
  tar_make(study_data)

  # EXPECT ------------------------------------------------------------------
  tar_load(study_data)
  after <- study_data$dat
  expect_equal(intersect(c("study_data"), tar_outdated(names = study_data)), "study_data")
  expect_failure(expect_equal(before, after))
  x <- tar_meta() %>% as.data.table()
  expect_true(all(is.na(x$error)))
})


test_that("Only affected branches outdated when new strata added", {
  # SETUP -------------------------------------------------------------------
  mk_endpoint_def <- function() {
    mk_endpoint_str(
      study_metadata = list(),
      pop_var = "SAFFL",
      pop_value = "Y",
      treatment_var = "TRT01A",
      treatment_refval = "Xanomeline High Dose",
      stratify_by = list(c("SEX")),
      group_by = list(list(AESEV = c())),
      data_prepare = mk_adae,
      custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
      stat_by_strata_by_trt = list(
        "fn_1" = c(n_sub),
        "fn_2_adae" = c(p_subev)
      )
    )
  }

  # This is needed because mk_adcm it is calling from a new R session, it
  # doesn't have access to the helper-* functions from chef
  path <-
    system.file("templates", package = "chef") |> file.path("template-pipeline.R")
  tmp <- readLines(path)
  tar_dir({
    dir.create("R")
    dump("p_subev", file = "R/custom_functions.R")
    dump("n_sub", file = "R/custom_functions.R", append = TRUE)
    dump("mk_adae", file = "R/mk_adae.R")
    dump("mk_adcm", file = "R/mk_adcm.R")
    dump("mk_endpoint_def", file = "R/mk_endpoint_def.R")

    x <-
      whisker::whisker.render(tmp, data = list(r_script_dir = "R/"))
    writeLines(whisker::whisker.render(tmp, data = list(r_script_dir =
                                                          "R/")), con = "_targets.R")
    tar_make()
    # ACT ---------------------------------------------------------------------
    mk_endpoint_def <- function() {
      list(
        mk_endpoint_str(
          study_metadata = list(),
          pop_var = "SAFFL",
          pop_value = "Y",
          treatment_var = "TRT01A",
          treatment_refval = "Xanomeline High Dose",
          stratify_by = list(c("SEX")),
          group_by = list(list(AESEV = c())),
          data_prepare = mk_adae,
          custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
          stat_by_strata_by_trt = list(
            "fn_1" = c(n_sub),
            "fn_2_adae" = c(p_subev)
          )
        ),
        mk_endpoint_str(
          study_metadata = list(),
          pop_var = "SAFFL",
          pop_value = "Y",
          treatment_var = "TRT01A",
          treatment_refval = "Xanomeline High Dose",
          stratify_by = list(c("SEX")),
          data_prepare = mk_adcm,
          custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
          stat_by_strata_by_trt = list("fn_2_adcm" = c(n_sub))
        )
      ) |> data.table::rbindlist()
    }
    dump("mk_endpoint_def", file = "R/mk_endpoint_def.R")
    tar_make()
    x <- tar_meta() |> data.table::setDT()


    # EXPECT ------------------------------------------------------------------
    expect_outdated_patterns <-
      c(
        "study_data",
        "ep_prep_by_strata_by_trt_",
        "ep_stat_by_strata_by_trt_",
        "ep_crit_by_strata_by_trt_",
        "ep_crit_endpoint_"
      )

    timestamp_re_run_target <-
      x[grepl("ep_fn_map", name), time][2]

    # Check that the targets we expected to be skipped were actually
    # skipped
    actual <-
      vapply(expect_outdated_patterns, function(i) {
        rgx <- paste0(i, collapse = "|")
        compar_dt <- x[grepl(rgx, name), .(name, time)]
        NROW(compar_dt[time < timestamp_re_run_target]) == 1
      }, FUN.VALUE = logical(1L))


    # We expect a FALSE for study_data, as this  target should NOT run
    # before ep_fn_map
    expect_equal(actual, c(FALSE, TRUE, TRUE, TRUE, TRUE), ignore_attr = TRUE)
  })
})


test_that("Only affected branches outdated when mk_adam are updated", {
  # SETUP -------------------------------------------------------------------
  mk_endpoint_def <- function() {
    list(
      mk_endpoint_str(
        study_metadata = list(),
        pop_var = "SAFFL",
        pop_value = "Y",
        treatment_var = "TRT01A",
        treatment_refval = "Xanomeline High Dose",
        stratify_by = list(c("SEX")),
        group_by = list(list(AESEV = c())),
        data_prepare = mk_adae,
        custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
        stat_by_strata_by_trt = list(
          "fn_1" = c(n_sub),
          "fn_2_adae" = c(p_subev)
        )
      ),
      mk_endpoint_str(
        study_metadata = list(),
        pop_var = "SAFFL",
        pop_value = "Y",
        treatment_var = "TRT01A",
        treatment_refval = "Xanomeline High Dose",
        stratify_by = list(c("SEX")),
        data_prepare = mk_adcm,
        custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
        stat_by_strata_by_trt = list("fn_2_adcm" = c(n_sub))
      )
    ) |> data.table::rbindlist()
  }

  # This is needed because mk_adcm it is calling from a new R session, it
  # doesn't have access to the helper-* functions from chef
  path <-
    system.file("templates", package = "chef") |> file.path("template-pipeline.R")
  tmp <- readLines(path)
  tar_dir({
    dir.create("R")
    dump("p_subev", file = "R/custom_functions.R")
    dump("n_sub", file = "R/custom_functions.R", append = TRUE)
    dump("mk_adae", file = "R/mk_adae.R")
    dump("mk_adcm", file = "R/mk_adcm.R")
    dump("mk_endpoint_def", file = "R/mk_endpoint_def.R")

    x <-
      whisker::whisker.render(tmp, data = list(r_script_dir = "R/"))
    writeLines(whisker::whisker.render(tmp, data = list(r_script_dir =
                                                          "R/")), con = "_targets.R")
    tar_make()
    # ACT ---------------------------------------------------------------------
    mk_adae <- function(study_metadata) {
      adsl <- data.table::as.data.table(pharmaverseadam::adsl)
      adsl[, AGEGR2 := data.table::fcase(
        AGE < 65, "AGE < 65",
        AGE >= 65, "AGE >= 65"
      )]

      adae <- data.table::as.data.table(pharmaverseadam::adae)

      adae_out <-
        merge(adsl, adae[, c(setdiff(names(adae), names(adsl)), "USUBJID"),
                         with =
                           F
        ], by = "USUBJID", all = TRUE)
      adae_out[]
    }

    dump("mk_adae", file = "R/mk_adae.R")
    tar_make()
    x <- tar_meta() |> data.table::setDT()


    # EXPECT ------------------------------------------------------------------
    expect_outdated_patterns <-
      c(
        "study_data",
        "ep_prep_by_strata_by_trt_",
        "ep_stat_by_strata_by_trt_",
        "ep_crit_by_strata_by_trt_",
        "ep_crit_endpoint_"
      )

    timestamp_re_run_target <-
      x[grepl("ep_fn_map", name), time][2]

    # Check that the targets we expected to be skipped were actually
    # skipped
    actual <-
      vapply(expect_outdated_patterns, function(i) {
        rgx <- paste0(i, collapse = "|")
        compar_dt <- x[grepl(rgx, name), .(name, time)]
        NROW(compar_dt[time < timestamp_re_run_target]) == 1
      }, FUN.VALUE = logical(1L))


    # We expect a FALSE for study_data, as this  target should NOT run
    # before ep_fn_map
    expect_equal(actual, c(FALSE, TRUE, TRUE, TRUE, TRUE), ignore_attr = TRUE)

    })
})

test_that(
  "Check for discordant columns in result data model when having one endpoint spec without grouping and one endpoint spec with grouping",
  {
    # SETUP -------------------------------------------------------------------
    mk_endpoint_def <- function() {
      ep <- mk_endpoint_str(
        study_metadata = list(),
        pop_var = "SAFFL",
        pop_value = "Y",
        treatment_var = "TRT01A",
        treatment_refval = "Xanomeline High Dose",
        stratify_by = list(c("SEX", "AGEGR1")),
        data_prepare = mk_adae,
        endpoint_label = "A",
        custom_pop_filter =
          "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
        group_by = list(list(
          AESOC = c(), AESEV = c()
        )),
        stat_by_strata_by_trt = list(c(n_sub))
      )

      ep2 <- mk_endpoint_str(
        data_prepare = mk_advs,
        treatment_var = "TRT01A",
        treatment_refval = "Xanomeline High Dose",
        pop_var = "SAFFL",
        pop_value = "Y",
        stratify_by = list(c("AGEGR1", "SEX")),
        stat_by_strata_by_trt = list(c(n_sub)),
        endpoint_label = "Demographics endpoint (categorical measures)"
      )

      data.table::rbindlist(list(ep, ep2))
    }

    mk_advs <- function(study_metadata) {
      # Read ADSL
      adsl <- data.table::as.data.table(pharmaverseadam::adsl)

      # Filter treatment arms
      adsl <-
        adsl[adsl$TRT01A %in% c("Placebo", "Xanomeline High Dose")]
      adsl[1, AGEGR1 := NA_character_]
      adsl[2:10, SEX := NA_character_]

      # Read ADVS
      advs <- data.table::as.data.table(pharmaverseadam::advs)

      # Identify baseline body weight
      advs_bw <-
        advs[advs$PARAMCD == "WEIGHT" & advs$VISIT == "BASELINE"]

      # Create new variable BW_BASELINE
      advs_bw[["BW_BASELINE"]] <- advs_bw[["AVAL"]]

      # Merge ADSL, ADAE and baseline body weight from ADVS
      adam_out <-
        merge(adsl, advs_bw[, c("BW_BASELINE", "USUBJID")], by = "USUBJID", all.x = TRUE)

      return(adam_out)
    }

    # This is needed because mk_adcm it is calling from a new R session, it
    # doesn't have access to the helper-* functions from chef
    path <-
      system.file("templates", package = "chef") |>
      file.path("template-pipeline.R")
    tmp <- readLines(path)

    # ACT ---------------------------------------------------------------------

    tar_dir({
      dir.create("R")
      dump("n_sub", file = "R/custom_functions.R")
      dump("mk_adae", file = "R/mk_adae.R")
      dump("mk_advs", file = "R/mk_advs.R")
      dump("mk_endpoint_def", file = "R/mk_endpoint_def.R")

      x <-
        whisker::whisker.render(tmp, data = list(r_script_dir = "R/"))
      writeLines(whisker::whisker.render(tmp, data = list(r_script_dir = "R/")), con = "_targets.R")

      tar_make()

      # EXPECT ------------------------------------------------------------------


      targets::tar_load(ep_stat)
      expect_equal(nrow(ep_stat), 700)
      expect_equal(ncol(ep_stat), 37)
      expect_equal(sum(ep_stat$endpoint_spec_id == 1), 690)
      expect_equal(sum(ep_stat$endpoint_spec_id == 2), 10)

      x <- tar_meta() |> data.table::setDT()
      expect_false(any(!is.na(x$error)))
    })
  }
)
