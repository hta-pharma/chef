{{make_endpoints_fun}} <- function() {
  mk_endpoint_str(
                  study_metadata = list(),
                  pop_var = "SAFFL",
                  pop_value = "Y",
                  treatment_var = "TRT01A",
                  treatment_refval = "Xanomeline High Dose",
                  period_var = "ANL01FL",
                  period_value = "Y")
}
