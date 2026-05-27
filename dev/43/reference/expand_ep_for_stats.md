# Expand Endpoint Data for Statistics

Expands endpoint datatable for statistical analysis based on specified
grouping columns. Creates specifications for expansion and performs the
expansion to prepare the data for statistical functions.

## Usage

``` r
expand_ep_for_stats(
  ep,
  grouping_cols,
  analysis_data_container,
  data_col,
  id_col,
  col_prefix
)
```

## Arguments

- ep:

  A `data.table` containing endpoint data to be expanded.

- grouping_cols:

  A character vector specifying the columns used for grouping in the
  expansion.

- analysis_data_container:

  data.table containing the analysis data.

- data_col:

  The name of the column in `ep` that contains the ADaM dataset.

- id_col:

  The name of the column in `ep` that contains the unique identifier for
  the strata.

- col_prefix:

  A prefix for the resulting columns, defaults to "stat".

## Value

A `data.table` with expanded endpoints prepared for statistical
analysis.
