# Add forced group levels

Expand the set of unique group levels of one grouping variables in a
table containing all combinations of one or more grouping variables.

## Usage

``` r
add_forced_group_levels(combos_all, forced_group_levels)
```

## Arguments

- combos_all:

  A data.table containing all combinations of group levels found in the
  analysis data.

- forced_group_levels:

  A one column data.table containing a required set of group levels of a
  grouping variable.

## Value

A data.table containing all combinations of group levels exapnded with
the forced grouping levels.
