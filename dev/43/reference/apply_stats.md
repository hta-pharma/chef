# Apply Statistical Methods

Applies user-supplied statistical functions to the prepared endpoint
data. The results are stored in a `data.table` that is nested in the row
of the endpoint definition object.

## Usage

``` r
apply_stats(
  ep,
  analysis_data_container,
  type = c("stat_by_strata_by_trt", "stat_by_strata_across_trt",
    "stat_across_strata_across_trt")
)
```

## Arguments

- ep:

  A `data.table` containing prepared endpoint data for statistical
  analysis, typically the output from `prepare_for_stats`.

- analysis_data_container:

  data.table containing the analysis data. functions.

- type:

  The type of statistical function. Can be one of
  "stat_by_strata_by_trt", "stat_by_strata_across_trt", or
  "stat_across_strata_across_trt"

## Value

A `data.table` with statistical results appended.
