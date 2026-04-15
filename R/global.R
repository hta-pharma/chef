#' @noRd
covr_ignore <- function() {
  list(
    "R/global.R"
  )
}

# To avoid the R CMD notes:
utils::globalVariables(
  c(
    ":=",
    "%>%",
    ".",
    ".SD",
    ".I",
    "..keep",
    "..pk",
    "..vars_to_keep",
    "..keep_cols",
    "..x",
    ".N",
    "AGE",
    "AGEGR2",
    "AVAL",
    "AVISIT2",
    "COUNTRY2",
    "N_sub",
    "N_subev",
    "PARAMCD",
    "SEX",
    "adam",
    "adam_fn",
    "endpoint",
    "endpoint_id",
    "endpoint_label",
    "id",
    "measurement",
    "mk_adam",
    "project",
    "sex2",
    "strata_val",
    "strata_var",
    "treatment_val",
    "value"
  )
)
