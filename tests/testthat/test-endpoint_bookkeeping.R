test_that("Bookkeeping of rejected endpoints/strata", {
  # SETUP -------------------------------------------------------------------

  crit_ep <- function(dat,
                      event_index,
                      endpoint_group_metadata,
                      ...) {
    if (endpoint_group_metadata[["AESOC"]] %in% c(
      "CARDIAC DISORDERS",
      "INFECTIONS AND INFESTATIONS",
      "SKIN AND SUBCUTANEOUS TISSUE DISORDERS",
      "VASCULAR DISORDERS"
    )) {
      return(TRUE)
    }
    return(FALSE)
  }
  crit_bb <- function(dat,
                      event_index,
                      endpoint_group_metadata,
                      strata_var,
                      ...) {
    if (endpoint_group_metadata[["AESOC"]] == "CARDIAC DISORDERS" |
      (endpoint_group_metadata[["AESOC"]] == "INFECTIONS AND INFESTATIONS" & strata_var == "TOTAL_") |
      (endpoint_group_metadata[["AESOC"]] %in% c("SKIN AND SUBCUTANEOUS TISSUE DISORDERS", "VASCULAR DISORDERS") &
        strata_var %in% c("TOTAL_", "AGEGR2")
      )) {
      return(TRUE)
    } else {
      return(FALSE)
    }
  }
  crit_ba <- function(dat,
                      event_index,
                      endpoint_group_metadata,
                      strata_var,
                      ...) {
    if (endpoint_group_metadata[["AESOC"]] %in% c(
      "CARDIAC DISORDERS",
      "INFECTIONS AND INFESTATIONS",
      "SKIN AND SUBCUTANEOUS TISSUE DISORDERS"
    ) | (endpoint_group_metadata[["AESOC"]] == "VASCULAR DISORDERS" & strata_var == "TOTAL_")) {
      return(TRUE)
    } else {
      return(FALSE)
    }
  }

  ep <- mk_ep_0001_base(
    stratify_by = list(c("SEX", "AGEGR2")),
    data_prepare = mk_adae,
    custom_pop_filter = "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
    endpoint_label = "Test: <AESOC>",
    group_by = list(list(AESOC = c())),
    stat_by_strata_by_trt = list(
      "n_subev" = n_subev,
      "p_subev" = p_subev
    ),
    stat_by_strata_across_trt = list("n_subev_trt_diff" = n_subev_trt_diff),
    stat_across_strata_across_trt = list("P-interaction" = contingency2x2_strata_test),
    crit_endpoint = list(crit_ep),
    crit_by_strata_by_trt = list(crit_bb),
    crit_by_strata_across_trt = list(crit_ba)
  )

  study_metadata <- list()
  ep <- add_id(ep)

  ep_fn_map <- suppressWarnings(unnest_endpoint_functions(ep))
  user_def_fn <- mk_userdef_fn_dt(ep_fn_map, env = environment())

  fn_map <-
    merge(ep_fn_map[, .(endpoint_spec_id, fn_hash)], user_def_fn, by = "fn_hash")

  adam_db <-
    fetch_db_data(
      study_metadata = ep$study_metadata[[1]],
      fn_dt = user_def_fn
    )

  ep_and_data <- filter_db_data(ep, ep_fn_map, adam_db)
  ep_data_key <- ep_and_data$ep
  analysis_data_container <- ep_and_data$analysis_data_container
  ep_expanded <-
    expand_over_endpoints(ep_data_key, analysis_data_container)

  ep_ev_index <-
    add_event_index(ep_expanded, analysis_data_container)

  ep_crit_endpoint <-
    apply_criterion_endpoint(ep_ev_index, analysis_data_container, fn_map)
  ep_crit_by_strata_by_trt <-
    apply_criterion_by_strata(ep_crit_endpoint, analysis_data_container, fn_map)
  ep_crit_by_strata_across_trt <-
    apply_criterion_by_strata(ep_crit_by_strata_by_trt,
      analysis_data_container,
      fn_map,
      type = "by_strata_across_trt"
    )

  # ACT ---------------------------------------------------------------------

  ep_prep_by_strata_by_trt <-
    prepare_for_stats(ep_crit_by_strata_across_trt,
      analysis_data_container,
      fn_map,
      type = "stat_by_strata_by_trt"
    )


  ep_prep_by_strata_across_trt <-
    prepare_for_stats(ep_crit_by_strata_across_trt,
      analysis_data_container,
      fn_map,
      type = "stat_by_strata_across_trt"
    )

  ep_prep_across_strata_across_trt <-
    prepare_for_stats(ep_crit_by_strata_across_trt,
      analysis_data_container,
      fn_map,
      type = "stat_across_strata_across_trt"
    )


  ep_rejected <- ep_crit_by_strata_across_trt[!(crit_accept_endpoint) |
    !(crit_accept_by_strata_by_trt) |
    !(crit_accept_by_strata_across_trt)]

  # EXPECT ------------------------------------------------------------------

  # by_strata_by_trt: Summary
  expect_equal(nrow(ep_prep_by_strata_by_trt), 48)
  expect_equal(nrow(ep_prep_by_strata_by_trt[fn_name == "n_subev", ]), 24)
  expect_equal(nrow(ep_prep_by_strata_by_trt[fn_name == "p_subev", ]), 24)

  # by_strata_by_trt: CARDIAC DISORDERS
  ep_soc1 <- ep_prep_by_strata_by_trt[grepl("CARDIAC DISORDERS", endpoint_label), ]
  expect_equal(nrow(ep_soc1), 20)
  expect_equal(nrow(ep_soc1[strata_var == "TOTAL_", ]), 4)
  expect_equal(nrow(ep_soc1[strata_var == "SEX", ]), 8)
  expect_equal(nrow(ep_soc1[strata_var == "AGEGR2", ]), 8)

  # by_strata_by_trt: INFECTIONS AND INFESTATIONS
  ep_soc2 <- ep_prep_by_strata_by_trt[grepl("INFECTIONS AND INFESTATIONS", endpoint_label), ]
  expect_equal(nrow(ep_soc2), 4)
  expect_equal(nrow(ep_soc2[strata_var == "TOTAL_", ]), 4)

  # by_strata_by_trt: SKIN AND SUBCUTANEOUS TISSUE DISORDERS
  ep_soc3 <- ep_prep_by_strata_by_trt[grepl("SKIN AND SUBCUTANEOUS TISSUE DISORDERS", endpoint_label), ]
  expect_equal(nrow(ep_soc3), 12)
  expect_equal(nrow(ep_soc3[strata_var == "TOTAL_", ]), 4)
  expect_equal(nrow(ep_soc3[strata_var == "AGEGR2", ]), 8)

  # by_strata_by_trt: VASCULAR DISORDERS
  ep_soc4 <- ep_prep_by_strata_by_trt[grepl("VASCULAR DISORDERS", endpoint_label), ]
  expect_equal(nrow(ep_soc4), 12)
  expect_equal(nrow(ep_soc4[strata_var == "TOTAL_", ]), 4)
  expect_equal(nrow(ep_soc4[strata_var == "AGEGR2", ]), 8)

  # by_strata_across_trt: Summary
  expect_equal(nrow(ep_prep_by_strata_across_trt), 10)
  expect_equal(nrow(ep_prep_by_strata_across_trt[fn_name == "n_subev_trt_diff", ]), 10)

  # by_strata_across_trt: CARDIAC DISORDERS
  ep_soc5 <- ep_prep_by_strata_across_trt[grepl("CARDIAC DISORDERS", endpoint_label), ]
  expect_equal(nrow(ep_soc5), 5)
  expect_equal(nrow(ep_soc5[strata_var == "TOTAL_", ]), 1)
  expect_equal(nrow(ep_soc5[strata_var == "SEX", ]), 2)
  expect_equal(nrow(ep_soc5[strata_var == "AGEGR2", ]), 2)

  # by_strata_across_trt: INFECTIONS AND INFESTATIONS
  ep_soc6 <- ep_prep_by_strata_across_trt[grepl("INFECTIONS AND INFESTATIONS", endpoint_label), ]
  expect_equal(nrow(ep_soc6), 1)
  expect_equal(nrow(ep_soc6[strata_var == "TOTAL_", ]), 1)

  # by_strata_across_trt: SKIN AND SUBCUTANEOUS TISSUE DISORDERS
  ep_soc7 <- ep_prep_by_strata_across_trt[grepl("SKIN AND SUBCUTANEOUS TISSUE DISORDERS", endpoint_label), ]
  expect_equal(nrow(ep_soc7), 3)
  expect_equal(nrow(ep_soc7[strata_var == "TOTAL_", ]), 1)
  expect_equal(nrow(ep_soc7[strata_var == "AGEGR2", ]), 2)

  # by_strata_across_trt: VASCULAR DISORDERS
  ep_soc8 <- ep_prep_by_strata_across_trt[grepl("VASCULAR DISORDERS", endpoint_label), ]
  expect_equal(nrow(ep_soc8), 1)
  expect_equal(nrow(ep_soc8[strata_var == "TOTAL_", ]), 1)

  # across_strata_across_trt: Summary
  expect_equal(nrow(ep_prep_across_strata_across_trt), 3)
  expect_equal(nrow(ep_prep_across_strata_across_trt[fn_name == "P-interaction", ]), 3)

  # across_strata_across_trt: CARDIAC DISORDERS
  ep_soc9 <- ep_prep_across_strata_across_trt[grepl("CARDIAC DISORDERS", endpoint_label), ]
  expect_equal(nrow(ep_soc9), 2)
  expect_equal(nrow(ep_soc9[strata_var == "SEX", ]), 1)
  expect_equal(nrow(ep_soc9[strata_var == "AGEGR2", ]), 1)

  # across_strata_across_trt: INFECTIONS AND INFESTATIONS
  ep_soc10 <- ep_prep_across_strata_across_trt[grepl("INFECTIONS AND INFESTATIONS", endpoint_label), ]
  expect_equal(nrow(ep_soc10), 0)

  # across_strata_across_trt: SKIN AND SUBCUTANEOUS TISSUE DISORDERS
  ep_soc11 <- ep_prep_across_strata_across_trt[grepl("SKIN AND SUBCUTANEOUS TISSUE DISORDERS", endpoint_label), ]
  expect_equal(nrow(ep_soc11), 1)
  expect_equal(nrow(ep_soc11[strata_var == "AGEGR2", ]), 1)

  # across_strata_across_trt: VASCULAR DISORDERS
  ep_soc12 <- ep_prep_across_strata_across_trt[grepl("VASCULAR DISORDERS", endpoint_label), ]
  expect_equal(nrow(ep_soc12), 0)

  # Rejected entities
  expect_equal(nrow(ep_rejected), 24)

  # Rejected endpoints
  expect_equal(nrow(ep_rejected[crit_accept_endpoint == FALSE, ]), 19)

  # Rejected by_strata_by_trt: Summary
  ep_reject1 <- ep_rejected[crit_accept_endpoint == TRUE & crit_accept_by_strata_by_trt == FALSE, ]
  expect_equal(nrow(ep_reject1), 4)

  # Rejected by_strata_by_trt: INFECTIONS AND INFESTATIONS
  ep_reject2 <- ep_reject1[grepl("INFECTIONS AND INFESTATIONS", endpoint_label), ]
  expect_equal(nrow(ep_reject2), 2)
  expect_equal(nrow(ep_reject2[strata_var == "SEX"]), 1)
  expect_equal(nrow(ep_reject2[strata_var == "AGEGR2"]), 1)

  # Rejected by_strata_by_trt: SKIN AND SUBCUTANEOUS TISSUE DISORDERS
  ep_reject3 <- ep_reject1[grepl("SKIN AND SUBCUTANEOUS TISSUE DISORDERS", endpoint_label), ]
  expect_equal(nrow(ep_reject3), 1)
  expect_equal(nrow(ep_reject3[strata_var == "SEX"]), 1)

  # Rejected by_strata_by_trt: VASCULAR DISORDERS
  ep_reject4 <- ep_reject1[grepl("VASCULAR DISORDERS", endpoint_label), ]
  expect_equal(nrow(ep_reject3), 1)
  expect_equal(nrow(ep_reject3[strata_var == "SEX"]), 1)

  # Rejected by_strata_across_trt
  ep_reject5 <- ep_rejected[crit_accept_endpoint == TRUE & crit_accept_by_strata_by_trt == TRUE & crit_accept_by_strata_across_trt == FALSE, ]
  expect_equal(nrow(ep_reject5), 1)
  expect_equal(nrow(ep_reject5[grepl("VASCULAR DISORDERS", endpoint_label) & strata_var == "AGEGR2"]), 1)
})
