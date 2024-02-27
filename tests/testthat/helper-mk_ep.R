mk_ep_0001_base <-
  purrr::partial(
    mk_endpoint_str,
    study_metadata = list(),
    pop_var = "SAFFL",
    pop_value = "Y",
    treatment_var = "TRT01A",
    treatment_refval = "Xanomeline High Dose",
  )

mk_ep_0001_awaiting_data <- purrr::partial(
  mk_ep_0001_base,
  group_by = list(list(AESOC = c())),
  stratify_by = list(c("SEX", "AGEGR2")),
  endpoint_filter = "AESEV == 'MILD'",
  stat_by_strata_across_trt = list(c()),
  stat_by_strata_by_trt = list("n_sub" = n_sub,
                                   "n_subev" = n_subev)
)

mk_ep_0001_waiting_grps <- purrr::partial(
  mk_ep_0001_base,
  stratify_by = list(c("SEX", "AGEGR2")),
  stat_by_strata_by_trt = list("n_subj" = n_sub,
                                   "n_subev" = n_subev)
)
