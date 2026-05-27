# Index the expanded endpoints

Creates an index for endpoint groups by expanding a single endpoint
definition to include all specified levels. If multiple variables are
specified for grouping, the function returns all possible combinations.
It also indexes the specific combinations found in the supplied study
data, indicating whether data exists for each group combination.

## Usage

``` r
index_expanded_ep_groups(x, group_by, forced_group_levels = NULL)
```

## Arguments

- x:

  A dataset with study data (i.e ADaM).

- group_by:

  A list specifying the grouping for endpoints.

- forced_group_levels:

  data.table (optional). Table with group levels that must be included
  in the expansion, regardless of `group_by`.

## Value

A data table with the same number of columns as the number of variables
included in the grouping specification, plus an additional column
`empty` that specifies if there are any records corresponding to the
group combination. `FALSE` means \>=1 record exists in the supplied
study data.
