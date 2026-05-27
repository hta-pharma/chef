# Unnest data model by the supplied function columns

This function takes a `data.table` and a vector of column names. These
columns are expected to contain lists of function calls. The function
'unnests' these columns such that each function call is represented on
its own row in the resulting `data.table`. This is useful for processing
or analyzing the function calls separately.

## Usage

``` r
unnest_by_fns(dt, cols)
```

## Arguments

- dt:

  A `data.table` object. The endpoint data model that contains nested
  function calls.

- cols:

  A character vector of quoted column names in `dt` that contain the
  nested function calls.

## Value

A `data.table` in long format, where each row corresponds to a single
function call from the nested lists in the specified columns.
