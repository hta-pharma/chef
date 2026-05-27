# Prepare (and Expand) Endpoint for Statistical Analysis

Prepares the endpoint data for ingestion by the user-supplied
statistical function by expanding it based on the type of statistics to
be performed. It expands the data according to the specified statistical
type, which determines the grouping columns used for the expansion.

## Usage

``` r
prepare_for_stats(
  ep,
  analysis_data_container,
  fn_map,
  type = c("stat_by_strata_by_trt", "stat_by_strata_across_trt",
    "stat_across_strata_across_trt"),
  data_col = "dat",
  id_col = "strata_id"
)
```

## Arguments

- ep:

  A `data.table` containing expanded endpoint definitions and associated
  data, typically the output from `apply_criterion_by_strata`.

- analysis_data_container:

  data.table containing the analysis data.

- fn_map:

  A `data.table` mapping endpoint definitions to statistical functions.

- type:

  A character string specifying the type of statistics for which the
  data is being prepared. Valid types are "stat_by_strata_by_trt",
  "stat_by_strata_across_trt", and "stat_across_strata_across_trt".

- data_col:

  The name of the column in `ep` that contains the ADaM dataset.

- id_col:

  The name of the column in `ep` that contains the unique identifier for
  the strata.

## Value

A `data.table` with expanded endpoints prepared for statistical
analysis.
