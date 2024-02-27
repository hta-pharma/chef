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
    "AGEGR2",
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

helper_calls_to_imports <- function(){
  # Some packages will be needed when the user runs the pipeline, so we want
  # those packages "Imported" in the DESCRIPTION file, so the user does not have
  # any additional steps to install them after installing chef. However, the
  # code for this is stored in the template files, and for some reason, R CMD
  # check does not see theses files, so it gives a warning that we have
  # dependancies listed in the DESCRIPTION file that are not used in the
  # package. These notes are not allowed in our CI/CD checks, so we use this
  # function to make just one call to each of those packages.

  qs::starnames[1, 1]
  future::availableCores
  future.callr::callr
  tarchetypes::walk_ast
  targets::tar_warning

}
