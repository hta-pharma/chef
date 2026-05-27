# Validate the user supplied functions arguments.

Checks whether the expected function arguments are supplied. Throws a
meaningful error in case the expected and supplied arguments are
mismatched.

## Usage

``` r
validate_usr_fn_args(
  fn,
  fn_type = c("data_prepare", "stat_by_strata_by_trt", "stat_by_strata_across_trt",
    "stat_across_strata_across_trt", "crit_endpoint", "crit_by_strata_by_trt",
    "crit_by_strata_across_trt"),
  fn_name = NA_character_
)
```

## Arguments

- fn:

  (function) A non-primitive function

- fn_type:

  (character) giving the type of user def function.

- fn_name:

  (character) a custom name to use in error msg: will otherwise derive a
  name from function symbol.

## Value

NA if function complies or throws an error.
