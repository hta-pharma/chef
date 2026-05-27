# Handle creation of endpoint def function

Handle creation of endpoint def function

## Usage

``` r
handle_mk_fn(
  fn,
  pipeline_id,
  r_functions_dir,
  type = c("mk_endpoint_def", "mk_criterion", "mk_adam"),
  env
)
```

## Arguments

- fn:

  fn in list format

- pipeline_id:

  The pipeline ID

- r_functions_dir:

  The directory where the custom R scripts go

- type:

  Type of mk\_\* function: mk_endpoint_def (default), mk_criterion, or
  mk_adam.

- env:

  Environment
