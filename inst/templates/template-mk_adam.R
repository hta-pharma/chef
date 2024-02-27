# EVERYTHING HERE CAN BE DELETED
# This is where you create your input data sets that will be ingested into chef.

# There are a few requirements:
# 1. The first argument to the function must always be "study_metadata"
# 2. The function must return a data.table object



# Remember to also change the name of the functions to something meaningful and
# unique (no two functions can have the same name).

mk_adcm_template <- function(study_metadata){
  adcm <- data.table::as.data.table(pharmaverseadam::adcm)
  adsl <- data.table::as.data.table(pharmaverseadam::adsl)
  adae_out <-
    merge(adsl, adcm[, c(setdiff(names(adcm), names(adsl)), "USUBJID"), with =
                       F], by = "USUBJID", all = TRUE)

}
