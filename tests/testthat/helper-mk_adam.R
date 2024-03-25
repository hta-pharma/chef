mk_adae <- function(study_metadata) {
  adsl <- data.table::as.data.table(pharmaverseadam::adsl)
  adsl[, AGEGR2 := data.table::fcase(
    AGE < 70, "AGE < 70",
    AGE >= 70, "AGE >= 70"
  )]

  adae <- data.table::as.data.table(pharmaverseadam::adae)

  adae_out <-
    merge(adsl, adae[, c(setdiff(names(adae), names(adsl)), "USUBJID"),
      with =
        F
    ], by = "USUBJID", all = TRUE)
  adae_out[]
}

mk_adex <- function(study_metadata) {
  adsl <- data.table::as.data.table(pharmaverseadam::adsl)
  adsl[, AGEGR2 := data.table::fcase(
    AGE < 70, "AGE < 70",
    AGE >= 70, "AGE >= 70"
  )]

  adex <- pharmaverseadam::adex

  adex_out <-
    merge(adsl, adex[, c(setdiff(names(adex), names(adsl)), "USUBJID"),
      with =
        F
    ], by = "USUBJID", all = TRUE)
  adex_out[]
}

mk_adcm <- function(study_metadata) {
  adsl <- data.table::as.data.table(pharmaverseadam::adsl)
  adsl[, AGEGR2 := data.table::fcase(
    AGE < 70, "AGE < 70",
    AGE >= 70, "AGE >= 70"
  )]

  adcm <- data.table::as.data.table(pharmaverseadam::adcm)

  adcm_out <-
    merge(adsl, adcm[, c(setdiff(names(adcm), names(adsl)), "USUBJID"),
      with =
        F
    ], by = "USUBJID", all = TRUE)
  adcm_out[]
}
