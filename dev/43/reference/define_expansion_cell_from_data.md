# Create Expansion Cell Containing a Data Table Based on Strata

Defines an expansion cell for a `data.table` row based on the the
strata. Creates a `data.table` with metadata and filter conditions for
each combination of strata levels.

## Usage

``` r
define_expansion_cell_from_data(row, grouping_cols, data_col, col_prefix)
```

## Arguments

- row:

  A single row from a data table containing endpoint data.

- grouping_cols:

  A character vector specifying the columns that point to the grouping
  variables in the data.

- data_col:

  The name of the column that points to the ADaM dataset.

- col_prefix:

  A prefix for the resulting columns, such as "prefix_filter" and
  "prefix_metadata".

## Value

A nested `data.table` (double listed) to be inserted into a data table
cell.
