# Fetch ADaM tables from a source based on endpoint specifications

This function reads the set of ADaM tables required to produce the
specified endpoints from the input. It uses the user-supplied
preprocessing functions specified for each endpoint to identify and
process the necessary ADaM tables. It validates the preprocessing
functions and applies them to the study metadata to obtain the data
tables. If any preprocessing functions result in errors, the function
stops and reports the errors.

## Usage

``` r
fetch_db_data(study_metadata, fn_dt, env = parent.frame())
```

## Arguments

- study_metadata:

  Study metadata that is passed to the `mk_adam*` functions.

- fn_dt:

  A `data.table` containing the parsed user-supplied functions.

- env:

  Advanced parameter for specifying the evaluation environment, defaults
  to [`parent.frame()`](https://rdrr.io/r/base/sys.parent.html).

## Value

A list of ADaM tables with additional columns from `fn_dt` including
function type, hash, name, character representation of the call, and the
callable itself.
