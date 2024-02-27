test_that("error if expecting more variables", {

  my_data_prepare <- function(study_metadata, some_specific_var){
    a <- study_metadata
    b <- some_specific_var
  }

  expect_error(
    validate_usr_fn_args(
      fn = my_data_prepare,
      fn_type = "data_prepare"
    ),
    sprintf(
      "Function (%s) of type (%s) expects argument(s) which is not supplied",
      "my_data_prepare", "data_prepare"),
    fixed=TRUE
  )


})

test_that("error is not thrown for partialized functions",{
  my_data_prepare <- function(study_metadata, some_specific_var){
    a <- study_metadata
    b <- some_specific_var

    return(a)
  }

  my_data_partial <- purrr::partial(
    my_data_prepare,
    some_specific_var = "something"
  )

  expect_error(
    validate_usr_fn_args(
      fn = my_data_prepare,
      fn_type = "data_prepare"
    ),
    sprintf(
      "Function (%s) of type (%s) expects argument(s) which is not supplied",
      "my_data_prepare", "data_prepare" ),
    fixed=TRUE
  )

  expect_na_or_null(
    validate_usr_fn_args(
      fn = my_data_partial,
      fn_type = "data_prepare"
      )
  )
}
)

test_that("Under defined functions fail, but is rescued by dots.",{

  my_fun <- function(){
    1+1
    }
  my_fun_dots <- function(...){
    1+1
  }

  expect_error(
    validate_usr_fn_args(
      fn = my_fun,
      fn_type = "data_prepare"
    ),
    "is supplied arguments it does not expect",
    fixed=TRUE
  )

  expect_na_or_null(
    validate_usr_fn_args(
      fn = my_fun_dots,
      fn_type = "data_prepare"
    )
  )

})

test_that("Ekstra args but with default args are allowed",{
  my_data_prep <- function(study_metadata, arg_no_default, ...){
    message(study_metadata, arg_no_default, ...)
  }

  expect_error(
    validate_usr_fn_args(
      fn = my_data_prep,
      fn_type = "data_prepare"),
    "expects argument(s) which is not supplied",
    fixed=TRUE
    )


  my_data_prep <- function(study_metadata, arg_with_default=1, ...){
    message(study_metadata, arg_with_default)
  }

  expect_na_or_null(
    validate_usr_fn_args(
      fn=my_data_prep,
      fn_type = "data_prepare"
    )
  )


})

test_that("Test implementation in mk_userdef_fn_dt",{

  crit_endpoint <- function(...) {
    return(T)
  }
  crit_sga <- function(...) {
    return(T)
  }
  crit_sgd <- function(...) {
    return(T)
  }

  stat_bad_input <- function(dat, missing_arg){"woooh"}
  stat_good_input <- function(dat, cell_index, defaulted_arg=1, ...){"wububu"}

  ep_good <- mk_endpoint_str(
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
    stat_by_strata_by_trt = list("stat_good_input" = stat_good_input),
    stat_by_strata_across_trt = list("n_subev_trt_diff" = c(n_subev_trt_diff)),
    stat_across_strata_across_trt = list("P-interaction" = contingency2x2_strata_test),
    crit_endpoint = list(crit_endpoint),
    crit_by_strata_by_trt = list(crit_sgd),
    crit_by_strata_across_trt = list(crit_sga)
  )

  ep_err <- mk_endpoint_str(
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
    stat_by_strata_by_trt = list("stat_bad_input" = stat_bad_input),
    stat_by_strata_across_trt = list("n_subev_trt_diff" = n_subev_trt_diff),
    stat_across_strata_across_trt = list("P-interaction" = contingency2x2_ptest),
    crit_endpoint = list(crit_endpoint),
    crit_by_strata_by_trt = list(crit_sgd),
    crit_by_strata_across_trt = list(crit_sga)
  )

  ep_err <- add_id(ep_err)
  ep_good <- add_id(ep_good)


  ep_fn_map_err <-
    suppressWarnings(unnest_endpoint_functions(ep_err))

  ep_fn_map_good <-
    suppressWarnings(unnest_endpoint_functions(ep_good))

# ACT ---------------------------------------------------------------------
  expect_true(
    inherits(
      mk_userdef_fn_dt(ep_fn_map_good, env = environment()),
      "data.table"
      )
  )

  expect_error(
    mk_userdef_fn_dt(ep_fn_map_err, env = environment()),
    "Function (stat_bad_input) of type (stat_by_strata_by_trt) expects argument(s) which is not supplied",
    fixed=TRUE
  )


})
